REPORT zhr_controle_col30.

DATA: wa_001 TYPE zhr001_30.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS: p_re    TYPE zhr001_30-zz_re OBLIGATORY MATCHCODE OBJECT ZHP_RE_30,
            p_nome  TYPE zhr001_30-zz_nome_emp,
            p_cargo TYPE zhr001_30-zz_cargo,
            p_stt   TYPE zhr001_30-zz_status_emp ,
            p_dtc   TYPE zhr001_30-zz_data_cad.
SELECTION-SCREEN END OF BLOCK b0.

INITIALIZATION.


AT SELECTION-SCREEN.

  IF p_re IS NOT INITIAL
    AND p_re NE wa_001-zz_re.
    SELECT SINGLE zz_re
                  zz_nome_emp
                  zz_status_emp
                  zz_data_cad
                  zz_cargo
          INTO (p_re, p_nome, p_stt, p_dtc, p_cargo )
          FROM zhr001_30
          WHERE zz_re  EQ p_re.

    IF sy-subrc IS NOT INITIAL.
      CLEAR:  p_nome,
              p_stt,
              p_dtc,
              p_cargo.
    ELSE.
      wa_001-zz_re = p_re.
    ENDIF.
  ENDIF.



AT SELECTION-SCREEN OUTPUT.


AT SELECTION-SCREEN ON EXIT-COMMAND.


START-OF-SELECTION.

  CLEAR: wa_001.

  wa_001-zz_re         = p_re.
  wa_001-zz_nome_emp   = p_nome.
  wa_001-zz_cargo      = p_cargo.
  wa_001-zz_status_emp = p_stt.
  wa_001-zz_data_cad   = p_dtc.


  SELECT COUNT(*)
    FROM zhr001_30 UP TO 1 ROWS
  WHERE zz_re  EQ p_re.

  IF sy-dbcnt GT 0.
    PERFORM f_update.
    PERFORM f_commit.
  ELSE.
    PERFORM f_insert.
    PERFORM f_commit.
  ENDIF.

FORM f_insert.
  INSERT zhr001_30 FROM wa_001.
ENDFORM.

FORM f_update .
  MODIFY zhr001_30 FROM wa_001.
ENDFORM.

FORM f_commit.
  IF sy-subrc EQ 0.
    COMMIT WORK AND WAIT.
    MESSAGE s208(00) WITH 'SALVO COM SUCESSO!'.
  ELSE.
    ROLLBACK WORK.
    MESSAGE s001(z00) WITH 'ERRO AO GRAVAR!' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
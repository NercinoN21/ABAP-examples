REPORT zpm_cont_emp_30.

*------- DATA - WORK AREA E NUMERO AUTOMATICO --------------
DATA: wa_30     TYPE ztpm001_30,
      lv_number TYPE num10.

*--------------- ENTRADA DO USUARIO - OPÇÕES ------------------------
SELECTION-SCREEN BEGIN OF BLOCK b0_30 WITH FRAME TITLE text-t00.
PARAMETERS:     p_emp    RADIOBUTTON GROUP grp1,
                p_devolv RADIOBUTTON GROUP grp1.
SELECTION-SCREEN END OF BLOCK b0_30.

*--------------- ENTRADA DO USUARIO - PEGAR EMPRESTADO ------------------------
SELECTION-SCREEN BEGIN OF BLOCK b1_30 WITH FRAME TITLE text-t01.
PARAMETERS: p_matnr TYPE  ztpm001_30-matnr,
            p_menge TYPE  ztpm001_30-menge,
            p_parnr TYPE  ztpm001_30-parnr,
            p_werks TYPE  ztpm001_30-werks.
SELECTION-SCREEN END OF BLOCK b1_30.

*-------------------- ENTRADAS DO USUARIO - DEVOLVER ------------------------
SELECTION-SCREEN BEGIN OF BLOCK b2_30 WITH FRAME TITLE text-t02.
PARAMETERS:   p_num    TYPE  ztpm001_30-zznum.
SELECTION-SCREEN END OF BLOCK b2_30.

*---------- INICIANDO E VERIFICANDO PREENCHIMENTO ---------------------------
START-OF-SELECTION.
  IF p_emp EQ 'X'.
    IF p_matnr EQ '' AND p_menge EQ '' AND
       p_parnr EQ '' AND p_werks EQ ''.
      MESSAGE i000(z30) WITH 'PREENCHA OS CAMPOS PARA PEGAR EMPRESTADO.'.
    ELSE.
      PERFORM f_emprestar.
    ENDIF.
  ELSE.
    IF p_num EQ ''.
      MESSAGE i000(z30) WITH 'PREENCHA COM O CÓDIGO DE EMPRÉSTIMO PARA DEVOLVER.'.
    ELSE.
      PERFORM f_devolver.
    ENDIF.
  ENDIF.

*------------ GERA NUMERO PARA O ZZNUM ------------------------
FORM f_gerador_numero.
  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr             = '30'
      object                  = 'ZNUMPM0001' "=> USAR ESSE OBJETO!
    IMPORTING
      number                  = lv_number "NUMERO GERADO PARA O CONTROLE
    EXCEPTIONS
      interval_not_found      = 1
      number_range_not_intern = 2
      object_not_found        = 3
      quantity_is_0           = 4
      quantity_is_not_1       = 5
      interval_overflow       = 6
      buffer_overflow         = 7.
ENDFORM.

*---------------- EXIBINDO PARA O USUARIO ----------------
FORM f_exibindo_numero.
  MESSAGE i010(z30) WITH wa_30-zznum
                         wa_30-data_emp
                         wa_30-hora_emp.
ENDFORM.

FORM f_exibindo_devolver.
  MESSAGE i000(z30) WITH 'MATERIAL DEVOLVIDO!!!'.
ENDFORM.

*------------------- SALVANDO ALTERAÇÕES ------------------------
FORM f_commitando.
  IF
      sy-subrc IS INITIAL.
    COMMIT WORK AND WAIT.
    MESSAGE s208(00) WITH 'Salvo com sucesso'.
  ELSE.
    ROLLBACK WORK.
    MESSAGE s208(00) WITH 'Erro ao cadastrar' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.

*---------------------- PEGANDO O MATERIAL ----------------------
FORM f_emprestar.
  CLEAR: wa_30.

  PERFORM f_gerador_numero.

*-------------- ATRIBUINDO VALORES A WORK AREA ----------------
  wa_30-zzstatus  =     'Z1'.
  wa_30-matnr     =     p_matnr.
  wa_30-menge     =     p_menge.
  wa_30-parnr     =     p_parnr.
  wa_30-werks     =     p_werks.
  wa_30-data_emp  =     sy-datum.
  wa_30-hora_emp  =     sy-uzeit.
  wa_30-zznum = lv_number.

  INSERT ztpm001_30 FROM wa_30.
  PERFORM f_commitando.
  PERFORM f_exibindo_numero.
ENDFORM.

*--------------------- DEVOLVENDO O MATERIAL --------------------
FORM f_devolver.
  SELECT COUNT(*) FROM ztpm001_30 UP TO 1 ROWS WHERE zznum EQ p_num.

  IF sy-dbcnt GE 1.
    UPDATE ztpm001_30 SET zzstatus = 'Z2' WHERE zznum EQ p_num.
    PERFORM f_commitando.
    PERFORM f_exibindo_devolver.
  ELSE.
    ROLLBACK WORK.
    MESSAGE s208(00) WITH 'Erro ao Devolver' DISPLAY LIKE 'E'.
  ENDIF.
ENDFORM.
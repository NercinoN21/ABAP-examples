REPORT zz_calc_media_30.

DATA:
  v_media     TYPE p DECIMALS 2,
  v_resultado TYPE char100.

PARAMETERS: p_nota1 TYPE p DECIMALS 2,
            p_nota2 TYPE p DECIMALS 2,
            p_nota3 TYPE p DECIMALS 2,
            p_nota4 TYPE p DECIMALS 2.

INITIALIZATION.
  MESSAGE w208(00) WITH 'BEM VINDO AO CALCULADOR DE MÉDIA!'.

START-OF-SELECTION.

  PERFORM f_calc USING p_nota1
                       p_nota2
                       p_nota3
                       p_nota4.
  PERFORM f_exibe_msg.


FORM f_calc USING p_nota1
                  p_nota2
                  p_nota3
                  p_nota4.
  v_media = ( p_nota1 + p_nota2 + p_nota3 + p_nota4 ) / 4.

  IF v_media GE 7.
    v_resultado = 'APROVADO'.
  ELSE.
    v_resultado = 'REPROVADO'.
  ENDIF.
ENDFORM.

FORM f_exibe_msg.
  MESSAGE i001(z00) WITH v_resultado.
*     RESULTADO: & !
ENDFORM.
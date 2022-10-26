REPORT zz_exerc03_30.

DATA:
  v_resultado     TYPE p DECIMALS 2.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS: p_altura TYPE p DECIMALS 2,
            p_base   TYPE p DECIMALS 2.
SELECTION-SCREEN END OF BLOCK b0.

INITIALIZATION.
  MESSAGE w208(00) WITH 'BEM VINDO(A)!'.

START-OF-SELECTION.

  PERFORM f_calc USING p_altura
                       p_base.
  PERFORM f_exibe_msg.


FORM f_calc USING p_altura
                  p_base.
  v_resultado = ( p_altura * p_base ) / 2.
ENDFORM.

FORM f_exibe_msg.
  MESSAGE i001(z30) WITH v_resultado.
ENDFORM.
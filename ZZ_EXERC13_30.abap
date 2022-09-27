REPORT zz_exerc13_30.

DATA: v_contador TYPE i VALUE '1',
      v_dois     TYPE i VALUE '2'.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS: p_valor TYPE i.
SELECTION-SCREEN END OF BLOCK b0.

START-OF-SELECTION.
  PERFORM f_calc_mult_dois USING p_valor.

FORM f_calc_mult_dois USING p_valor.
  SKIP 1.
  WRITE: 'Valor Lido: ', p_valor.
  SKIP 1.
  WRITE: 'Sequência impressa:'.
  WRITE: v_contador.

  WHILE v_contador * v_dois LE p_valor.
    v_contador = v_contador * v_dois.
    WRITE: v_contador.
  ENDWHILE.
ENDFORM.
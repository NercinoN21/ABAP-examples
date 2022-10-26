REPORT zz_exerc12_30.

DATA: v_contador      TYPE i VALUE '0',
      v_cache_tabuada TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS: p_valor TYPE i.
SELECTION-SCREEN END OF BLOCK b0.

START-OF-SELECTION.
  PERFORM f_calc_tabuada USING p_valor.

FORM f_calc_tabuada USING p_valor.
  WHILE v_contador LE 10.
    v_cache_tabuada = p_valor * v_contador.
    SKIP 1.
    WRITE: p_valor, 'x', v_contador, ' = ', v_cache_tabuada.
    v_contador = v_contador + 1.
    v_cache_tabuada = 0.
  ENDWHILE.
ENDFORM.
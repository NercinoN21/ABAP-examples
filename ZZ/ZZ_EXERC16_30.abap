REPORT zz_exerc16_30.

DATA: v_contador TYPE i VALUE '1',
      v_soma     TYPE i.

START-OF-SELECTION.
  PERFORM f_calc.
  WRITE: 'SOMA DE TODOS OS NÚMEROS ÍMPARES MÚLTIPLOS DE TRÊS DE 1 ATÉ 500:'.
  SKIP 1.
  WRITE: v_soma.

FORM f_calc .
  WHILE v_contador LE 500.
    IF v_contador MOD 2 NE 0 AND v_contador MOD 3 EQ 0.
      v_soma = v_soma + v_contador.
    ENDIF.
    v_contador = v_contador + 1.
  ENDWHILE.
ENDFORM.
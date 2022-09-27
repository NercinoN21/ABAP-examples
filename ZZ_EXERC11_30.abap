REPORT zz_exerc11_30.

DATA: v_contador TYPE i VALUE '1'.

START-OF-SELECTION.
  PERFORM f_loop.

FORM f_loop.
  WRITE: 'Exercício de loop, 1 até 100:'.
  SKIP 1.
  WHILE v_contador NE 101.
    WRITE: v_contador.
    v_contador = v_contador + 1.
  ENDWHILE.
ENDFORM.
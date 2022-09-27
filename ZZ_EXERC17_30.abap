REPORT ZZ_EXERC17_30.

DATA: v_contador TYPE i VALUE '100'.

START-OF-SELECTION.
  PERFORM f_loop.

FORM f_loop.
  WRITE: 'NÚMEROS ÍMPARES ENTRE 100 E 200.'.
  SKIP 1.
  WHILE v_contador LE 200.
    IF V_CONTADOR MOD 2 NE 0.
      WRITE: v_contador.
    ENDIF.
    v_contador = v_contador + 1.
  ENDWHILE.
ENDFORM.
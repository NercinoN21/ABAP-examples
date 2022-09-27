REPORT zz_exerc08_30.

DATA: v_resultado     TYPE char100,
      v_resto_divisao TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS:  p_valor TYPE i.
SELECTION-SCREEN END OF BLOCK b0.

START-OF-SELECTION.
  PERFORM f_par_impar USING p_valor.
  PERFORM f_exibe_resultado.


FORM f_par_impar USING p_valor.

  v_resto_divisao = p_valor MOD 2.

  CASE v_resto_divisao.
    WHEN 0.
      v_resultado = 'PAR'.
    WHEN 1.
      v_resultado = 'ÍMPAR'.
  ENDCASE.
ENDFORM.

form f_exibe_resultado.
  MESSAGE i004(z30) WITH v_resultado.
ENDFORM.
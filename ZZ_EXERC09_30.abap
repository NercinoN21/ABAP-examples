REPORT zz_exerc09_30.

DATA: "----------- Homem - Variáveis(h) ----------------
  v_const_h_multiplicar   TYPE p  DECIMALS 1    VALUE '72.7',
  v_const_h_subtrair      TYPE p  DECIMALS 1    VALUE '58',
  "----------- Mulher - Variáveis(m) ----------------
  v_const_m_multiplicar   TYPE p  DECIMALS 1    VALUE '62.1',
  v_const_m_subtrair      TYPE p  DECIMALS 1    VALUE '44.7',
  "--------------- Resultado ---------------------
  v_resultado             TYPE p  DECIMALS 2.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS:   p_altura TYPE p DECIMALS 2,
              p_homem  RADIOBUTTON GROUP grp1,
              p_mulher RADIOBUTTON GROUP grp1.
SELECTION-SCREEN END OF BLOCK b0.

START-OF-SELECTION.
  PERFORM f_calc_peso_ideal USING p_altura.
  PERFORM f_exibe_resultado.

FORM f_calc_peso_ideal USING p_altura.
  IF p_homem EQ 'X'.
    v_resultado = ( v_const_h_multiplicar * p_altura ) - v_const_h_subtrair.
  ELSE.
    v_resultado = ( v_const_m_multiplicar * p_altura ) - v_const_m_subtrair.
  ENDIF.
ENDFORM.

FORM f_exibe_resultado.
  MESSAGE i005(z30) WITH v_resultado.
ENDFORM.
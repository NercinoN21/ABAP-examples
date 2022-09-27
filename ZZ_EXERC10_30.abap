REPORT zz_exerc10_30.

DATA: v_resultado TYPE p DECIMALS 2.

*-------------- Criando e Alinhando os Botões ---------------
SELECTION-SCREEN BEGIN OF LINE.

PARAMETERS:   p_soma  RADIOBUTTON GROUP grp1.
SELECTION-SCREEN COMMENT 10(10) FOR FIELD p_soma.

PARAMETERS:   p_subt  RADIOBUTTON GROUP grp1.
SELECTION-SCREEN COMMENT 30(10) FOR FIELD p_subt.

PARAMETERS:   p_div  RADIOBUTTON GROUP grp1.
SELECTION-SCREEN COMMENT 50(10) FOR FIELD p_div.

PARAMETERS:   p_mult  RADIOBUTTON GROUP grp1.
SELECTION-SCREEN COMMENT 70(11) FOR FIELD p_mult.

PARAMETERS:   p_resto RADIOBUTTON GROUP grp1.
SELECTION-SCREEN COMMENT 83(15) FOR FIELD p_resto.

SELECTION-SCREEN END OF LINE.

*----------------- Entradas do user -----------------------
SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS:   p_valor1 TYPE p DECIMALS 2,
              p_valor2 TYPE p DECIMALS 2.
SELECTION-SCREEN END OF BLOCK b0.

START-OF-SELECTION.
  PERFORM f_calc USING p_valor1
                       p_valor2.
  PERFORM f_exibe_resultado.

FORM f_calc USING p_valor1
                  p_valor2.
  CASE 'X'.
    WHEN p_soma.
      v_resultado = p_valor1 + p_valor2.
    WHEN p_subt.
      v_resultado = p_valor1 - p_valor2.
    WHEN p_div.
      v_resultado = p_valor1 / p_valor2.
    WHEN p_mult.
      v_resultado = p_valor1 * p_valor2.
    WHEN p_resto.
      v_resultado = p_valor1 MOD p_valor2.
  ENDCASE.
ENDFORM.

FORM f_exibe_resultado.
  MESSAGE i006(z30) WITH v_resultado.
ENDFORM.
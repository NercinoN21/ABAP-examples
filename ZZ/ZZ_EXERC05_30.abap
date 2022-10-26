REPORT zz_exerc05_30.

DATA: v_idade_atual TYPE  i,
      v_idade_2050  TYPE  i. 

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS: p_nasceu TYPE    d, "Ano de Nascimento
            p_atual  TYPE d. "Ano atual
SELECTION-SCREEN END OF BLOCK b0.

START-OF-SELECTION.
  PERFORM f_calc_idades USING p_nasceu
                              p_atual.
  PERFORM f_exibe_msg.

FORM f_calc_idades USING p_nasceu
                         p_atual.
*------------ Idade Atual ---------------------
  v_idade_atual = p_atual(4) - p_nasceu(4).
*------------- Em 2050 ------------------------
  v_idade_2050 = 2050 - p_nasceu(4).
ENDFORM.

FORM f_exibe_msg.
  MESSAGE i003(z30) WITH v_idade_atual
                         v_idade_2050.
* VOCÊ TEM OU VAI FAZER & ANOS! EM 2050 VOCÊ VAI FAZER & ANOS!
ENDFORM.
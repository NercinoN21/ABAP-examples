REPORT zz_exerc07_30.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS:  p_valor1 TYPE i,
             p_valor2  TYPE i.
SELECTION-SCREEN END OF BLOCK b0.

START-OF-SELECTION.
  PERFORM f_verificando USING p_valor1
                              p_valor2.

FORM f_verificando USING p_valor1
                         p_valor2. "Qual é o maior numero entre os dois digitados pelo user
  IF p_valor1 GT p_valor2.
    MESSAGE i000(z30) WITH 'O maior número entre os dois é: ' p_valor1.
  ELSEIF p_valor1 < p_valor2.
    MESSAGE i000(z30) WITH 'O maior número entre os dois é: ' p_valor2.
  ELSE.
    MESSAGE S208(00) WITH 'Os números digitados são iguais!' DISPLAY LIKE 'W'.
  ENDIF.
ENDFORM.
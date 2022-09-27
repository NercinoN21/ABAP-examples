REPORT zz_exerc06_30.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS:  p_number TYPE p DECIMALS 2.
SELECTION-SCREEN END OF BLOCK b0.

START-OF-SELECTION.
  PERFORM f_verificando.

FORM f_verificando."Se o número digitado é maior que 3
  IF p_number LT 3.
    MESSAGE i000(z30) WITH 'O número:' p_number ', não é maior que 3!'.
  ELSE.
    MESSAGE i000(z30) WITH 'O número digitado é maior que 3!'.
  ENDIF.
ENDFORM.
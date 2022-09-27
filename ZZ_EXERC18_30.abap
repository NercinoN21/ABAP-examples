REPORT zz_exerc18_30.
* --- Considerando 8 hrs de trabalho padrão por dia e o mês com 4 semanas exatas ---
DATA:   v_const_hrs_mensal     TYPE i VALUE '160',
        v_const_val_hora_extra TYPE p DECIMALS 2 VALUE '1.50', "Acréscimo de 50% no pagamento por hora
        v_hora_extra           TYPE p DECIMALS 2,
        v_salario_parcial      TYPE p DECIMALS 2, "Sem hora extra
        v_salario_final        TYPE p DECIMALS 2.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS: p_horas TYPE i, "Horas totais trabalhadas no mês
            p_valor TYPE p DECIMALS 2. "Valor ganho por hora
SELECTION-SCREEN END OF BLOCK b0.

START-OF-SELECTION.
  PERFORM f_calc_salario USING p_horas
                               p_valor.
  PERFORM f_exibe_result.


FORM f_calc_salario USING p_horas
                          p_valor.

  IF p_horas GT v_const_hrs_mensal.
    v_hora_extra = ( p_horas - v_const_hrs_mensal ) * ( p_valor * v_const_val_hora_extra ) .
    v_salario_parcial = v_const_hrs_mensal * p_valor.
    v_salario_final = v_salario_parcial + v_hora_extra .
  ELSE.
    v_salario_parcial = p_horas * p_valor.
    v_salario_final = v_salario_parcial + v_hora_extra .
  ENDIF.
ENDFORM.

FORM f_exibe_result.
  MESSAGE i009(z30) WITH  v_salario_parcial
                          v_hora_extra
                          v_salario_final.
*   Salário Parcial: R$ & ! Valor Horas Extras: R$ & ! Salário Final: R$ & !
ENDFORM.
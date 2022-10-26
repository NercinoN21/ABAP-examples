REPORT zz_exerc02_30.

DATA:       v_a       TYPE i VALUE '3',
            v_b       TYPE i VALUE '2',
            v_c       TYPE i VALUE '5',
            v_questao TYPE char100,
            v_boolean TYPE string.

START-OF-SELECTION.
  WRITE: '2. Considerando A = 3, B = 2 e C = 5 determine como Verdadeiro ou Falso.'.
  SKIP 1.

*------ Printando os Resultados -----
  PERFORM f_a.
  PERFORM f_b.
  PERFORM f_c.
  PERFORM f_d.
  PERFORM f_e.
  PERFORM f_f.

*------ Printa o Resultado -------
FORM f_exibe_resultado.
  WRITE: v_questao.
  SKIP 1.
  WRITE: |Resultado: | & |{ v_boolean }| & |!|.
  SKIP 2.
ENDFORM.

*----------- Questões -------------
FORM f_a.
  v_questao = 'a. A > B'.
  IF v_a GT v_b.
    v_boolean = 'Verdadeiro'.
  ELSE.
    v_boolean = 'Falso'.
  ENDIF.
  PERFORM f_exibe_resultado.
ENDFORM.

FORM f_b.
  v_questao = 'b. B = A'.
  IF v_b EQ v_a.
    v_boolean = 'Verdadeiro'.
  ELSE.
    v_boolean = 'Falso'.
  ENDIF.
  PERFORM f_exibe_resultado.
ENDFORM.

FORM f_c.
  v_questao = 'c. (A >= B) AND (C <> 5)'.
  IF v_a GE v_b AND v_c NE 5.
    v_boolean = 'Verdadeiro'.
  ELSE.
    v_boolean = 'Falso'.
  ENDIF.
  PERFORM f_exibe_resultado.
ENDFORM.

FORM f_d.
  v_questao = 'd. (B < A) OR (A = 3)'.
  IF v_b LT v_a OR v_a EQ 3.
    v_boolean = 'Verdadeiro'.
  ELSE.
    v_boolean = 'Falso'.
  ENDIF.
  PERFORM f_exibe_resultado .
ENDFORM.

FORM f_e.
  v_questao = 'e. (A > B) OR (A = 3)'.
  IF v_a GT v_b OR  v_a EQ 3.
    v_boolean = 'Verdadeiro'.
  ELSE.
    v_boolean = 'Falso'.
  ENDIF.
  PERFORM f_exibe_resultado .
ENDFORM.

FORM f_f.
  v_questao = 'f. (C <= 7) AND (B > 0) AND (C > A)'.
  IF v_c LE 7 AND v_b GT 0 AND v_c GT v_a .
    v_boolean = 'Verdadeiro'.
  ELSE.
    v_boolean = 'Falso'.
  ENDIF.
  PERFORM f_exibe_resultado .
ENDFORM.
REPORT zz_exerc15_30.

DATA:     v_soma        TYPE i,
          v_media_geral TYPE p DECIMALS 2,
          v_maior       TYPE i,
          v_menor       TYPE i,
          v_media_pares TYPE p DECIMALS 2,
          v_contador    TYPE i VALUE '0'.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS: p_n1 TYPE i,
            p_n2 TYPE i,
            p_n3 TYPE i,
            p_n4 TYPE i,
            p_n5 TYPE i.
SELECTION-SCREEN END OF BLOCK b0.

INITIALIZATION.
  MESSAGE w208(00) WITH 'BEM VINDO(A)!'.

START-OF-SELECTION.
  PERFORM f_calc_soma USING p_n1
                            p_n2
                            p_n3
                            p_n4
                            p_n5.

  PERFORM f_calc_media_geral USING p_n1
                                   p_n2
                                   p_n3
                                   p_n4
                                   p_n5.

  PERFORM f_calc_maior_numero USING p_n1
                                    p_n2
                                    p_n3
                                    p_n4
                                    p_n5.

  PERFORM f_calc_menor_numero USING p_n1
                                    p_n2
                                    p_n3
                                    p_n4
                                    p_n5.

  PERFORM f_calc_media_dos_pares USING p_n1
                                       p_n2
                                       p_n3
                                       p_n4
                                       p_n5.

  PERFORM f_exibe_msg.


FORM f_calc_soma USING p_n1
                       p_n2
                       p_n3
                       p_n4
                       p_n5.

  v_soma = ( p_n1 + p_n2 + p_n3 + p_n4 + p_n5 ) .
ENDFORM.

FORM f_calc_media_geral USING p_n1
                              p_n2
                              p_n3
                              p_n4
                              p_n5.

  v_media_geral = v_soma / 5 .
ENDFORM.

FORM f_calc_maior_numero USING p_n1
                               p_n2
                               p_n3
                               p_n4
                               p_n5.

  v_maior = p_n1.
  IF v_maior LT p_n2.
    v_maior = p_n2.
  ENDIF.

  IF v_maior LT p_n3.
    v_maior = p_n3.
  ENDIF.

  IF v_maior LT p_n4.
    v_maior = p_n4.
  ENDIF.

  IF v_maior LT p_n5.
    v_maior = p_n5.
  ENDIF.
ENDFORM.


FORM f_calc_menor_numero USING p_n1
                               p_n2
                               p_n3
                               p_n4
                               p_n5.

  v_menor = p_n1.
  IF v_menor GT p_n2.
    v_menor = p_n2.
  ENDIF.

  IF v_menor GT p_n3.
    v_menor = p_n3.
  ENDIF.

  IF v_menor GT p_n4.
    v_menor = p_n4.
  ENDIF.

  IF v_menor GT p_n5.
    v_menor = p_n5.
  ENDIF.
ENDFORM.


FORM f_calc_media_dos_pares USING p_n1
                                  p_n2
                                  p_n3
                                  p_n4
                                  p_n5.

  IF ( p_n1 MOD 2 ) EQ 0.
    v_media_pares = v_media_pares + p_n1.
    v_contador = v_contador + 1 .
  ENDIF.

  IF ( p_n2 MOD 2 ) EQ 0.
    v_media_pares = v_media_pares + p_n2.
    v_contador = v_contador + 1 .
  ENDIF.

  IF ( p_n3 MOD 2 ) EQ 0.
    v_media_pares = v_media_pares + p_n3.
    v_contador = v_contador + 1 .
  ENDIF.

  IF ( p_n4 MOD 2 ) EQ 0.
    v_media_pares = v_media_pares + p_n4.
    v_contador = v_contador + 1 .
  ENDIF.

  IF ( p_n5 MOD 2 ) EQ 0.
    v_media_pares = v_media_pares + p_n5.
    v_contador = v_contador + 1 .
  ENDIF.

  v_media_pares = v_media_pares / v_contador .

ENDFORM.

FORM f_exibe_msg.
  MESSAGE i007(z30) WITH  v_soma
                          v_maior
                          v_menor.
*   Soma Total: & ! Maior Valor: & ! Menor Valor: & !
  MESSAGE i008(z30) WITH  v_media_geral
                          v_media_pares.
*   Média Geral: & ! Média dos Pares: & !
ENDFORM.
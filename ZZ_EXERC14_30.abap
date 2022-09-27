REPORT zz_exerc14_30.

DATA: v_contador TYPE i VALUE '1',
      v_cache    TYPE i.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-tb0.
PARAMETERS:   p_valor1 TYPE i,
              p_valor2 TYPE i.
SELECTION-SCREEN END OF BLOCK b0.

START-OF-SELECTION.
  IF p_valor1 NE p_valor2.
    PERFORM f_calc_menor_ao_maior USING p_valor1
                                        p_valor2.
    PERFORM f_calc_maior_ao_menor USING p_valor1
                                        p_valor2.
  ELSE.
    MESSAGE i000(z30) WITH 'DIGITE NÚMEROS DIFERENTES!'.
  ENDIF.

FORM f_calc_menor_ao_maior USING p_valor1
                  p_valor2.
  IF p_valor1 GT p_valor2.
    WRITE: 'Do Menor ao Maior: '.
    v_cache = p_valor2.
    WHILE p_valor1 GE v_cache.
      WRITE: v_cache.
      v_cache = v_cache + 1.
    ENDWHILE.
  ELSE.
    WRITE: 'Do Menor ao Maior: '.
    v_cache = p_valor1.
    WHILE p_valor2 GE v_cache.
      WRITE: v_cache.
      v_cache = v_cache + 1.
    ENDWHILE.
  ENDIF.
ENDFORM.

FORM f_calc_maior_ao_menor USING p_valor1
                                 p_valor2.
  SKIP 1.
  IF p_valor1 GT p_valor2.
    WRITE: 'Do Maior ao Menor: '.
    v_cache = p_valor1.
    WHILE p_valor2 LE v_cache.
      WRITE: v_cache.
      v_cache = v_cache - 1.
    ENDWHILE.
  ELSE.
    WRITE: 'Do Maior ao Menor: '.
    v_cache = p_valor2.
    WHILE p_valor1 LE v_cache.
      WRITE: v_cache.
      v_cache = v_cache - 1.
    ENDWHILE.
  ENDIF.
ENDFORM.
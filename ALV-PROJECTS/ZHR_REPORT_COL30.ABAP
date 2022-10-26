REPORT zhr_report_col30.

DATA:    v_re        TYPE zhr001_30-zz_re,
         v_nome      TYPE zhr001_30-zz_nome_emp,
         v_cargo     TYPE zhr001_30-zz_cargo,
         v_stt       TYPE zhr001_30-zz_status_emp,
         v_dtc       TYPE zhr001_30-zz_data_cad,

         t_out       TYPE TABLE OF zhr001_30, "TABELA INTERNA
         wa_out      LIKE LINE OF t_out,  "ESTRUTURA / WORK AREA
*ALV
         t_fieldcat  TYPE  slis_t_fieldcat_alv,
         wa_fieldcat LIKE LINE OF t_fieldcat,
         wa_layout   TYPE  slis_layout_alv.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-b01.
SELECT-OPTIONS: s_re     FOR v_re,
                s_nome   FOR v_nome,
                s_cargo  FOR v_cargo,
                s_stt    FOR v_stt,
                s_dtc    FOR v_dtc.
SELECTION-SCREEN END OF BLOCK b0.

START-OF-SELECTION.

  PERFORM f_buscar_dados.
  PERFORM f_exibir_alv.

FORM f_buscar_dados.
  REFRESH: t_out[].

  SELECT  mandt
          zz_re
          zz_nome_emp
          zz_cargo
          zz_status_emp
          zz_data_cad
    INTO TABLE t_out
    FROM zhr001_30
    WHERE zz_re         IN s_re
      AND zz_nome_emp   IN s_nome
      AND zz_cargo      IN s_cargo
      AND zz_status_emp IN s_stt
      AND zz_data_cad   IN s_dtc.

  IF t_out[] IS INITIAL.
    MESSAGE e208(00) WITH 'NENHUM REGISTRO ENCONTRADO!'.
  ENDIF.

  DELETE t_out WHERE zz_nome_emp IS INITIAL.

ENDFORM.

FORM f_exibir_alv.

  DATA: lv_tabix TYPE sy-tabix.

*  PERFORM f_cria_fcat USING:
*        '1'    'ZZ_RE'          'T_OUT'    'ZHR001_30'    'ZZ_RE'          'CÓD.MAT.'    'X'    'X',
*        '2'    'ZZ_NOME_EMP'    'T_OUT'    'ZHR001_30'    'ZZ_NOME_EMP'    'NOME'        ''     '',
*        '3'    'ZZ_CARGO'       'T_OUT'    'zhr001_30'    'ZZ_CARGO'       'CARGO'       ''     '',
*        '4'    'ZZ_STATUS_EMP'  'T_OUT'    'zhr001_30'    'ZZ_STATUS_EMP'  'STATUS'      ''     '',
*        '5'    'ZZ_DATA_CAD'    'T_OUT'    'zhr001_30'    'ZZ_DATA_CAD'    'DAT.CAD.'    ''     ''.


  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZHR001_30'
      i_client_never_display = abap_true
    CHANGING
      ct_fieldcat            = t_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2.

  FIELD-SYMBOLS: <lfs_line>  TYPE slis_fieldcat_alv.

  LOOP AT t_fieldcat ASSIGNING <lfs_line>.
    CASE <lfs_line>-fieldname.
      WHEN 'ZZ_RE'.
        <lfs_line>-hotspot = abap_true.

      WHEN 'ZZ_DATA_CAD'.
        <lfs_line>-no_out = abap_true.

      WHEN OTHERS.
    ENDCASE.
  ENDLOOP.


  wa_layout-colwidth_optimize = abap_true.
  wa_layout-zebra             = abap_true.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      is_layout     = wa_layout
      it_fieldcat   = t_fieldcat
    TABLES
      t_outtab      = t_out
    EXCEPTIONS
      program_error = 1.

  IF sy-subrc IS NOT INITIAL.
    "ERRO
    MESSAGE e208(30) WITH 'ERRO GERAR O ALV!'.
  ENDIF.


ENDFORM.

*FORM f_cria_fcat USING VALUE(p_col_pos)
*                       VALUE(p_fieldname)
*                       VALUE(p_tabname)
*                       VALUE(p_ref_tabname)
*                       VALUE(p_ref_fieldname)
*                       VALUE(p_seltext_m)
*                       VALUE(p_key)
*                       VALUE(p_hotspot).
*
*  CLEAR: wa_fieldcat.
*  wa_fieldcat-col_pos       = p_col_pos.
*  wa_fieldcat-fieldname     = p_fieldname.
*  wa_fieldcat-tabname       = p_tabname.
*  wa_fieldcat-ref_tabname   = p_ref_tabname.
*  wa_fieldcat-ref_fieldname = p_ref_fieldname.
*  wa_fieldcat-seltext_m     = p_seltext_m.
*  wa_fieldcat-key           = p_key.
*  wa_fieldcat-hotspot       = p_hotspot.
*  APPEND wa_fieldcat TO t_fieldcat.
*
*ENDFORM.
REPORT zpm_rep_emp30.

*-------------- DADOS E FIELD PARA ALV --------------------
DATA:    t_fieldcat  TYPE  slis_t_fieldcat_alv,
         wa_fieldcat LIKE LINE OF t_fieldcat,
         wa_layout   TYPE  slis_layout_alv.
FIELD-SYMBOLS: <lfs_line> TYPE ztpm001_30.

*--------------- DECLARANDO DATA PARA A BUSCA ----------------
DATA:    v_num    TYPE ztpm001_30-zznum,
         v_matnr  TYPE ztpm001_30-matnr,
         v_men    TYPE ztpm001_30-menge,
         v_parnr  TYPE ztpm001_30-parnr,
         v_werks  TYPE ztpm001_30-werks,
         v_data   TYPE ztpm001_30-data_emp,
         v_hor    TYPE ztpm001_30-hora_emp,
         v_status TYPE ztpm001_30-zzstatus,

         " DECLARANDO T_OUT PARA SELECT E "t_outtab"
         t_out    TYPE TABLE OF ztpm001_30,
         " WORK AREA (USAR NO "MOVE-CORRESPONDING")
         wa_out   LIKE LINE OF t_out.

*------------------ ENTRADAS DO USUARIO ---------------------------
SELECTION-SCREEN BEGIN OF BLOCK a0 WITH FRAME TITLE text-001.
SELECT-OPTIONS: s_matnr      FOR v_matnr,
                s_parnr      FOR v_parnr,
                s_werks      FOR v_werks,
                s_data      FOR v_data,
                s_stt      FOR v_status .
SELECTION-SCREEN END OF BLOCK a0.

*--------- ATIVANDO OS FORMS ------------
START-OF-SELECTION.
  PERFORM f_dados_report.
  PERFORM f_report_alv.

*------------ COLETANDO OS DADOS E JOGANDO NA "T_OUT" --------------
FORM f_dados_report.
  SELECT  mandt
          zznum
          matnr
          menge
          parnr
          werks
          data_emp
          hora_emp
          zzstatus
    INTO TABLE t_out
    FROM ztpm001_30
    WHERE ztpm001_30~matnr         IN s_matnr
      AND ztpm001_30~parnr         IN s_parnr
      AND ztpm001_30~werks         IN s_werks
      AND ztpm001_30~data_emp      IN s_data
      AND ztpm001_30~zzstatus      IN s_stt.

  " VERIFICAÇÃO DE TABELA VAZIA
  IF t_out[] IS INITIAL.
    MESSAGE e208(00) WITH 'NENHUM REGISTRO ENCONTRADO!'.
  ENDIF.

  DELETE t_out WHERE zznum IS INITIAL.
ENDFORM.

*----------------- PADRAO DE ALV (<LFS_LINE>/t_fieldcat) ---------------
FORM f_report_alv.
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZTPM001_30'
      i_client_never_display = abap_true
    CHANGING
      ct_fieldcat            = t_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2.

  APPEND INITIAL LINE TO t_out ASSIGNING <lfs_line>.
  MOVE-CORRESPONDING wa_out TO <lfs_line>.

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
    MESSAGE e208(00) WITH 'ERRO AO GERAR O ALV!'.
  ENDIF.
ENDFORM.
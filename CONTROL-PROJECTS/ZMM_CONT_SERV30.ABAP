REPORT zmm_lista_serv30.

*   2 – Seleção de dados ( Types )
TYPES: BEGIN OF type_serv,
         matnr TYPE mara-matnr,
         mtart TYPE mara-mtart,
         meins TYPE mara-meins,
         matkl TYPE mara-matkl,
         werks TYPE marc-werks,
         ekgrp TYPE marc-ekgrp,
         vprsv TYPE mbew-vprsv,
         verpr TYPE mbew-verpr,
         stprs TYPE mbew-stprs,
         peinh TYPE mbew-peinh,
       END OF type_serv,

       BEGIN OF  type_makt,
         matnr TYPE mara-matnr,
         maktx TYPE zst_makt-maktx,
       END OF type_makt,

       BEGIN OF type_waers,
         werks TYPE t001w-werks,
         waers TYPE t001-waers,
       END OF type_waers.

*   1 – Tela de seleção(data)

DATA:  v_matnr  TYPE mara-matnr,
       v_matkl  TYPE mara-matkl,
       v_werks  TYPE marc-werks,
       v_ekgrp  TYPE marc-ekgrp,

*   2 – Seleção de dados (data)
* LIKE LINE OF = significa que a variável será do tipo linha de tabela
* WA = WORK ÁREA
       t_waers  TYPE TABLE OF type_waers,
       wa_waers LIKE LINE OF t_waers,

       t_makt   TYPE  TABLE OF type_makt,
       wa_makt  LIKE LINE OF t_makt,

       t_serv   TYPE TABLE OF type_serv,
       wa_serv  TYPE type_serv, " usar type no "wa" quando nao tiver certeza das mudanças no t_

*   3 - Output(data)
       t_out    TYPE TABLE OF zsmm_lista_serv30.

INCLUDE ZALV_30.

FIELD-SYMBOLS: <lfs_line> TYPE zsmm_lista_serv30.

SELECTION-SCREEN BEGIN OF BLOCK b0 WITH FRAME TITLE text-s01.
SELECT-OPTIONS: s_matnr  FOR  v_matnr,
                s_matkl  FOR  v_matkl,
                s_werks  FOR  v_werks,
                s_ekgrp  FOR  v_ekgrp.
SELECTION-SCREEN END OF BLOCK b0.

START-OF-SELECTION.

  PERFORM f_select_data.
  PERFORM f_show_alv USING 'ZSMM_LISTA_SERV30'.
*&---------------------------------------------------------------------*
*&      Form  F_SELECT_DATA
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*  -->  p1        text
*  <--  p2        text
*----------------------------------------------------------------------*

*   2 – Seleção de dados ( Usar os dados criados em DATA )
*  INTO TABLE = copia dados de uma tabela para uma nova tabela.
*  INNER JOIN = Faz junção entre duas ou mais tabelas que tem
*                                                       entrelaçamento.
FORM f_select_data .
  SELECT  mara~matnr
          mara~mtart
          mara~meins
          mara~matkl
          marc~werks
          marc~ekgrp
          mbew~vprsv
          mbew~verpr
          mbew~stprs
          mbew~peinh
    INTO TABLE t_serv
    FROM mara INNER JOIN marc
    ON mara~matnr EQ marc~matnr
    INNER JOIN mbew
    ON  marc~matnr EQ mbew~matnr
    AND marc~werks EQ mbew~bwkey
    WHERE
        mara~matnr     IN s_matnr
        AND mara~mtart EQ 'DIEN' "Tratar isso com STVARV
        AND mara~matkl IN s_matkl
        AND marc~werks IN s_werks "Centro
        AND marc~ekgrp IN s_ekgrp."Grupo de Compradores
*   Validando SELECT:
  IF t_serv[] IS INITIAL.
    MESSAGE e208(00) WITH 'NENHUM REGISTRO ENCONTRADO!!!'.
  ENDIF.

* Select do Material
  SELECT matnr
         maktx
    INTO TABLE t_makt
    FROM makt
    FOR ALL ENTRIES IN t_serv
    WHERE matnr EQ t_serv-matnr
      AND spras EQ sy-langu.

* Select da Moeda
  SELECT   t001w~werks
         	 t001~waers
    INTO TABLE t_waers
    FROM t001w INNER JOIN t001k
    ON t001k~bwkey EQ t001w~bwkey
    INNER JOIN t001"Tabela Empresa
    ON t001~bukrs EQ t001k~bukrs
    WHERE t001w~werks IN s_werks.

  SORT t_makt   BY  matnr.
  SORT t_waers  BY  werks.

  LOOP AT t_serv INTO wa_serv.
    CLEAR: wa_makt,
           wa_waers.
    APPEND INITIAL LINE TO t_out ASSIGNING <lfs_line>.

    MOVE-CORRESPONDING wa_serv TO <lfs_line>.

* SE O CAMPO MBEW- VPRSV FOR IGUAL A ‘V’ TRANSFERIR
* O VALOR DE MBEW-VERPR/PEINH PARA ZPRECO_00,
* SENAO MBEW-STPRS/PEINH = ZPRECO_00

    IF wa_serv-vprsv EQ 'V'.
      <lfs_line>-preco = ( wa_serv-verpr / wa_serv-peinh ).
    ELSE.
      <lfs_line>-preco = ( wa_serv-stprs / wa_serv-peinh ).
    ENDIF.

* ---------- Textos de Material ---------------------
* BINARY SEARCH = pesquisa mais rapido, mas os
*                     dados precisam está ordenados
    READ TABLE t_makt INTO wa_makt
    WITH KEY matnr  = <lfs_line>-matnr BINARY SEARCH.
    IF sy-subrc IS INITIAL."Verificando Se deu certo
      <lfs_line>-maktx = wa_makt-maktx.
    ENDIF.

* ---------- Textos de Moeda ---------------------
    READ TABLE t_waers INTO wa_waers
    WITH KEY werks  = <lfs_line>-werks BINARY SEARCH.
    IF sy-subrc IS INITIAL."Verificando Se deu certo
      <lfs_line>-waers = wa_waers-waers.
    ENDIF.
  ENDLOOP.

ENDFORM.
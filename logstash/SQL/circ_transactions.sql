SELECT
  circ_trans.id,
  circ_trans.transaction_gmt AS circ_timestamp,
  circ_trans.application_name AS circ_app,
  circ_trans.source_code AS circ_source,
  circ_trans.op_code AS circ_operation,
  circ_trans.item_location_code AS item_location,
  circ_trans.patron_home_library_code AS patron_branch,
  bib_view.title AS item_title,
  user_defined_pcode3_myuser.name AS patron_municipality,
  statistic_group_myuser.location_code AS circ_branch,
  itype_property_myuser.name AS item_type,
  ptype_property_myuser.name AS patron_type
FROM
  sierra_view.circ_trans
  LEFT OUTER JOIN sierra_view.user_defined_pcode3_myuser
  ON (
      CASE WHEN user_defined_pcode3_myuser.code ~ :num_pattern
      then CAST (user_defined_pcode3_myuser.code AS SMALLINT)
      ELSE NULL
      end
  ) = circ_trans.pcode3
  LEFT OUTER JOIN sierra_view.bib_view
  ON circ_trans.bib_record_id = bib_view.id
  LEFT OUTER JOIN sierra_view.itype_property_myuser
  ON circ_trans.itype_code_num = itype_property_myuser.code
  LEFT OUTER JOIN sierra_view.statistic_group_myuser
  ON circ_trans.stat_group_code_num = statistic_group_myuser.code
  LEFT OUTER JOIN sierra_view.ptype_property_myuser
  ON (
      CASE WHEN circ_trans.ptype_code ~ :num_pattern 
      then CAST (circ_trans.ptype_code AS SMALLINT)
      ELSE NULL
      end
  ) = ptype_property_myuser.value
WHERE
  circ_trans.id > :sql_last_value
ORDER BY id

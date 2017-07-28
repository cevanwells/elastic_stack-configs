SELECT 
  `tbluserpcrdetail`.`pcrKey` AS `id`,
  `tbluserpcrdetail`.`pcrDateTime` AS `session_timestamp`,
  `tbluserpcrdetail`.`pcrBranch` AS `branch`,
  `tbluserpcrdetail`.`pcrPC` AS `computer`,
  (
    CASE `tbluserpcrdetail`.`pcrIsGuest` 
    WHEN 0 THEN 'No' 
    ELSE 'Yes' 
    END
  ) AS `is_guest`,
  `tbluserpcrdetail`.`pcrQuotedWait` AS `quoted_wait`,
  `tbluserpcrdetail`.`pcrActualWait` AS `actual_wait`,
  `tbluserpcrdetail`.`pcrStartTime` AS `start_time`,
  `tbluserpcrdetail`.`pcrStopTime` AS `end_time`,
  `tbluserpcrdetail`.`pcrExtraTimeExtensions` AS `times_extended`,
  `tbluserpcrdetail`.`pcrMinutesUsed` AS `minutes_used`,
  (
  	CASE `tbluserpcrdetail`.`pcrWhereMade` 
  	WHEN 1 THEN 'PC' 
  	WHEN 2 THEN 'Reservation Station' 
  	WHEN 3 THEN 'Management Console' 
  	WHEN 4 THEN 'Web Module' 
  	WHEN 5 THEN 'Staff' 
  	ELSE 'Unknown' 
  	END
  ) AS `reservation_location`,
  (
  	CASE `tbluserpcrdetail`.`pcrStatus` 
  	WHEN 512 THEN 'No' 
  	WHEN 1024 THEN 'Yes' 
  	END
  ) AS `session_interrupted` 
 FROM 
   `tbluserpcrdetail` 
 WHERE 
   ((`tbluserpcrdetail`.`pcrStatus` = 512) or (`tbluserpcrdetail`.`pcrStatus` = 1024)) 
 ORDER BY 
   `tbluserpcrdetail`.`pcrKey` DESC
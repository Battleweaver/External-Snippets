SELECT 
	CASE 
		WHEN LEFT(table1.campaignid, 3) = 'fbn' THEN date(table2.date)
      	WHEN LEFT(table1.campaignid, 3) = 'gsn' THEN date(table2_1.date)
    END as "Date",
	table1.accountid,
	table1.campaignid,
	table1.channel,	
	CASE 
    WHEN LEFT(table1.campaignid, 3) = 'fbn' THEN table2.start_date 
    WHEN LEFT(table1.campaignid, 3) = 'gsn' THEN table2_1.start_date 
  END as "Start Date",
  CASE 
    WHEN LEFT(table1.campaignid, 3) = 'fbn' THEN table2.end_date 
    WHEN LEFT(table1.campaignid, 3) = 'gsn' THEN table2_1.end_date 
  END as "End Date",
  CASE 
    WHEN LEFT(table1.campaignid, 3) = 'fbn' THEN to_char (date(table2.date), 'Day')
    WHEN LEFT(table1.campaignid, 3) = 'gsn' THEN to_char (date(table2_1.date), 'Day')
  END as "Day of the week",
  CASE 
    WHEN LEFT(table1.campaignid, 3) = 'fbn' THEN table2.clicks
     WHEN LEFT(table1.campaignid, 3) = 'gsn' THEN table2_1.clicks
  END as "Clicks",
  CASE 
  WHEN LEFT(table1.campaignid, 3) = 'fbn' THEN table2.views
      WHEN LEFT(table1.campaignid, 3) = 'gsn' THEN table2_1.views
  END as "Views",
  CASE 
    WHEN LEFT(table1.campaignid, 3) = 'fbn' THEN 
      CASE
        WHEN table2.end_date is null then 0
        ELSE 1
      END
    WHEN LEFT(table1.campaignid, 3) = 'gsn' then
      CASE
        WHEN table2_1.end_date is null then 0
      ELSE 1
    END
  END as "Life Campaign count",
  CASE 
    WHEN LEFT(table1.campaignid, 3) = 'fbn' THEN 'fbn'
    WHEN LEFT(table1.campaignid, 3) = 'gsn' THEN 'gsn'
  END as "Network"
FROM table1
LEFT JOIN table2 
  ON table1.campaignid = table2.campaignid 
LEFT JOIN table2_1 
  ON table1.campaignid = table2_1.campaignid 

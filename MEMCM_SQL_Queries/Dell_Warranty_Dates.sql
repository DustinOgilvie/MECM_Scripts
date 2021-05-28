Select distinct
	sys.Netbios_Name0 AS 'Computer Name',
	CS.Model0 AS 'Model',
	AWI.WarrantyEndDate0 AS 'Warranty End Date',
	DATEDIFF (day, CURRENT_TIMESTAMP, WarrantyEndDate0) as 'Warranty Days Left'
From
	dbo.v_R_System sys
	inner join dbo.v_gs_computer_system CS on (CS.ResourceID = sys.ResourceID)
	inner join dbo.v_GS_DELL_ASSETWARRANTYINFORMATION0 AWI on (AWI.ResourceID = sys.ResourceID)

WHERE
	AWI.WarrantyEndDate0 IS NOT NULL
	
Order by
	AWI.WarrantyEndDate0 DESC;
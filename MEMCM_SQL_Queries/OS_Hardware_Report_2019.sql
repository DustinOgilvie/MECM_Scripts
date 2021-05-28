select  distinct  
	sys.Netbios_Name0 AS 'Computer Name',
	max(ou.System_OU_Name0) as 'OU',
	sys.AD_Site_Name0 as 'AD Site',
	sys.User_Name0 as 'User Name', 
	OS.Caption0 AS 'Operating System', 
	OS.CSDVersion0 AS 'Service Pack', 
		CASE
			WHEN OSN.Operating_System_Name_and0 like '%workstation%'
			THEN
			(CASE
				WHEN OS.Version0 like '5.%' THEN 'Windows XP'
				WHEN OS.Version0 like '6.0.%' THEN 'Windows Vista'
				WHEN OS.Version0 like '6.1.%' THEN 'Windows 7'
				WHEN OS.Version0 like '6.2.%' THEN 'Windows 8'
				WHEN OS.Version0 like '6.3.%' THEN 'Windows 8.1'
				WHEN OS.Version0 like '10.0.10240' THEN 'Windows 10 v1507'
				WHEN OS.Version0 like '10.0.10586' THEN 'Windows 10 v1511'
				WHEN OS.Version0 like '10.0.14393' THEN 'Windows 10 v1607'
				WHEN OS.Version0 like '10.0.15063' THEN 'Windows 10 v1703'
				WHEN OS.Version0 like '10.0.16299' THEN 'Windows 10 v1709'
				WHEN OS.Version0 like '10.0.17134' THEN 'Windows 10 v1803'
				WHEN OS.Version0 like '10.0.17763' THEN 'Windows 10 v1809'
				WHEN OS.Version0 like '10.0.18362' THEN 'Windows 10 v1903'
				WHEN OS.Version0 like '10.0.18363' THEN 'Windows 10 v1909'
				WHEN OS.Version0 like '10.0.19033' THEN 'Windows 10 v2004'
				END)
			WHEN OSN.Operating_System_Name_and0 like '%server%'
			THEN
			(CASE
				WHEN OS.Version0 like '5.2%' THEN 'Windows Server 2003'
				WHEN OS.Version0 like '6.0.%' THEN 'Windows Server 2008'
				WHEN OS.Version0 like '6.1.%' THEN 'Windows Server 2008 R2'
				WHEN OS.Version0 like '6.2.%' THEN 'Windows Server 2012'
				WHEN OS.Version0 like '6.3.%' THEN 'Windows Server 2012 R2'
				WHEN OS.Version0 like '10.0.14393' THEN 'Windows Server 2016'
				WHEN OS.Version0 like '10.0.16299' THEN 'Windows Server 1709'
				WHEN OS.Version0 like '10.0.17134' THEN 'Windows Server 2016 (1803)'
				WHEN OS.Version0 like '10.0.17763' THEN 'Windows Server 2019'
			END)
			END AS 'OS Version',
			OS.Version0 AS 'Version #',
		(CASE
			WHEN OSN.Operating_System_Name_and0 like '%Workstation%' THEN 'Workstation'
			WHEN OSN.Operating_System_Name_and0 like '%Server%' THEN 'Server'
			END)AS 'Type',
	SEU.SerialNumber0 AS 'Serial Number',  
	CS.Model0 AS 'Model', 
	WS.LastHWScan AS 'Last Hardware Scan', 
	RAM.TotalPhysicalMemory0 AS 'Memory (KBytes)',  
	PRO.NormSpeed0 AS 'Processor (GHz)',
	BIOS.ReleaseDate0 as 'BIOS Date',
	SE.ChassisTypes0 as 'Chassis Type'

 from 
	dbo.v_R_System sys
	left outer join dbo.v_RA_System_SystemOUName ou on (ou.ResourceID = sys.ResourceID)
	inner join dbo.v_GS_OPERATING_SYSTEM OS on (sys.ResourceID = OS.ResourceID) 
	inner join dbo.v_R_System OSN on (sys.ResourceID = OSN.ResourceID)
	inner join dbo.v_GS_SYSTEM_ENCLOSURE_UNIQUE SEU on (SEU.ResourceID = sys.ResourceID) 
	inner join dbo.v_GS_COMPUTER_SYSTEM CS on (CS.ResourceID = sys.ResourceID)  
	inner join dbo.v_GS_X86_PC_MEMORY RAM on (RAM.ResourceID = sys.ResourceID)  
	inner join dbo.v_GS_PROCESSOR PRO on (PRO.ResourceID = sys.ResourceID) 
	inner join dbo.v_GS_PC_BIOS BIOS on (BIOS.ResourceID = sys.ResourceID)
	inner join dbo.v_GS_WORKSTATION_STATUS WS on (WS.ResourceID = sys.ResourceID) 
	inner join dbo.v_FullCollectionMembership FCM on (FCM.ResourceID = sys.ResourceID)
	inner join dbo.v_GS_SYSTEM_ENCLOSURE SE on (SE.ResourceID = sys.ResourceID)

 group by 
	sys.Netbios_Name0, 
	ou.ResourceID,
	sys.AD_Site_Name0,
	sys.User_Name0, 
	OS.Caption0, 
	OS.CSDVersion0,
	OS.Version0,
	OSN.Operating_System_Name_and0,
	SEU.SerialNumber0, 
	CS.Model0, 
	WS.LastHWScan, 
	RAM.TotalPhysicalMemory0, 
	PRO.NormSpeed0,
	BIOS.ReleaseDate0,
	sys.ResourceID,
	SE.ChassisTypes0
 Order by 
	sys.Netbios_Name0
select TYPE, OS, Sum(Count) as 'Count' from (
select Distinct 'Workstations' as 'Type', (
 CASE
 WHEN OPSYS.Version0 like '5.%' THEN 'Windows XP'
 WHEN OPSYS.Version0 like '6.0.%' THEN 'Windows Vista'
 WHEN OPSYS.Version0 like '6.1.%' THEN 'Windows 7'
 WHEN OPSYS.Version0 like '6.2.%' THEN 'Windows 8'
 WHEN OPSYS.Version0 like '6.3.%' THEN 'Windows 8.1'
 WHEN OPSYS.Version0 like '10.0.10240' THEN 'Windows 10 v1507'
 WHEN OPSYS.Version0 like '10.0.10586' THEN 'Windows 10 v1511'
 WHEN OPSYS.Version0 like '10.0.14393' THEN 'Windows 10 v1607'
 WHEN OPSYS.Version0 like '10.0.15063' THEN 'Windows 10 v1703'
 WHEN OPSYS.Version0 like '10.0.16299' THEN 'Windows 10 v1709'
 WHEN OPSYS.Version0 like '10.0.17134' THEN 'Windows 10 v1803'
 WHEN OPSYS.Version0 like '10.0.17763' THEN 'Windows 10 v1809'
 WHEN OPSYS.Version0 like '10.0.18362' THEN 'Windows 10 v1903'
 WHEN OPSYS.Version0 like '10.0.18363' THEN 'Windows 10 v1909'
 WHEN OPSYS.Version0 like '10.0.19033' THEN 'Windows 10 v2004'
 Else OPSYS.Version0
 END 
 ) AS 'OS',
Count(OPsys.ResourceID)as count from v_GS_OPERATING_SYSTEM OPSYS
join v_R_System S on S.ResourceID=OPSYS.ResourceID
where S.Operating_System_Name_and0 like '%workstation%'
Group by OPSYS.Version0) WSQuery
Group by Type, OS
UNION
select TYPE, OS, Sum(Count) from (
select Distinct 'Servers' as 'Type', (
 CASE
 WHEN OPSYS.Version0 like '5.2%' THEN 'Windows Server 2003'
 WHEN OPSYS.Version0 like '6.0.%' THEN 'Windows Server 2008'
 WHEN OPSYS.Version0 like '6.1.%' THEN 'Windows Server 2008 R2'
 WHEN OPSYS.Version0 like '6.2.%' THEN 'Windows Server 2012'
 WHEN OPSYS.Version0 like '6.3.%' THEN 'Windows Server 2012 R2'
 WHEN OPSYS.Version0 like '10.0.14393' THEN 'Windows Server 2016'
 WHEN OPSYS.Version0 like '10.0.16299' THEN 'Windows Server 1709'
 WHEN OPSYS.Version0 like '10.0.17134' THEN 'Windows Server 2016 (1803)'
 WHEN OPSYS.Version0 like '10.0.17763' THEN 'Windows Server 2019'
 END 
 ) AS 'OS',
Count(OPsys.ResourceID)as count from v_GS_OPERATING_SYSTEM OPSYS
join v_R_System S on S.ResourceID=OPSYS.ResourceID
where S.Operating_System_Name_and0 like '%server%'
Group by OPSYS.Version0) SVRQuery
Group by Type, OS
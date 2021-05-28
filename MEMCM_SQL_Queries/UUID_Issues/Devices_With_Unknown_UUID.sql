SELECT sys.Name0, sys.SMS_Unique_Identifier0, un.Description0 AS 'Built-In Unknown Computer Object', un.SiteCode0
FROM v_R_System AS sys LEFT OUTER JOIN
UnknownSystem_DISC AS un ON sys.SMS_Unique_Identifier0 = un.SMS_Unique_Identifier0
WHERE sys.SMS_Unique_Identifier0 IN (SELECT SMS_Unique_Identifier0
FROM UnknownSystem_DISC)
SELECT DISTINCT TOP 200
  NormalizedName,
  NormalizedPublisher,
  NormalizedVersion,
  COUNT(DISTINCT ResourceID) AS QTY
FROM 
  dbo.v_GS_INSTALLED_SOFTWARE_CATEGORIZED
GROUP BY
  NormalizedName,
  NormalizedPublisher,
  NormalizedVersion
ORDER BY QTY DESC
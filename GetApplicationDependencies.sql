SELECT
    FromApps.DisplayName AS 'Parent Application'
    ,ToApps.DisplayName AS 'Dependency'
FROM
    vSMS_AppDependenceRelation_Flat ad
    INNER JOIN fn_ListApplicationCIs(1003) FromApps ON FromApps.CI_ID=ad.FromApplicationCIID
    INNER JOIN fn_ListApplicationCIs(1033) ToApps ON ToApps.CI_ID=ad.ToApplicationCIID
WHERE FromApps.DisplayName <> ToApps.DisplayName
GROUP BY fromapps.DisplayName, toapps.DisplayName
ORDER BY fromapps.DisplayName

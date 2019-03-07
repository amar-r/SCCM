SELECT
    ts.Name AS 'Task Sequence'
    ,pkg.Name AS 'Software Name'
FROM
    v_Package pkg
    INNER JOIN v_TaskSequencePackageReferences tsref ON tsref.RefPackageID=pkg.PackageID
    INNER JOIN v_TaskSequencePackage ts ON ts.PackageID=tsref.PackageID
GROUP BY ts.Name, pkg.Name
ORDER BY ts.Name, pkg.Name
-- Search by Task Sequence WHERE ts.Name = <Task Sequence Name>
-- Search by Software name WHERE pkg.Name = <Software Name>

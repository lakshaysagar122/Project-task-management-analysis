USE InternshipData;
GO

-- 1. Project-wise Total Tasks
SELECT
    Project_Name,
    COUNT(*) AS TotalTasks
FROM SalesData
GROUP BY Project_Name
ORDER BY TotalTasks DESC;


-- 2. Project-wise Average Progress
SELECT
    Project_Name,
    AVG(
        TRY_CONVERT(decimal(5,2), REPLACE(Progress, '%', ''))
    ) AS AvgProgress
FROM SalesData
GROUP BY Project_Name
ORDER BY AvgProgress DESC;


-- 3. Task Status Classification
SELECT
    Project_Name,
    Task_Name,
    Assigned_to,
    Progress,
    CASE
        WHEN TRY_CONVERT(INT, REPLACE(Progress, '%', '')) = 100
            THEN 'Completed'
        WHEN TRY_CONVERT(INT, REPLACE(Progress, '%', '')) > 0
            THEN 'In Progress'
        ELSE 'Not Started'
    END AS TaskStatus
FROM SalesData;


-- 4. Overall Task Status Count
SELECT
    CASE
        WHEN TRY_CONVERT(INT, REPLACE(Progress, '%', '')) = 100
            THEN 'Completed'
        WHEN TRY_CONVERT(INT, REPLACE(Progress, '%', '')) > 0
            THEN 'In Progress'
        ELSE 'Not Started'
    END AS TaskStatus,
    COUNT(*) AS TotalTasks
FROM SalesData
GROUP BY
    CASE
        WHEN TRY_CONVERT(INT, REPLACE(Progress, '%', '')) = 100
            THEN 'Completed'
        WHEN TRY_CONVERT(INT, REPLACE(Progress, '%', '')) > 0
            THEN 'In Progress'
        ELSE 'Not Started'
    END
ORDER BY TotalTasks DESC;


-- 5. Pending Tasks
SELECT
    Project_Name,
    Task_Name,
    Assigned_to,
    Start_Date,
    End_Date,
    Progress
FROM SalesData
WHERE TRY_CONVERT(INT, REPLACE(Progress, '%', '')) < 100
ORDER BY TRY_CONVERT(INT, REPLACE(Progress, '%', '')) DESC;


-- 6. Employee-wise Workload
SELECT
    Assigned_to,
    COUNT(*) AS TotalTasks
FROM SalesData
GROUP BY Assigned_to
ORDER BY TotalTasks DESC;


-- 7. Employee-wise Average Progress
SELECT
    Assigned_to,
    AVG(
        TRY_CONVERT(decimal(5,2), REPLACE(Progress, '%', ''))
    ) AS AvgProgress
FROM SalesData
GROUP BY Assigned_to
ORDER BY AvgProgress DESC;


-- 8. Project-wise Employee Workload
SELECT
    Project_Name,
    Assigned_to,
    COUNT(*) AS TotalTasks
FROM SalesData
GROUP BY
    Project_Name,
    Assigned_to
ORDER BY
    Project_Name,
    TotalTasks DESC;


-- 9. Project-wise Pending Tasks
SELECT
    Project_Name,
    COUNT(*) AS PendingTasks
FROM SalesData
WHERE TRY_CONVERT(INT, REPLACE(Progress, '%', '')) < 100
GROUP BY Project_Name
ORDER BY PendingTasks DESC;


-- 10. Project-wise Total Tasks + Average Progress
SELECT
    Project_Name,
    COUNT(*) AS TotalTasks,
    AVG(
        TRY_CONVERT(decimal(5,2), REPLACE(Progress, '%', ''))
    ) AS AvgProgress
FROM SalesData
GROUP BY Project_Name
ORDER BY AvgProgress DESC;


-- 11. Project-wise Status Breakdown
SELECT
    Project_Name,
    CASE
        WHEN TRY_CONVERT(INT, REPLACE(Progress, '%', '')) = 100
            THEN 'Completed'
        WHEN TRY_CONVERT(INT, REPLACE(Progress, '%', '')) > 0
            THEN 'In Progress'
        ELSE 'Not Started'
    END AS TaskStatus,
    COUNT(*) AS TotalTasks
FROM SalesData
GROUP BY
    Project_Name,
    CASE
        WHEN TRY_CONVERT(INT, REPLACE(Progress, '%', '')) = 100
            THEN 'Completed'
        WHEN TRY_CONVERT(INT, REPLACE(Progress, '%', '')) > 0
            THEN 'In Progress'
        ELSE 'Not Started'
    END
ORDER BY
    Project_Name,
    TotalTasks DESC;
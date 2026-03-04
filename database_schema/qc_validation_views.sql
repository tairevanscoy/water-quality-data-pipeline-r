-- Example Quality Control (QC) validation queries
-- These SQL views demonstrate common automated data checks used
-- in environmental monitoring databases.

--------------------------------------------------
-- 1. Missing Result Values
--------------------------------------------------
CREATE VIEW QC_MissingResults AS
SELECT
    ResultID,
    EventID,
    ParameterID,
    ResultValue
FROM Results
WHERE ResultValue IS NULL;


--------------------------------------------------
-- 2. Negative Values (invalid for many parameters)
--------------------------------------------------
CREATE VIEW QC_NegativeValues AS
SELECT
    ResultID,
    EventID,
    ParameterID,
    ResultValue
FROM Results
WHERE ResultValue < 0;


--------------------------------------------------
-- 3. Duplicate Measurements
--------------------------------------------------
CREATE VIEW QC_DuplicateResults AS
SELECT
    EventID,
    ParameterID,
    COUNT(*) AS DuplicateCount
FROM Results
GROUP BY EventID, ParameterID
HAVING COUNT(*) > 1;


--------------------------------------------------
-- 4. Results Outside Expected Detection Limits
--------------------------------------------------
CREATE VIEW QC_OutsideDetectionLimit AS
SELECT
    r.ResultID,
    r.EventID,
    p.ParameterName,
    r.ResultValue,
    p.DetectionLimit
FROM Results r
JOIN Parameters p
ON r.ParameterID = p.ParameterID
WHERE r.ResultValue < p.DetectionLimit;
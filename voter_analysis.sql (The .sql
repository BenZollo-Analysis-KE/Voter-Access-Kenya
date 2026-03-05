-- PROJECT: Voter Accessibility Analysis (Kenya 2027)
-- OBJECTIVE: Identify "High-Risk" stations with high density and low turnout.

-- 1. Create a virtual table to calculate the "Crowding Factor"
SELECT 
    Station_Name, 
    Ward, 
    Registered_Voters, 
    Votes_Cast,
    (Votes_Cast * 100.0 / Registered_Voters) AS Turnout_Percentage
FROM 
    Kibera_2022_Data
WHERE 
    Registered_Voters > 10000  -- Focusing on high-density "Serious Problems"
ORDER BY 
    Turnout_Percentage ASC;    -- Show the lowest turnout first (The Crisis Zones)

-- 2. Sociology Insight: Identify stations needing "Decentralization"
-- If turnout is below 65% at a major station, we flag it for GIS buffering.
SELECT 
    Station_Name, 
    'NEEDS NEW SUB-STATION' AS Policy_Recommendation
FROM 
    Kibera_2022_Data
WHERE 
    Turnout_Percentage < 65.0 AND Registered_Voters > 10000;

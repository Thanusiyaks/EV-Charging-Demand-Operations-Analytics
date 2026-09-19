CREATE DATABASE ev_charging_analytics;
USE ev_charging_analytics;
CREATE TABLE charging_sessions (
    Session_ID VARCHAR(10) PRIMARY KEY,
    Station_ID VARCHAR(10),
    Vehicle_ID VARCHAR(10),
    Session_Date DATE,
    Start_Time TIME,
    End_Time TIME,
    Energy_Consumed_kWh DECIMAL(10,2),
    Charging_Duration_Min INT,
    Waiting_Time_Min INT,
    Charger_Type VARCHAR(20),
    Vehicle_Type VARCHAR(20),
    Location VARCHAR(100),
    Charging_Status VARCHAR(20),
    Payment_Method VARCHAR(30)
);
SELECT COUNT(*) 
FROM charging_sessions;
SELECT *
FROM charging_sessions
LIMIT 10;
SELECT COUNT(*) AS Total_Charging_Sessions
FROM charging_sessions;
SELECT SUM(Energy_Consumed_kWh) AS Total_Energy_Consumed
FROM charging_sessions;
SELECT AVG(Energy_Consumed_kWh) AS Average_Energy_Per_Session
FROM charging_sessions;
SELECT AVG(Charging_Duration_Min) AS Average_Charging_Duration
FROM charging_sessions;
SELECT AVG(Waiting_Time_Min) AS Average_Waiting_Time
FROM charging_sessions;
SELECT 
    Station_ID,
    COUNT(Session_ID) AS Total_Sessions
FROM charging_sessions
GROUP BY Station_ID
ORDER BY Total_Sessions DESC;
SELECT 
    Station_ID,
    SUM(Energy_Consumed_kWh) AS Total_Energy
FROM charging_sessions
GROUP BY Station_ID
ORDER BY Total_Energy DESC;
SELECT 
    Station_ID,
    AVG(Charging_Duration_Min) AS Average_Charging_Duration
FROM charging_sessions
GROUP BY Station_ID
ORDER BY Average_Charging_Duration DESC;
SELECT 
    HOUR(Start_Time) AS Charging_Hour,
    COUNT(Session_ID) AS Total_Sessions
FROM charging_sessions
GROUP BY HOUR(Start_Time)
ORDER BY Total_Sessions DESC;
SELECT 
    DAYNAME(Session_Date) AS Day_Name,
    COUNT(Session_ID) AS Total_Sessions
FROM charging_sessions
GROUP BY DAYNAME(Session_Date)
ORDER BY Total_Sessions DESC;
SELECT 
    DATE_FORMAT(Session_Date, '%Y-%m') AS Month,
    COUNT(Session_ID) AS Total_Sessions
FROM charging_sessions
GROUP BY DATE_FORMAT(Session_Date, '%Y-%m')
ORDER BY Month;
SELECT 
    Charger_Type,
    COUNT(Session_ID) AS Total_Sessions
FROM charging_sessions
GROUP BY Charger_Type
ORDER BY Total_Sessions DESC;
SELECT 
    Charger_Type,
    SUM(Energy_Consumed_kWh) AS Total_Energy
FROM charging_sessions
GROUP BY Charger_Type
ORDER BY Total_Energy DESC;
SELECT 
    Vehicle_Type,
    COUNT(Session_ID) AS Total_Sessions
FROM charging_sessions
GROUP BY Vehicle_Type
ORDER BY Total_Sessions DESC;
SELECT 
    Location,
    COUNT(Session_ID) AS Total_Sessions
FROM charging_sessions
GROUP BY Location
ORDER BY Total_Sessions DESC;
SELECT 
    Charging_Status,
    COUNT(Session_ID) AS Total_Sessions
FROM charging_sessions
GROUP BY Charging_Status;
SELECT 
    COUNT(CASE WHEN Charging_Status = 'Failed' THEN 1 END) * 100.0 
    / COUNT(*) AS Failed_Session_Rate
FROM charging_sessions;
SELECT 
    Station_ID,
    COUNT(Session_ID) AS Total_Sessions,
    CASE
        WHEN COUNT(Session_ID) >= 110 THEN 'High Utilization'
        WHEN COUNT(Session_ID) >= 90 THEN 'Medium Utilization'
        ELSE 'Low Utilization'
    END AS Utilization
FROM charging_sessions
GROUP BY Station_ID
ORDER BY Total_Sessions DESC;

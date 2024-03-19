
                                                --- Patient safety Analysis---
use patient_safety;

select* from patient_safety1;

select* from ae_outcomes;

-- 1. Count total no of patients admitted to hospital 
select count(Name) from patient_safety1;

 --- 2 Calculate the average age of patients by gender
 SELECT Gender, AVG(Age) AS AvgAge
FROM patient_safety1
GROUP BY Gender;

ALTER TABLE ae_outcomes
RENAME COLUMN `Patient Id` TO Patient_id;

ALTER TABLE patient_safety1
RENAME COLUMN `Adverse event` TO Adverse_event;

-- 3 Which suspect drug caused max adverse events 
SELECT Suspect_drug, COUNT(Adverse_event) AS Suspect_drug_count
FROM patient_safety1
GROUP BY Suspect_drug;

--- 4 Calculate age group of patients as Adult, Elderly, Child.

SELECT 
Age, 
CASE
        WHEN age> 65 then 'elderly'
        WHEN age between 18 and 64 THEN 'adult'
        ELSE 'child'
    END AS 'age group'
FROM
    patient_safety1;
    
    CREATE VIEW patient_age_groups AS 
SELECT 
    Age, 
    CASE
        WHEN Age > 65 THEN 'elderly'
        WHEN Age BETWEEN 18 AND 64 THEN 'adult'
        ELSE 'child'
    END AS age_group
FROM
    patient_safety1;
    
    
    select* from patient_age_groups;
    
    select age_group ,count(Age) from patient_age_groups group by age_group;
    
    
    --- 5. Count no_of_patients who are having particular medical history
    select Medical_history, count(Name) as no_of_patients from patient_safety1 group by Medical_history;
    
    
    --- 6. Calculate Male and Female patients.
    select Gender,count(Name) from patient_safety1 group by Gender;
    
    ALTER TABLE patient_safety1 RENAME COLUMN `Discharge Date` TO Discharge_Date;
    
    
    --- 7 Show those patients name whose billing amount is greater than average billing amount

select avg(Billing_Amount) from patient_safety1;

SELECT Name, Billing_Amount FROM patient_safety1 WHERE billing_amount > (SELECT AVG(Billing_Amount)FROM patient_safety1);

--- 8 Severity wise patients 
Select Severity, count(Adverse_event) as No_of_patients from patient_safety1 group by severity;

--- 9 
SELECT Suspect_Drug, COUNT(*) AS NumEvents
FROM patient_safety1
GROUP BY Suspect_Drug
ORDER BY NumEvents DESC
LIMIT 1;

--- 10 Identify patients who had a specific lab test with abnormal results
select name, Lab_test,Test_Results from patient_safety1 where Test_Results='Abnormal';

--- 11
SELECT Name, Adverse_event, ae_outcomes.Outcome
FROM patient_safety1
right JOIN ae_outcomes ON patient_safety1.PatientId = ae_outcomes.Patient_Id;

--- 12 Left join 2 tables 
SELECT Name, Adverse_Event, ae_outcomes.Outcome FROM patient_safety1 left JOIN ae_outcomes ON patient_safety1.Patient_Id = ae_outcomes. Patient_Id;

--- 13 Left join 
SELECT patient_safety1.Name, ae_outcomes.Ethnicity 
FROM patient_safety1 
RIGHT JOIN ae_outcomes ON ae_outcomes.Patient_Id = patient_safety1.Patient_Id;

--- 14 select the count of each adverse event
SELECT Adverse_event, COUNT(Adverse_event) AS event_count
FROM patient_safety1
GROUP BY Adverse_event
ORDER BY event_count DESC
LIMIT 3;

--- 15 Return Name, AE, and outcome containing Not recovered.

SELECT patient_safety1.Name, patient_safety1.Adverse_event, ae_outcomes.outcome
FROM patient_safety1
RIGHT JOIN ae_outcomes ON ae_outcomes.Patient_Id = patient_safety1.Patient_Id
WHERE ae_outcomes.outcome = 'Not recovered';



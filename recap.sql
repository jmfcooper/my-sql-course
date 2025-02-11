/*
Foundation Recap Exercise

Use the table PatientStay.  
This lists 44 patients admitted to London hospitals over 5 days between Feb 26th and March 2nd 2024
*/

SELECT
	*
FROM
	PatientStay ps ;

/*
1. List the patients -
a) in the Oxleas or PRUH hospitals and
b) admitted in February 2024
c) only the Surgery wards

2. Show the PatientId, AdmittedDate, DischargeDate, Hospital and Ward columns only, not all the columns.
3. Order results by AdmittedDate (latest first) then PatientID column (high to low)
4. Add a new column LengthOfStay which calculates the number of days that the patient stayed in hospital, inclusive of both admitted and discharge date.
*/

-- Write the SQL statement here
SELECT
	*
FROM
	PatientStay ps 
WHERE ps.Hospital in ('Oxleas','PRUH') 
AND ps.AdmittedDate between '2024-02-01' AND '2024-02-29'
AND ps.Ward like '%Surgery';

SELECT  ps.PatientId, 
        ps.AdmittedDate, 
        ps.DischargeDate, 
        ps.Hospital, 
        ps.Ward, 
        DATEDIFF(DAY,ps.AdmittedDate,ps.DischargeDate)+1 as LengthOfStay,
        --DATEADD(DAY, -14, ps.AdmittedDate) as ReminderDate
        DATEADD(WEEK, -2, ps.AdmittedDate) as ReminderDate
FROM
	PatientStay ps 
ORDER By ps.AdmittedDate DESC, ps.PatientId ASC;

SELECT  ps.Hospital
        ,Sum(ps.Tariff) as TotalTariff
        ,count(*) as NumberOfPatients
FROM
	PatientStay ps 
GROUP BY ps.Hospital
HAVING count(*) >10
ORDER BY NumberOfPatients DESC

SELECT * 
FROM PatientStay ps 
JOIN DimHospital h ON ps.Hospital=h.Hospital
WHERE h.Type='Teaching'

SELECT  ps.PatientId
        ,ps.admittedDate
        ,h.[Type]
        ,h.Hospital 
FROM PatientStay ps 
LEFT JOIN DimHospitalBad h ON ps.Hospital=h.Hospital
WHERE h.Type='Teaching'
OR h.[Type] IS NULL



/*
5. How many patients has each hospital admitted? 
6. How much is the total tarriff for each hospital?
7. List only those hospitals that have admitted over 10 patients
8. Order by the hospital with most admissions first
*/

-- Write the SQL statement here


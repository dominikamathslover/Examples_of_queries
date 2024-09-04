/*
Question 11. 
Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

Query:
*/

SELECT 
 	    (MAX(weight)-MIN(weight)) AS max_height_difference
FROM 	patients
WHERE 
	    last_name ='Maroni'

/*
Question 12.
Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

Query:
*/

SELECT 
 	    day(admission_date), count(patient_id)
FROM 	admissions
GROUP BY
	    day(admission_date)
ORDER BY
	    count(patient_id) DESC

/*
Question 12.
Show all columns for patient_id 542's most recent admission_date.

Query:
*/

SELECT 
	    *
FROM 	admissions
WHERE 	patient_id = 542
GROUP BY 
	    patient_id
HAVING
  	    admission_date = MAX(admission_date);

/*
Question 13.
Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.

Query:
*/

SELECT 
	    patient_id, 
	    attending_doctor_id, 
	    diagnosis
FROM 	admissions
WHERE 	(MOD(patient_id,2)=1 AND attending_doctor_id in(1,5,19))
	    OR 
	    (attending_doctor_id like '%2%' and LEN(patient_id)=3 )


/*
Question 14.
Show first_name, last_name, and the total number of admissions attended for each doctor.
Every admission has been attended by a doctor.


Query:
*/

SELECT 
	    doctors.first_name, 
	    doctors.last_name, 
	    COUNT(attending_doctor_id)
FROM 	admissions JOIN doctors ON doctors.doctor_id = admissions.attending_doctor_id
GROUP BY 
        attending_doctor_id

/*
Question 15.
For each doctor, display their id, full name, and the first and last admission date they attended.

Query:
*/

SELECT 
	    doctors.doctor_id,
        CONCAT(doctors.first_name, ' ',  doctors.last_name) AS full_name, 
        MIN(admission_date),
        Max(admission_date)  
FROM 	admissions JOIN doctors ON doctors.doctor_id = admissions.attending_doctor_id
GROUP BY 
	    doctor_id
		
/*
Question 16.
Display the total amount of patients for each province. Order by descending.

Query:
*/

SELECT 
	    province_names.province_name, 
	    COUNT(patient_id)
FROM 	patients JOIN province_names ON province_names.province_id = patients.province_id
GROUP BY 
	    province_names.province_name
ORDER BY 
        COUNT(patient_id) DESC

/*
Question 17.
For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.

Query:
*/

SELECT
  	    CONCAT(patients.first_name, ' ', patients.last_name) as patient_full_name, 
        diagnosis,
  	    CONCAT(doctors.first_name,' ',doctors.last_name) as doctor_full_name
FROM 	patients
  JOIN 	admissions ON admissions.patient_id = patients.patient_id
  JOIN 	doctors ON doctors.doctor_id = admissions.attending_doctor_id

/*
Question 18.
Display the first name, last name and number of duplicate patients based on their first name and last name.

Query:
*/

SELECT
  	    first_name, 
	    last_name, 
	    COUNT(concat(first_name, last_name)) AS number_of_repetitions
FROM 	patients
GROUP BY 
	    CONCAT(first_name, last_name)
HAVING 	COUNT(concat(first_name, last_name))>=2


/*
Question 19.
Display patient's full name,height in the units feet rounded to 1 decimal, weight in the unit pounds rounded to 0 decimals, birth_date, gender non abbreviated.

Convert CM to feet by dividing by 30.48.
Convert KG to pounds by multiplying by 2.205.

Query:
*/

SELECT
    	CONCAT(first_name, ' ', last_name) AS 'patient_full_name', 
    	ROUND(height / 30.48, 1) AS 'height "Feet"', 
    	ROUND(weight * 2.205, 0) AS 'weight "Pounds"', 
    	birth_date,
CASE
	WHEN gender = 'M' THEN 'MALE' 
  	ELSE 'FEMALE' 
END AS 'gender'
FROM 	patients

/*
Question 20.
Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)

Query:
*/

SELECT
  	    patients.patient_id,
  	    first_name,
  	    last_name
FROM 	patients
WHERE 	patients.patient_id NOT IN (SELECT admissions.patient_id FROM admissions)

/*
Question 31. 
Show all of the patients grouped into weight groups.
Show the total amount of patients in each weight group.
Order the list by the weight group decending.

For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.

Query:
*/

SELECT
  	COUNT(patient_id) AS patients_in_group,
  	FLOOR(weight / 10) * 10 AS weight_group
FROM 	patients
GROUP BY 
	weight_group
ORDER BY 
	weight_group DESC;

/*
Question 32. 
Show patient_id, weight, height, isObese from the patients table.
Display isObese as a boolean 0 or 1.
Obese is defined as weight(kg)/(height(m)2) >= 30.
weight is in units kg.
height is in units cm.

Query:
*/

SELECT
  	patient_id,
  	weight,
  	height, 
  	(weight/(height*height*0.0001)) >= 30 AS isObese
FROM 	patients

/*
Question 33. 
Show patient_id, first_name, last_name, and attending doctor's specialty.
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
Check patients, admissions, and doctors tables for required information.

Query:
*/ 

SELECT
  	patients.patient_id,
  	patients.first_name,
  	patients.last_name,
  	doctors.specialty
FROM 	patients 	JOIN admissions ON admissions.patient_id = patients.patient_id
			        JOIN doctors	ON doctors.doctor_id = admissions.attending_doctor_id
WHERE 	admissions.diagnosis ='Epilepsy'AND doctors.first_name = 'Lisa'

/*
Question 34. 
All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date

Query:
*/ 

SELECT DISTINCT
  	    admissions.patient_id,
    	CONCAT(admissions.patient_id,len(patients.last_name),year(patients.birth_date)) AS temp_password
FROM 	patients JOIN admissions ON admissions.patient_id = patients.patient_id

/*
Question 35.
Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.


Query:
*/ 

SELECT 
	CASE WHEN patient_id % 2 = 0 Then 
    		'Yes'
	ELSE 
    		'No' 
	END AS has_insurance,
	SUM(CASE WHEN patient_id % 2 = 0 Then 
    		10
	ELSE 
    		50 
	END) AS cost_after_insurance
FROM 	
		admissions 
GROUP BY 
		has_insurance;

/*
Question 36.
Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name


Query:
*/ 

SELECT
		province_names.province_name
FROM 		patients JOIN province_names ON province_names.province_id = patients.province_id
GROUP BY	province_name
HAVING		COUNT( CASE WHEN gender = 'M' THEN 1 END) > COUNT( CASE WHEN gender = 'F' THEN 1 END);


/*
Question 37.

We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston'

Query:
*/ 

SELECT
	*
FROM 	patients
WHERE 	first_name LIKE '__r%' 	AND gender ='F'
				AND month(birth_date) IN (2,5,12)
				AND (weight BETWEEN 60 AND 80) 
				AND patient_id %2 =1 
				AND city ='Kingston'
/*
Question 38.
Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.

Query:
*/ 

SELECT 
   	CONCAT(ROUND(SUM(gender='M') / CAST(COUNT(*) AS float), 4) * 100, '%')
FROM 	patients

/*
Question 39.
For each day display the total amount of admissions on that day. Display the amount changed from the previous date.

Query:
*/ 

SELECT
 		admission_date,
 		COUNT(admission_date),
 		COUNT(admission_date) - LAG(count(admission_date)) OVER(ORDER BY admission_date) AS admission_change 
FROM 		admissions
GROUP BY 	admission_date

/*
Question 39.
Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.

Query:
*/ 

SELECT  	province_name
FROM		province_names
ORDER BY 	(CASE WHEN province_name = 'Ontario' THEN 0 ELSE 1 END),
  		province_name


/*
Question 40.

We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.

Query:
*/ 

SELECT
	    doctors.doctor_id,
    	concat(doctors.first_name, ' ',doctors.last_name) AS doctor_full_name,
    	doctors.specialty,
    	YEAR(admissions.admission_date),
    	COUNT(year(admissions.admission_date))
FROM
	doctors JOIN admissions ON admissions.attending_doctor_id = doctors.doctor_id
GROUP BY
	doctor_full_name, year(admission_date)
ORDER BY
	doctor_id

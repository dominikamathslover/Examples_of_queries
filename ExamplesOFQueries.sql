/*
Question 1. 
Display every patient's first_name.
Order the list by the length of each name and then by alphabetically.

Query:
*/
SELECT 
	first_name
FROM 	patients
ORDER BY 
	len(first_name), first_name

/*
Question 2. 
Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.

Query:
*/
SELECT 
  	(SELECT count(*) FROM patients WHERE gender='M') AS male_count, 
  	(SELECT count(*) FROM patients WHERE gender='F') AS female_count;

/*
Question 3.
Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.

Query:
*/
SELECT 
	first_name, last_name, allergies
FROM 	patients
WHERE 
	allergies in('Penicillin','Morphine')
ORDER BY 
	allergies asc, first_name, last_name

/*
Question 4.
Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.

Query:
*/
SELECT
  	patient_id,
  	diagnosis
FROM 	admissions
GROUP BY
  	patient_id,
  	diagnosis
HAVING 	COUNT(*) > 1;

/*
Question 5. 

Show the city and the total number of patients in the city.
Order from most to least patients and then by city name ascending.

Query:
*/
SELECT
  	city, count(patient_id) AS number_of_patients
FROM 	patients
GROUP BY 
	city
ORDER BY 
	count(city) desc, city asc
/*

Question 6. 
Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor"

Query: 
*/
SELECT first_name, last_name, 'Patient' as role FROM patients
    UNION ALL 
SELECT first_name, last_name, 'Doctor' from doctors;

/*
Question 7.
Show all allergies ordered by popularity. Remove NULL values from query.

Query: 
*/
SELECT 	
	allergies, count(patient_id)
FROM 	patients
WHERE 	allergies IS NOT null
GROUP BY 
	allergies
ORDER BY 
	count(patient_id) DESC

/*
Question 8. 
Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.

Query: 
*/
SELECT 
	first_name, last_name, birth_date
FROM 	patients
WHERE 	year(birth_date) BETWEEN 1970 AND 1979
ORDER BY 
	birth_date ASC

/*
Question 9. 
We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order


QUERY:
*/ 
SELECT 
 	concat(upper(last_name), ',',lower(first_name)) AS full_name
FROM 	patients
ORDER BY 
	first_name DESC

/*
Question 10. 
Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7000.


Query: 
*/
SELECT 
 	province_id, SUM(height)
FROM 	patients
GRUOP BY 
	province_id
HAVING 	SUM(height) >= 7000





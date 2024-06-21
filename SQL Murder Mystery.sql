/*challenge found at https://mystery.knightlab.com/ */

--check what types of crimes there are to find murder to make sure spelling is consistent
SELECT type
FROM crime_scene_report
GROUP BY type
;


--Find murders on the given date
SELECT *
FROM crime_scene_report
WHERE type = 'murder'
	AND date = 20180115
;
            

/*RESULTS	
Security footage shows that there were 2 witnesses. The first witness lives at the last house on "Northwestern Dr". The second witness, named Annabel, lives somewhere on "Franklin Ave".
*/

--Investigate Annabel on Franklin Ave
SELECT *
FROM person
WHERE name LIKE '%Annabel%'
;

/*RESULTS
id	name	license_id	address_number	address_street_name	ssn
16371	Annabel Miller	490173	103	Franklin Ave	318771143
*/

--Check her interview
SELECT *
FROM interview
WHERE person_id = 16371
;

/*RESULTS
person_id	transcript
16371	I saw the murder happen, and I recognized the killer from my gym when I was working out last week on January the 9th.
*/

--Check gym records from Jan 9
SELECT *
FROM get_fit_now_check_in
WHERE check_in_date = 20180109
;

/*
too many records. 
Find Annabel's gym ID number to find what time she was at the gym and narrow it to those who overlapped.
*/
--Find Annabel's Gym ID
SELECT *
FROM get_fit_now_member
WHERE person_id = 16371
;

/*
id	person_id	name	membership_start_date	membership_status
90081	16371	Annabel Miller	20160208	gold
*/

--Find what time she was there on Jan 9
SELECT *
FROM get_fit_now_check_in
WHERE check_in_date = 20180109
	AND membership_id = 90081
;	

/*
membership_id	check_in_date	check_in_time	check_out_time
90081	20180109	1600	1700
*/

--find members who checked out AFTER she checked in and check in BEFORE she checked out.
SELECT *
FROM get_fit_now_check_in
WHERE check_in_date = 20180109
	AND check_in_time <= 1700
	AND check_out_time >= 1600
;	

/*There are two besides Annabel
membership_id	check_in_date	check_in_time	check_out_time
48Z7A	20180109	1600	1730
48Z55	20180109	1530	1700
*/

--Get the names of the gym members who overlapped with Annabel
SELECT *
FROM get_fit_now_member
WHERE id = '48Z7A'
	OR id = '48Z55'
;	

/*RESULTS
id	person_id	name	membership_start_date	membership_status
48Z55	67318	Jeremy Bowers	20160101	gold
48Z7A	28819	Joe Germuska	20160305	gold
*/

/*
Look into the other witness
*/
--See who lives in the last house on Northwestern Dr
--assuming 'Last House' means highest number
SELECT *
FROM person
WHERE address_street_name = 'Northwestern Dr'
ORDER BY address_number DESC
LIMIT 1
;	

/*RESULTS
id	name	license_id	address_number	address_street_name	ssn
14887	Morty Schapiro	118009	4919	Northwestern Dr	111564949
*/

--Check Morty's interview
SELECT *
FROM interview
WHERE person_id=14887
;	

/*RESULTS
person_id	transcript
14887	I heard a gunshot and then saw a man run out. He had a "Get Fit Now Gym" bag. The membership number on the bag started with "48Z". Only gold members have those bags. The man got into a car with a plate that included "H42W".
*/

--Both members who overlapped with Annabel at the gym have membership numbers starting with 48Z.
--Check license plates that include H42W
SELECT *
FROM drivers_license
WHERE plate_number LIKE '%H42W%'
;	

/*RESULTS
id	age	height	eye_color	hair_color	gender	plate_number	car_make	car_model
183779	21	65	blue	blonde	female	H42W0X	Toyota	Prius
423327	30	70	brown	brown	male	0H42W2	Chevrolet	Spark LS
664760	21	71	black	black	male	4H42WR	Nissan	Altima
*/

--Check the names of these people
SELECT *
FROM person
WHERE license_id IN (183779, 423327, 664760)
;	

/*RESULTS
id	name	license_id	address_number	address_street_name	ssn
51739	Tushar Chandra	664760	312	Phi St	137882671
67318	Jeremy Bowers	423327	530	Washington Pl, Apt 3A	871539279
78193	Maxine Whitely	183779	110	Fisk Rd	137882671
*/


--Jeremy Bowers overlapped with Annabel at the gym! Let's check the solution
INSERT INTO solution VALUES (1, 'Jeremy Bowers');
        
        SELECT value FROM solution;

/*RESULTS
Congrats, you found the murderer! But wait, there's more... If you think you're up for a challenge, try querying the interview transcript of the murderer to find the real villain behind this crime. If you feel especially confident in your SQL skills, try to complete this final step with no more than 2 queries. Use this same INSERT statement with your new suspect to check your answer.
*/

--Let's continue to find the real villain!
--Check Jeremy's interview
SELECT *
FROM interview
WHERE person_id = 67318
;	

/*RESULTS
person_id	transcript
67318	I was hired by a woman with a lot of money. I don't know her name but I know she's around 5'5" (65") or 5'7" (67"). She has red hair and she drives a Tesla Model S. I know that she attended the SQL Symphony Concert 3 times in December 2017.
*/

--find the names of red haired women who drive teslas and attended the SQL symphony concert 3 times in december 2017
--Challenging myself to do this in one query (with subqueries)
SELECT name
FROM person
WHERE id IN (
  --find person ids of red haired women who drive teslas and attended the SQL symphony concert
  SELECT person_id
	FROM facebook_event_checkin
	WHERE event_name = 'SQL Symphony Concert'
		AND person_id IN (
		  	--find the ids of red haired women who drive teslas
		  	SELECT id
	  		FROM person
	  		WHERE license_id IN (
			  --Find red haired women who drive Teslas
			  SELECT id
			  FROM drivers_license
			  WHERE hair_color = 'red'
		  		AND gender = 'female'
		  		AND car_make = 'Tesla'
		  )
	  )
	GROUP BY person_id
 )
 ;


/*RESULTS
name
Miranda Priestly
*/

--check the solution
INSERT INTO solution VALUES (1, 'Miranda Priestly');
        
        SELECT value FROM solution;

/*RESULTS
Congrats, you found the brains behind the murder! Everyone in SQL City hails you as the greatest SQL detective of all time. Time to break out the champagne!
*/








clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"





/* 	This do-file includes the following sections
	1. Data cleaning based on INEGI criteria. 
	2. Merge the datasets for each of the year/quarters considered for the study. 
	3. Append all the merged datasets to create a unique pool dataset 
	4. Create a unique identification variable based on INEGI criteria 
	5. Drop irrelevant variables
	6. Compress the pool dataset. */

/* 	INEGI recommends to always uses the SDEM dataset as the reference dataset 
	and then merge it with the datasets that includes the questions that you are interested in. 
	But before doing that, it is necessary to execute a data cleaning process. 
	
	Therefore, I have to create a loop to perform the data cleaning and merge the datasets. */

// 	Create a folder where the merged datasets are going to be stored
	cd "${root}/2_data-storage"	
	capture mkdir merge_datasets
	
// 	Now, change the working directory to indicate Stata the file path of the raw datasets that I will merge. 	
	cd "${root}/2_data-storage/bases_enoe"	
	
// 	Creating the loop  	
	local year_quarter ///
	116 /// 1st quarter of 2016
	217 /// 2nd quarter of 2017
	318 /// 3rd quarter of 2018
	419 //	4th quarter of 2019	
	
	
foreach year_q of local year_quarter {

use SDEMT`year_q' // Always use the SDEM dataset for each quarter as a reference. 

// DATA CLEANING BASED ON INEGI CRITERIA

	/* INEGI explains that it is necessary to execute a data cleaning process in the demographic dataset (SDEM) 
	in case you want to combine it with the employment datasets (COE1 and COE2)
	All the specifications are explained in page 13 of the following document: 
	https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/doc/con_basedatos_proy2010.pdf  */

	/* Nevertheless, before starting with the data cleaning process, I need to generate a variable that 
	counts the total number of people living in the household (including kids), as this is a variable that 
	will be used in the regression analysis */	

	// To do so, I first need to create the unique household ID based on INEGI instructions.  
	egen house_id_per  = concat(cd_a ent con v_sel n_hog h_mud per), punct(.)		
	
	// Now I will ask stata to create the variable that counts the total number of household members. 
	egen hh_members = total(eda>=0), by(house_id_per) 
	summarize hh_members	
	
	// Now I will ask stata to create a variable that captures the presence of kids (5 years or younger). 
	egen hh_kids = total(eda<=5), by(house_id_per) 
	summarize hh_kids

	// After doing this, I will ask stata to erase the unique household ID
	drop house_id_per 	
	
	/* After this data creation, I need to follow INEGI's criteria to merge datasets. */
	
	/* First, INEGI recommends to drop all the kids below 12 years old from the sample because 
	those kids where not interviewed in the employment survey. Therefore, it is not necesary to keep them. 
	More specifically, all values between 00 and 11 as well as those equal to 99 should be dropped. 
	Remember that variable "eda" is equal to "age".*/
	
	drop if eda<=11
	drop if eda==99

	/* Second, INEGI recommends to drop all the individual that didn't 
	complete the interview. More specifically, the explain that I should 
	eliminate those interviews where the variable "r_def" is different from 
	"00", since "r_def" is the definitive result of the interview and 
	"00" indicates that the interview was completed. */

	drop if r_def!=00 

	/* 	Third, INEGI recommends to drop all the interviews of people who 
	were absent during the interview, since there is no labor information 
	or the questionnaire was not applied to the absentees. 	More specifically, 
	they explain that I should eliminate those interviews where the variable 
	"c_res" is equal to "2", since "c_res" shows the residence condition and 
	"2" is for definitive absentees.  */
	
	drop if c_res==2 

	
// MERGE PROCESS 

	* Now that the data cleaning process is complete, I will start the merging process. 
	* The first step is to merge the SDEM Database with the COE1 survey 
	merge 1:1 cd_a ent con v_sel n_hog h_mud n_ren using COE1T`year_q'
	rename _merge merge_COE1T`year_q'
	tab merge_COE1T`year_q' // Data quality check: All observations matched.

	* The second step is to merge the SDEM Database with the COE2 survey 
	merge 1:1 cd_a ent con v_sel n_hog h_mud n_ren using COE2T`year_q'
	rename _merge merge_COE2T`year_q'
	tab merge_COE2T`year_q' // Data quality check: All observations matched.
	
	* The third step is to save the merged datasets. 
	save "${root}/2_data-storage/merge_datasets/merge_enoe`year_q'.dta", replace
	
}










// APPEND PROCESS 
// Now that the datasets are merged, I will append them all to create a unique pool dataset.  

// 	Create a folder where the pool dataset is going to be stored
	cd 	"${root}/2_data-storage"	
	capture mkdir pool_dataset
	
	clear
	cd 		"${root}/2_data-storage/merge_datasets"
	use 			merge_enoe116
	append	using 	merge_enoe217
	append	using	merge_enoe318
	append	using	merge_enoe419
	save 	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419.dta", replace


	
	/*	Now that I have the pool dataset for each of the 4 year/quarters considered for this study...	
	It is time to ask Stata to erase the merged_datasets as they are taking storage space and 
	they are no longer needed. */
	cd 		"${root}/2_data-storage/merge_datasets"
	erase 	merge_enoe116.dta	
	erase 	merge_enoe217.dta	
	erase 	merge_enoe318.dta	
	erase 	merge_enoe419.dta	
	cd 		"${root}/2_data-storage"
	rmdir 	merge_datasets


	
	
	
	
	
	
	
//	UNIQUE IDENTIFICATION VARIABLE BASED ON INEGI CRITERIA	
	
// 	unique id for each household
	egen house_id  = concat(cd_a ent con v_sel n_hog h_mud), 		punct(.)  
// 	unique_id for each respondent
	egen person_id = concat(cd_a ent con v_sel n_hog h_mud n_ren), 	punct(.) 

/* 	Data quality check: 
	person_id shouldn't have duplicates, so I will check if this is true. */
	duplicates report person_id
	
/* Duplicates in terms of person_id
--------------------------------------
   Copies | Observations       Surplus
----------+---------------------------
        1 |       237801             0
        2 |       248490        124245
        3 |       368835        245890
        4 |       396168        297126
-------------------------------------- */

/* 	The above result shows that there are several observations that are repeated. 
	The reason why this is happening is because I am not including 
	the variable "per" as an additional variable to uniquely identify individuals.
	The variable "per" indicates the period when the survey was done. 
	If I don't include it, there could be different people using the same ID in 
	different surveys. Let's say one person with the ID "1.9.501.1.1.0.1" in the survey 
	for 2005, and a different person with the same ID "1.9.501.1.1.0.1" in the 
	survey for 2019. Therefore, although INEGI doesn't include "per" as variable that 
	should be used to create the ID variable, for this study it is necessary to include it
	to uniquely identify individuals in the sample. */

egen person_id_per = concat(cd_a ent con v_sel n_hog h_mud n_ren per), 	punct(.)
duplicates report person_id_per

/* Duplicates in terms of person_id_per
--------------------------------------
   Copies | Observations       Surplus
----------+---------------------------
        1 |      1251294             0
--------------------------------------
*/

/* 	Now that the problem is solved, 
	I should drop the person_id variable and only mantain person_id_per */
	drop person_id

	
	
	
	
	
/* 	Data quality check: 
	person_id shouldn't have duplicates, so I will check if this is true. */
	duplicates report house_id	
	
/* Duplicates in terms of house_id
--------------------------------------
   Copies | Observations       Surplus
----------+---------------------------
        1 |         4910             0
        2 |        23848         11924
        3 |        20451         13634
        4 |        27888         20916
        5 |        36225         28980
        6 |        52710         43925
        7 |        78680         67440
        8 |       104424         91371
        9 |       127008        112896
       10 |       138930        125037
       11 |       140888        128080
       12 |       128400        117700
       13 |       109564        101136
       14 |        86366         80197
       15 |        62145         58002
       16 |        42240         39600
       17 |        27115         25520
       18 |        16596         15674
       19 |        10488          9936
       20 |         5600          5320
       21 |         3318          3160
       22 |         1826          1743
       23 |          644           616
       24 |          456           437
       25 |          300           288
       26 |          130           125
       27 |           54            52
       30 |           90            87
-------------------------------------- */	
	
egen house_id_per  = concat(cd_a ent con v_sel n_hog h_mud per), 		punct(.)	
duplicates report house_id_per	
	
/*
Duplicates in terms of house_id_per

--------------------------------------
   Copies | Observations       Surplus
----------+---------------------------
        1 |        53693             0
        2 |       302400        151200
        3 |       311361        207574
        4 |       302868        227151
        5 |       168165        134532
        6 |        68760         57300
        7 |        26229         22482
        8 |        10664          9331
        9 |         3852          3424
       10 |         1920          1728
       11 |          869           790
       12 |          300           275
       13 |          117           108
       14 |           14            13
       15 |           30            28
       16 |           16            15
       18 |           36            34
--------------------------------------	
	
*/

// It is normal to have more than one household ID in a dataset, as there could be more than one individual living in the household. 

/* 	Now that the problem is solved, 
	I should drop the house_id variable and only mantain house_id_per */
	drop house_id
	
	
save "${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419.dta", replace











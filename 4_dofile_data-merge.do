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
	All the specifications are explained in page 13 of the following document: */

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






























// 	Now, change the working directory to indicate Stata the file path of the raw datasets that I will merge. 	



local year_quarter ///
116 /// 1st quarter of 2016
217 /// 2nd quarter of 2017
318 /// 3rd quarter of 2018
419 //	4th quarter of 2019	

foreach year_q of local year_quarter {

cd "${root}/2_data-storage/bases_enoe"
use SDEMT`year_q'

// (Dropping variables based on INEGI instructions)
// INEGI explains that it is necessary to execute a data cleaning process in the 
// demographic dataset (SDEM) to combine it with the employment datasets (COE1 and COE2)
drop if eda<=11 // Drop kids between 00 and 11 years old 
drop if eda==99 // Drop everyone with age 99 
drop if r_def!=00 // Drop anything different from "00", which is the indicator that interview was completed
drop if c_res==2 // "c_res" shows the residence condition and "2" is for definitive absentees. Drop them.  
replace e_con=. if e_con==9 // "9" is for those who "Doesn't know their marital situation"

*************************
***** Merge Process *****
*************************

merge 1:1 cd_a ent con v_sel n_hog h_mud n_ren using COE1T`year_q'
rename _merge merge_COE1T`year_q'
tab merge_COE1T`year_q' // Data quality check: 

merge 1:1 cd_a ent con v_sel n_hog h_mud n_ren using COE2T`year_q'
rename _merge merge_COE2T`year_q'
*Data quality check.
tab merge_COE2T`year_q' // Data quality check: 

* The third step is to save the merged datasets. 
save "${root}/2_data-storage/merge_datasets/merge_enoe`year_q'.dta", replace

}
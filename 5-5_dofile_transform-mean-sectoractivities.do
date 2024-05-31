clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-const-activities.dta" 





// GENERATE NEW VARIABLES: CHARACTERISTICS OF ECONOMIC ACTIVITIES (AVERAGES AND PERCENTAGES)			
			

// 	Variable "cat_52_scian" will be used to uniquely identify each economic activity.
						
// First, create a folder to store all the calculations. 
cd "${root}/2_data-storage"
capture mkdir data_econ_activities			
			
					
// WORKING HOURS

	// Average working hours in each economic activity			
	preserve
	collapse (mean) hrsocup [fweight=fac], by (cat_scian_50) 			
	rename hrsocup hrsocup_50 		
	save "${root}/2_data-storage/data_econ_activities/hrsocup_50.dta", replace
	restore 	
	
	// Average working hours of WOMEN each economic activity		
	preserve
	keep if female==1
	collapse (mean) hrsocup [fweight=fac], by (cat_scian_50) 			
	rename hrsocup hrsocup_50_female 		
	save "${root}/2_data-storage/data_econ_activities/hrsocup_50_female.dta", replace
	restore 		
	
	// Average working hours of MEN each economic activity	
	preserve
	keep if female==0
	collapse (mean) hrsocup [fweight=fac], by (cat_scian_50) 			
	rename hrsocup hrsocup_50_male 		
	save "${root}/2_data-storage/data_econ_activities/hrsocup_50_male.dta", replace
	restore 		
		
	
// LEVEL OF EDUCATION


	// Generate variable to identify people with high education levels
	generate high_educ=.
	replace  high_educ=0 if inlist(educ, 0,1,2,3,4)
	replace  high_educ=1 if educ==5
	
	// Percentage of people with bachelors, masters or phd in each economic activity 
	preserve
	collapse (mean) high_educ [fweight=fac], by (cat_scian_50) 			
	rename high_educ high_educ_50 		
	save "${root}/2_data-storage/data_econ_activities/high_educ_50.dta", replace
	restore 	
		
	// Percentage of WOMEN with bachelors, masters or phd in each economic activity	
	preserve
	keep if female==1
	collapse (mean) high_educ [fweight=fac], by (cat_scian_50) 			
	rename high_educ high_educ_50_female 		
	save "${root}/2_data-storage/data_econ_activities/high_educ_50_female.dta", replace
	restore 	
		
	// Percentage of MEN with bachelors, masters or phd in each economic activity	
	preserve
	keep if female==0
	collapse (mean) high_educ [fweight=fac], by (cat_scian_50) 			
	rename high_educ high_educ_50_male 		
	save "${root}/2_data-storage/data_econ_activities/high_educ_50_male.dta", replace
	restore 		
	
		
		// Generate variable to identify people with high education levels
		generate low_educ=.
		replace  low_educ=1 if inlist(educ,0,1,2)	
		replace  low_educ=0 if inlist(educ,3,4,5)
			
		// Percentage of people with secondary school or less, in each economic activity 
		preserve
		collapse (mean) low_educ [fweight=fac], by (cat_scian_50)	
		rename low_educ low_educ_50 		
		save "${root}/2_data-storage/data_econ_activities/low_educ_50.dta", replace
		restore 
			
		// Percentage of WOMEN with secondary school or less, in each economic activity 
		preserve
		keep if female==1
		collapse (mean) low_educ [fweight=fac], by (cat_scian_50)	
		rename low_educ low_educ_50_female 		
		save "${root}/2_data-storage/data_econ_activities/low_educ_50_female.dta", replace
		restore 	
			
		// Percentage of MEN with secondary school or less, in each economic activity 
		preserve
		keep if female==0
		collapse (mean) low_educ [fweight=fac], by (cat_scian_50)	
		rename low_educ low_educ_50_male 		
		save "${root}/2_data-storage/data_econ_activities/low_educ_50_male.dta", replace
		restore 	
	
	
// PERCENTAGE OF WOMEN WORKING IN EACH ECONOMIC ACTIVITY 

	// Percentage of women in each economic activity 
	preserve
	collapse (mean) female [fweight=fac], by (cat_scian_50) 			
	save "${root}/2_data-storage/data_econ_activities/female.dta", replace
	restore 	
	
	

	
	
	
	
	
	
	
	
	
	
	
	
	
// INFORMAL CATEGORIZATION IN EACH ECONOMIC ACTIVITY  
		
	// Formal job, formal sector
	preserve
	generate formal_formal=.
	replace  formal_formal=1 if cat_informal==1
	replace  formal_formal=0 if cat_informal==2
	replace  formal_formal=0 if cat_informal==3
	collapse (mean) formal_formal [fweight=fac], by (cat_scian_50) 
	
	save "${root}/2_data-storage/data_econ_activities/formal_formal.dta", replace
	restore
	
	// Informal job, formal sector
	preserve
	generate informal_formal=.
	replace  informal_formal=0 if cat_informal==1
	replace  informal_formal=1 if cat_informal==2
	replace  informal_formal=0 if cat_informal==3
	collapse (mean) informal_formal [fweight=fac], by (cat_scian_50) 
	save "${root}/2_data-storage/data_econ_activities/informal_formal.dta", replace
	restore	

	// Informal job, informal sector
	preserve
	generate informal_informal=.
	replace  informal_informal=0 if cat_informal==1
	replace  informal_informal=0 if cat_informal==2
	replace  informal_informal=1 if cat_informal==3
	tab cat_scian_50 informal_informal [fweight=fac], row nofreq
	collapse (mean) informal_informal [fweight=fac], by (cat_scian_50) 
	save "${root}/2_data-storage/data_econ_activities/informal_informal.dta", replace
	restore		
	

// PERCENTAGE OF PEOPLE WORKING IN EACH ECONOMIC ACTIVITY AS A SHARE OF TOTAL LABOUR FORCE IN THE ECONOMY. 
	
	preserve 
	generate working=.
	replace  working=1 if clase2==1
	replace  working=0 if inlist(clase2, 2,3,4)
	keep if  working==1
	collapse (percent) working [fweight=fac], by (cat_scian_50)
	save "${root}/2_data-storage/data_econ_activities/share_total_cat50.dta", replace
	restore
	tab cat_scian_50 [fweight=fac]

	
	
	


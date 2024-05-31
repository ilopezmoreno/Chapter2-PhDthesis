clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-recode.dta" 

***************************************
***** Data Transformation Process *****
***************************************


			
			
// GENERATE NEW VARIABLES: INDIVIDUAL  CHARACTERISTICS

// Generate dummy variables to identify males and females.
			gen 	female=.
			replace female=1 if sex==2
			replace female=0 if sex==1
			label 	variable female "Female Identificator" 
			label 	define female 0 "Men" 1 "Women", replace
			label 	value female female
			drop 	sex

// Number of sons or daughters
			generate num_kids=.
			replace num_kids=0 if n_hij==0 
			replace num_kids=1 if n_hij==1
			replace num_kids=2 if n_hij==2
			replace num_kids=3 if n_hij==3
			replace num_kids=4 if n_hij==4
			replace num_kids=5 if n_hij>4 & n_hij<30
			label var num_kids "In total, how many live-born sons and daughters have you had?"
			label define num_kids 		/// 
			0 "No sons or daughters" 	///
			1 "1 son or daughter" 		///
			2 "2 sons or daughters" 	///
			3 "3 sons or daughters" 	///
			4 "4 sons or daughters" 	///
			5 "5 or more sons or daughters"
			label value num_kids num_kids
			tab num_kids
			tab n_hij num_kids // Data quality Check: Variable was created correctly
					
// Level of education
			generate educ=.
			replace educ=0 if cs_p13_1==0 // No studies at all
			replace educ=0 if cs_p13_1==1 // Pre-School
			replace educ=1 if cs_p13_1==2 // Elementary School
			replace educ=2 if cs_p13_1==3 // Secondary School
			replace educ=3 if cs_p13_1==4 // High School
			replace educ=4 if cs_p13_1==5 // Teacher Training 
			replace educ=4 if cs_p13_1==6 // Technical Career 
			replace educ=5 if cs_p13_1==7 // Bachelors 
			replace educ=5 if cs_p13_1==8 // Masters 
			replace educ=5 if cs_p13_1==9 // PhD 
			label var educ "Level of education"
			label define educ /// 
			0 "No Studies" ///
			1 "Primary School" ///
			2 "Secondary School" ///
			3 "High School" /// 
			4 "Technical Career" /// 
			5 "Graduate or post-graduate"
			label value educ educ
			tab educ cs_p13_1
			drop cs_p13_1
			
// Working age categories (Between 18 and 65)
			generate working_age=. 
			replace working_age=1 if eda<=17 
			replace working_age=2 if eda>17 & eda<66
			replace working_age=3 if eda>=66
			label var working_age "People in Working Ages"
			label define working_age 1 "Below 18 years old" 2 "Between 18 & 65 years old" 3 "Above 65 years old"
			label value working_age working_age
			tab eda working_age // Data quality Check: Variable was created correctly			


// Informal employment categories

/* 
Generate variable to categorize three types of employment:
1 - Empleo formal
2 - Empleo informal en el sector formal
3 - Empleo informal en el sector informal */
			tab emp_ppal tue_ppal
			fre tue_ppal
							
			generate cat_informal=.
			replace  cat_informal=1 if emp_ppal==0  				// Formal job
			replace  cat_informal=2 if emp_ppal==1 & tue_ppal==1 	// Informal job in the formal sector 			
			replace  cat_informal=3 if emp_ppal==1 & tue_ppal==0  	// Informal job in the informal sector
			
			label define cat_informal				/// 
			1 "Formal job, formal sector"			///
			2 "Informal job, formal sector" 		///
			3 "Informal job, informal sector" 	
			label value cat_informal cat_informal
			
			

			
			
			
	
			
			
			
// GENERATE NEW VARIABLES: HOUSEHOLD CHARACTERISTICS
			
// Socio-economic stratum
			generate soc_str=.
			replace soc_str=1 if est==10 
			replace soc_str=2 if est==20 
			replace soc_str=3 if est==30 
			replace soc_str=4 if est==40 
			tab soc_str
			label define soc_str 1 "Low" 2 "Medium-Low" 3 "Medium-High" 4 "High", replace 
			label value soc_str soc_str 
			tab soc_str [fweight=fac]
			fre soc_str
			drop est			
			


			
			
			
	
		
// GENERATE NEW VARIABLES: HOUSEHOLD HEAD CHARACTERISTICS
				
by house_id_per, sort: egen hh_count = total(par_c==101)
fre hh_count //	Consistency check: All cases have only one household head. 

/* 	Create variables to capture age, sex, education, and 
	labor status of the household head */

foreach x in eda female educ clase1 {
	by house_id_per, sort: egen hhh_`x' = max(cond(par_c==101, `x', .))
}			




			
			
// GENERATE NEW VARIABLES: WORKING CHARACTERISTICS			

	
// Dummy variable to identify informal jobs
			generate informal_jobs=.
			replace  informal_jobs=1 if emp_ppal==1 // Informal job 
			replace  informal_jobs=0 if emp_ppal==2 // Formal job 
			label variable informal_jobs "Informal jobs identificator" 
			label define informal_jobs 1 "Informal job" 2 "Formal job", replace
			label value informal_jobs informal_jobs			
			
// Dummy variable to identify the informal sector
			generate informal_sector=.
			replace  informal_sector=1 if tue_ppal==1 // Informal job 
			replace  informal_sector=0 if tue_ppal==2 // Formal job 
			label variable informal_sector "Informal sector identificator" 
			label define informal_sector 1 "Informal sector" 2 "Outside informal sector", replace
			label value informal_sector informal_jobs
									
// Categorical variable to identify people workin in the primary, secondary or terciary sector. 
			generate P4A_Sector=.
			rename p4a P4A 
			replace P4A_Sector=1 if P4A>=1100 & P4A<=1199 
			// If values in P4A are between 1100 & 1199 classify as PRIMARY SECTOR
			replace P4A_Sector=2 if P4A>=2100 & P4A<=3399 
			// If values in P4A are between 2100 & 2399 classify as SECONDARY SECTOR
			replace P4A_Sector=3 if P4A>=4300 & P4A<=9399 
			// If values in P4A are between 4300 & 9399 classify as TERCIARY SECTOR
			replace P4A_Sector=4 if P4A>=9700 & P4A<=9999 
			// If values in P4A are between 9700 & 9999 classify as UNSPECIFIED ACTIVITIES
			// Define values of variable P4A_Sector
			label var P4A_Sector "Economic Sector Categories"
			label define P4A_Sector ///
			1 "Primary Sector" 2 "Secondary Sector" 3 "Terciary Sector" 4 "Unspecified Sector"
			label value P4A_Sector P4A_Sector
			tab P4A_Sector // Data quality check. Result: 0 missing values

// Generate a categorical variable that captures if the invidividual is not working, as well as in which sector are they working (in case they are)
			generate work_p4asector=.
			replace work_p4asector=0 if clase2!=1 // This will identify people that are not working.
			replace work_p4asector=1 if P4A_Sector==1 
			replace work_p4asector=2 if P4A_Sector==2
			replace work_p4asector=3 if P4A_Sector==3
			replace work_p4asector=4 if P4A_Sector==4
			label var work_p4asector "Working Categories"
			label define work_p4asector 0 "Not Working" 1 "Working in Agriculture" 2 "Working in Industry" 3 "Working in Services" 4 "Working in unspecified activities"
			label value work_p4asector work_p4asector
			tab work_p4asector // Data quality Check: 341,402 total observations. Variable was created correctly.				
	
// Dummy variable to identify working-age women working in the agricultural sector.
			generate work_fem_agri=.
			replace work_fem_agri=0 if female==1 & working_age==2 & clase2!=1 
			replace work_fem_agri=1 if female==1 & working_age==2 & clase2==1 & P4A_Sector==1 
			replace work_fem_agri=2 if female==1 & working_age==2 & clase2==1 & P4A_Sector!=1
			
// Dummy variable to identify working-age women working in the industrial sector.
			generate work_fem_ind=.
			replace work_fem_ind=0 if female==1 & working_age==2 & clase2!=1 
			replace work_fem_ind=1 if female==1 & working_age==2 & clase2==1 & P4A_Sector==2 
			replace work_fem_ind=2 if female==1 & working_age==2 & clase2==1 & P4A_Sector!=2 
			
// Dummy variable to identify working-age women working in the service sector.
			generate work_fem_serv=.
			replace work_fem_serv=0 if female==1 & working_age==2 & clase2!=1 
			replace work_fem_serv=1 if female==1 & working_age==2 & clase2==1 & P4A_Sector==3 
			replace work_fem_serv=2 if female==1 & working_age==2 & clase2==1 & P4A_Sector!=3 				
			
			
		
save	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-const-indhhh.dta", replace  	

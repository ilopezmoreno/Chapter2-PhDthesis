clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta" 

cd "${root}/4_outputs/regression_results"
capture mkdir 3rd_stage



// First, I will only mantain in the sample those people that are married or in a free union relationship. 
keep if e_con==5 | e_con==1

// Second, I will ask stata to drop all household members that are not husband and wife. 
drop if par_c>=205
/* Note: 	par_c is the variable that shows the relationship with the household head. 
			101 code to identify the household head
			201 husband or wife of the household head
			202 concubine 
			204 lover 
*/

// Third, I will ask stata to count how many members are living in each household.  
bysort house_id_per: egen count_members=count(person_id)   
tab count_members 


// Now I will ask stata to mantain just those cases where there are two household members. 
drop if count_members==3
drop if count_members==1





// The following code is used to obtain the husbands' level of education
order educ, last
bysort house_id_per: gen educ_pareja1 = educ[_n-1]
bysort house_id_per: gen educ_pareja2 = educ[_n+1]
generate educ_pareja=.
forvalues i=0/5 {
replace educ_pareja=`i' if educ_pareja1==`i'
replace educ_pareja=`i' if educ_pareja2==`i'
}
tabulate educ_pareja, missing  // Data quality check
// 339 missing values
drop if educ_pareja==. 
drop educ_pareja1 educ_pareja2
sort house_id_per female
order person_id_per count_members house_id_per female e_con educ educ_pareja, last


// The following code is used to control for husbands' income level. 

sort house_id_per female
order ingocup house_id_per female, last 

bysort house_id_per: gen ingocup_husband = ingocup[_n-1]

summarize ingocup_husband if female==0 // Data quality check
summarize ingocup_husband if female==1 // Data quality check




summarize ingocup_husband
fre ingocup_husband





// Descriptive statistics 

tab educ_pareja if female==1 & eda>=18 & eda<=65





drop if female==0



// Code to identify people working in agriculture, industry or services

drop industry 

generate agriculture=.
replace  agriculture=1 if work_p4asector==1
replace  agriculture=0 if work_p4asector!=1

generate industry=.
replace  industry=1 if work_p4asector==2
replace  industry=0 if work_p4asector!=2


generate services=.
replace  services=1 if work_p4asector==3
replace  services=0 if work_p4asector!=3

summarize agriculture industry services
summarize agriculture industry services if female==1 & eda>=18 & eda<=65


local dep_variable /// 
agriculture ///
industry 	///
services 	// 


foreach dependent_variable of local dep_variable {	
	
cd "${root}/4_outputs/regression_results/3rd_stage"


probit `dependent_variable' 	/// 
ib(0).educ_pareja		/// Main variable: 		Husband's education 		Base category = 0 "Graduate or post-graduate education"
c.eda##c.eda 			/// Individual control: Age and age squared.		Continuous variable
ib(0).educ 				/// Individual control: Education level. 			Base Category = 0 "No studies at all"
ib(1).soc_str 			/// Household control:  HH socioeconomic stratum. 	Base Category = 1 "Low"
ib(4).t_loc 			/// Household control:  Population size.			Base category = 4 "Between 2,500 and 15,000 inhabitants"
ib(1).ur 				/// Household control:  Rural/urban identifier. 	Base Category = 1 "Urban" 
ib(0).num_kids			/// Individual control: Number of sons/daughters.	Base Category = 0 "No sons"
ib(0).hh_kids			/// Household control:  Kids below 5 in the hh 		Base Category = 0 "No kids below 5 in the household"
ib(0).hhh_female 		/// HH head control: 	Sex of the household head	Base Category = 0 "Men"
c.hhh_eda				/// HH head control:	Age of the household head	
ib(9).ent 				/// Fixed effects: 		Mexican states.  			Base category = 9 "Mexico City"  
ib(1).per				/// Fixed effects: 		Years/quarters.  			Base category = 4 "1st quarte of 2019"
if female==1 & eda>=18 & eda<=65	/// Regression restricted to women. 
[pweight=fac], 						/// Probability weights 
vce (robust) 						//  Robust standard errors. 
outreg2 using  probit_husband.xls, label dec(4) // Save regression results in excel format
outreg2 using  probit_husband_`dependent_variable'.doc, replace label // Save regression results in word format
estimates save probit_husband_`dependent_variable'.ster, replace // Save regression results in .ster format

}






local dep_variable /// 
agriculture ///
industry 	///
services 	// 


foreach dependent_variable of local dep_variable {	
	
cd "${root}/4_outputs/regression_results/3rd_stage"


probit `dependent_variable' 	/// 
ib(0).educ_pareja		/// Main variable: 		Husband's education 		Base category = 0 "Graduate or post-graduate education"
c.ingocup_husband		/// Husband control:	Husband reported income. 	Continuous variable
c.eda##c.eda 			/// Individual control: Age and age squared.		Continuous variable
ib(0).educ 				/// Individual control: Education level. 			Base Category = 0 "No studies at all"
ib(1).soc_str 			/// Household control:  HH socioeconomic stratum. 	Base Category = 1 "Low"
ib(4).t_loc 			/// Household control:  Population size.			Base category = 4 "Between 2,500 and 15,000 inhabitants"
ib(1).ur 				/// Household control:  Rural/urban identifier. 	Base Category = 1 "Urban" 
ib(0).num_kids			/// Individual control: Number of sons/daughters.	Base Category = 0 "No sons"
ib(0).hh_kids			/// Household control:  Kids below 5 in the hh 		Base Category = 0 "No kids below 5 in the household"
ib(0).hhh_female 		/// HH head control: 	Sex of the household head	Base Category = 0 "Men"
c.hhh_eda				/// HH head control:	Age of the household head	
ib(9).ent 				/// Fixed effects: 		Mexican states.  			Base category = 9 "Mexico City"  
ib(1).per				/// Fixed effects: 		Years/quarters.  			Base category = 4 "1st quarte of 2019"
if female==1 & eda>=18 & eda<=65	/// Regression restricted to women. 
[pweight=fac], 						/// Probability weights 
vce (robust) 						//  Robust standard errors. 
outreg2 using  probit_husband_ingocup.xls, label dec(4) // Save regression results in excel format
outreg2 using  probit_husband_`dependent_variable'_ingocup.doc, replace label // Save regression results in word format
estimates save probit_husband_`dependent_variable'_ingocup.ster, replace // Save regression results in .ster format

}


























































// Excluded as a control variable as it is highly colinear with husbands' level of education
* ib(0).hhh_educ 			/// HH head control:	Education of the hh head	Base Category = 0 "No studies at all"

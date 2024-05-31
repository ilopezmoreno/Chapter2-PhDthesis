clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta" 


cd "${root}/4_outputs/regression_results"
capture mkdir 2nd_stage


local dep_variable 	///
mining				///
construction 		/// 
food 				/// 
computers 			///
clothing 			///
textile 			//

/*
metals				///
autoparts 			/// 
appliances 			/// 
industry			///
*/

foreach dependent_variable of local dep_variable {	

cd "${root}/4_outputs/regression_results/2nd_stage"

/*

// Without control variables 
probit `dependent_variable' ///   
ib(6).e_con /// Marital status. Base category 6: Single  
ib(9).ent /// State fixed effects to control unobserved heterogeneity, Base category: 9 "Mexico City" 
ib(1).per /// Year fixed effects to control for unobserved heterogeneity across years/quarters. Base category: 1st quarter of 2016
if female==1 & working_age==2 /// Regression restricted only to working_age women in the sample. 
[pweight=fac], /// Probability weights 
vce (robust) // Robust standard errors. 
outreg2 using 	nocontrol_probit_ind_activities_116_419.xls, label dec(4)
outreg2 using 	nocontrol_probit_ind_activities_116_419.doc, label // Save regression results in word format
estimates save 	nocontrol_probit_ind_activities_116_419_`dependent_variable'.ster, replace // Save regression results in .ster format

*/

// With control variables 
probit `dependent_variable' ///   
ib(6).e_con				/// Dependent variable: Marital status. 			Base category = 6 "Being single"
c.eda##c.eda 			/// Individual control: Age and age squared.
ib(0).educ 				/// Individual control: Education level. 			Base Category = 0 "No studies at all"
ib(0).num_kids			/// Individual control: Number of sons/daughters.	Base Category = 0 "No sons"
ib(1).soc_str 			/// Household control:  HH socioeconomic stratum. 	Base Category = 1 "Low"
ib(4).t_loc 			/// Household control:  Population size.			Base category = 4 "Between 2,500 and 15,000 inhabitants"
ib(1).ur 				/// Household control:  Rural/urban identifier. 	Base Category = 1 "Urban" 
ib(0).hh_kids			/// Household control:  Kids below 5 in the hh 		Base Category = 0 "No kids below 5 in the household"
ib(1).hh_members		/// Household control:  Household members 			Base Category = 1 "One household member"
c.hhh_eda				/// HH head control:	Age of the household head	
ib(0).hhh_female 		/// HH head control: 	Sex of the household head	Base Category = 0 "Men"
ib(0).hhh_educ 			/// HH head control:	Education of the hh head	Base Category = 0 "No studies at all"
ib(9).ent 				/// Fixed effects: 		Mexican states.  			Base category = 9 "Mexico City"  
ib(1).per				/// Fixed effects: 		Years/quarters.  			Base category = 4 "1st quarte of 2019"
if female==1 & eda>=18 & eda<=65 	///    Regression restriction: Only working-age women. (18 to 65)
[pweight=fac], 						/// 	  Probability weights. 
vce (robust)					 	// 	   Robust standard errors.
outreg2 using 	control_probit_industry_activities_116_419.xls, label dec(4)
outreg2 using 	control_probit_industry_activities_116_419.doc, label // Save regression results in word format
estimates save 	control_probit_industry_activities_116_419_`dependent_variable'.ster, replace // Save regression results in .ster format



/*

// With control variables and interaction marital_status and age
probit `dependent_variable' ///   
ib(6).e_con#c.eda /// Marital status, Base category 6: Single  
c.eda#c.eda /// Aage squared
ib(0).educ /// Level of education, Base category 0: No studies at all
ib(1).soc_str /// Social stratum, Base category 1: Low social stratum 
ib(4).t_loc /// Locality size, Base category 4: Less than 2,500 inhabitants 
ib(1).ur /// Rural/urban identificator, Base category 1: Urban 
ib(0).num_kids /// Number of kids, Base category 0: No sons or daughters 
ib(9).ent /// State fixed effects to control unobserved heterogeneity, Base category: 9 "Mexico City" 
ib(1).per /// Year fixed effects to control for unobserved heterogeneity across years/quarters. Base category: 1st quarter of 2016
if female==1 & working_age==2 /// Regression restricted only to working_age women in the sample. 
[pweight=fac], /// Probability weights 
vce (robust) // Robust standard errors. 
outreg2 using 	interaction_probit_ind_activities_116_419.xls, label dec(4)
outreg2 using 	interaction_probit_ind_activities_116_419.doc, label // Save regression results in word format
estimates save 	interaction_probit_ind_activities_116_419_`dependent_variable'.ster, replace // Save regression results in .ster format

*/

}
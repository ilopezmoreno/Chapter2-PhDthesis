clear 
use	"C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta"


global root "C:/Users/d57917il/Documents/GitHub/Chapter3-PhDthesis"

cd "${root}/4_outputs/regression_results"
capture mkdir probit_service_activities















































local dep_variable 	///
domestic_emp		/// SERVICES
hotel_rest 			/// SERVICES
retail 				/// SERVICES
real_estate 		/// SERVICES
health 				/// SERVICES
government 			/// SERVICES
education 			/// SERVICES
finance 			/// SERVICES
corporative 		// SERVICES




foreach dependent_variable of local dep_variable {	

cd "${root}/4_outputs/regression_results/probit_service_activities"

// 1 SET OF REGRESSIONS: NO CONTROL VARIABLES.
 
probit `dependent_variable' 	///   
ib(6).e_con 					/// Marital status. Base category 6: Single  
ib(9).ent 						/// State fixed effects to control unobserved heterogeneity, Base category: 9 "Mexico City" 
ib(1).per 						/// Year fixed effects to control for unobserved heterogeneity across years/quarters. Base category: 1st quarter of 2016
if female==1 & working_age==2 	/// Regression restricted only to working_age women in the sample. (18 to 65)
[pweight=fac], 					/// Probability weights 
vce (robust)					 // Robust standard errors. 
outreg2 using nocontrols_probit_services_informality_116_419.xls, label dec(4)
*outreg2 using nocontrols_probit_services_informality_116_419.doc, label // Save regression results in word format
*estimates save nocontrols_probit_services_informality_116_419`dependent_variable'.ster, replace // Save regression results in .ster format

}

















































local dep_variable 	///
domestic_emp		/// SERVICES
hotel_rest 			/// SERVICES
retail 				/// SERVICES
real_estate 		/// SERVICES
health 				/// SERVICES
government 			/// SERVICES
education 			/// SERVICES
finance 			/// SERVICES
corporative 		// SERVICES


foreach dependent_variable of local dep_variable {	

cd "${root}/4_outputs/regression_results/probit_service_activities"

// With control variables 
probit `dependent_variable' ///   
ib(6).e_con##c.eda /// Marital status, Base category 6: Single  
c.eda#c.eda /// Aage squared
ib(9).ent /// State fixed effects to control unobserved heterogeneity, Base category: 9 "Mexico City" 
ib(1).per /// Year fixed effects to control for unobserved heterogeneity across years/quarters. Base category: 1st quarter of 2016
if female==1 & working_age==2 /// Regression restricted only to working_age women in the sample. 
[pweight=fac], /// Probability weights 
vce (robust) // Robust standard errors. 
outreg2 using age_control_probit_serv_activities_116_419.xls, label dec(4)


}




































local dep_variable 	///
domestic_emp		/// SERVICES
hotel_rest 			/// SERVICES
retail 				/// SERVICES
real_estate 		/// SERVICES
health 				/// SERVICES
government 			/// SERVICES
education 			/// SERVICES
finance 			/// SERVICES
corporative 		// SERVICES




foreach dependent_variable of local dep_variable {	

cd "${root}/4_outputs/regression_results/probit_service_activities"


// With control variables and interaction marital_status and age
probit `dependent_variable' ///   
ib(6).e_con##c.eda /// Marital status, Base category 6: Single  
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
outreg2 using individual_controls_probit_serv_activities_116_419.xls, label dec(4)
*outreg2 using interaction_probit_serv_activities_116_419.doc, label // Save regression results in word format
estimates save individual_controls_probit_serv_activities_116_419`dependent_variable'.ster, replace // Save regression results in .ster format

}





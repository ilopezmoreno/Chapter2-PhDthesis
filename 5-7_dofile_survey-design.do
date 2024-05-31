clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-tidy.dta" 


svyset upm [pweight=fac], strata(est_d)

local econ_activities 		///
industry 					///
mining 						///
food 						///
autoparts 					///
clothing 					///
textile 					/// 
computers 					///
appliances 					///
construction 				///
real_estate 				///
retail 						///
street_retail				///
non_street_retail			///
media 						///
finance 					///
corporative 				///
education 					///
health 						///
hotel_rest 					///
government 					///
clerical 					///
domestic_emp 				/// 
retail10_street 			///
retail10_groceries 			///
retail10_convenience 		///
retail10_clothing 			///
retail10_health 			///
retail10_stationery 		///
retail10_hhitemsdecor 		///
retail10_hardware 			///
retail10_cars_autoparts 	///
retail10_internet_catalogs 	///
hf3cat_hotels 				///
hf3cat_restaurant			///
hf3cat_streetfood 			//

foreach econ_activity of local econ_activities {
svy: mean `econ_activity'	
estat cv
}	







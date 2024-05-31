clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta" 

cd "${root}/4_outputs/regression_results"
capture mkdir 1st_stage
cd "${root}/4_outputs/regression_results/1st_stage"



* FIRST STEP: Run the econometric model 

mprobit work_p4asector 	/// 
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
if female==1 & eda>=18 & eda<=65 			/// Regression restriction: Only working-age women. (18 to 65)
[pweight=fac], 								/// Probability weights 
vce (robust) 								//  Robust standard errors.  
outreg2 using  mprobit_work_p4asector_marital_1865.xls, replace label // Save regression results in excel format
outreg2 using  mprobit_work_p4asector_marital_1865.doc, replace label // Save regression results in word format
estimates save mprobit_work_p4asector_marital_1865.ster, replace // Save regression results in .ster format




* SECOND STEP: Obtain the predictive margins 
* Obtaining predictive margins depending on marital status and mean of other covariates (Standard errors reported)

clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"
use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta" 
cd "${root}/4_outputs/regression_results/1st_stage"

estimates use mprobit_work_p4asector_marital_1865.ster  
estimates esample:
mprobit 

// The following code WORKED
margins e_con, nose 
estimates save margins_wmprobit_work_p4asector_marital_1865_atmeans_nose.ster, replace


// The following code DIDNT WORK
margins e_con, atmeans vce(delta) 
*estimates save margins_wmprobit_work_p4asector_marital_1865_atmeans_withse.ster, replace







* THIRD STEP: Visualize and plot the predictive margins 
clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"
use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta" 
cd "${root}/4_outputs/regression_results/1st_stage"

estimates use margins_wmprobit_work_p4asector_marital_1865_atmeans_nose.ster  
estimates esample:
margins e_con
estimates save margins_wmprobit_work_p4asector_marital_1865_atmeans_withse.ster, replace


marginsplot, ///
by(_predict, label("Not Working" "Working in agriculture" "Working in industry" "Working in Services" )) ///
byopts(holes(3) title("Predicted probability that a woman is working in a economic sector" "depending on their marital status.")) ///
title(, size(vsmall)) /// legend(order(4 "Married" 3 "Single")) ///
ytitle("Predicted probability") ytitle(, size(vsmall)) ///
xtitle("Age") xtitle(, size(vsmall)) ///
ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) ///
ylabel(0(0.1)1) /// 
legend(size(vsmall)) ///
plotopts(msize(vsmall))
graph export 		"${root}/4_outputs/regression_results/mprobit_sectors\marginsplot_margins_work_p4asector_marital_nose.png", replace
graph save "Graph" 	"${root}/4_outputs/regression_results/mprobit_sectors\marginsplot_margins_work_p4asector_marital_nose.gph", replace


gr_edit .plotregion1.plotregion1[5].draw_view.setstyle, style(no)
gr_edit .plotregion1.subtitle[5].draw_view.setstyle, style(no)
gr_edit .plotregion1.xaxis1[5].draw_view.setstyle, style(no)
gr_edit .title.style.editstyle size(medsmall) editcopy
gr_edit .legend.Edit , style(rows(1)) style(cols(0)) keepstyles 
gr_edit .legend.Edit , style(rows(1)) style(cols(0)) style(key_xsize(10)) keepstyles 
gr_edit .legend.Edit , style(rows(1)) style(cols(0)) keepstyles 



















































































































// Marginal probabilities depending on marital status, and age (No standard errors reported)
margins e_con, at(eda=(18(2)65)) nose post // Por alguna razon, solo funciona con nose "no standard errors"
estimates save margins_work_p4asector_marital_nose_1865.ster, replace 

margins e_con, at(eda=(18(2)65)) post // Por alguna razon, solo funciona con nose "no standard errors"
estimates save margins_work_p4asector_marital_1865.ster, replace 




























































// MARGINS AND MARGINSPLOT WITHOUT STANDARD ERRORS (NOSE)


clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta" 
cd "${root}/4_outputs/regression_results/1st_stage"

estimates use mprobit_work_p4asector_marital_1865.ster  
estimates esample:
mprobit 

// Marginal probabilities depending on marital status, and age (No standard errors reported)
margins e_con, at(eda=(18(2)65)) nose post // Por alguna razon, solo funciona con nose "no standard errors"
estimates save margins_work_p4asector_marital_nose_1865.ster, replace 

margins e_con, at(eda=(18(2)65)) post // Por alguna razon, solo funciona con nose "no standard errors"
estimates save margins_work_p4asector_marital_1865.ster, replace 





















// Marginal probabilities, depending on marital status and mean of other covariates (Standard errors reported)
margins e_con, at(eda=(18(2)65)) atmeans vsquish
estimates save margins_work_p4asector_marital_means_withse.ster, replace


clear 
use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta" 
cd "${root}/4_outputs/regression_results/1st_stage"

estimates use margins_work_p4asector_marital_nose.ster
estimates esample:
margins 


marginsplot, ///
by(_predict, label("Not Working" "Working in agriculture" "Working in industry" "Working in Services" )) ///
byopts(holes(3) title("Predicted probability that a woman is working in a economic sector" "depending on their age & their marital status.")) ///
title(, size(vsmall)) /// legend(order(4 "Married" 3 "Single")) ///
ytitle("Predicted probability") ytitle(, size(vsmall)) ///
xtitle("Age") xtitle(, size(vsmall)) ///
ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) ///
ylabel(0(0.1)1) /// 
legend(size(vsmall)) ///
plotopts(msize(vsmall))
gr_edit .plotregion1.plotregion1[5].draw_view.setstyle, style(no)
gr_edit .plotregion1.subtitle[5].draw_view.setstyle, style(no)
gr_edit .plotregion1.xaxis1[5].draw_view.setstyle, style(no)
gr_edit .title.style.editstyle size(medsmall) editcopy
gr_edit .legend.Edit , style(rows(1)) style(cols(0)) keepstyles 
gr_edit .legend.Edit , style(rows(1)) style(cols(0)) style(key_xsize(10)) keepstyles 
gr_edit .legend.Edit , style(rows(1)) style(cols(0)) keepstyles 
graph export 		"${root}/4_outputs/regression_results/mprobit_sectors\marginsplot_margins_work_p4asector_marital_nose.png", replace
graph save "Graph" 	"${root}/4_outputs/regression_results/mprobit_sectors\marginsplot_margins_work_p4asector_marital_nose.gph", replace








// MARGINS AND MARGINSPLOT WITH STANDARD ERRORS




clear 
use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta" 
cd "${root}/4_outputs/regression_results/mprobit_sectors"

estimates use mprobit_work_p4asector_marital.ster  
estimates esample:
mprobit 

margins e_con, at(eda=(20(5)80)) atmeans vsquish // Por alguna razon, parece que solo funciona con nose "no standard errors"
estimates save margins_work_p4asector_marital_withse.ster, replace 




clear 
use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta" 
cd "${root}/4_outputs/regression_results/mprobit_sectors"

estimates use margins_work_p4asector_marital_withse.ster
estimates esample:
margins 


marginsplot, ///
by(_predict, label("Not Working" "Working in agriculture" "Working in industry" "Working in Services" )) ///
byopts(holes(3) title("Predicted probability that a woman is working in a economic sector" "depending on their age & their marital status.")) ///
title(, size(vsmall)) /// legend(order(4 "Married" 3 "Single")) ///
ytitle("Predicted probability") ytitle(, size(vsmall)) ///
xtitle("Age") xtitle(, size(vsmall)) ///
ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) ///
ylabel(0(0.1)1) /// 
legend(size(vsmall)) ///
plotopts(msize(vsmall))
gr_edit .plotregion1.plotregion1[5].draw_view.setstyle, style(no)
gr_edit .plotregion1.subtitle[5].draw_view.setstyle, style(no)
gr_edit .plotregion1.xaxis1[5].draw_view.setstyle, style(no)
gr_edit .title.style.editstyle size(medsmall) editcopy
gr_edit .legend.Edit , style(rows(1)) style(cols(0)) keepstyles 
gr_edit .legend.Edit , style(rows(1)) style(cols(0)) style(key_xsize(10)) keepstyles 
gr_edit .legend.Edit , style(rows(1)) style(cols(0)) keepstyles 
graph export 		"${root}/4_outputs/regression_results/mprobit_sectors/marginsplot_margins_work_p4asector_marital_withse.png", replace
graph save "Graph" 	"${root}/4_outputs/regression_results/mprobit_sectors/marginsplot_margins_work_p4asector_marital_withse.gph", replace


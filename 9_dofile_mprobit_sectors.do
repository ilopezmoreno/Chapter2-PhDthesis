clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta" 

cd "${root}/4_outputs/regression_results"
capture mkdir mprobit_sectors
cd "${root}/4_outputs/regression_results/mprobit_sectors"



mprobit work_p4asector 	/// 
ib(6).e_con				/// Marital status, base category=6 "single"
c.eda##c.eda 			/// Age and age squared
ib(0).educ 				/// Education level, Base Category=0 "no studies at all"
ib(1).soc_str 			/// Socio-Economic Stratum, Base Category=0 "Low"
ib(3).t_loc 			/// Locality size, Base category=4 "Between 2,500 and 15,000 inhabitants"
ib(1).ur 				/// Rural/urban identifier, Base Category=1 "Urban" 
ib(9).ent 				/// Fixed effects at the state level.  Base category = 9, Mexico City  
ib(4).per				/// Fixed effects years/quarters.      Base category = 4, 2019
if female==1 			/// Regression restricted only to women in the sample. 
[pweight=fac], 			/// Probability weights 
vce (robust) 			// Robust standard errors. 
outreg2 using  mprobit_work_p4asector_marital.xls, replace label // Save regression results in excel format
outreg2 using  mprobit_work_p4asector_marital.doc, replace label // Save regression results in word format
estimates save mprobit_work_p4asector_marital.ster, replace // Save regression results in .ster format








// MARGINS AND MARGINSPLOT WITHOUT STANDARD ERRORS (NOSE)


clear 
use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta" 
cd "${root}/4_outputs/regression_results/mprobit_sectors"

estimates use mprobit_work_p4asector_marital.ster  
estimates esample:
mprobit 

margins e_con, at(eda=(20(5)80)) nose post // Por alguna razon, solo funciona con nose "no standard errors"
estimates save margins_work_p4asector_marital_nose.ster, replace 



clear 
use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta" 
cd "${root}/4_outputs/regression_results/mprobit_sectors"

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


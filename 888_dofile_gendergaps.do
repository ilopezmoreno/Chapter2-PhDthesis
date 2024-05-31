clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta" 


generate labour_status=.
replace	 labour_status=0 if clase1==0
replace	 labour_status=0 if clase2==2
replace	 labour_status=1 if emp_ppal==0
replace	 labour_status=2 if emp_ppal==1


generate informal_job=.
replace	 informal_job=0 if clase1==0
replace	 informal_job=0 if clase2==2
replace	 informal_job=0 if emp_ppal==0
replace	 informal_job=1 if emp_ppal==1

generate formal_job=.
replace	 formal_job=0 if clase1==0
replace	 formal_job=0 if clase2==2
replace	 formal_job=0 if emp_ppal==1
replace	 formal_job=1 if emp_ppal==0


generate no_job=.
replace	 no_job=1 if clase1==0
replace	 no_job=1 if clase2==2
replace	 no_job=0 if emp_ppal==1
replace	 no_job=0 if emp_ppal==0






probit informal_job	///
ib(1).female		///
c.eda##c.eda 		///
ib(0).educ 			///
ib(1).soc_str 		///
ib(4).t_loc 		///
ib(1).ur 			///
ib(6).e_con			//

margins female, at(eda=(20(5)60)) atmeans post

marginsplot,											///
title("Predicted probability of having an informal job" "depending on sex and age.") /// 
title(, size(small)) 									///
ytitle("Predicted probability") ytitle(, size(vsmall)) 	///
xtitle("Age") xtitle(, size(vsmall)) 					///
ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) 		///
ylabel(0(0.1)1) 										/// 
legend(size(vsmall)) 									///
plotopts(msize(vsmall))















probit formal_job	///
i.female			///
c.eda##c.eda 		///
ib(0).educ 			///
ib(1).soc_str 		///
ib(4).t_loc 		///
ib(1).ur 			///
ib(6).e_con			//

margins female, at(eda=(20(5)60)) atmeans post

marginsplot,											///
title("Predicted probability of having an formal job" "depending on sex and age.") /// 
title(, size(small)) 									///
ytitle("Predicted probability") ytitle(, size(vsmall)) 	///
xtitle("Age") xtitle(, size(vsmall)) 					///
ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) 		///
ylabel(0(0.1)1) 										/// 
legend(size(vsmall)) 									///
plotopts(msize(vsmall))









probit no_job		///
i.female			///
c.eda##c.eda 		///
ib(0).educ 			///
ib(1).soc_str 		///
ib(4).t_loc 		///
ib(1).ur 			///
ib(6).e_con			//


margins female, at(eda=(20(5)60)) atmeans post

marginsplot,											///
title("Predicted probability of not working" "depending on sex and age.") /// 
title(, size(small)) 									///
ytitle("Predicted probability") ytitle(, size(vsmall)) 	///
xtitle("Age") xtitle(, size(vsmall)) 					///
ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) 		///
ylabel(0(0.1)1) 										/// 
legend(size(vsmall)) 									///
plotopts(msize(vsmall))











probit emp_ppal		///
i.female			///
c.eda##c.eda 		///
ib(0).educ 			///
ib(1).soc_str 		///
ib(4).t_loc 		///
ib(1).ur 			///
ib(6).e_con			//


margins female, at(eda=(25(5)55)) atmeans post

marginsplot,											///
title("Predicted probability of not working" "depending on sex and age.") /// 
title(, size(small)) 									///
ytitle("Predicted probability") ytitle(, size(vsmall)) 	///
xtitle("Age") xtitle(, size(vsmall)) 					///
ylabel(,labsize(vsmall)) xlabel(,labsize(vsmall)) 		///
ylabel(0(0.1)1) 										/// 
legend(size(vsmall)) 									///
plotopts(msize(vsmall))



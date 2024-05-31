clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-recode.dta" 


//	Variable: Income (ingocup)

// 	There are people in the sample that are not working and their income is equal to 0.
	summarize 	ingocup 	if clase1==1
	summarize 	ingocup 	if clase1==0				
// 	If they don't have any income, their income shouldn't be equal to 0. 
// 	Instead, their income should be equal to a missing value *
	replace 	ingocup=.n 	if clase1==0
	

// 	There is still respondents who reported that they are not working, but in the dataset they have a 0 salary. 
	summarize 	ingocup 	if clase2==1
	summarize 	ingocup 	if clase2==2
	replace 	ingocup=.n 	if clase2==2
	
// 	There are still some respondents that reported a 0 salary, when in fact that should be a missing value. 
	fre 		clase3 		if ingocup==0				
// 	Ocupados sin pago que reportaron ingresos de 0. 
	replace 	ingocup=.n 	if clase3==2 & ingocup==0 
//	Ocupado ausente con nexo laboral que reporto ingresos de 0.     
	replace 	ingocup=.n  if clase3==3 & ingocup==0
// 	Ocupado ausente con retorno asegurado	
	replace 	ingocup=.n  if clase3==4 & ingocup==0


// 	Data quality check:
	fre 		ingocup
/*	Result: 28% of the respondents indicated having a job and a salary, but in the variable "ingocup" they 
			did not report their income. */

			
/*	One option to imput those results, as it might be the case that some of them decided not to report their income. */
				   
				tab eda 	 if ingocup==0  
				tab sex 	 if ingocup==0  // 60% are men 
				tab ur  	 if ingocup==0  // 67% live in urban areas
				tab cs_p13_1 if ingocup==0  
				tab ent		 if ingocup==0  
				tab e_con	 if ingocup==0  
				tab n_hij	 if ingocup==0
				tab dur9c	 if ingocup==0
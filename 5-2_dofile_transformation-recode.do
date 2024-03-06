clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-drop.dta" 


// RECODING VARIABLES
recode ur 			(2=0) 			// Rural/Urban: 2 was rural, now 0 is rural 
recode clase1 		(2=0) 			// Econ-active: 2 was non-econ-active, now 0 is non-econ-active 
recode e_con		(9=.d)			// 9: "Doesn't know" will now be equal to ".d"	
recode scian 		(0=.n)			// 0: "No aplica" will now be equal to ".n" not applicable							
recode emp_ppal		(0=.n)  		// 0: "No aplica" will now be equal to ".n" not applicable, 
recode emp_ppal 	(2=0)			// 2: "Formal" will now be equal to 0
recode tue_ppal		(0=.n)  		// 0: "No aplica" will now be equal to ".n" not applicable, 2 "Formal" will now be equal to 0
recode tue_ppal 	(2=0)			// 2: "Formal" will now be equal to 0
recode per  (116=1) (217=2) (318=3) (419=4) // Rural/Urban: 2 was non-econ-active, now 0 is non-econ-active 



// RELABEL VARIABLES
label define ur  		0 "Rural", 							modify
label define ur  		1 "Urban", 							modify
label define per 		1 "2016, Q1", 						modify
label define per 		2 "2017, Q2",  						modify
label define per 		3 "2018, Q3",  						modify
label define per 		4 "2019, Q4",  						modify
label define t_loc 		1 "More than 100,000 inhabitants", 	modify
label define t_loc 		2 "Between 15,000 and 99,999", 		modify
label define t_loc 		3 "Between 2,500 and 14,999", 		modify
label define t_loc 		4 "Less than 2,500 inhabitants", 	modify
label define emp_ppal 	1 "Informal",  						modify
label define emp_ppal 	0 "Formal",  						modify
label define tue_ppal 	1 "Informal",  						modify
label define tue_ppal 	0 "Formal",  						modify
label define e_con 		1 "Free Union", 					modify
label define e_con 		2 "Separated", 						modify
label define e_con 		3 "Divorced", 						modify
label define e_con 		4 "Widowed", 						modify
label define e_con 		5 "Married", 						modify
label define e_con 		6 "Single", 						modify


// 	Managing zeros "0" and missing values

// 	Variable: Number of weekly working hours (hrsocup)
	
			/* 	There are people in the sample that are non-economically active.
				The number of hours worked for these people shouldn't be 0. 
				Instead, it should be a missing value.	*/
				summarize 	hrsocup 	if clase1==1
				summarize 	hrsocup 	if clase1==0
				replace 	hrsocup=.n 	if clase1==0
			
			// 	Consistency check
				summarize	hrsocup		if clase1==1 & hrsocup==0	
			/* 	There are several cases of people that are 
				economically active, but they reported 0 working hours. */
				fre 		clase3 		if clase1==1 & hrsocup==0
			/* 	50% of the cases are people who are not working, 
				but they are looking for a job. Therefore, it is important
				to replace their "zero" working hours. */
				replace 	hrsocup=.n	if clase3==2 // 2: Ocupado sin pago (very few cases)
				replace 	hrsocup=.n	if clase3==3 // 3: Ocupado ausente con nexo laboral
				replace 	hrsocup=.n	if clase3==4 // 4: Ocupado ausente con retorno asegurado
				replace 	hrsocup=.n	if clase3==6 // 6: Desocupados en búsqueda de empleo
			// 	Now I will ask stata to show me if those with zero hours are working or not.
				fre 		clase2 
				replace 	hrsocup=.n	if  clase2!=1 	// 1: Población ocupada 
				fre 		clase3 		if hrsocup==0
				tab 		dur9c		if hrsocup==0
				replace 	hrsocup=.n	if   dur9c==1  	// 1: Ausentes laborales con vinculo laborales

				replace 	hrsocup=.d	if hrsocup==0  	
			// 	This variable is now transformed!
							fre			hrsocup
							tab 		hrsocup
							summarize	hrsocup	[fweight=fac]
				bysort per: summarize 	hrsocup [fweight=fac]
				bysort per: tab 		hrsocup [fweight=fac]
	

//	Variable: Income (ingocup)

			/* 	There are people in the sample that are not working and their income is equal to 0.
				If they don't have any income, their income shouldn't be equal to 0. 
				Instead, their income should be equal to a missing value */
				summarize 	ingocup 	if clase1==1
				summarize 	ingocup 	if clase1==0				
				replace 	ingocup=.n 	if clase1==0

				fre 		clase3 		if ingocup==0
				replace 	ingocup=.n 	if clase3==2 // 2: Ocupado sin pago (very few cases)
                replace 	ingocup=.n  if clase3==3 // 3: Ocupado ausente con nexo laboral
				replace 	ingocup=.n	if clase3==4 // 4: Ocupado ausente con retorno asegurado
                replace 	ingocup=.n  if clase3==5 // 5: Desocupados Iniciadores
                replace 	ingocup=.n  if clase3==6 // 6: Desocupados en búsqueda de empleo
                replace 	ingocup=.n  if clase3==7 // 7: Desocupados Ausentes sin ingreso y sin nexo laboral
                replace 	ingocup=.n  if clase2==2 // 2: Población desocupada
                replace 	ingocup=.n  if  dur9c==2 // 2: Población desocupada
				
				fre 	ingocup
				/* Up to know, 15% of people who indicated having a job and a salary, have 0 as a monthly income. 
				   It could be an option to imput those results, as it might be the case that some of them decided not to report their income. */
				   
				tab eda 	 if ingocup==0  
				tab sex 	 if ingocup==0  // 60% are men 
				tab ur  	 if ingocup==0  // 67% live in urban areas
				tab cs_p13_1 if ingocup==0  
				tab ent		 if ingocup==0  
				tab e_con	 if ingocup==0  
				tab n_hij	 if ingocup==0
				tab dur9c	 if ingocup==0
				   

save "${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-recode.dta", replace 
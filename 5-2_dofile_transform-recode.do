clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-drop.dta" 


// RECODING VARIABLES
recode ur 			(2=0) 			// Rural/Urban: 2 was rural, now 0 is rural 
recode clase1 		(2=0) 			// Econ-active: 2 was non-econ-active, now 0 is non-econ-active 
recode e_con		(9=.d)			// 9: "Doesn't know" will now be equal to ".d"	
recode scian 		(0=.n)			// 0: "No aplica" will now be equal to ".n" not applicable							
recode emp_ppal		(0=.n)  		// 0: "No aplica" will now be equal to ".n" not applicable 
recode emp_ppal 	(2=0)			// 2: "Formal" will now be equal to 0
recode tue_ppal		(0=.n)  		// 0: "No aplica" will now be equal to ".n" not applicable, 2 "Formal" will now be equal to 0
recode tue_ppal 	(2=0)			// 2: "Formal" will now be equal to 0
recode per  (116=1) (217=2) (318=3) (419=4) // Rural/Urban: 2 was non-econ-active, now 0 is non-econ-active 

recode hh_members (12=11) (13=11) (14=11) (15=11) (16=11) (17=11) (18=11) (19=11) (20=11) (21=11) (22=11) (23=11) (24=11) (25=11)
recode hh_kids (5=4) (6=4) (7=4) (8=4)

// RELABEL VARIABLES
label define ur  		0 "Rural", 							modify
label define ur  		1 "Urban", 							modify
label define per 		1 "2016, Q1", 						modify
label define per 		2 "2017, Q2",  						modify
label define per 		3 "2018, Q3",  						modify
label define per 		4 "2019, Q4",  						modify
label define emp_ppal 	1 "Informal",  						modify
label define emp_ppal 	0 "Formal",  						modify
label define tue_ppal 	1 "Sector Informal", 				modify
label define tue_ppal 	0 "Fuera del sector informal",		modify
label define e_con 		1 "Free Union", 					modify
label define e_con 		2 "Separated", 						modify
label define e_con 		3 "Divorced", 						modify
label define e_con 		4 "Widowed", 						modify
label define e_con 		5 "Married", 						modify
label define e_con 		6 "Single", 						modify
label define t_loc 		1 "More than 100,000 inhabitants", 	modify
label define t_loc 		2 "Between 15,000 and 99,999", 		modify
label define t_loc 		3 "Between 2,500 and 14,999", 		modify
label define t_loc 		4 "Less than 2,500 inhabitants", 	modify



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
	

				   

save "${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-recode.dta", replace 
clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-drop.dta" 



// RECODING VARIABLES
recode ur (2=0) // Rural/Urban: 2 was rural, now 0 is rural 
recode clase1 (2=0) // Rural/Urban: 2 was non-econ-active, now 0 is non-econ-active 





// 	Managing zeros "0" and missing values

/* 	There is people in the sample that are non-economically active.
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
	to not consider their "zero" working hours. */
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
	

	





	
// Modificar la variable horas trabajadas. 


 

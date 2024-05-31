clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-const-indhhh.dta" 

// Important note. This is the source of the P4A codes used in this do-file: 
// https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/doc/clasificaciones_enoe.pdf



// Exploratory data analysis
fre scian

forvalues i=1(1)21 {
tab P4A if scian==`i' 	
} 

forvalues i=1(1)21 {
tab P4A emp_ppal if scian==`i', row 	
} 

/*
forvalues i=1(1)21 {
tab P4A P5E1 if scian==`i', row 	
} 
*/


tab P4A emp_ppal if scian==10, row 
/*
       P4A |    Formal   Informal |     Total
-----------+----------------------+----------
      5210 |         3          0 |         3  	// 5210 Banca central (Banco de México)
           |    100.00       0.00 |    100.00 
-----------+----------------------+----------
      5221 |     2,290        137 |     2,427  	// 5221 Banca múltiple, y administración de fondos y fideicomisos del sector privado
           |     94.36       5.64 |    100.00 
-----------+----------------------+----------
      5222 |     1,993        433 |     2,426  	// 5222 Otras instituciones de intermediación crediticia y financiera no bursátil del sector privado
           |     82.15      17.85 |    100.00 
-----------+----------------------+----------
      5223 |       111         14 |       125  	// 5223 Banca de desarrollo, y administración de fondos y fideicomisos del sector público
           |     88.80      11.20 |    100.00 
-----------+----------------------+----------
      5230 |       286         51 |       337  	// 5230 Actividades bursátiles, cambiarias y de inversión financiera 
           |     84.87      15.13 |    100.00 
-----------+----------------------+----------
      5240 |       912        399 |     1,311  	// 5240 Compañías de fianzas, seguros y pensiones 
           |     69.57      30.43 |    100.00 
-----------+----------------------+----------
      5299 |         1          0 |         1  	// 5299 Descripciones insuficientemente especificadas de subsector de actividad del sector
           |    100.00       0.00 |    100.00 
-----------+----------------------+----------
     Total |     5,596      1,034 |     6,630 
           |     84.40      15.60 |    100.00 

 P4A |      Freq.     Percent        Cum.
5210 |          3        0.05        0.05 		// 5210 Banca central (Banco de México) 
5221 |      2,427       36.61       36.65 		// 5221 Banca múltiple, y administración de fondos y fideicomisos del sector privado	 
5222 |      2,426       36.59       73.24 		// 5222 Otras instituciones de intermediación crediticia y financiera no bursátil del sector privado	
5223 |        125        1.89       75.13 		// 5223 Banca de desarrollo, y administración de fondos y fideicomisos del sector público	
5230 |        337        5.08       80.21 		// 5230 Actividades bursátiles, cambiarias y de inversión financiera 	
5240 |      1,311       19.77       99.98 		// 5240 Compañías de fianzas, seguros y pensiones	
5299 |          1        0.02      100.00 		// 5299 Descripciones insuficientemente especificadas de subsector de actividad del sector	

*/
			

			
			
			
// Generate SCIAN categories, differentiating options within "Other services"
			clonevar scian_26 = scian
			fre scian_26
			fre P4A if scian==19 [fweight=fac]
			replace scian_26=22 if P4A==8111 	// Servicios de reparación y mantenimiento de automóviles y camiones
			replace scian_26=23 if P4A==8112 	// Servicios de reparación y mantenimiento de equipo, maquinaria, artículos para el hogar y personales
			replace scian_26=24 if P4A==8121 	// Servicios personales
			replace scian_26=25 if P4A==8130 	// Asociaciones y organizaciones
			replace scian_26=26 if P4A==8140 	// Hogares con empleados domésticos
			recode  scian_26 (0=.d) 			// Replacing 0 "Doesn't apply" to ".d"
			// List of codes for P4A variable available in the following INEGI website: 
			// https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/doc/clasificaciones_enoe.pdf
			
			label define scian_26 									///
			1   "Agricultural activities" 							///
			2   "Mining"											///
			3	"Supply of electricity, water or gas"				///
			4	"Construction"										///
			5	"Manufacturing"                                 	///
			6	"Wholesale trade"									///
			7	"Retail trade"                                  	///
			8	"Transportation (Air, water, railway, etc)"     	///
			9	"Media services"									///			
			10	"Finance and insurance"                             ///
			11	"Real estate"                                       ///
			12	"Scientists, professionals and technical services"  ///
			13	"Corporate services"                                ///
			14	"Business support"                                  ///
			15	"Education services"                                ///
			16	"Health and social assistance"                      ///
			17	"Culture, sports, leisure"                          ///
			18	"Temporary accommodation, food and beverage"		///
			19	"Other services"                                    ///
			20	"Government"                                        ///
			21	"Unspecified service activities"                    ///
			22	"Repair and maintenance (Car and truck)"            ///
			23	"Repair and maintenance (Machinery and equipment)"  ///
			24	"Personal services"                                 ///
			25	"Associations and organizations"                    ///
			26	"Domestic employees"                                //
			label value scian_26 scian_26
			fre scian_26 [fweight=fac]
			tab scian_26 [fweight=fac]

			
// Generate variable to identify specific economic activities within the manufacturing sector. 
tab P4A if scian==5 // 5 = Manufacturing	
	
/* P4A code |      Freq.     Percent        Cum.
------------+-----------------------------------
       3110 |     23,004       20.41       20.41
       3120 |      3,674        3.26       23.67
       3130 |      1,488        1.32       25.00
       3140 |      3,192        2.83       27.83
       3150 |      8,868        7.87       35.70
       3160 |      5,507        4.89       40.58
       3210 |      1,815        1.61       42.20
       3220 |      2,017        1.79       43.99
       3230 |      1,933        1.72       45.70
       3240 |        619        0.55       46.25
       3250 |      3,015        2.68       48.93
       3260 |      4,860        4.31       53.24
       3270 |      4,925        4.37       57.61
       3310 |      1,483        1.32       58.92
       3320 |      9,043        8.02       66.95
       3330 |      1,707        1.51       68.46
       3340 |      3,502        3.11       71.57
       3350 |      3,033        2.69       74.26
       3360 |     19,027       16.88       91.15
       3370 |      5,647        5.01       96.16
       3380 |      4,224        3.75       99.91
       3399 |        103        0.09      100.00
------------+-----------------------------------
      Total |    112,686      100.00           */
			
/*
31-33 Industrias manufactureras
3110 Industria alimentaria
3120 Industria de las bebidas y del tabaco
3130 Fabricación de insumos textiles y acabado de textiles
3140 Fabricación de productos textiles, excepto prendas de vestir
3150 Fabricación de prendas de vestir
3160 Curtido y acabado de cuero y piel, y fabricación de productos de cuero, piel y materiales sucedáneos
3210 Industria de la madera
3220 Industria del papel
3230 Impresión e industrias conexas
3240 Fabricación de productos derivados del petróleo y del carbón
3250 Industria química
3260 Industria del plástico y del hule
3270 Fabricación de productos a base de minerales no metálicos
3310 Industrias metálicas básicas
3320 Fabricación de productos metálicos
3330 Fabricación de maquinaria y equipo
3340 Fabricación de equipo de computación, comunicación, medición y de otros equipos, componentes y accesorios electrónicos
3350 Fabricación de accesorios, aparatos eléctricos y equipo de generación de energía eléctrica
3360 Fabricación de equipo de transporte y partes para vehículos automotores
3370 Fabricación de muebles, colchones y persianas
3380 Otras industrias manufactureras
3399 Descripciones insuficientemente especificadas de subsector de actividad del sector
Source: https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/doc/clasificaciones_enoe.pdf
*/
			
	generate manufacture_cat=.		
	replace  manufacture_cat=1	if P4A==3110 // Industria alimentaria 
	replace  manufacture_cat=2	if P4A==3120 // Industria de las bebidas y del tabaco 
	replace  manufacture_cat=3	if P4A==3130 // Fabricación de insumos textiles y acabado de textiles 
	replace  manufacture_cat=4	if P4A==3140 // Fabricación de productos textiles, excepto prendas de vestir 
	replace  manufacture_cat=5	if P4A==3150 // Fabricación de prendas de vestir 
	replace  manufacture_cat=6	if P4A==3160 // Curtido y acabado de cuero y piel, y fabricación de productos de cuero, piel y materiales sucedáneos 
	replace  manufacture_cat=7	if P4A==3210 // Industria de la madera
	replace  manufacture_cat=8	if P4A==3220 // Industria del papel
	replace  manufacture_cat=9	if P4A==3230 // Impresión e industrias conexas
	replace  manufacture_cat=10	if P4A==3240 // Fabricación de productos derivados del petróleo y del carbón
	replace  manufacture_cat=11	if P4A==3250 // Industria química
	replace  manufacture_cat=12	if P4A==3260 // Industria del plástico y del hule
	replace  manufacture_cat=13	if P4A==3270 // Fabricación de productos a base de minerales no metálicos
	replace  manufacture_cat=14	if P4A==3310 // Industrias metálicas básicas
	replace  manufacture_cat=15	if P4A==3320 // Fabricación de productos metálicos
	replace  manufacture_cat=16	if P4A==3330 // Fabricación de maquinaria y equipo
	replace  manufacture_cat=17	if P4A==3340 // Fabricación de equipo de computación, comunicación, medición y de otros equipos, componentes y accesorios electrónicos
	replace  manufacture_cat=18	if P4A==3350 // Fabricación de accesorios, aparatos eléctricos y equipo de generación de energía eléctrica
	replace  manufacture_cat=19	if P4A==3360 // Fabricación de equipo de transporte y partes para vehículos automotores
	replace  manufacture_cat=20	if P4A==3370 // Fabricación de muebles, colchones y persianas
	replace  manufacture_cat=21	if P4A==3399 // Descripciones insuficientemente especificadas de subsector de actividad del sector

			 label define manufacture_cat						///
			 1  "Food industry" 								///
			 2  "Beverage and tobacco industry"					///
			 3	"Textile Inputs"								///
			 4	"Textile products, except clothing"				///
			 5	"Clothing "                                 	///
			 6	"Leather goods manufacturing"					///
			 7	"Wood industry"                             	///
			 8	"Paper industry"     							///
			 9	"Printing and related industries"				///			
			 10	"Petroleum and coal products"  					///
			 11	"Chemical industry"                        		///
			 12	"Plastic and rubber industry"  					///
			 13	"Non-metallic mineral products" 				///
			 14	"Basic metal industries" 						///
			 15	"Metal products manufacturing" 					///
			 16	"Machinery and equipment manufacturing" 		///
			 17	"Computers and other electronic components" 	///
			 18	"Electric appliances and accessories" 			///
			 19	"Autoparts and transportation equipment" 		///
			 20	"Furniture, mattresses, and blinds" 			///
			 21	"Unspecified manufacturing activities" 			//
			
			 label value manufacture_cat manufacture_cat
			 fre manufacture_cat [fweight=fac]
			 tab manufacture_cat [fweight=fac]
			
			
// 	Generate variables to identify industrial activities and differentiate manufacturing industries. 
	clonevar ind_manufacture_cat = manufacture_cat
			
			replace  ind_manufacture_cat=22 if scian==2  // Mining
			replace  ind_manufacture_cat=23 if scian==3  // Electricity, gas and water supply
			replace  ind_manufacture_cat=24 if scian==4  // Construction
			 
			label define ind_manufacture_cat					///
			1   "Food industry" 								///
			2   "Beverage and tobacco industry"					///
			3	"Textile Inputs"								///
			4	"Textile products, except clothing"				///
			5	"Clothing "                                 	///
			6	"Leather goods manufacturing"					///
			7	"Wood industry"                             	///
			8	"Paper industry"     							///
			9	"Printing and related industries"				///			
			10	"Petroleum and coal products"  					///
			11	"Chemical industry"                        		///
			12	"Plastic and rubber industry"  					///
			13	"Non-metallic mineral products" 				///
			14	"Basic metal industries" 						///
			15	"Metal products manufacturing" 					///
			16	"Machinery and equipment manufacturing" 		///
			17	"Computers and other electronic components" 	///
			18	"Electric appliances and accessories" 			///
			19	"Autoparts and transportation equipment" 		///
			20	"Furniture, mattresses, and blinds" 			///
			21	"Unspecified manufacturing activities" 			///
			22	"Mining"										///
			23  "Electricity, gas and water supply"				///
			24  "Construction"									//
				
			label value ind_manufacture_cat ind_manufacture_cat
			fre ind_manufacture_cat [fweight=fac]
			tab ind_manufacture_cat [fweight=fac]			
			


// Generate variable to identify retail trade in streets 
generate street_retail_trade=.			
replace  street_retail_trade=0 if inlist(P4A, 4611,4631,4641,4651,4661,4671,4681,4620,4690,4699)			
replace  street_retail_trade=1 if inlist(P4A, 4612,4632,4642,4652,4662,4672,4682)			
// Exploratory Data Analysis
tab street_retail_trade
tab street_retail_trade [fweight=fac]
tab female street_retail_trade [fweight=fac], row 
tab street_retail_trade female [fweight=fac], row 
tab street_retail_trade emp_ppal [fweight=fac], row  
tab ent street_retail_trade [fweight=fac], row nofreq			
/*
fre P4A if scian==7
-----------------------------------------------------------
              |      Freq.    Percent      Valid       Cum.
--------------+--------------------------------------------
Valid   4611  |      33006      29.27      29.27      29.27	 /// 4611 Comercio al por menor de abarrotes, alimentos, bebidas, hielo y tabaco
        4612  |       5142       4.56       4.56      33.83	 /// 4612 Comercio ambulante de abarrotes, alimentos, bebidas, hielo y tabaco
        4620  |      13779      12.22      12.22      46.05	 /// 4620 Comercio al por menor en tiendas de autoservicio y departamentales
        4631  |      10492       9.31       9.31      55.36	 /// 4631 Comercio al por menor de productos textiles, bisutería, accesorios de vestir y calzado
        4632  |       2492       2.21       2.21      57.57	 /// 4632 Comercio ambulante de productos textiles, bisutería, accesorios de vestir y calzado
        4641  |       4415       3.92       3.92      61.48	 /// 4641 Comercio al por menor de artículos para el cuidado de la salud
        4642  |        378       0.34       0.34      61.82	 /// 4642 Comercio ambulante de artículos para el cuidado de la salud 			
        4651  |       7814       6.93       6.93      68.75	 /// 4651 Comercio al por menor de artículos de papelería, para el esparcimiento y otros artículos de uso personal
        4661  |       8245       7.31       7.31      77.40	 /// 4661 Comercio al por menor de enseres domésticos, computadoras, artículos para la decoración de interiores y de artículos usados
        4662  |       2955       2.62       2.62      80.02	 /// 4662 Comercio ambulante de muebles, artículos para el hogar y de artículos usados.
        4671  |       5407       4.80       4.80      84.81	 /// 4671 Comercio al por menor de artículos de ferretería, tlapalería y vidrios
        4672  |        372       0.33       0.33      85.14	 /// 4672 Comercio ambulante de artículos de ferretería, tlapalería
        4681  |       9407       8.34       8.34      93.49	 /// 4681 Comercio al por menor de vehículos de motor, refacciones, combustibles y lubricantes
        4682  |        139       0.12       0.12      93.61	 /// 4682 Comercio ambulante de partes y refacciones para automóviles, camionetas y combustibles
        4690  |       7166       6.36       6.36      99.96	 /// 4690 Comercio al por menor exclusivamente a través de Internet, y catálogos impresos, televisión y similares
        4699  |         40       0.04       0.04     100.00	 /// 4699 Descripciones insuficientemente especificadas de subsector de actividad del sector
        Total |     112754     100.00     100.00           
-----------------------------------------------------------

// Source of P4A codes: 
// https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/doc/clasificaciones_enoe.pdf     */								
		
			
			

// Generate variable to identify different types of retail trade. 
generate retail_cat=.	
replace  retail_cat=0  if inlist(clase2,2,3,4)
replace  retail_cat=1  if inlist(P4A,4612,4632,4642,4652,4662,4672,4682)   		// Comercio ambulante				
replace  retail_cat=2  if P4A==4611	// 4611 Comercio al por menor de abarrotes, alimentos, bebidas, hielo y tabaco
replace  retail_cat=3  if P4A==4620	// 4620 Comercio al por menor en tiendas de autoservicio y departamentales
replace  retail_cat=4  if P4A==4631	// 4631 Comercio al por menor de productos textiles, bisutería, accesorios de vestir y calzado
replace  retail_cat=5  if P4A==4641	// 4641 Comercio al por menor de artículos para el cuidado de la salud
replace  retail_cat=6  if P4A==4651	// 4651 Comercio al por menor de artículos de papelería, para el esparcimiento y otros artículos de uso personal
replace  retail_cat=7  if P4A==4661	// 4661 Comercio al por menor de enseres domésticos, computadoras, artículos para la decoración de interiores y de artículos usados
replace  retail_cat=8  if P4A==4671	// 4671 Comercio al por menor de artículos de ferretería, tlapalería y vidrios
replace  retail_cat=9  if P4A==4681	// 4681 Comercio al por menor de vehículos de motor, refacciones, combustibles y lubricantes
replace  retail_cat=10 if P4A==4690	// 4690 Comercio al por menor exclusivamente a través de Internet, y catálogos impresos, televisión y similares
// Labeling
label define retail_cat 0      "Not working",				 				 								modify
label define retail_cat 1      "Street retail trade",		 				 								modify
label define retail_cat 2      "Grocery stores", 							 								modify
label define retail_cat 3      "Departamental and convenience stores", 		 								modify
label define retail_cat 4      "Clothing, footwear, jewelry, and other accesories of textiles products", 	modify
label define retail_cat 5      "Health care products", 				 										modify
label define retail_cat 6      "Stationery products", 				 										modify
label define retail_cat 7      "Household goods or decoration items, used articles, and computers",			modify
label define retail_cat 8      "Retail stores selling hardware, paint, or glassware items", 				modify
label define retail_cat 9      "Retail stores selling cars, autoparts, fuels, and lubricants",				modify
label define retail_cat 10     "Selling items using internet or printed catalogs ", 						modify
label value retail_cat retail_cat
// Exploratory Data Analysis
tab retail_cat
tab retail_cat if retail_cat!=0
tab retail_cat [fweight=fac]
tab retail_cat emp_ppal [fweight=fac], row		
			
			

// Generate variable to identify different types of activities within hotels, food and beverages. 			
generate hotel_food=. 
replace  hotel_food=0 if inlist(clase2,2,3,4)
replace  hotel_food=1 if P4A==7210 // 7210 Servicios de alojamiento temporal 
replace  hotel_food=2 if P4A==7221 // 7221 Servicios de preparación de alimentos y bebidas 
replace  hotel_food=3 if P4A==7222 // 7222 Servicios de preparación de alimentos y bebidas por trabajadores en unidades ambulantes
// Labeling
label define hotel_food 0 "Not working",				 		modify
label define hotel_food 1 "Hotels and temporary accomodation", 	modify
label define hotel_food 2 "Food and beverages", 				modify
label define hotel_food 3 "Food and beverages in streets", 		modify			
// Exploratory Data Analysis
tab hotel_food
tab hotel_food if hotel_food!=0
tab hotel_food [fweight=fac]
tab hotel_food emp_ppal [fweight=fac], row		
						
			
			
			
			
			
			
			
			
// 	Generate variables to identify 52 different economic activities 
generate cat_52_scian=.			
replace  cat_52_scian=1		if P4A==1110 // Agricultura
replace  cat_52_scian=2		if P4A==1121 // Cría y explotación de animales
replace  cat_52_scian=3		if P4A==1122 // Acuicultura
replace  cat_52_scian=4		if P4A==1130 // Aprovechamiento forestal
replace  cat_52_scian=5		if P4A==1141 // Pesca
replace  cat_52_scian=6		if P4A==1142 // Caza y captura 
replace  cat_52_scian=7		if P4A==1150 // Servicios relacionados con las actividades agropecuarias y forestales
replace  cat_52_scian=7		if P4A==1199 // Descripciones insuficientemente especificadas (Agriclutura)
replace  cat_52_scian=8		if scian==2	 // Mineria
replace  cat_52_scian=9		if scian==3  // Generacion y distribucion de electricidad, agua y gas	
replace  cat_52_scian=10	if scian==4	 // Construccion
replace  cat_52_scian=11	if P4A==3110 // Industria alimentaria 
replace  cat_52_scian=12	if P4A==3120 // Industria de las bebidas y del tabaco 
replace  cat_52_scian=13	if P4A==3130 // Fabricación de insumos textiles y acabado de textiles 
replace  cat_52_scian=14	if P4A==3140 // Fabricación de productos textiles, excepto prendas de vestir 
replace  cat_52_scian=15	if P4A==3150 // Fabricación de prendas de vestir 
replace  cat_52_scian=16	if P4A==3160 // Curtido y acabado de cuero y piel, y fabricación de productos de cuero, piel y materiales sucedáneos
replace  cat_52_scian=17	if P4A==3210 // Industria de la madera
replace  cat_52_scian=18	if P4A==3220 // Industria del papel
replace  cat_52_scian=19	if P4A==3230 // Impresión e industrias conexas
replace  cat_52_scian=20	if P4A==3240 // Fabricación de productos derivados del petróleo y del carbón
replace  cat_52_scian=21	if P4A==3250 // Industria química
replace  cat_52_scian=22	if P4A==3260 // Industria del plástico y del hule
replace  cat_52_scian=23	if P4A==3270 // Fabricación de productos a base de minerales no metálicos
replace  cat_52_scian=24	if P4A==3310 // Industrias metálicas básicas
replace  cat_52_scian=25	if P4A==3320 // Fabricación de productos metálicos
replace  cat_52_scian=26	if P4A==3330 // Fabricación de maquinaria y equipo
replace  cat_52_scian=27	if P4A==3340 // Fabricación de equipo de computación, comunicación, medición y de otros equipos, componentes y accesorios electrónicos
replace  cat_52_scian=28	if P4A==3350 // Fabricación de accesorios, aparatos eléctricos y equipo de generación de energía eléctrica
replace  cat_52_scian=29	if P4A==3360 // Fabricación de equipo de transporte y partes para vehículos automotores
replace  cat_52_scian=30	if P4A==3370 // Fabricación de muebles, colchones y persianas
replace  cat_52_scian=31	if P4A==3380 // Otras industrias manufactureras
replace  cat_52_scian=31	if P4A==3399 // Descripciones insuficientemente especificadas de subsector de actividad del sector			
replace  cat_52_scian=32	if scian==6	 //	"Wholesale trade"									
replace  cat_52_scian=33	if scian==7	 //	"Retail trade"                                  	
replace  cat_52_scian=34	if scian==8	 //	"Transportation (Air, water, railway, etc)"     	
replace  cat_52_scian=35	if scian==9	 //	"Media services"									
replace  cat_52_scian=36	if scian==10 //	"Finance and insurance"                             
replace  cat_52_scian=37	if scian==11 //	"Real estate"                                       
replace  cat_52_scian=38	if scian==12 //	"Scientists, professionals and technical services"  
replace  cat_52_scian=39	if scian==13 //	"Corporate services"                                
replace  cat_52_scian=40	if scian==14 //	"Business support"                                  
replace  cat_52_scian=41	if scian==15 //	"Education services"                                
replace  cat_52_scian=42	if scian==16 //	"Health and social assistance"                      
replace  cat_52_scian=43	if scian==17 //	"Culture, sports, leisure"                          
replace  cat_52_scian=44	if scian==18 //	"Temporary accommodation, food and beverage"
replace  cat_52_scian=45	if scian==19 //	"Other services"                                                        
replace  cat_52_scian=46	if scian==20 //	"Government"                                                        
replace  cat_52_scian=47	if scian==21 //	"Unspecified service activities"                   
replace  cat_52_scian=48	if P4A==8111 // Servicios de reparación y mantenimiento de automóviles y camiones                   
replace  cat_52_scian=49	if P4A==8112 // Servicios de reparación y mantenimiento de equipo, maquinaria, artículos para el hogar y personales
replace  cat_52_scian=50	if P4A==8121 // Servicios personales
replace  cat_52_scian=51	if P4A==8130 // Asociaciones y organizaciones
replace  cat_52_scian=52    if P4A==8140 // Hogares con empleados domésticos
// Labelling
label define cat_52_scian 1     "Agriculture",		 								 modify
label define cat_52_scian 2     "Animal breeding and exploitation", 				 modify
label define cat_52_scian 3     "Aquaculture", 										 modify
label define cat_52_scian 4     "Forestry use", 									 modify
label define cat_52_scian 5     "Fishing", 											 modify
label define cat_52_scian 6     "Hunting and capturing", 							 modify
label define cat_52_scian 7     "Other agricultural activities", 					 modify
label define cat_52_scian 8		"Mining",											 modify
label define cat_52_scian 9		"Supply of electricity, water or gas", 				 modify
label define cat_52_scian 10	"Construction", 									 modify
label define cat_52_scian 11	"Food industry", 									 modify
label define cat_52_scian 12	"Beverage and tobacco industry",			    	 modify
label define cat_52_scian 13	"Textile Inputs",						        	 modify
label define cat_52_scian 14	"Textile products, except clothing",		    	 modify
label define cat_52_scian 15	"Clothing ",                                    	 modify
label define cat_52_scian 16	"Leather goods manufacturing",			        	 modify
label define cat_52_scian 17	"Wood industry",                                	 modify
label define cat_52_scian 18	"Paper industry",     					        	 modify
label define cat_52_scian 19	"Printing and related industries",					 modify
label define cat_52_scian 20	"Petroleum and coal products",  					 modify
label define cat_52_scian 21	"Chemical industry",                        		 modify
label define cat_52_scian 22	"Plastic and rubber industry",  					 modify
label define cat_52_scian 23	"Non-metallic mineral products", 					 modify
label define cat_52_scian 24	"Basic metal industries", 							 modify
label define cat_52_scian 25	"Metal products manufacturing", 					 modify
label define cat_52_scian 26	"Machinery and equipment manufacturing", 	    	 modify
label define cat_52_scian 27	"Computers and other electronic components",    	 modify
label define cat_52_scian 28	"Electric appliances and accessories", 	        	 modify
label define cat_52_scian 29	"Autoparts and transportation equipment",       	 modify
label define cat_52_scian 30	"Furniture, mattresses, and blinds",            	 modify
label define cat_52_scian 31	"Unspecified manufacturing activities",				 modify
label define cat_52_scian 32	"Wholesale trade",									 modify
label define cat_52_scian 33	"Retail trade",                                  	 modify
label define cat_52_scian 34	"Transportation (Air, water, railway, etc)",     	 modify
label define cat_52_scian 35	"Media services",									 modify
label define cat_52_scian 36	"Finance and insurance",                           	 modify
label define cat_52_scian 37	"Real estate",                                     	 modify
label define cat_52_scian 38	"Scientists, professionals and technical services",	 modify
label define cat_52_scian 39	"Corporate services",                              	 modify
label define cat_52_scian 40	"Business support",                                	 modify
label define cat_52_scian 41	"Education services",                              	 modify
label define cat_52_scian 42	"Health and social assistance",                    	 modify
label define cat_52_scian 43	"Culture, sports, leisure",                        	 modify
label define cat_52_scian 44	"Temporary accommodation, food and beverage",      	 modify
label define cat_52_scian 45	"Other services",                                  	 modify
label define cat_52_scian 46	"Government",                                      	 modify
label define cat_52_scian 47	"Unspecified service activities",                  	 modify
label define cat_52_scian 48	"Repair and maintenance services (Cars and trucks)", modify
label define cat_52_scian 49	"Repair and maintenance services (Machinery)", 		 modify
label define cat_52_scian 50	"Personal services", 								 modify
label define cat_52_scian 51	"Associations and organizations", 					 modify
label define cat_52_scian 52	"Domestic employees", 								 modify
label value cat_52_scian cat_52_scian
// Exploratory Data Analysis
tab clase2 if cat_52_scian==. // Consistency check: All working people has been classified in variable cat_52_scian
tab cat_52_scian [fweight=fac]







// 	Generate variables to identify 50 different economic activities 
generate cat_scian_50=.			
replace  cat_scian_50=1		if P4A==1110 // Agricultura
replace  cat_scian_50=2		if P4A==1121 // Cría y explotación de animales
replace  cat_scian_50=3		if P4A==1122 // Acuicultura
replace  cat_scian_50=4		if P4A==1141 // Pesca
replace  cat_scian_50=5		if P4A==1130 // Aprovechamiento forestal
replace  cat_scian_50=5		if P4A==1142 // Caza y captura 
replace  cat_scian_50=5		if P4A==1150 // Servicios relacionados con las actividades agropecuarias y forestales
replace  cat_scian_50=5		if P4A==1199 // Descripciones insuficientemente especificadas (Agriclutura)
replace  cat_scian_50=6		if scian==2	 // Mineria
replace  cat_scian_50=7 	if scian==3  // Generacion y distribucion de electricidad, agua y gas	
replace  cat_scian_50=8		if scian==4	 // Construccion
replace  cat_scian_50=9		if P4A==3110 // Industria alimentaria 
replace  cat_scian_50=10	if P4A==3120 // Industria de las bebidas y del tabaco 
replace  cat_scian_50=11	if P4A==3130 // Fabricación de insumos textiles y acabado de textiles 
replace  cat_scian_50=12	if P4A==3140 // Fabricación de productos textiles, excepto prendas de vestir 
replace  cat_scian_50=13	if P4A==3150 // Fabricación de prendas de vestir 
replace  cat_scian_50=14	if P4A==3160 // Curtido y acabado de cuero y piel, y fabricación de productos de cuero, piel y materiales sucedáneos
replace  cat_scian_50=15	if P4A==3210 // Industria de la madera
replace  cat_scian_50=16	if P4A==3220 // Industria del papel
replace  cat_scian_50=17	if P4A==3230 // Impresión e industrias conexas
replace  cat_scian_50=18	if P4A==3240 // Fabricación de productos derivados del petróleo y del carbón
replace  cat_scian_50=19	if P4A==3250 // Industria química
replace  cat_scian_50=20	if P4A==3260 // Industria del plástico y del hule
replace  cat_scian_50=21	if P4A==3270 // Fabricación de productos a base de minerales no metálicos
replace  cat_scian_50=22	if P4A==3310 // Industrias metálicas básicas
replace  cat_scian_50=23	if P4A==3320 // Fabricación de productos metálicos
replace  cat_scian_50=24	if P4A==3330 // Fabricación de maquinaria y equipo
replace  cat_scian_50=25	if P4A==3340 // Fabricación de equipo de computación, comunicación, medición y de otros equipos, componentes y accesorios electrónicos
replace  cat_scian_50=26	if P4A==3350 // Fabricación de accesorios, aparatos eléctricos y equipo de generación de energía eléctrica
replace  cat_scian_50=27	if P4A==3360 // Fabricación de equipo de transporte y partes para vehículos automotores
replace  cat_scian_50=28	if P4A==3370 // Fabricación de muebles, colchones y persianas
replace  cat_scian_50=29	if P4A==3380 // Otras industrias manufactureras
replace  cat_scian_50=30	if P4A==3399 // Descripciones insuficientemente especificadas de subsector de actividad del sector			
replace  cat_scian_50=31	if scian==6	 //	"Wholesale trade"									
replace  cat_scian_50=31	if scian==7	 //	"Retail trade"                                  	
replace  cat_scian_50=32	if scian==8	 //	"Transportation (Air, water, railway, etc)"     	
replace  cat_scian_50=33	if scian==9	 //	"Media services"									
replace  cat_scian_50=34	if scian==10 //	"Finance and insurance"                             
replace  cat_scian_50=35	if scian==11 //	"Real estate"                                       
replace  cat_scian_50=36	if scian==12 //	"Scientists, professionals and technical services"  
replace  cat_scian_50=37	if scian==13 //	"Corporate services"                                
replace  cat_scian_50=38	if scian==14 //	"Business support"                                  
replace  cat_scian_50=39	if scian==15 //	"Education services"                                
replace  cat_scian_50=40	if scian==16 //	"Health and social assistance"                      
replace  cat_scian_50=41	if scian==17 //	"Culture, sports, leisure"                          
replace  cat_scian_50=42	if scian==18 //	"Temporary accommodation, food and beverage"
replace  cat_scian_50=43	if scian==19 //	"Other services"                                                        
replace  cat_scian_50=44	if scian==20 //	"Government"                                                        
replace  cat_scian_50=45	if scian==21 //	"Unspecified service activities"                   
replace  cat_scian_50=46	if P4A==8111 // Servicios de reparación y mantenimiento de automóviles y camiones                   
replace  cat_scian_50=47	if P4A==8112 // Servicios de reparación y mantenimiento de equipo, maquinaria, artículos para el hogar y personales
replace  cat_scian_50=48	if P4A==8121 // Servicios personales
replace  cat_scian_50=49	if P4A==8130 // Asociaciones y organizaciones
replace  cat_scian_50=50    if P4A==8140 // Hogares con empleados domésticos
// Labeling                       
label define cat_scian_50 1     "Agriculture",		 								 modify
label define cat_scian_50 2     "Animal breeding and exploitation", 				 modify
label define cat_scian_50 3     "Aquaculture", 										 modify
label define cat_scian_50 4     "Fishing", 											 modify
label define cat_scian_50 5     "Other agricultural activities", 					 modify
label define cat_scian_50 6		"Mining",											 modify
label define cat_scian_50 7		"Supply of electricity, water or gas", 				 modify
label define cat_scian_50 8		"Construction", 									 modify
label define cat_scian_50 9		"Food industry", 									 modify
label define cat_scian_50 10	"Beverage and tobacco industry",			    	 modify
label define cat_scian_50 11	"Textile Inputs",						        	 modify
label define cat_scian_50 12	"Textile products, except clothing",		    	 modify
label define cat_scian_50 13	"Clothing ",                                    	 modify
label define cat_scian_50 14	"Leather goods manufacturing",			        	 modify
label define cat_scian_50 15	"Wood industry",                                	 modify
label define cat_scian_50 16	"Paper industry",     					        	 modify
label define cat_scian_50 17	"Printing and related industries",					 modify
label define cat_scian_50 18	"Petroleum and coal products",  					 modify
label define cat_scian_50 19	"Chemical industry",                        		 modify
label define cat_scian_50 20	"Plastic and rubber industry",  					 modify
label define cat_scian_50 21	"Non-metallic mineral products", 					 modify
label define cat_scian_50 22	"Basic metal industries", 							 modify
label define cat_scian_50 23	"Metal products manufacturing", 					 modify
label define cat_scian_50 24	"Machinery and equipment manufacturing", 	    	 modify
label define cat_scian_50 25	"Computers and other electronic components",    	 modify
label define cat_scian_50 26	"Electric appliances and accessories", 	        	 modify
label define cat_scian_50 27	"Autoparts and transportation equipment",       	 modify
label define cat_scian_50 28	"Furniture, mattresses, and blinds",            	 modify
label define cat_scian_50 29	"Unspecified manufacturing activities",				 modify
label define cat_scian_50 30	"Wholesale trade",									 modify
label define cat_scian_50 31	"Retail trade",                                  	 modify
label define cat_scian_50 32	"Transportation (Air, water, railway, etc)",     	 modify
label define cat_scian_50 33	"Media services",									 modify
label define cat_scian_50 34	"Finance and insurance",                           	 modify
label define cat_scian_50 35	"Real estate",                                     	 modify
label define cat_scian_50 36	"Scientists, professionals and technical services",	 modify
label define cat_scian_50 37	"Corporate services",                              	 modify
label define cat_scian_50 38	"Business support",                                	 modify
label define cat_scian_50 39	"Education services",                              	 modify
label define cat_scian_50 40	"Health and social assistance",                    	 modify
label define cat_scian_50 41	"Culture, sports, leisure",                        	 modify
label define cat_scian_50 42	"Temporary accommodation, food and beverage",      	 modify
label define cat_scian_50 43	"Other services",                                  	 modify
label define cat_scian_50 44	"Government",                                      	 modify
label define cat_scian_50 45	"Unspecified service activities",                  	 modify
label define cat_scian_50 46	"Repair and maintenance services (Cars and trucks)", modify
label define cat_scian_50 47	"Repair and maintenance services (Machinery)", 		 modify
label define cat_scian_50 48	"Personal services", 								 modify
label define cat_scian_50 49	"Associations and organizations", 					 modify
label define cat_scian_50 50	"Domestic employees", 								 modify
label value cat_scian_50 cat_scian_50
// Exploratory Data Analysis 
tab clase2 if cat_scian_50==. // Consistency check: All working people has been classified in variable cat_52_scian
tab cat_scian_50 [fweight=fac]		
tab cat_scian_50 cat_informal [fweight=fac], row nofreq
 

 
 
 
 
 
 
 
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

generate service_scian=. 


replace  service_scian=1  if scian==6  // 6   Comercio al por mayor
/*
4310 Comercio al por mayor de abarrotes, alimentos, bebidas, hielo y tabaco
4320 Comercio al por mayor de productos textiles y calzado
4330 Comercio al por mayor de productos farmacéuticos, de perfumería, artículos para el esparcimiento, electrodomésticos menores y aparatos de línea blanca
4340 Comercio al por mayor de materias primas agropecuarias y forestales, para la industria, y materiales de desecho
4350 Comercio al por mayor de maquinaria, equipo y mobiliario para actividades agropecuarias, industriales, de servicios y comerciales, y de otra maquinaria y equipo de uso general
4360 Comercio al por mayor de camiones y de partes y refacciones nuevas para automóviles, camionetas y camiones
4370 Intermediación de comercio al por mayor
4399 Descripciones insuficientemente especificadas de subsector de actividad del sector
43, Comercio al por mayor
*/


// Generate category to identify STREET TRADE
replace  service_scian=2 if inlist(P4A,4612,4632,4642,4652,4662,4672,4682,7133,7222,9521,9511,9512,9521)
/*
4612 Comercio ambulante de abarrotes, alimentos, bebidas, hielo y tabaco 
4632 Comercio ambulante de productos textiles, bisutería, accesorios de vestir y calzado 
4642 Comercio ambulante de artículos para el cuidado de la salud 
4652 Comercio ambulante de artículos de papelería, para el esparcimiento y otros artículos de uso personal 
4662 Comercio ambulante de muebles, artículos para el hogar y de artículos usados. 
4672 Comercio ambulante de artículos de ferretería, tlapalería 
4682 Comercio ambulante de partes y refacciones para automóviles, camionetas y combustibles

7133 Venta ambulante de billetes de lotería nacional 
7222 Servicios de preparación de alimentos y bebidas por trabajadores en unidades ambulantes 
9521 Preparadores y vendedores ambulantes de alimentos 
9511 Vendedores ambulantes de periódicos y lotería 
9512 Vendedores ambulantes de artículos diversos (excluyendo los de venta de alimentos) 
9521 Preparadores y vendedores ambulantes de alimentos 
*/
  
  
// Generate category to identify RETAIL TRADE (Excluding STREET TRADE)
replace  service_scian=3 if inlist(P4A,4641,4661,4671,4681,4699)
/*
4641 Comercio al por menor de artículos para el cuidado de la salud 
4661 Comercio al por menor de enseres domésticos, computadoras, artículos para la decoración de interiores y de artículos usados
4671 Comercio al por menor de artículos de ferretería, tlapalería y vidrios 				<----------------------------------- Other retail trade
4681 Comercio al por menor de vehículos de motor, refacciones, combustibles y lubricantes 	<----------------------------------- Other retail trade
4699 Descripciones insuficientemente especificadas de subsector de actividad del sector 43, Comercio al por menor 
*/


replace  service_scian=4  if scian==8  // Transportes, correos y almacenamiento 
/*
4810 Transporte aéreo
4820 Transporte por ferrocarril
4830 Transporte por agua
4840 Autotransporte de carga
4850 Transporte terrestre de pasajeros, excepto por ferrocarril
4860 Transporte por ductos
4870 Transporte turístico
4881 Servicios relacionados con el transporte
4882 Servicios de reparación y limpieza exterior de aviones, barcos y trenes                					<-----------------------------------
4899 Descripciones insuficientemente especificadas de subsector de actividad del sector

4910 Servicios postales																							<-----------------------------------
4920 Servicios de mensajería y paquetería																		<-----------------------------------
4930 Servicios de almacenamiento																				<-----------------------------------
*/


replace  service_scian=5  if scian==9  // 9   Información en medios masivos   
/*
5110 Edición de periódicos, revistas, libros, software y otros materiales, y edición de estas publicaciones integrada con la impresión
5120 Industria fílmica y del video, e industria del sonido
5150 Radio y televisión 
5170 Otras telecomunicaciones 
5180 Procesamiento electrónico de información, hospedaje y otros servicios relacionados 
5190 Otros servicios de información 
5199 Descripciones insuficientemente especificadas de subsector de actividad del sector 51, Información en medios masivos
*/


replace  service_scian=6  if scian==10 // 10  Servicios financieros y de seguros
/*
5210 Banca central (Banco de México)
5221 Banca múltiple, y administración de fondos y fideicomisos del sector privado
5222 Otras instituciones de intermediación crediticia y financiera no bursátil del sector privado
5223 Banca de desarrollo, y administración de fondos y fideicomisos del sector público
5229 Descripciones insuficientemente especificadas de servicios financieros no bursátiles
5230 Actividades bursátiles, cambiarias y de inversión financiera
5240 Compañías de fianzas, seguros y pensiones
5299 Descripciones insuficientemente especificadas de subsector de actividad del sector 52, Servicios financieros y de seguros 
*/

replace  service_scian=7  if scian==11 // Real estate and rental services
/*
5310 Servicios inmobiliarios
5321 Servicios de alquiler de automóviles, camiones y otros transportes terrestres
5322 Servicios de alquiler y centros de alquiler de bienes muebles, excepto equipo de transporte terrestre
5330 Servicios de alquiler de marcas registradas, patentes y franquicias
5399 Descripciones insuficientemente especificadas de subsector de actividad del sector 53, Servicios inmobiliarios y de alquiler de bienes muebles e intangibles 

Atencion: Despues de este codigo, se excluira la categoria 5310, la cual se usara para crear la categoria "real estate" de forma separada. 
*/

/*
replace  service_scian=8  if P4A==xxx // (real estate) 
*/

replace  service_scian=9  if scian==12 // 12  Servicios profesionales, científicos y técnicos
/*
5411 Servicios profesionales, científicos y técnicos		
5412 Servicios de investigación científica y desarrollo 	
5413 Servicios veterinarios									 
5414 Servicios de fotografía 								 
*/

replace  service_scian=10 if scian==13 // 13  Corporativos
/*
5510 Corporativos
*/

replace  service_scian=11   if scian==14 // 14  Servicios de apoyo a los negocios y manejo de desechos
/*
56 	 Servicios de apoyo a los negocios y manejo de desechos y servicios de remediación 

5611 Servicios de apoyo a los negocios, de empleo, apoyo secretarial y otros servicios de apoyo a los negocios
5612 Limpieza interior de aviones, barcos y trenes  		<-----------------------------------
5613 Servicios de limpieza y de instalación y mantenimiento de áreas verdes
5614 Servicios de investigación, protección y seguridad
5615 Agencias de viajes y servicios de reservaciones
5616 Servicios combinados de apoyo a instalaciones
5620 Manejo de desechos y servicios de remediación 
*/

replace  service_scian=12   if scian==15 // 15  Servicios educativos
/*
6111 Escuela de educación básica, media y especial pertenecientes al sector privado
6112 Escuela de educación básica, media y especial pertenecientes al sector público
6119 Escuela de educación básica, media y especial no especificadas de sector privado o público
6121 Escuelas de educación postbachillerato no universitaria perteneciente al sector privado
6122 Escuelas de educación postbachillerato no universitaria perteneciente al sector público
6129 Escuelas de educación postbachillerato no universitaria no especificadas de sector privado o público
6131 Escuelas de educación superior pertenecientes al sector privado
6132 Escuelas de educación superior pertenecientes al sector público
6139 Escuelas de educación superior no especificadas de sector privado o público
6141 Otros servicios educativos pertenecientes al sector privado
6142 Otros servicios educativos pertenecientes al sector público
6149 Otros servicios educativos no especificados de sector privado o público
6150 Servicios de apoyo a la educación
6199 Descripciones insuficientemente especificadas de subsector de actividad del sector 61, Servicios educativos
*/

replace  service_scian=13   if scian==16 // 16  Servicios de salud y de asistencia social
/*
62 Servicios de salud y de asistencia social
6211 Servicios médicos de consulta externa y servicios relacionados pertenecientes al sector privado
6212 Servicios médicos de consulta externa y servicios relacionados pertenecientes al sector público
6219 Servicios médicos de consulta externa y servicios relacionados no especificados de sector privado o público
6221 Hospitales pertenecientes al sector privado
6222 Hospitales pertenecientes al sector público
6229 Hospitales no especificados de sector privado o público
6231 Residencias de asistencia social y para el cuidado de la salud pertenecientes al sector privado
6232 Residencias de asistencia social y para el cuidado de la salud pertenecientes al sector público
6239 Residencias de asistencia social y para el cuidado de la salud no especificadas de sector privado o público
6241 Otros servicios de asistencia social pertenecientes al sector privado
6242 Otros servicios de asistencia social pertenecientes al sector público
6249 Otros servicios de asistencia social no especificados de sector privado o público
6251 Guarderías pertenecientes al sector privado					<----------------------------------- Este codigo se usara para crear la variable "Childcare services"
6252 Guarderías pertenecientes al sector público					<----------------------------------- Este codigo se usara para crear la variable "Childcare services"
6259 Guarderías no especificados de sector privado o público		<----------------------------------- Este codigo se usara para crear la variable "Childcare services"
6299 Descripciones insuficientemente especificadas de subsector de actividad del sector 62, Servicios de salud y de asistencia social
*/



replace  service_scian=14   if scian==17 // 17  Servicios de esparcimiento, culturales y deportivos
/*
71 Servicios de esparcimiento culturales y deportivos, y otros servicios recreativos
7111 Compañías y grupos de espectáculos artísticos
7112 Deportistas y equipos deportivos profesionales y semiprofesionales
7113 Promotores, agentes y representantes de espectáculos artísticos, deportivos y similares
7114 Artistas, escritores y técnicos independientes
7115 Trabajadores ambulantes en espectáculos						<----------------------------------- Esta opcion debe ser parte de comercio ambulante
7120 Museos, sitios históricos, zoológicos y similares
7131 Parques con instalaciones recreativas y casas de juegos electrónicos
7132 Venta de billetes de lotería nacional						 	<----------------------------------- Esta opcion debe ser parte de RETAIL TRADE
7133 Venta ambulante de billetes de lotería nacional 				<----------------------------------- Esta opcion debe ser parte de comercio ambulante
*/


replace service_scian=15   if P4A==7210 // Hotels category
// 7210 Servicios de alojamiento temporal

replace service_scian=16   if P4A==7221 // Restaurants
// 7221 Servicios de preparación de alimentos y bebidas

replace service_scian=17   if scian==20 // Gobierno
/*
93 Actividades legislativas, gubernamentales, de impartición de justicia y de organismos internacionales y extraterritoriales
9311 Órganos legislativos
9312 Administración Pública Federal
9313 Administración Pública Estatal
9314 Administración Pública Municipal
9319 Descripciones de administración pública que no especifican el nivel de gobierno
9320 Organismos internacionales y extraterritoriales 
*/

replace service_scian=18   if scian==19 // 19 Otros servicios, excepto actividades gubernamentales
/*
81 Otros servicios excepto actividades gubernamentales
8111 Servicios de reparación y mantenimiento de automóviles y camiones
8112 Servicios de reparación y mantenimiento de equipo, maquinaria, artículos para el hogar y personales
8119 Descripciones insuficientemente especificadas de servicios de reparación y mantenimiento
8121 Servicios personales 
8122 Estacionamientos y pensiones para vehículos automotores
8123 Servicios de cuidado y de lavado de automóviles por trabajadores ambulantes
8124 Servicios de revelado e impresión de fotografías
8125 Servicios de administración de cementerios
8130 Asociaciones y organizaciones
8140 Hogares con empleados domésticos  
*/

 
replace service_scian=19   if P4A==9999 // Servicios no especificados
/// 9999 No especificado de sector de actividad 

replace service_scian=20   if P4A==8140 // Domestic employees 
// 8140 Hogares con empleados domésticos 

replace service_scian=21   if P4A==4611 // Tiendas de abarrotes  
// 4611 Comercio al por mayor de abarrotes, alimentos, bebidas, hielo y tabaco

replace service_scian=22   if P4A==4620 // Tiendas de auto servicio y departamentales  
// 4620 Comercio al por menor en tiendas de autoservicio y departamentales 

replace service_scian=23   if P4A==4631 // Tiendas de ropa, calzado, textiles  
// 4631 Comercio al por menor de productos textiles, bisutería, accesorios de vestir y calzado  

replace service_scian=24   if P4A==4690 // Ventas por internet o catalogos impresos
// 4690 Comercio al por menor exclusivamente a través de Internet, y catálogos impresos, televisión y similares 

replace service_scian=25   if P4A==4651 // Papeleria
// 4651 Comercio al por menor de artículos de papelería, para el esparcimiento y otros artículos de uso personal 

replace service_scian=26   if inlist(P4A,6251,6252,6259)
// 6251 Guarderías pertenecientes al sector privado			 
// 6252 Guarderías pertenecientes al sector público			 
// 6259 Guarderías no especificados de sector privado o público 
























































































 
 
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

						
// Generating variables to identify specific activities within the industrial and service sector 
			local new_variables ///
			industry 			/// INDUSTRY
			mining 				/// INDUSTRY
			food 				/// INDUSTRY
			autoparts 			/// INDUSTRY
			clothing 			/// INDUSTRY
			textile 			/// INDUSTRY
			computers 			/// INDUSTRY
			appliances 			/// INDUSTRY
			construction 		/// INDUSTRY
			street_trade 		/// SERVICES
			retail_trade 		/// SERVICES	
			domestic_emp		/// SERVICES
			hotels				/// SERVICES
			restaurants			/// SERVICES
			education 			/// SERVICES
			health 				/// SERVICES
			finance 			/// SERVICES			
			government 			/// SERVICES
			real_estate 		/// SERVICES		
			media				/// SERVICES
			corporate 			/// SERVICES
			hotel_rest 			/// SERVICES
			clerical 			//  SERVICES 

			foreach new_var of local new_variables {
			generate `new_var'=. 
			replace `new_var'=0 if clase2!=1 // takes value of 0 if they are not working 	
			}			
			
			replace industry=1			if P4A_Sector==2			// 2 = Working in industry
			replace mining=1 			if scian==2					// 2 = Working in mining
			replace food=1 				if P4A==3110 				// 3110 Industria alimentaria 	 			
			replace autoparts=1 		if P4A==3360 				// 3360 Fabricar equipo de transporte y autopartes	 		
			replace clothing=1 			if P4A==3150 				// 3150 Fabricar prendas de vestir 			 
			replace textile=1 			if P4A==3140 				// 3140 Fabricar productos textiles, excepto prendas de vestir			 
			replace computers=1 		if P4A==3340 				// 3340 Fabricar equipo de computo, componentes y accesorios electrónicos		 
			replace appliances=1 		if P4A==3350 				// 3350 Fabricar aparatos eléctricos, equipo para generación de energía eléctrica, accesorios 			 
			replace construction=1 		if scian==4 				// Construction			 
			
			replace real_estate=1 		if scian==11 				// Servicios inmobiliarios y de alquiler de bienes 	
			replace media=1 		  	if scian==9 				// Información en medios masivos		 
			replace finance=1 		  	if scian==10				// Servicios financieros y de seguros			 
			replace corporative=1 	  	if scian==13				// Servicios Corporativos		 
			replace education=1 	  	if scian==15				// Servicios educativos		 
			replace health=1 		  	if scian==16				// Servicios de salud y de asistencia social			
			replace government=1 	  	if scian==20				// Actividades gubernamentales y de organismos internacionales		 
			
			replace clerical=1 		  	if c_ocu11c==4 				// Clerical jobs		  
			replace domestic_emp=1	  	if P4A==8140				// 8140 Hogares con empleados domésticos
			replace street_trade=1		if inlist(P4A,4612,4632,4642,4652,4662,4672,4682) // Comercio ambulante

			
			replace retail=1 			if scian==7 				// Comercio al por menor		 
			replace non_street_retail=1	if street_retail_trade==0	// Comercio NO-AMBULANTE al por menor
 
			replace hotel_rest=1 	  	if scian==18				// Servicios de hospedaje y de preparación de alimentos y bebidas		 
			
			
			
// Generating variables to identify specific activities within the RETAIL TRADE 
			local retail_variables 	 	///
			retail10_street			 	///
			retail10_groceries 		 	///
			retail10_convenience	 	///
			retail10_clothing		 	///
			retail10_health			 	/// 
			retail10_stationery		 	///
			retail10_hhitemsdecor	 	///
			retail10_hardware		 	///
			retail10_cars_autoparts	 	///
			retail10_internet_catalogs 	//

			foreach retail_variable of local retail_variables {
			generate `retail_variable'=. 
			replace `retail_variable'=0 if clase2!=1 // takes value of 0 if they are not working 	
			}				
			
			replace retail10_street=1			  if inlist(P4A,4612,4632,4642,4652,4662,4672,4682)  // Comercio ambulante
			replace retail10_groceries=1		  if P4A==4611  // 4611 Comercio al por menor de abarrotes, alimentos, bebidas, hielo y tabaco
			replace retail10_convenience=1	 	  if P4A==4620  // 4620 Comercio al por menor en tiendas de autoservicio y departamentales
			replace retail10_clothing=1		 	  if P4A==4631  // 4631 Comercio al por menor de productos textiles, bisutería, accesorios de vestir y calzado
			replace retail10_health=1			  if P4A==4641  // 4641 Comercio al por menor de artículos para el cuidado de la salud
			replace retail10_stationery=1		  if P4A==4651  // 4651 Comercio al por menor de artículos de papelería, para el esparcimiento y otros artículos de uso personal
			replace retail10_hhitemsdecor=1	 	  if P4A==4661  // 4661 Comercio al por menor de enseres domésticos, computadoras, artículos para la decoración de interiores y de artículos usados			 
			replace retail10_hardware=1		 	  if P4A==4671  // 4671 Comercio al por menor de artículos de ferretería, tlapalería y vidrios
			replace retail10_cars_autoparts=1	  if P4A==4681  // 4681 Comercio al por menor de vehículos de motor, refacciones, combustibles y lubricantes 	
			replace retail10_internet_catalogs=1  if P4A==4690  // 4690 Comercio al por menor exclusivamente a través de Internet, y catálogos impresos, televisión y similares


			
			
// Generating variables to identify specific activities within FOOD AND RESTAURANTS 
			local hotelfood_variables 	///
			hf3cat_hotels 				///
			hf3cat_restaurant			///
			hf3cat_streetfood			//
			
			foreach hotelfood_variable of local hotelfood_variables {
			generate `hotelfood_variable'=. 
			replace `hotelfood_variable'=0 if clase2!=1 // takes value of 0 if they are not working 	
			}				
			
			replace hf3cat_hotels=1			if P4A==7210 // 7210 Servicios de alojamiento temporal
			replace hf3cat_restaurant=1		if P4A==7221 // 7221 Servicios de preparación de alimentos y bebidas
			replace hf3cat_streetfood=1		if P4A==7222 // 7222 Servicios de preparación de alimentos y bebidas por trabajadores en unidades ambulantes
	

	
	
// Generate variables to identify women that are married or in a free union relatoinship and their participation in specific economic sectors. 


generate married_agriculture=.
replace  married_agriculture=1 if female==1 & (e_con==1 | e_con==5) & work_p4asector==1
replace  married_agriculture=0 if female==1 & (e_con==1 | e_con==5) & work_p4asector==0

generate married_industry=.
replace  married_industry=1 if female==1 & (e_con==1 | e_con==5) & work_p4asector==2
replace  married_industry=0 if female==1 & (e_con==1 | e_con==5) & work_p4asector==0

generate married_services=.	
replace  married_services=1 if female==1 & (e_con==1 | e_con==5) & work_p4asector==3
replace  married_services=0 if female==1 & (e_con==1 | e_con==5) & work_p4asector==0	


	
	
save	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-const-activities.dta", replace  		



fre 		industry 			///
			mining 				///
			food 				///
			autoparts 			///
			clothing 			///
			textile 			/// 
			computers 			///
			appliances 			///
			construction 		///
if female==1 & eda>=18 & eda<=65 	
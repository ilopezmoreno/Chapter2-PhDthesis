clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-drop.dta" 

***************************************
***** Data Transformation Process *****
***************************************












// GENERATE NEW VARIABLES

	// Generate SCIAN categories, differentiating options within "Other services"
			clonevar scian_1 = scian
			fre scian_1
			fre p4a if scian==19 [fweight=fac]
			replace scian_1=22 if p4a==8111 // Servicios de reparación y mantenimiento de automóviles y camiones
			replace scian_1=23 if p4a==8112 // Servicios de reparación y mantenimiento de equipo, maquinaria, artículos para el hogar y personales
			replace scian_1=24 if p4a==8121 // Servicios personales
			replace scian_1=25 if p4a==8130 // Asociaciones y organizaciones
			replace scian_1=26 if p4a==8140 // Hogares con empleados domésticos
			recode scian_1 (0=.d) 			// Replacing 0 "Doesn't apply" to ".d"
			// List of codes for P4A variable available in the following INEGI website: 
			// https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/doc/clasificaciones_enoe.pdf
			
			label define scian_1 									///
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
			label value scian_1 scian_1
			fre scian_1 [fweight=fac]
			tab scian_1 [fweight=fac]

			
// Generate variable to identify specific economic activities within the manufacturing sector. 
tab p4a if scian==5 // 5 = Manufacturing	
	
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
	replace  manufacture_cat=1	if p4a==3110 // Industria alimentaria 
	replace  manufacture_cat=2	if p4a==3120 // Industria de las bebidas y del tabaco 
	replace  manufacture_cat=3	if p4a==3130 // Fabricación de insumos textiles y acabado de textiles 
	replace  manufacture_cat=4	if p4a==3140 // Fabricación de productos textiles, excepto prendas de vestir 
	replace  manufacture_cat=5	if p4a==3150 // Fabricación de prendas de vestir 
	replace  manufacture_cat=6	if p4a==3160 // Curtido y acabado de cuero y piel, y fabricación de productos de cuero, piel y materiales sucedáneos 
	replace  manufacture_cat=7	if p4a==3210 // Industria de la madera
	replace  manufacture_cat=8	if p4a==3220 // Industria del papel
	replace  manufacture_cat=9	if p4a==3230 // Impresión e industrias conexas
	replace  manufacture_cat=10	if p4a==3240 // Fabricación de productos derivados del petróleo y del carbón
	replace  manufacture_cat=11	if p4a==3250 // Industria química
	replace  manufacture_cat=12	if p4a==3260 // Industria del plástico y del hule
	replace  manufacture_cat=13	if p4a==3270 // Fabricación de productos a base de minerales no metálicos
	replace  manufacture_cat=14	if p4a==3310 // Industrias metálicas básicas
	replace  manufacture_cat=15	if p4a==3320 // Fabricación de productos metálicos
	replace  manufacture_cat=16	if p4a==3330 // Fabricación de maquinaria y equipo
	replace  manufacture_cat=17	if p4a==3340 // Fabricación de equipo de computación, comunicación, medición y de otros equipos, componentes y accesorios electrónicos
	replace  manufacture_cat=18	if p4a==3350 // Fabricación de accesorios, aparatos eléctricos y equipo de generación de energía eléctrica
	replace  manufacture_cat=19	if p4a==3360 // Fabricación de equipo de transporte y partes para vehículos automotores
	replace  manufacture_cat=20	if p4a==3370 // Fabricación de muebles, colchones y persianas
	replace  manufacture_cat=21	if p4a==3399 // Descripciones insuficientemente especificadas de subsector de actividad del sector

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
			
			
// Generate dummy variables to identify males and females.
			gen female=.
			replace female=1 if sex==2
			replace female=0 if sex==1
			label variable female "Female Identificator" 
			label define female 0 "Men" 1 "Women", replace
			label value female female
			drop sex
			
// Number of sons or daughters
			generate num_kids=.
			replace num_kids=0 if n_hij==0 
			replace num_kids=1 if n_hij==1
			replace num_kids=2 if n_hij==2
			replace num_kids=3 if n_hij==3
			replace num_kids=4 if n_hij==4
			replace num_kids=5 if n_hij>4 & n_hij<30
			label var num_kids "In total, how many live-born sons and daughters have you had?"
			label define num_kids 		/// 
			0 "No sons or daughters" 	///
			1 "1 son or daughter" 		///
			2 "2 sons or daughters" 	///
			3 "3 sons or daughters" 	///
			4 "4 sons or daughters" 	///
			5 "5 or more sons or daughters"
			label value num_kids num_kids
			tab num_kids
			tab n_hij num_kids // Data quality Check: Variable was created correctly
			drop n_hij
			
			
// Level of education
			generate educ=.
			replace educ=0 if cs_p13_1==0 // No studies at all
			replace educ=0 if cs_p13_1==1 // Pre-School
			replace educ=1 if cs_p13_1==2 // Elementary School
			replace educ=2 if cs_p13_1==3 // Secondary School
			replace educ=3 if cs_p13_1==4 // High School
			replace educ=4 if cs_p13_1==5 // Teacher Training 
			replace educ=4 if cs_p13_1==6 // Technical Career 
			replace educ=5 if cs_p13_1==7 // Bachelors 
			replace educ=5 if cs_p13_1==8 // Masters 
			replace educ=5 if cs_p13_1==9 // PhD 
			label var educ "Level of education"
			label define educ /// 
			0 "No Studies" ///
			1 "Primary School" ///
			2 "Secondary School" ///
			3 "High School" /// 
			4 "Technical Career" /// 
			5 "Graduate or post-graduate"
			label value educ educ
			tab educ cs_p13_1
			drop cs_p13_1
			
// Socio-economic stratum
			generate soc_str=.
			replace soc_str=1 if est==10 
			replace soc_str=2 if est==20 
			replace soc_str=3 if est==30 
			replace soc_str=4 if est==40 
			tab soc_str
			label define soc_str 1 "Low" 2 "Medium-Low" 3 "Medium-High" 4 "High", replace 
			label value soc_str soc_str 
			tab soc_str [fweight=fac]
			fre soc_str
			drop est
			
// Working ages (Between 18 and 65)
			generate working_age=. 
			replace working_age=1 if eda<=17 
			replace working_age=2 if eda>17 & eda<66
			replace working_age=3 if eda>=66
			label var working_age "People in Working Ages"
			label define working_age 1 "Below 18 years old" 2 "Between 18 & 65 years old" 3 "Above 65 years old"
			label value working_age working_age
			tab eda working_age // Data quality Check: Variable was created correctly
			
			
// Categorical variable to identify people workin in the primary, secondary or terciary sector. 
			generate P4A_Sector=.
			rename p4a P4A 
			replace P4A_Sector=1 if P4A>=1100 & P4A<=1199 
			// If values in P4A are between 1100 & 1199 classify as PRIMARY SECTOR
			replace P4A_Sector=2 if P4A>=2100 & P4A<=3399 
			// If values in P4A are between 2100 & 2399 classify as SECONDARY SECTOR
			replace P4A_Sector=3 if P4A>=4300 & P4A<=9399 
			// If values in P4A are between 4300 & 9399 classify as TERCIARY SECTOR
			replace P4A_Sector=4 if P4A>=9700 & P4A<=9999 
			// If values in P4A are between 9700 & 9999 classify as UNSPECIFIED ACTIVITIES
			// Define values of variable P4A_Sector
			label var P4A_Sector "Economic Sector Categories"
			label define P4A_Sector ///
			1 "Primary Sector" 2 "Secondary Sector" 3 "Terciary Sector" 4 "Unspecified Sector"
			label value P4A_Sector P4A_Sector
			tab P4A_Sector // Data quality check. Result: 0 missing values
			
			
// Dummy variable to identify working-age women working in the agricultural sector.
			generate work_fem_agri=.
			replace work_fem_agri=0 if female==1 & working_age==2 & clase2!=1 
			replace work_fem_agri=1 if female==1 & working_age==2 & clase2==1 & P4A_Sector==1 
			replace work_fem_agri=2 if female==1 & working_age==2 & clase2==1 & P4A_Sector!=1
			
// Dummy variable to identify working-age women working in the industrial sector.
			generate work_fem_ind=.
			replace work_fem_ind=0 if female==1 & working_age==2 & clase2!=1 
			replace work_fem_ind=1 if female==1 & working_age==2 & clase2==1 & P4A_Sector==2 
			replace work_fem_ind=2 if female==1 & working_age==2 & clase2==1 & P4A_Sector!=2 
			
// Dummy variable to identify working-age women working in the service sector.
			generate work_fem_serv=.
			replace work_fem_serv=0 if female==1 & working_age==2 & clase2!=1 
			replace work_fem_serv=1 if female==1 & working_age==2 & clase2==1 & P4A_Sector==3 
			replace work_fem_serv=2 if female==1 & working_age==2 & clase2==1 & P4A_Sector!=3 

// Dummy variable to identify informal jobs
			generate informal_jobs=.
			replace  informal_jobs=1 if emp_ppal==1 // Informal job 
			replace  informal_jobs=0 if emp_ppal==2 // Formal job 
			label variable informal_jobs "Informal jobs identificator" 
			label define informal_jobs 1 "Informal job" 2 "Formal job", replace
			label value informal_jobs informal_jobs			
			
// Dummy variable to identify the informal sector
			generate informal_sector=.
			replace  informal_sector=1 if tue_ppal==1 // Informal job 
			replace  informal_sector=0 if tue_ppal==2 // Formal job 
			label variable informal_sector "Informal sector identificator" 
			label define informal_sector 1 "Informal sector" 2 "Outside informal sector", replace
			label value informal_sector informal_jobs
			
// Generate a categorical variable that captures if the invidividual is not working, as well as in which sector are they working (in case they are)
			generate work_p4asector=.
			replace work_p4asector=0 if clase2!=1 // This will identify people that are not working.
			replace work_p4asector=1 if P4A_Sector==1 
			replace work_p4asector=2 if P4A_Sector==2
			replace work_p4asector=3 if P4A_Sector==3
			replace work_p4asector=4 if P4A_Sector==4
			label var work_p4asector "Working Categories"
			label define work_p4asector 0 "Not Working" 1 "Working in Agriculture" 2 "Working in Industry" 3 "Working in Services" 4 "Working in unspecified activities"
			label value work_p4asector work_p4asector
			tab work_p4asector // Data quality Check: 341,402 total observations. Variable was created correctly.

						
// Generating variables to identify specific activities within the industrial and service sector 

			local new_variables ///
			industry 			///
			food 				///
			autoparts 			///
			clothing 			///
			textile 			/// 
			computers 			///
			appliances 			///
			construction 		///
			real_estate 		///
			retail 				///
			media 				///
			finance 			///
			corporative 		///
			education 			///
			health 				///
			hotel_rest 			///
			government 			///
			clerical 			///
			domestic_emp 		//

			foreach new_var of local new_variables {
			generate `new_var'=. 
			replace `new_var'=0 if clase2!=1 // takes value of 0 if they are not working 	
			}			
			
			replace industry=1		if P4A_Sector==2	// 2 = Working in industry
			replace food=1 			if P4A==3110 		// 3110 Industria alimentaria 	 			
			replace autoparts=1 	if P4A==3360 		// 3360 Fabricar equipo de transporte y autopartes	 		
			replace clothing=1 		if P4A==3150 		// 3150 Fabricar prendas de vestir 			 
			replace textile=1 		if P4A==3140 		// 3140 Fabricar productos textiles, excepto prendas de vestir			 
			replace computers=1 	if P4A==3340 		// 3340 Fabricar equipo de computo, componentes y accesorios electrónicos		 
			replace appliances=1 	if P4A==3350 		// 3350 Fabricar aparatos eléctricos, equipo para generación de energía eléctrica, accesorios 			 
			replace construction=1 	if scian==4 		// Construction			 
			replace real_estate=1 	if scian==11 		// Servicios inmobiliarios y de alquiler de bienes 	
			replace retail=1 		if scian==7 		// Comercio al por menor		 
			replace media=1 		if scian==9 		// Información en medios masivos		 
			replace finance=1 		if scian==10		// Servicios financieros y de seguros			 
			replace corporative=1 	if scian==13		// Servicios Corporativos		 
			replace education=1 	if scian==15		// Servicios educativos		 
			replace health=1 		if scian==16		// Servicios de salud y de asistencia social			 
			replace hotel_rest=1 	if scian==18		// Servicios de hospedaje y de preparación de alimentos y bebidas		 
			replace government=1 	if scian==20		// Actividades gubernamentales y de organismos internacionales		 
			replace clerical=1 		if c_ocu11c==4 		// Clerical jobs		  
			replace domestic_emp=1	if P4A==8140		// 8140 Hogares con empleados domésticos
			
			// Source of P4A codes: 
			// https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/doc/clasificaciones_enoe.pdf

save	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-const.dta", replace  	
			
			
			
// Variable para estimar las horas trabajadas promedio en distintas actividades dentro del sector servicios 

					
			

			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
/*				
			
			// Dummy variable to identify working-age women working in the textiles sector.
			// *3130 Fabricación de insumos textiles y acabado de textiles
			// *3140 Fabricación de productos textiles, excepto prendas de vestir
			// *3150 Fabricación de prendas de vestir
			// *3160 Fabricación de productos de cuero, piel y materiales sucedáneos
			
	
			// Dummy variable to identify working-age women working in informal services.
			generate work_fem_serv_informal=.
			replace work_fem_serv_informal=0 if female==1 & working_age==2 & clase2!=1
			replace work_fem_serv_informal=1 if female==1 & working_age==2 & clase2==1 & P4A_Sector==3 & emp_ppal==1 

			
			// Dummy variable to identify working-age women working in formal services.
			generate work_fem_serv_formal=.
			replace work_fem_serv_formal=0 if female==1 & working_age==2 & clase2!=1
			replace work_fem_serv_formal=1 if female==1 & working_age==2 & clase2==1 & P4A_Sector==3 & emp_ppal==2
			
	
			// This variable excludes agriculture, services and unspecified activities. 
			generate ind_5=. 
			replace ind_5=0 if clase2!=1 // 0 if they are not working 
			replace ind_5=1 if rama_est1==2 // Jobs in industry excluding the mentioned below
			replace ind_5=2 if P4A==3110 // 3110 Industria alimentaria 
			replace ind_5=3 if P4A==3360 // 3360 Fabricación de equipo de transporte y autopartes
			replace ind_5=4 if P4A==3150 // 3150 Fabricación de prendas de vestir 
			replace ind_5=5 if rama_est2==4 // Construction
			tab ind_5
			label define ind_5 ///
			0 "Not working" ///
			1 "Other industrial jobs" ///
			2 "Food Industry" ///
			3 "Autoparts and transportation equipment" /// 
			4 "Clothing" /// 
			5 "Construction" 
			label value ind_5 ind_5
			tab ind_5, missing // Data quality checks: No missing values. 

			// This variable doesn't exclude agriculture, services and unspecified activities. 
			generate ind_8=. 
			replace ind_8=0 if clase2!=1 // 0 if they are not working 
			replace ind_8=1 if rama_est1==1 // Agriculture
			replace ind_8=2 if rama_est1==2 // Jobs in industry excluding the mentioned below
			replace ind_8=3 if P4A==3110 // 3110 Industria alimentaria 
			replace ind_8=4 if P4A==3360 // 3360 Fabricación de equipo de transporte y autopartes
			replace ind_8=5 if P4A==3150 // 3150 Fabricación de prendas de vestir 
			replace ind_8=6 if rama_est2==4 // Construction
			replace ind_8=7 if rama_est1==3 // Jobs in services
			replace ind_8=8 if rama_est1==4 // Unspecified activities
			tab ind_8
			label define ind_8 ///
			0 "Not working" ///
			1 "Agriculture" ///
			2 "Other industrial jobs" ///
			3 "Food Industry" ///
			4 "Manufacturing of autoparts and transportation equipment" /// 
			5 "Clothing" /// 
			6 "Construction" ///
			7 "Service jobs" /// 
			8 "Unspecified activities"
			label value ind_8 ind_8
			tab ind_8, missing // Data quality checks: No missing values. 



			generate service_jobcat=. 
			replace service_jobcat=0 if clase2!=1 // 0 if they are not working 
			replace service_jobcat=1 if scian==6 // Comercio al por mayor
			replace service_jobcat=2 if scian==7 // Comercio al por menor
			replace service_jobcat=3 if scian==8 // Transportes, correos y almacenamiento
			replace service_jobcat=4 if scian==9 // Información en medios masivos
			replace service_jobcat=5 if scian==10 // Servicios financieros y de seguros
			replace service_jobcat=6 if scian==11 // Servicios inmobiliarios y de alquiler de bienes
			replace service_jobcat=7 if scian==12 // Servicios profesionales, científicos y técnicos
			replace service_jobcat=8 if scian==13 // Servicios Corporativos
			replace service_jobcat=9 if scian==14 // Servicios de apoyo a los negocios y manejo de deseechos
			replace service_jobcat=10 if scian==15 // Servicios educativos
			replace service_jobcat=11 if scian==16 // Servicios de salud y de asistencia social
			replace service_jobcat=12 if scian==17 // Servicios de esparcimiento, culturales y deportivos
			replace service_jobcat=13 if scian==18 // Servicios de hospedaje y de preparación de alimentos y bebidas
			replace service_jobcat=14 if scian==19 // Otros servicios, excepto actividades gubernamentales
			replace service_jobcat=15 if scian==20 // Actividades gubernamentales y de organismos internacionales
			replace service_jobcat=16 if rama_est1==1 // Agriculture
			replace service_jobcat=17 if rama_est1==2 // Jobs in industry  
			replace service_jobcat=18 if rama_est1==4 // Unspecified activities
			label var service_jobcat "Dissagregation of the Service Sector"
			label define service_jobcat ///
			0 "Not working" ///
			1 "Wholesale Trade" ///
			2 "Retail Trade" ///
			3 "Transportation, communications, mailing and warehousing" /// 
			4 "Media Communication"  /// 
			5 "Financial and insurance services" ///
			6 "Real estate services and rental of movable and intangible assets" /// 
			7 "Professional, scientific and technical services" /// 
			8 "Corporative services" /// 
			9 "Business support services, waste management and remediation services" /// 
			10 "Education Services" /// 
			11 "Health Services" /// 
			12 "Cultural, sporting and other recreational services" /// 
			13 "Temporary accommodation services & food or beverage preparation services" /// 
			14 "Other services except governmental activities" /// 
			15 "Government & International Organizations" ///
			16 "Agriculture" ///
			17 "Industry" ///
			18 "Unspecified activities"
			label value service_jobcat service_jobcat
			tab service_jobcat, missing // Data quality checks: No missing values. 




			generate industry_jobcat=. 
			replace industry_jobcat=0 if clase2!=1 // 0 if they are not working 
			replace industry_jobcat=1 if rama_est1==1 // Agriculture
			replace industry_jobcat=2 if rama_est1==2 // Jobs in industry excluding the mentioned below
			replace industry_jobcat=3 if P4A==3110 // 3110 Industria alimentaria 
			replace industry_jobcat=4 if P4A==3360 // 3360 Fabricación de equipo de transporte y autopartes
			replace industry_jobcat=5 if P4A==3150 // 3150 Fabricación de prendas de vestir 
			replace industry_jobcat=6 if rama_est2==4 // Construction
			replace industry_jobcat=7 if rama_est1==3 // Jobs in services
			replace industry_jobcat=8 if rama_est1==4 // Unspecified activities
			label define industry_jobcat ///
			0 "Not working" ///
			1 "Agriculture" ///
			2 "Other industrial jobs" ///
			3 "Food Industry" ///
			4 "Manufacturing of autoparts and transportation equipment" ///
			5 "Clothing" /// 
			6 "Construction" ///
			7 "Service jobs" /// 
			8 "Unspecified activities"
			label value industry_jobcat industry_jobcat
			tab industry_jobcat, missing // Data quality checks: No missing values. 
			
			
			generate ind_jobcat=. 
			replace ind_jobcat=0 if clase2!=1 // 0 if they are not working 
			replace ind_jobcat=1 if rama_est1==2 // Jobs in industry excluding the mentioned below
			replace ind_jobcat=2 if P4A==3110 // 3110 Industria alimentaria 
			replace ind_jobcat=3 if P4A==3360 // 3360 Fabricación de equipo de transporte y autopartes
			replace ind_jobcat=4 if P4A==3150 // 3150 Fabricación de prendas de vestir 
			replace ind_jobcat=5 if rama_est2==4 // Construction
			label define ind_jobcat ///
			0 "Not working" ///
			1 "Other industrial jobs" ///
			2 "Food Industry" ///
			3 "Manufacturing of autoparts and transportation equipment" ///
			4 "Clothing" /// 
			5 "Construction"
			label value ind_jobcat ind_jobcat
			tab ind_jobcat, missing // Data quality checks: No missing values. 
			drop if ind_jobcat==.



			generate service_jobcat=. 
			replace service_jobcat=0 if clase2!=1 // 0 if they are not working 
			replace service_jobcat=1 if scian==6 // Comercio al por mayor
			replace service_jobcat=2 if scian==7 // Comercio al por menor
			replace service_jobcat=3 if scian==8 // Transportes, correos y almacenamiento
			replace service_jobcat=4 if scian==9 // Información en medios masivos
			replace service_jobcat=5 if scian==10 // Servicios financieros y de seguros
			replace service_jobcat=6 if scian==11 // Servicios inmobiliarios y de alquiler de bienes
			replace service_jobcat=7 if scian==12 // Servicios profesionales, científicos y técnicos
			replace service_jobcat=8 if scian==13 // Servicios Corporativos
			replace service_jobcat=9 if scian==14 // Servicios de apoyo a los negocios y manejo de deseechos
			replace service_jobcat=10 if scian==15 // Servicios educativos
			replace service_jobcat=11 if scian==16 // Servicios de salud y de asistencia social
			replace service_jobcat=12 if scian==17 // Servicios de esparcimiento, culturales y deportivos
			replace service_jobcat=13 if scian==18 // Servicios de hospedaje y de preparación de alimentos y bebidas
			replace service_jobcat=14 if scian==19 // Otros servicios, excepto actividades gubernamentales
			replace service_jobcat=15 if scian==20 // Actividades gubernamentales y de organismos internacionales
			replace service_jobcat=16 if rama_est1==1 // Agriculture
			replace service_jobcat=17 if rama_est1==2 // Jobs in industry  
			replace service_jobcat=18 if rama_est1==4 // Unspecified activities
			label var service_jobcat "Dissagregation of the Service Sector"
			label define service_jobcat ///
			0 "Not working" ///
			1 "Wholesale Trade" ///
			2 "Retail Trade" ///
			3 "Transportation, communications, mailing and warehousing" /// 
			4 "Media Communication"  /// 
			5 "Financial and insurance services" ///
			6 "Real estate services and rental of movable and intangible assets" /// 
			7 "Professional, scientific and technical services" /// 
			8 "Corporative services" /// 
			9 "Business support services, waste management and remediation services" /// 
			10 "Education Services" /// 
			11 "Health Services" /// 
			12 "Cultural, sporting and other recreational services" /// 
			13 "Temporary accommodation services & food or beverage preparation services" /// 
			14 "Other services except governmental activities" /// 
			15 "Government & International Organizations" ///
			16 "Agriculture" ///
			17 "Industry" ///
			18 "Unspecified activities"
			label value service_jobcat service_jobcat
			

			
			generate service_jobcat=. 
			replace service_jobcat=0 if clase2!=1 // 0 if they are not working 
			replace service_jobcat=1 if scian==6 // Comercio al por mayor
			replace service_jobcat=2 if scian==7 // Comercio al por menor
			replace service_jobcat=3 if scian==8 // Transportes, correos y almacenamiento
			replace service_jobcat=4 if scian==9 // Información en medios masivos
			replace service_jobcat=5 if scian==10 // Servicios financieros y de seguros
			replace service_jobcat=6 if scian==11 // Servicios inmobiliarios y de alquiler de bienes
			replace service_jobcat=7 if scian==12 // Servicios profesionales, científicos y técnicos
			replace service_jobcat=8 if scian==13 // Servicios Corporativos
			replace service_jobcat=9 if scian==14 // Servicios de apoyo a los negocios y manejo de deseechos
			replace service_jobcat=10 if scian==15 // Servicios educativos
			replace service_jobcat=11 if scian==16 // Servicios de salud y de asistencia social
			replace service_jobcat=12 if scian==17 // Servicios de esparcimiento, culturales y deportivos
			replace service_jobcat=13 if scian==18 // Servicios de hospedaje y de preparación de alimentos y bebidas
			replace service_jobcat=14 if scian==19 // Otros servicios, excepto actividades gubernamentales
			replace service_jobcat=15 if scian==20 // Actividades gubernamentales y de organismos internacionales
			replace service_jobcat=16 if rama_est1==1 // Agriculture
			replace service_jobcat=17 if rama_est1==2 // Jobs in industry  
			replace service_jobcat=18 if rama_est1==4 // Unspecified activities
			label var service_jobcat "Dissagregation of the Service Sector"
			label define service_jobcat ///
			
		
		
		
		*/
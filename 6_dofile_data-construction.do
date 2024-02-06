clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-drop.dta" 

***************************************
***** Data Transformation Process *****
***************************************

/*

// RECODING VARIABLES
			recode ur (2=0) // Rural/Urban identificator - 2 was Rural, now 0 is rural 


// MISSING VALUE DECISIONS 
			replace ingocup=. if ingocup==0 // If monthly income "ingocup" is equal to 0, make it a missing value. 
			// (764,184 real changes made, 764,184 to missing)



// RE LABELING VARIABLES  
			label define e_con 1 "Free Union", modify
			label define e_con 2 "Separated", modify
			label define e_con 3 "Divorced", modify
			label define e_con 4 "Widowed", modify
			label define e_con 5 "Married", modify
			label define e_con 6 "Single", modify
			
			label define ur 0 "Rural", modify
			label define ur 1 "Urban", modify
			
			label define t_loc 1 "More than 100,000", modify
			label define t_loc 2 "Between 15,000 and 99,999", modify
			label define t_loc 3 "Between 2,500 and 14,999", modify
			label define t_loc 4 "Less than 2,500", modify


			
// REPLACING VARIABLE VALUES 
			replace per=1 if per==116 // 1st quarter of 2016 
			replace per=2 if per==217 // 2nd quarter of 2017
			replace per=3 if per==318 // 3rd quarter of 2018
			replace per=4 if per==419 // 4th quarter of 2019			
			
*/

// GENERATE NEW VARIABLES

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
			
			
			// Generating variables to identify specific activities within the industrial and service sector 

			local new_variables ///
			food ///
			autoparts ///
			clothing ///
			textile /// 
			computers ///
			appliances ///
			construction ///
			real_estate ///
			retail ///
			media ///
			finance ///
			corporative ///
			education ///
			health ///
			hotel_rest ///
			government ///
			clerical //

			foreach new_var of local new_variables {
			generate `new_var'=. 
			replace `new_var'=0 if clase2!=1 // takes value of 0 if they are not working 	
			}			
			
			replace food=1 			if P4A==3110 	// 3110 Industria alimentaria 	 			
			replace autoparts=1 	if P4A==3360 	// 3360 Fabricar equipo de transporte y autopartes	 		
			replace clothing=1 		if P4A==3150 	// 3150 Fabricar prendas de vestir 			 
			replace textile=1 		if P4A==3140 	// 3140 Fabricar productos textiles, excepto prendas de vestir			 
			replace computers=1 	if P4A==3340 	// 3340 Fabricar equipo de computo, componentes y accesorios electrónicos		 
			replace appliances=1 	if P4A==3350 	// 3350 Fabricar aparatos eléctricos, equipo para generación de energía eléctrica, accesorios 			 
			replace construction=1 	if scian==4 	// Construction			 
			replace real_estate=1 	if scian==11 	// Servicios inmobiliarios y de alquiler de bienes 	
			replace retail=1 		if scian==7 	// Comercio al por menor		 
			replace media=1 		if scian==9 	// Información en medios masivos		 
			replace finance=1 		if scian==10	// Servicios financieros y de seguros			 
			replace corporative=1 	if scian==13	// Servicios Corporativos		 
			replace education=1 	if scian==15	// Servicios educativos		 
			replace health=1 		if scian==16	// Servicios de salud y de asistencia social			 
			replace hotel_rest=1 	if scian==18	// Servicios de hospedaje y de preparación de alimentos y bebidas		 
			replace government=1 	if scian==20	// Actividades gubernamentales y de organismos internacionales		 
			replace clerical=1 		if c_ocu11c==4 	// Clerical jobs		  

			

save	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-const.dta", replace  	
			
			
			
					
			

			
			
			
			
			
			
			
			
			
			
			
			
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

			
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
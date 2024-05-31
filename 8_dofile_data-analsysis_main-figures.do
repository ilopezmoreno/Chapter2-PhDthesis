clear

/* 	Final data analysis is the "Stage Two" of exploratory data analysis 
	Getting outputs into publication-ready format is time consuming.
	Therefore, hard-code custom formatting should only be done after the team 
	has agreed what tables and graphs are going to be included in the report/paper.
	After that, you can spend time customizing those tables and graphs. 
	The goal is to reduce the number of times you will need to make very precise 
	adjustments to the code and aesthetics of the output. */
	
	
/*	Typically, you will need at least 4 separate do-files for this stage. 
		1) main_figures 
		2) main_tables 
		3) appendix_figures
		4) appendix_tables. 
	However, you can also have a separate do-file for each table or figure. */ 
	
	
use "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta"	


// FIGURE: Sectoral composition of employment in Mexico. (Industry and manufacturing dissagregated)

* 1st part of the figure: Sectoral distribution of employment in 2019
tab P4A_Sector if per==4 [fweight=fac]
/*
Economic sector of |
 the company where |
   you are working |      Freq.     Percent        Cum.
-------------------+-----------------------------------
    Primary Sector |  6,939,778       12.44       12.44
  Secondary Sector | 13,864,577       24.85       37.28
   Terciary Sector | 34,667,375       62.13       99.41
Unspecified Sector |    329,350        0.59      100.00
-------------------+-----------------------------------
             Total | 55,801,080      100.00          */

* 2nd part of the figure: Composition of industrial activities
tab scian if P4A_Sector==2 & per==4 [fweight=fac]
/*
 Economic activities (SCIAN categories) |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                                Minería |    181,270        1.31        1.31
Generación y distribución de electricid |    200,342        1.44        2.75
                           Construcción |  4,231,602       30.52       33.27
              Industrias manufactureras |  9,251,363       66.73      100.00
----------------------------------------+-----------------------------------
                                  Total | 13,864,577      100.00         */

* 3rd part of the figure: Composition of the manufacturing sector
tab cat_scian_50 if scian==5 & per==4 [fweight=fac]							  
								  
								  
								  
								  
								  
								  
								  
								  
								  
								  


// Figure 1: Percentage of women with different marital status each year/quarter.

tab e_con if female==1 & eda>=18 & eda<=65 & per==1 [fweight=fac]	
tab e_con if female==1 & eda>=18 & eda<=65 & per==2 [fweight=fac]	
tab e_con if female==1 & eda>=18 & eda<=65 & per==3 [fweight=fac]	
tab e_con if female==1 & eda>=18 & eda<=65 & per==4 [fweight=fac]	




// Figure: Del total de mujeres trabajando en el sector industrial, cuales son los sectores donde mas trabajan?

tab cat_scian_50 if P4A_Sector==2 & female==1 & eda>=18 & eda<=65 & per==4 [fweight=fac]	









// Figure 2: Share of jobs in different economic activities based on SCIAN categories

tab scian_1 if per==4 [fweight=fac]

/*

           Clasificación de actividades |
      económicas con base al sistema de |
                      clasificación Ind |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                Agricultural activities |  6,939,778       12.44       12.44
                                 Mining |    181,270        0.32       12.76
    Supply of electricity, water or gas |    200,342        0.36       13.12
                           Construction |  4,231,602        7.58       20.70
                          Manufacturing |  9,251,363       16.58       37.28
                        Wholesale trade |  1,539,701        2.76       40.04
                           Retail trade |  9,378,076       16.81       56.85
Transportation (Air, water, railway, et |  2,509,767        4.50       61.35
                         Media services |    400,922        0.72       62.06
                  Finance and insurance |    574,165        1.03       63.09
                            Real estate |    332,288        0.60       63.69
Scientists, professionals and technical |  1,442,826        2.59       66.27
                     Corporate services |     59,563        0.11       66.38
                       Business support |  1,498,391        2.69       69.07
                     Education services |  2,685,746        4.81       73.88
           Health and social assistance |  1,650,185        2.96       76.84
               Culture, sports, leisure |    485,439        0.87       77.71
Temporary accommodation, food and bever |  4,462,894        8.00       85.71
                         Other services |     77,971        0.14       85.84
                             Government |  2,387,417        4.28       90.12
         Unspecified service activities |    329,350        0.59       90.71
 Repair and maintenance (Car and truck) |    996,729        1.79       92.50
Repair and maintenance (Machinery and e |    651,719        1.17       93.67
                      Personal services |    878,960        1.58       95.24
         Associations and organizations |    233,289        0.42       95.66
                     Domestic employees |  2,421,327        4.34      100.00
----------------------------------------+-----------------------------------
                                  Total | 55,801,080      100.00

								  
*/








// Figure 3: Percentage of men and women working in different economic activities. (4q, 2019)

tab scian_1 female if per==4 [fweight=fac], row nofreq


/*
					  | Female Identificator
  Economic activities |       Men      Women |     Total
----------------------+----------------------+----------
Agricultural activiti |     87.60      12.40 |    100.00 
               Mining |     86.49      13.51 |    100.00 
Supply of electricity |     81.19      18.81 |    100.00 
         Construction |     96.36       3.64 |    100.00 
        Manufacturing |     62.62      37.38 |    100.00 
      Wholesale trade |     73.94      26.06 |    100.00 
         Retail trade |     42.59      57.41 |    100.00 
Transportation (Air,  |     90.91       9.09 |    100.00 
       Media services |     65.80      34.20 |    100.00 
Finance and insurance |     48.33      51.67 |    100.00 
          Real estate |     60.15      39.85 |    100.00 
Scientists, professio |     58.76      41.24 |    100.00 
   Corporate services |     50.01      49.99 |    100.00 
     Business support |     64.35      35.65 |    100.00 
   Education services |     37.22      62.78 |    100.00 
Health and social ass |     32.27      67.73 |    100.00 
Culture, sports, leis |     73.03      26.97 |    100.00 
Temporary accommodati |     40.89      59.11 |    100.00 
       Other services |     85.84      14.16 |    100.00 
           Government |     59.39      40.61 |    100.00 
Unspecified service a |     68.97      31.03 |    100.00 
Repair and maintenanc |     96.30       3.70 |    100.00 
Repair and maintenanc |     76.60      23.40 |    100.00 
    Personal services |     28.33      71.67 |    100.00 
Associations and orga |     53.70      46.30 |    100.00 
   Domestic employees |      9.96      90.04 |    100.00 
----------------------+----------------------+----------
                Total |     60.51      39.49 |    100.00 

*/





// Figure 4: Most important industrial activities, splitting MANUFACTURING jobs. (4th quarter of 2019)

tab ind_manufacture_cat if per==4 [fweight=fac]

/*

                    ind_manufacture_cat |      Freq.     Percent        Cum.
----------------------------------------+-----------------------------------
                          Food industry |  2,114,105       15.68       15.68
          Beverage and tobacco industry |    274,699        2.04       17.71
                         Textile Inputs |    144,766        1.07       18.79
      Textile products, except clothing |    272,220        2.02       20.81
                              Clothing  |    713,414        5.29       26.10
            Leather goods manufacturing |    304,626        2.26       28.35
                          Wood industry |    145,079        1.08       29.43
                         Paper industry |    220,112        1.63       31.06
        Printing and related industries |    164,761        1.22       32.28
            Petroleum and coal products |     54,708        0.41       32.69
                      Chemical industry |    337,159        2.50       35.19
            Plastic and rubber industry |    438,774        3.25       38.44
          Non-metallic mineral products |    349,025        2.59       41.03
                 Basic metal industries |    132,941        0.99       42.02
           Metal products manufacturing |    700,658        5.20       47.21
  Machinery and equipment manufacturing |    113,978        0.85       48.06
Computers and other electronic componen |    311,685        2.31       50.37
    Electric appliances and accessories |    252,020        1.87       52.24
 Autoparts and transportation equipment |  1,361,188       10.09       62.33
      Furniture, mattresses, and blinds |    460,752        3.42       65.75
   Unspecified manufacturing activities |      5,780        0.04       65.79
                                 Mining |    181,270        1.34       67.14
      Electricity, gas and water supply |    200,342        1.49       68.62
                           Construction |  4,231,602       31.38      100.00
----------------------------------------+-----------------------------------
                                  Total | 13,485,664      100.00

*/








// Figure5: % of men and women working in different INDUSTRIAL and MANUFACTURING jobs. (4th quarter of 2019)



// First part of the figure (EVERYTHING EXCEPT MANUFACTURING)
tab ind_manufacture_cat female if per==4 [fweight=fac], row nofreq

/*

                      | Female Identificator
  ind_manufacture_cat |       Men      Women |     Total
----------------------+----------------------+----------
        Food industry |     55.13      44.87 |    100.00 
Beverage and tobacco  |     78.46      21.54 |    100.00 
       Textile Inputs |     62.67      37.33 |    100.00 
Textile products, exc |     24.37      75.63 |    100.00 
            Clothing  |     33.20      66.80 |    100.00 
Leather goods manufac |     66.24      33.76 |    100.00 
        Wood industry |     80.68      19.32 |    100.00 
       Paper industry |     61.33      38.67 |    100.00 
Printing and related  |     67.36      32.64 |    100.00 
Petroleum and coal pr |     82.07      17.93 |    100.00 
    Chemical industry |     66.82      33.18 |    100.00 
Plastic and rubber in |     62.64      37.36 |    100.00 
Non-metallic mineral  |     84.22      15.78 |    100.00 
Basic metal industrie |     87.45      12.55 |    100.00 
Metal products manufa |     89.21      10.79 |    100.00 
Machinery and equipme |     79.40      20.60 |    100.00 
Computers and other e |     55.91      44.09 |    100.00 
Electric appliances a |     59.43      40.57 |    100.00 
Autoparts and transpo |     63.39      36.61 |    100.00 
Furniture, mattresses |     86.91      13.09 |    100.00 
Unspecified manufactu |     74.74      25.26 |    100.00 
               Mining |     86.49      13.51 |    100.00 
Electricity, gas and  |     81.19      18.81 |    100.00 
         Construction |     96.36       3.64 |    100.00 
----------------------+----------------------+----------
                Total |     74.15      25.85 |    100.00 


*/













// Second part of the figure (DISSAGREGATED MANUFACTURING)

fre scian // value 5 equals "MANUFACTURING"


tab P4A female if scian==5 & per==419 [fweight=fac], row nofreq


/*

  Economic |
  activity |
    of the |
   company |
 where you |
       are | Female Identificator
   working |       Men      Women |     Total
-----------+----------------------+----------
      3110 | 1,165,449    948,656 | 2,114,105 
           |     55.13      44.87 |    100.00 
-----------+----------------------+----------
      3120 |   215,542     59,157 |   274,699 
           |     78.46      21.54 |    100.00 
-----------+----------------------+----------
      3130 |    90,724     54,042 |   144,766 
           |     62.67      37.33 |    100.00 
-----------+----------------------+----------
      3140 |    66,352    205,868 |   272,220 
           |     24.37      75.63 |    100.00 
-----------+----------------------+----------
      3150 |   236,845    476,569 |   713,414 
           |     33.20      66.80 |    100.00 
-----------+----------------------+----------
      3160 |   201,793    102,833 |   304,626 
           |     66.24      33.76 |    100.00 
-----------+----------------------+----------
      3210 |   117,053     28,026 |   145,079 
           |     80.68      19.32 |    100.00 
-----------+----------------------+----------
      3220 |   134,991     85,121 |   220,112 
           |     61.33      38.67 |    100.00 
-----------+----------------------+----------
      3230 |   110,983     53,778 |   164,761 
           |     67.36      32.64 |    100.00 
-----------+----------------------+----------
      3240 |    44,897      9,811 |    54,708 
           |     82.07      17.93 |    100.00 
-----------+----------------------+----------
      3250 |   225,273    111,886 |   337,159 
           |     66.82      33.18 |    100.00 
-----------+----------------------+----------
      3260 |   274,833    163,941 |   438,774 
           |     62.64      37.36 |    100.00 
-----------+----------------------+----------
      3270 |   293,953     55,072 |   349,025 
           |     84.22      15.78 |    100.00 
-----------+----------------------+----------
      3310 |   116,251     16,690 |   132,941 
           |     87.45      12.55 |    100.00 
-----------+----------------------+----------
      3320 |   625,049     75,609 |   700,658 
           |     89.21      10.79 |    100.00 
-----------+----------------------+----------
      3330 |    90,499     23,479 |   113,978 
           |     79.40      20.60 |    100.00 
-----------+----------------------+----------
      3340 |   174,275    137,410 |   311,685 
           |     55.91      44.09 |    100.00 
-----------+----------------------+----------
      3350 |   149,785    102,235 |   252,020 
           |     59.43      40.57 |    100.00 
-----------+----------------------+----------
      3360 |   862,836    498,352 | 1,361,188 
           |     63.39      36.61 |    100.00 
-----------+----------------------+----------
      3370 |   400,453     60,299 |   460,752 
           |     86.91      13.09 |    100.00 
-----------+----------------------+----------
      3380 |   191,185    187,728 |   378,913 
           |     50.46      49.54 |    100.00 
-----------+----------------------+----------
      3399 |     4,320      1,460 |     5,780 
           |     74.74      25.26 |    100.00 
-----------+----------------------+----------
     Total | 5,793,341  3,458,022 | 9,251,363 
           |     62.62      37.38 |    100.00 


3110	 Industria alimentaria                          
3120	 Industria de las bebidas y del tabaco         
3130	 Fabricación de insumos textiles y acabado de textiles 
3140	 Fabricación de productos textiles, excepto prendas de vestir 
3150	 Fabricación de prendas de vestir              
3160	 Curtido y acabado de cuero y piel, y fabricación de productos de cuero, piel y materiales sucedáneos 
3210	 Industria de la madera                        
3220	 Industria del papel                           
3230	 Impresión e industrias conexas                
3240	 Fabricación de productos derivados del petróleo y del carbón 
3250	 Industria química                             
3260	 Industria del plástico y del hule             
3270	 Fabricación de productos a base de minerales no metálicos 
3310	 Industrias metálicas básicas                  
3320	 Fabricación de productos metálicos            
3330	 Fabricación de maquinaria y equipo            
3340	 Fabricación de equipo de computación, comunicación, medición y de otros equipos, componentes y accesorios electrónicos 
3350	 Fabricación de accesorios, aparatos eléctricos y equipo de generación de energía eléctrica 
3360	 Fabricación de equipo de transporte y partes para vehículos automotores 
3370	 Fabricación de muebles, colchones y persianas 
3380	 Otras industrias manufactureras               
3399	 Descripciones insuficientemente especificadas 




*/










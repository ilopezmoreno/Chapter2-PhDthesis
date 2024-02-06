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


// Figure: Most important industrial activities in the MANUFACTURING jobs. (4th quarter of 2019)

/*

       3110 |  2,114,105       22.85       22.85
       3120 |    274,699        2.97       25.82
       3130 |    144,766        1.56       27.39
       3140 |    272,220        2.94       30.33
       3150 |    713,414        7.71       38.04
       3160 |    304,626        3.29       41.33
       3210 |    145,079        1.57       42.90
       3220 |    220,112        2.38       45.28
       3230 |    164,761        1.78       47.06
       3240 |     54,708        0.59       47.65
       3250 |    337,159        3.64       51.30
       3260 |    438,774        4.74       56.04
       3270 |    349,025        3.77       59.81
       3310 |    132,941        1.44       61.25
       3320 |    700,658        7.57       68.82
       3330 |    113,978        1.23       70.05
       3340 |    311,685        3.37       73.42
       3350 |    252,020        2.72       76.15
       3360 |  1,361,188       14.71       90.86
       3370 |    460,752        4.98       95.84
       3380 |    378,913        4.10       99.94
       3399 |      5,780        0.06      100.00

https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/doc/clasificaciones_enoe.pdf


The most relevant manufacturing activities in Mexico are: 

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









// Figure: % of men and women working in different INDUSTRIAL and MANUFACTURING jobs. (4th quarter of 2019)



// First part of the figure (EVERYTHING EXCEPT MANUFACTURING)
tab scian female if P4A_Sector==2 & per==419 [fweight=fac], row

/*

  Economic activities | Female Identificator
   (SCIAN categories) |       Men      Women |     Total
----------------------+----------------------+----------
              Minería |   156,789     24,481 |   181,270 
                      |     86.49      13.51 |    100.00 
----------------------+----------------------+----------
Generación y distribu |   162,649     37,693 |   200,342 
                      |     81.19      18.81 |    100.00 
----------------------+----------------------+----------
         Construcción | 4,077,393    154,209 | 4,231,602 
                      |     96.36       3.64 |    100.00 
----------------------+----------------------+----------
Industrias manufactur | 5,793,341  3,458,022 | 9,251,363 
                      |     62.62      37.38 |    100.00 
----------------------+----------------------+----------
                Total |10,190,172  3,674,405 |13,864,577 
                      |     73.50      26.50 |    100.00 
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










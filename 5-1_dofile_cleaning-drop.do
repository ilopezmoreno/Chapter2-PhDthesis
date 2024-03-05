clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419.dta" 

destring t_loc, replace


/*

describe t_loc
summarize t_loc
destring t_loc, replace 
describe t_loc
recast int t_loc, force
describe t_loc

label define t_loc 1 "More than 100,000", modify
label define t_loc 2 "Between 15,000 and 99,999", modify
label define t_loc 3 "Between 2,500 and 14,999", modify
label define t_loc 4 "Less than 2,500", modify

label drop t_loc
label define t_loc /// 
1 "More than 100,000" ///
2 "Between 15,000 and 99,999" ///
3 "Between 2,500 and 14,999" ///
4 "Less than 2,500" //

fre t_loc


*/










/* 	Although iecodebook offers the option to drop variable, the current dataset has 
	almost 500 variables. As a consequence, it takes a long time to generate the 
	excel file "iecodebook". Therefore, I will ask stata to drop several variables 
	from the dataset, since most of them are not needed. */
	drop 			///
	r_def 			///
	loc				///
	est_d			///
	ageb			///
	cd_a    		///
	con     		///
	upm     		///
	d_sem			///
	n_pro_viv   	///
	v_sel       	///
	n_hog       	///
	h_mud       	///
	n_ent       	///
	n_ren       	///
	nac_dia     	///
	nac_mes			///
	nac_anio    	///
	l_nac_c     	///
	cs_p12      	///
	cs_p13_2    	///
	cs_p14_c    	///
	cs_p15      	///
	cs_p16      	///
	cs_p17			///
	cs_ad_mot   	///
	cs_p20_des  	///
	cs_ad_des   	///
	cs_nr_mot   	///
	cs_p22_des  	///
	cs_nr_ori   	///
	zona        	///
	salario			///
	ing7c       	///
	medica5c    	///
	buscar5c    	///
	dur_est			///
	ambito1     	///
	ambito2     	///
	tue1        	///
	tue2        	///
	tue3        	///
	busqueda    	///
	d_ant_lab   	///
	d_cexp_est 		///
	dur_des     	///
	sub_o       	///
	s_clasifi   	///
	remune2c    	///
	pre_asa     	///
	tip_con     	///
	dispo       	///
	nodispo			///
	c_inac5c    	///
	eda5c       	///
	eda7c       	///
	eda12c      	///
	eda19c      	///
	domestico   	///
	anios_esc   	///
	ing_x_hrs   	///
	tpg_p8a     	///
	tcco        	///
	cp_anoc     	///
	imssissste  	///
	ma48me1sm   	///
	p14apoyos   	///
	t_tra			///
	trans_ppal  	///
	mh_fil2     	///
	sec_ins     	///
	n_inf       	///
	p1          	///
	p1a1        	///
	p1a2        	///
	p1a3        	///
	p1b         	///
	p1c         	///
	p1d         	///
	p1e         	///
	p2_1        	///
	p2_2        	///
	p2_3        	///
	p2_4        	///
	p2_9        	///
	p2a_dia     	///
	p2a_sem     	///
	p2a_mes     	///
	p2a_anio    	///
	p2b_dia     	///
	p2b_sem     	///
	p2b_mes     	///
	p2b_anio    	///
	p2b         	///
	p2c         	///
	p2d1        	///
	p2d2        	///
	p2d3        	///
	p2d4        	///
	p2d5        	///
	p2d6        	///
	p2d7        	///
	p2d8        	///
	p2d9        	///
	p2d10       	///
	p2d11       	///
	p2d99       	///
	p2e         	///
	p2f         	///
	p2g1        	///
	p2g2        	///
	p2h1        	///
	p2h2        	///
	p2h3        	///
	p2h4        	///
	p2h9        	///
	p3          	///
	p3a         	///
	p3b         	///
	p3c1        	///
	p3c2        	///
	p3c3        	///
	p3c4        	///
	p3c9        	///
	p3d         	///
	p3e         	///
	p3f1        	///
	p3f2        	///
	p3g1_1      	///
	p3g1_2      	///
	p3g2_1      	///
	p3g2_2      	///
	p3g3_1      	///
	p3g3_2      	///
	p3g4_1      	///
	p3g4_2      	///
	p3g9        	///
	p3g_tot			///
	p3h         	///
	p3i         	///
	p3j         	///
	p3k1        	///
	p3k2        	///
	p3l1        	///
	p3l2        	///
	p3l3        	///
	p3l4        	///
	p3l5        	///
	p3l9        	///
	p3m1        	///
	p3m2        	///
	p3m3        	///
	p3m4        	///
	p3m5        	///
	p3m6        	///
	p3m7        	///
	p3m8        	///
	p3m9        	///
	p3n         	///
	p3p1        	///
	p3p2        	///
	p3q         	///
	p3r_anio    	///
	p3r_mes     	///
	p3r         	///
	p3s         	///
	p3t_anio    	///
	p3t_mes     	///
	p4          	///
	p4_1        	///
	p4_2        	///
	p4_3        	///
	p4a_1			///
	p4b         	///
	p4c         	///
	p4d1        	///
	p4d2        	///
	p4d3        	///
	p4e         	///
	p4f         	///
	p4g         	///
	p4h         	///
	p4i         	///
	p4i_1       	///
	p5          	///
	p5a         	///
	p5b         	///
	p5c_hlu     	///
	p5c_mlu     	///
	p5c_hma     	///
	p5c_mma     	///
	p5c_hmi     	///
	p5c_mmi     	///
	p5c_hju     	///
	p5c_mju     	///
	p5c_hvi     	///
	p5c_mvi     	///
	p5c_hsa     	///
	p5c_msa     	///
	p5c_hdo     	///
	p5c_mdo     	///
	p5c_thrs    	///
	p5c_tdia    	///
	p5d         	///
	p5e1        	///
	p5e_hlu     	///
	p5e_mlu     	///
	p5e_hma     	///
	p5e_mma     	///
	p5e_hmi			///
	p5e_mmi     	///
	p5e_hju     	///
	p5e_mju     	///
	p5e_hvi     	///
	p5e_mvi     	///
	p5e_hsa     	///
	p5e_msa     	///
	p5e_hdo     	///
	p5e_mdo     	///
	p5e_thrs    	///
	p5e_tdia    	///
	p5f				///
	p5g1        	///
	p5g2        	///
	p5g3        	///
	p5g4        	///
	p5g5        	///
	p5g6        	///
	p5g7        	///
	p5g8        	///
	p5g9        	///
	p5g10       	///
	p5g11       	///
	p5g12			///		
	p5g13			///
	p5g14			///
	p5g15			///
	p5g99			///
	p5h				///
	p6_1			///
	p6_2            ///
	p6_3            ///
	p6_4            ///
	p6_5            ///
	p6_6            ///
	p6_7            ///
	p6_8            ///
	p6_9            ///
	p6_10           ///
	p6_99			///
	p6a1            ///
	p6a2            ///
	p6a3            ///
	p6a4            ///
	p6a9            ///
	p6b1            ///
	p6b2            ///
	p6c             ///
	p6d             ///
	p7              ///
	p7a             ///
	p7b             ///
	p7c				///
	p7d             ///
	p7e             ///
	p7f             ///
	p7f_dias        ///
	p7f_horas       ///
	p7g1            ///
	p7g2            ///
	p7g3            ///
	p7g9            ///
	p7gcan          ///
	p8_1            ///
	p8_2            ///
	p8_3			///
	p8_4            ///
	p8_9            ///
	p8a             ///
	p8b             ///
	p9              ///
	p9a             ///
	p9b             ///
	p9c             ///
	p9d             ///
	p9e             ///
	p9f_anio        ///
	p9f_mes         ///
	p9f				///
	p9g             ///
	p9h             ///
	p9h_1           ///
	p9i             ///
	p9j             ///
	p9k             ///
	p9l1            ///
	p9l2            ///
	p9l3            ///
	p9l4            ///
	p9l5            ///
	p9l9            ///
	p9m1			///
	p9m2            ///
	p9m3            ///
	p9m9            ///
	p9mcan          ///
	p9n1            ///
	p9n2            ///
	p9n3            ///
	p9n4            ///
	p9n5            ///
	p9n6            ///
	p9n9            ///
	p10_1           ///
	p10_2			///			
	p10_3           ///
	p10_4           ///
	p10_9           ///
	p10a1           ///
	p10a2           ///
	p10a3           ///
	p10a4           ///
	p10a9           ///
	p10b            ///
	p11_1           ///
	p11_h1          ///
	p11_m1          ///
	p11_2           ///
	p11_h2          ///
	p11_m2          ///
	p11_3           ///
	p11_h3			///
	p11_m3          ///
	p11_4           ///
	p11_h4          ///
	p11_m4          ///
	p11_5           ///
	p11_h5          ///
	p11_m5          ///
	p11_6           ///
	p11_h6          ///
	p11_m6          ///
	p11_7           ///
	p11_h7          ///
	p11_m7          ///
	p11_8           ///
	p11_h8          ///
	p11_m8          ///
	merge_COE1T116  ///
	merge_COE2T116	///
	merge_COE1T217	///
	merge_COE2T217	///
	merge_COE1T318	///
	merge_COE2T318	///
	merge_COE1T419	///
	merge_COE2T419	///
	niv_ins 		///
	p2i				///
	p2j             ///
	p2k_anio        ///
	p2k_mes         ///
	p2k             ///
	p3j1            ///
	p3j2            ///
	p3k3            ///
	p3k4            ///
	p3k5            ///
	p3k9            ///
	p3l             ///
	p5b_hlu         ///
	p5b_mlu         ///
	p5b_hma         ///
	p5b_mma         ///
	p5b_hmi         ///
	p5b_mmi         ///
	p5b_hju         ///
	p5b_mju         ///
	p5b_hvi         ///
	p5b_mvi         ///
	p5b_hsa         ///
	p5b_msa         ///
	p5b_hdo         ///
	p5b_mdo         ///
	p5b_thrs        ///
	p5b_tdia        ///
	p5c             ///
	p5d1            ///
	p5d_hlu         ///
	p5d_mlu         ///
	p5d_hma         ///
	p5d_mma         ///
	p5d_hmi         ///
	p5d_mmi         ///
	p5d_hju         ///
	p5d_mju         ///
	p5d_hvi         ///
	p5d_mvi         ///
	p5d_hsa         ///
	p5d_msa         ///
	p5d_hdo         ///
	p5d_mdo         ///
	p5d_thrs        ///
	p5d_tdia        ///
	p5e				///
	p5f1            ///
	p5f2            ///
	p5f3            ///
	p5f4            ///
	p5f5            ///
	p5f6            ///
	p5f7            ///
	p5f8            ///
	p5f9            ///
	p5f10           ///
	p5f11           ///
	p5f12			///
	p5f13           ///
	p5f14           ///
	p5f15           ///
	p5f99           ///
	p9_1            ///
	p9_h1           ///
	p9_m1           ///
	p9_2            ///
	p9_h2           ///
	p9_m2           ///
	p9_3            ///
	p9_h3			///
	p9_m3           ///
	p9_4            ///
	p9_h4           ///
	p9_m4           ///
	p9_5            ///
	p9_h5           ///
	p9_m5           ///
	p9_6            ///
	p9_h6           ///
	p9_m6           ///
	p9_7            ///
	p9_h7			///
	p9_m7           ///
	p9_8            ///
	p9_h8           ///
	p9_m8           ///
	P3K4            ///
	P5D_MSA         //

	
	
	
	
	
	
// 	Now I will compress the dataset so it takes less memory from the computer. 

/* 	COMPRESS
	Use the command "compress" to reduce the size of the dataset. 
	It will also take less memory from your computer. */
	compress 
	/*  This is what the compress command does.	
		doubles   to   longs, ints, or bytes
        floats    to   ints or bytes
        longs     to   ints or bytes
        ints      to   bytes
        str#s     to   shorter str#s
        strLs     to   str#s  				*/


save "${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-drop.dta", replace	
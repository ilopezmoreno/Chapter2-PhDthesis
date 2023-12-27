// This do-file is just to change the variable names from datasets COE1T419 & COE2T419 from uppercases to lowercases.

clear
// 	Establish a dynamic and absolute file path to the main working directory using the "global" command
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis" 

// Change the working directory to the folder where the datasets were saved.
cd "${root}/2_data-storage/bases_enoe"	



use COE1T419

rename  R_DEF        	r_def
rename  CD_A         	cd_a
rename  ENT          	ent
rename  CON          	con
rename  UPM          	upm
rename  D_SEM        	d_sem
rename  N_PRO_VIV       n_pro_viv 
rename  V_SEL   		v_sel
rename  N_HOG   		n_hog
rename  H_MUD   		h_mud
rename  N_ENT   		n_ent
rename  PER     		per
rename  N_REN   		n_ren
rename  EDA     		eda
rename  N_INF   		n_inf
rename  P1      		p1
rename  P1A1    		p1a1
rename  P1A2    		p1a2
rename  P1A3    		p1a3
rename  P1B     		p1b
rename  P1C     		p1c
rename  P1D     		p1d
rename  P1E     		p1e
rename  P2_1    		p2_1
rename  P2_2    		p2_2
rename  P2_3    		p2_3
rename  P2_4    		p2_4
rename  P2_9    	    p2_9
rename  P2A_DIA         p2a_dia
rename  P2A_SEM         p2a_sem
rename  P2A_MES         p2a_mes
rename  P2A_ANIO        p2a_anio
rename  P2B_DIA         p2b_dia
rename  P2B_SEM         p2b_sem
rename  P2B_MES         p2b_mes
rename  P2B_ANIO        p2b_anio
rename  P2B             p2b
rename  P2C             p2c
rename  P2D1            p2d1
rename  P2D2            p2d2
rename  P2D3            p2d3
rename  P2D4            p2d4
rename  P2D5            p2d5
rename  P2D6            p2d6
rename  P2D7            p2d7
rename  P2D8            p2d8
rename  P2D9            p2d9
rename  P2D10           p2d10
rename  P2D11           p2d11
rename  P2D99           p2d99
rename  P2E             p2e
rename  P2F             p2f
rename  P2G1            p2g1
rename  P2G2            p2g2
rename  P2H1            p2h1
rename  P2H2            p2h2
rename  P2H3            p2h3
rename  P2H4            p2h4
rename  P2H9            p2h9
rename  P2I             p2i
rename  P2J             p2j
rename  P2K_ANIO        p2k_anio
rename  P2K_MES         p2k_mes
rename  P2K             p2k
rename  P3              p3
rename  P3A             p3a
rename  P3B             p3b
rename  P3C1            p3c1
rename  P3C2            p3c2
rename  P3C3            p3c3
rename  P3C4            p3c4
rename  P3C9            p3c9
rename  P3D             p3d
rename  P3E             p3e
rename  P3F1            p3f1
rename  P3F2            p3f2
rename  P3G1_1          p3g1_1
rename  P3G1_2          p3g1_2
rename  P3G2_1          p3g2_1
rename  P3G2_2          p3g2_2
rename  P3G3_1          p3g3_1
rename  P3G3_2          p3g3_2
rename  P3G4_1          p3g4_1
rename  P3G4_2          p3g4_2
rename  P3G9            p3g9
rename  P3G_TOT         p3g_tot
rename  P3H             p3h
rename  P3I             p3i
rename  P3J1            p3j1
rename  P3J2            p3j2
rename  P3K1            p3k1
rename  P3K2            p3k2
rename  P3K3            p3k3
rename  P3K5            p3k5
rename  P3K9            p3k9
rename  P3L             p3l
rename  P4              p4
rename  P4_1            p4_1
rename  P4_2            p4_2
rename  P4_3            p4_3
rename  P4A             p4a
rename  P4A_1           p4a_1
rename  P4B             p4b
rename  P4C             p4c
rename  P4D1            p4d1
rename  P4D2            p4d2
rename  P4D3            p4d3
rename  P4E             p4e
rename  P4F             p4f
rename  P4G             p4g
rename  P4H             p4h
rename  P4I             p4i
rename  P4I_1           p4i_1
rename  P5              p5
rename  P5A             p5a
rename  P5B_HLU         p5b_hlu
rename  P5B_MLU         p5b_mlu
rename  P5B_HMA         p5b_hma
rename  P5B_MMA         p5b_mma
rename  P5B_HMI         p5b_hmi
rename  P5B_MMI         p5b_mmi
rename  P5B_HJU         p5b_hju
rename  P5B_MJU         p5b_mju
rename  P5B_HVI         p5b_hvi
rename  P5B_MVI         p5b_mvi
rename  P5B_HSA         p5b_hsa
rename  P5B_MSA         p5b_msa
rename  P5B_HDO         p5b_hdo
rename  P5B_MDO         p5b_mdo
rename  P5B_THRS        p5b_thrs
rename  P5B_TDIA        p5b_tdia
rename  P5C             p5c
rename  P5D1            p5d1
rename  P5D_HLU         p5d_hlu
rename  P5D_MLU         p5d_mlu
rename  P5D_HMA         p5d_hma
rename  P5D_MMA         p5d_mma
rename  P5D_HMI         p5d_hmi
rename  P5D_MMI         p5d_mmi
rename  P5D_HJU         p5d_hju
rename  P5D_MJU         p5d_mju
rename  P5D_HVI         p5d_hvi
rename  P5D_MVI         p5d_mvi
rename  P5D_HSA         p5d_hsa
rename  P5D_HDO         p5d_hdo
rename  P5D_MDO         p5d_mdo
rename  P5D_THRS        p5d_thrs
rename  P5D_TDIA        p5d_tdia
rename  P5E             p5e
rename  P5F1            p5f1
rename  P5F2            p5f2
rename  P5F3            p5f3
rename  P5F4            p5f4
rename  P5F5            p5f5
rename  P5F6            p5f6
rename  P5F7            p5f7
rename  P5F8            p5f8
rename  P5F9            p5f9
rename  P5F10           p5f10
rename  P5F11           p5f11
rename  P5F12           p5f12
rename  P5F13           p5f13
rename  P5F14           p5f14
rename  P5F15           p5f15
rename  P5F99           p5f99
rename  UR              ur
rename  FAC             fac	

save "${root}/2_data-storage/bases_enoe/COE1T419.dta", replace



	






	
clear	
// Change the working directory to the folder where the datasets were saved.
cd "${root}/2_data-storage/bases_enoe"	



use COE2T419
rename  CD_A        cd_a
rename  ENT         ent
rename  CON         con
rename  UPM         upm
rename  D_SEM       d_sem
rename  N_PRO_VIV   n_pro_viv 
rename  V_SEL   	v_sel
rename  N_HOG   	n_hog
rename  H_MUD   	h_mud
rename  N_ENT   	n_ent
rename  PER     	per
rename  N_REN   	n_ren
rename  EDA     	eda
rename  N_INF   	n_inf
rename  P6_1		p6_1
rename  P6_2		p6_2
rename  P6_3		p6_3
rename  P6_4		p6_4
rename  P6_5		p6_5
rename  P6_6		p6_6
rename  P6_7		p6_7
rename  P6_8		p6_8
rename  P6_9		p6_9
rename  P6_10		p6_10
rename  P6_99		p6_99
rename  P6A1		p6a1
rename  P6A2		p6a2
rename  P6A3		p6a3
rename  P6A4		p6a4
rename  P6A9		p6a9
rename  P6B1		p6b1
rename  P6B2		p6b2
rename  P6C			p6c
rename  P6D			p6d
rename  P7			p7
rename  P7A			p7a
rename  P7B			p7b
rename  P7C			p7c
rename  P8_1		p8_1
rename  P8_2		p8_2
rename  P8_3		p8_3
rename  P8_4		p8_4
rename  P8_9		p8_9
rename  P8A			p8a
rename  P9_1		p9_1
rename  P9_H1		p9_h1
rename  P9_M1		p9_m1
rename  P9_2		p9_2
rename  P9_H2		p9_h2
rename  P9_M2		p9_m2
rename  P9_3		p9_3
rename  P9_H3		p9_h3
rename  P9_M3		p9_m3
rename  P9_4		p9_4
rename  P9_H4		p9_h4
rename  P9_M4		p9_m4
rename  P9_5		p9_5
rename  P9_H5		p9_h5
rename  P9_M5		p9_m5
rename  P9_6		p9_6
rename  P9_H6		p9_h6
rename  P9_M6		p9_m6
rename  P9_7		p9_7
rename  P9_H7		p9_h7
rename  P9_M7		p9_m7
rename  P9_8		p9_8
rename  P9_H8		p9_h8
rename  P9_M8		p9_m8
rename  UR			ur
rename  FAC			fac



save "${root}/2_data-storage/bases_enoe/COE2T419.dta", replace
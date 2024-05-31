clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"


// Now it is time to merge all the constructed variables that capture the characteristics of 50 economic activities. 

	clear 
	cd  "${root}/2_data-storage/data_econ_activities"
	use share_total_cat50 
	
	
	// Create loop 
	
	local datasets 			/// 
	high_educ_50 			///
	high_educ_50_male 		///
	high_educ_50_female  	///
	low_educ_50				///
	low_educ_50_female		///
	low_educ_50_male		///
	hrsocup_50				///
	hrsocup_50_female		///
	hrsocup_50_male			///
	formal_formal			///
	informal_formal			///
	informal_informal		///	
	female					//
	
	
	foreach dataset of local datasets {
		
	merge 1:1 cat_scian_50 using `dataset'
	rename _merge merge_`dataset'
	tab merge_`dataset'	
	drop merge_`dataset'	

	gen pct_`dataset' = `dataset'*100
	
	}
	
	drop female 														///
		 high_educ_50 high_educ_50_male high_educ_50_female 			/// 
	     low_educ_50 low_educ_50_female low_educ_50_male    			///
		 pct_hrsocup_50 pct_hrsocup_50_female pct_hrsocup_50_male       /// 
		 formal_formal informal_formal informal_informal    			//		

	drop if cat_scian_50==.	
	
save "${root}/2_data-storage/data_econ_activities/merge_tidy_cat50.dta", replace











	
// Now it is time to merge the ENOE survey with the variables for each of the 50 economic activities in Mexico. 	

clear	
use	"${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-const-activities.dta" 

cd   "${root}/2_data-storage/data_econ_activities"
merge m:1 cat_scian_50 using merge_tidy_cat50.dta 

tab clase2 _merge
/* Does that were not "matched" is because they are not working. 
   Therefore, the merge is correct */
	

	
// Now it is time to perform some consistency checks and data quality checks.	
	






// Compress the dataset
compress 
save "${root}/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-tidy.dta", replace
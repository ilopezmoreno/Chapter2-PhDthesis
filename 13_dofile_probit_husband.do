clear 
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis"

use	"${root}/2_data-storage/pool_dataset/enoe_tidydata_116-419.dta" 





// First, I will only mantain married people in the sample. 
keep if e_con==5 | e_con==1


// Second, I will ask stata to drop all household members that are not husband and wife. 
drop if par_c>=205
/* Note: 	par_c is the variable that shows the relationship with the household head. 
			101 code to identify the household head
			201 husband or wife of the household head
			202 concubine 
			204 lover 
*/

// Third, I will ask stata to count how many members are living in each household.  
bysort house_id_per: egen count_members=count(person_id)   
tab count_members 


// Now I will ask stata to mantain just those cases where there are two household members. 
drop if count_members==3
drop if count_members==1



// Code to obtain the husbands' level of education
order educ, last
bysort house_id_per: gen educ_pareja1 = educ[_n-1]
bysort house_id_per: gen educ_pareja2 = educ[_n+1]
generate educ_pareja=.
forvalues i=0/5 {
replace educ_pareja=`i' if educ_pareja1==`i'
replace educ_pareja=`i' if educ_pareja2==`i'
}
tabulate educ_pareja, missing  // Data quality check
// 339 missing values
* keep if educ_pareja==. 
* sort house_id_per
drop educ_pareja1 educ_pareja2





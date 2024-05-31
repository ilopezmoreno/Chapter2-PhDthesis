clear


	
use "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis/2_data-storage/pool_dataset/pool_enoe_116_217_318_419-iecodebook.dta"	






// Table 1: Descriptive statistics of dependent variables
// First stage. Depend variable: CATEGORICAL - work_p4asector
fre work_p4asector if eda>=18 & eda<=65
fre work_p4asector if eda>=18 & eda<=65 & female==1
fre work_p4asector if eda>=18 & eda<=65 & female==0

// Second stage: Dependent variables: DUMMIES - Mining, Construction, Food processing, Clothing, Textiles
summarize mining construction food computers clothing textile if eda>=18 & eda<=65
summarize mining construction food computers clothing textile if eda>=18 & eda<=65 & female==1
summarize mining construction food computers clothing textile if eda>=18 & eda<=65 & female==0


// Third stage: Dependent variables: DUMMIES - 
summarize married_agriculture married_industry married_services if eda>=18 & eda<=65
summarize married_agriculture married_industry married_services if eda>=18 & eda<=65 & female==1



// Table 2: Descriptive statistics of controls at the individual level. 
tab e_con if eda>=18 & eda<=65 
tab e_con if female==1 & eda>=18 & eda<=65 
tab e_con if female==0 & eda>=18 & eda<=65 

tab educ if eda>=18 & eda<=65
tab educ if female==1 & eda>=18 & eda<=65 
tab educ if female==0 & eda>=18 & eda<=65 

summarize num_kids if eda>=18 & eda<=65
summarize num_kids if eda>=18 & eda<=65 & female==1

summarize eda if eda>=18 & eda<=65
summarize eda if eda>=18 & eda<=65 & female==1
summarize eda if eda>=18 & eda<=65 & female==0

summarize fac if eda>=18 & eda<=65
summarize fac if eda>=18 & eda<=65 & female==1
summarize fac if eda>=18 & eda<=65 & female==0



// Table 3: Descriptive statistics of household characteristics

tab soc_str if eda>=18 & eda<=65 
tab t_loc if eda>=18 & eda<=65 

summarize ur if eda>=18 & eda<=65 
summarize hh_kids if eda>=18 & eda<=65 
summarize hh_members if eda>=18 & eda<=65 

summarize hhh_eda hhh_female if eda>=18 & eda<=65 
tab hhh_educ if eda>=18 & eda<=65 



// Table 3: Descriptive statistics of husbands' level of education





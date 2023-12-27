// 	Establish a dynamic and absolute file path to the main working directory using the "global" command
global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis" 




// Data download 
		
// 	I need to start by establishing the working directories and creating the folders. 
cd "${root}/2_data-storage" 	// Change directory to the data storage folder
capture mkdir bases_enoe 		// Creating a folder where the downloaded data is going to be stored.


cd "${root}/2_data-storage/bases_enoe"	// Change working directory 	


/// copy is a command that will ask Stata to download the data from INEGI website.
copy "https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/microdatos/2016trim1_dta.zip" enoe_116.zip, replace 
copy "https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/microdatos/2017trim2_dta.zip" enoe_217.zip, replace 
copy "https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/microdatos/2018trim3_dta.zip" enoe_318.zip, replace 
copy "https://www.inegi.org.mx/contenidos/programas/enoe/15ymas/microdatos/2019trim4_dta.zip" enoe_419.zip, replace 


// Now I create a loop to ask stata to unzip the downloaded datasets	

forvalues i=116(101)419 {
unzipfile 	enoe_`i'.zip 	// Ask stata to unzip the downloaded dataset
erase 		enoe_`i'.zip 	// Ask stata to erase the zip file once it has been unzipped. 
erase 		HOGT`i'.dta		// Ask stata to erase the HOG dataset as I will not use it for this research project.
erase 		VIVT`i'.dta		// Ask stata to erase the VIV dataset as I will not use it for this research project.	
}
	
	
shell rename "sdemt419.dta" "SDEMT419.dta" // As this dataset is in lower case, I need to rename it. 
shell rename "coe1t419.dta" "COE1T419.dta" // As this dataset is in lower case, I need to rename it. 
shell rename "coe2t419.dta" "COE2T419.dta" // As this dataset is in lower case, I need to rename it. 

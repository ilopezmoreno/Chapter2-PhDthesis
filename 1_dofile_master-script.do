	**************************
	***** MASTER DO FILE *****
	**************************

// 	This do-file corresponds to the second chapter of my thesis 

	
	
/* 	This master do-file include the following instructions to Stata
	1. Installing required settings and packages 
	2. Establish dynamic and absolute file path to the working directory. 
	3. Create the basic folder structure
	4. Running the rest of the do-files */

	
	// Installing required settings and packages
		
		*ssc install stata_linter
		*ssc install fre
		*ssc install mdesc
		*ssc isntall bcstats
		*ssc install iefieldkit
		*ssc install ietoolkit

		
		clear
	// 	Establish a dynamic and absolute file path to the main working directory using the "global" command
		global root "C:/Users/d57917il/Documents/GitHub/Chapter2-PhDthesis" 
	/* 	Important notes: Always remember to use forward slashes "/" in file paths 
		to working directories For Stata, globals must only be defined in the master do-file */


	// 	Create the basic folder structure
		capture mkdir 1_do-files
		capture mkdir 2_data-storage
		capture mkdir 3_documentation
		capture mkdir 4_outputs
		
		cd "${root}/4_outputs"
		capture mkdir descriptive_statistics
		capture mkdir figures
		capture mkdir regression_results
		capture mkdir margins_results
		capture mkdir margins_plots
		capture mkdir tables
		
		
		
		
		
		
		
		
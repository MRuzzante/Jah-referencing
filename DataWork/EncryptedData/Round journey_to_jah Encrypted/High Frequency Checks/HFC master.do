
/*******************************************************************************
*						Jah Referencing									   	   *	
*																 			   *
*  PURPOSE:  			Run high frequency checks on journey data			   *
*  WRITTEN BY:  		Rastaman											   *
*  Last time modified:  March 2018											   *
*																			   *
********************************************************************************

	** OUTLINE:			PART 1: Settings
						PART 2: Checks
				
	** REQUIRES:	
	
	** CREATES:			See separate do-files
				
	** NOTES:			Run this code every day when the new data come in and 
						then report the issues to the field team by following
						the agreed protocol
		
********************************************************************************
* 							PART 1: SETTINGS
*******************************************************************************/

* ---------------------------------------------------------------------------- *
* 						1.1 Initial settings								   *
* ---------------------------------------------------------------------------- *

	* Install required packages
	if 0 {																		
		ssc install ietoolkit, replace
		ssc install dropmiss, replace
		ssc install labmask, replace
	}

	*Standardize settings accross users
    ieboilstart, version(13.0) 
    `r(version)'   
	   
	set maxvar 120000, perm
	query memory
	
* ---------------------------------------------------------------------------- *
* 						1.2 Create file path globals						   *
* ---------------------------------------------------------------------------- *

	* Users																		
	* -----
    if c(username) == 	"michaelorevba"   {
		global dropbox	"/Users/michaelorevba/Dropbox/Jah Referencing"
		global dropbox	"/Users/michaelorevba/GitHub/Jah-referencing"
	}
   	if c(username) == 	"WB527265" 		  {
		global dropbox 	"C:/Users/WB527265/Dropbox/Jah Referencing"
		global github	"C:/Users/WB527265/Documents/GitHub/Jah-referencing"
	}
	if c(username) == 	"ruzzante.matteo" {
		global dropbox	"C:/Users/ruzzante.matteo/Dropbox/Jah Referencing"
		global github	"C:/Users/ruzzante.matteo/Documents/GitHub/Jah-referencing"
	}
	if c(username) ==	"jonasguthoff" 	  {
		global dropbox  "/Users/jonasguthoff/Dropbox/Jah Referencing"
		global github	"/Users/jonasguthoff/GitHub/Jah-referencing"
	}

	* Project folder globals
	* ---------------------
	global dataWorkFolder       "${dropbox}/DataWork"
	global encryptFolder        "${dataWorkFolder}/EncryptedData" 
	global encrypt_journey     	"${encryptFolder}/Round journey_to_jah Encrypted"
	global journey_hfc			"${encrypt_journey}/High Frequency Checks"
	global hfc_data				"${journey_hfc}/Data"
	global raw_data       		"${journey_hfc}/Raw Identified Data"
	global today 				`c(current_date)' 
	global hfc_out 				"${journey_hfc}/Output/${today}"
	
	global doImport				"${github}/DataWork/EncryptedData/Round journey_to_jah Encrypted/Dofiles Import"
	global dofiles				"${github}/DataWork/EncryptedData/Round journey_to_jah Encrypted/High Frequency Checks/Dofiles"

* ---------------------------------------------------------------------------- *
* 							1.3 HFC settings								   *
* ---------------------------------------------------------------------------- *
	
	* Form version
	global version 1
	
	* Date
	global lastDay = mdy(3,26,2018)												// Add the date of the last observations you checked
													
	* Create output folder
	cap mkdir "${hfc_out}"
	
	* Pause Switch
	pause on
	
	* Sections switches
	local import			1
	local corrections		1
	local progress			1
	local distribution		1
	local prep				1
	
********************************************************************************
* 							PART 2: RUN CHECKS								   *
********************************************************************************
	
	if `import' {
		cap erase 			"${raw_data}/Dta/jah_referncing.dta"
		do 					"${doImport}/import_jah_referncing.do"
	}
	
	if `corrections'	 do "${dofiles}/0. Apply corrections.do"	
	if `progress'		 do "${dofiles}/1. Track progress.do"
	if `distribution'	 do "${dofiles}/2. Check distribution.do"
	if `prep'			 do "${dofiles}/3. Prepare GIS data.do"					
	
	//daily map checks with pop-up are done in R

***************************** End of do-file ***********************************

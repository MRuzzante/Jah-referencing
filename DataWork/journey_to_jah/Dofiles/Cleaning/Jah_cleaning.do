* **************************************************************************** *
* **************************************************************************** *
*                                                                      		   *
*               Jah referencing                                        		   *
*               Cleaning DO_FILE                                   		   	   *
*                                                                      		   *
* **************************************************************************** *
* **************************************************************************** *

       /*
       ** PURPOSE:      Cleaning of raw data and prepare GPS for mapping

       ** OUTLINE:      PART 0: Standardize settings and install packages
                        PART 1: Prepare folder path globals
                        PART 2: Run the master dofiles for each high-level task

       ** IDS VAR:      list_ID_var_here         //Uniquely identifies households (update for your project)

       ** NOTES:

       ** WRITTEN BY:   Jonas Guthoff

       ** Last date modified: 6 Apr 2019
       */

	   
* **************************************************************************** *
	

	* set global for ID variables
	* global rasta_id ""
	
	
	
	
* ---------------------------------------------------------------------------- *	
* 1. Main Questionnaire	
* ---------------------------------------------------------------------------- *	
	
		
	* load raw data
	use "$journey_to_jah_dtRaw/jah reference.dta", clear


	
	
	tab rasta
		
	
	
	
	
	
	
	
* ---------------------------------------------------------------------------- *	
* 2. Geo Data	
* ---------------------------------------------------------------------------- *	
	
	use "$journey_to_jah_dtRaw/jah reference.dta", clear
	
	
	gen 	date = dofc(starttime)
	format  date %td
	
	* keep only key variables
	keep 	rasta options map_type-end_geoaccuracy date
	
	
	tab 	whatsthepoint, miss
	
	* drop if it was only the main survey 
	drop if options == "1"
	
	
	* Format the entries and categorize them
	replace whatsthepoint = proper(whatsthepoint)
	replace whatsthepoint = trim(whatsthepoint)
	
	
	replace whatsthepoint = "Lyssons Beach" 	if whatsthepoint == "Lesson Beach" 
	
	
	* Categorize activities into the following main activities:
	* 1.) Party
	* 2.) Eat and Drink
	* 3.) Cultural Sight
	* 4.) Beach
	* 5.) Accomodation
	* 6.) Other (No bodda)
	
	lab define rudestuff 1 "Party" 	2 "Eat and Drink" 	  3 "Cultural Sight" 	///
						 4 "Beach" 	5 "Accomodation"	  6 "No bodda"
	
	
	
	gen 	activity_type =.
	* replace activity_type = 1	
	replace activity_type = 2		if inlist(whatsthepoint,"Jo Jo'S","Across Reggae Hostel - Maybe Some Nice Curry","Wilkes Seafood, Port Antonio","Jerk Center","Little Ochie")
	replace activity_type = 3		if inlist(whatsthepoint,"Weddy Weddy Stone Love Hq","Bob Marley'S Museum","Nanook Backyard","Blue Mountain Peak")
	replace activity_type = 4		if inlist(whatsthepoint,"Lyssons Beach","Some Beach In Port Antonio","Old Wharf Bay")
	replace activity_type = 5		if inlist(whatsthepoint,"Home Sweet Home  Reggae Hostel","Ragga Room","Reggae Hostel","Jay'S","Ridge View, Long Bay")
	replace activity_type = 6		if inlist(whatsthepoint,"Airpoooort","I M Not Ready","I'M Fucked Up","Bedtime")
	
	lab var activity_type "Type of activity"
	
	lab val activity_type rudestuff
	
	tab 	activity_type, miss
	
	
	tab 	rasta if activity_type ==.
	
	
	
	
	* Save the relevant data to map the geo locations
	rename 	gps_pointlatitude	latitude
	rename 	gps_pointlongitude	longitude
	
	decode  activity_type, gen(activity_type_str)
	
	rename  activity_type_str activity
	
	
	
	
	
	keep  	rasta date whatsthepoint activity latitude longitude
	
	order 	rasta date whatsthepoint activity latitude longitude
	
	
	* save the data
	save 	"$journey_to_jah_dtRaw/clean_map.dta", replace
	
	
	
	
	
	
	

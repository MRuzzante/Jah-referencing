* import_jah_reference.do
*
* 	Imports and aggregates "jah reference" (ID: jah_reference) data.
*
*	Inputs: .csv file(s) exported by the SurveyCTO Server
*	Outputs: "jah reference.dta"
*
*	Output by the SurveyCTO Server April 6, 2019 11:27 PM.

* initialize Stata
clear all
set more off
set mem 100m

* *** NOTE ***                                              *** NOTE ***
* If you run this .do file without customizing it, Stata will probably 
* give you errors about not being able to find or open files. If so,
* put all of your downloaded .do and .csv files into a single directory,
* edit the "cd" command just below to point to that directory, and then
* remove the * from the front of that cd line to un-comment it. That
* should resolve the problem.
*
* If you continue to encounter errors, see what filename Stata is trying
* to open, and rename any downloaded files accordingly. (E.g., your 
* browser might have added a (1) or a (2) to a downloaded filename.)

* initialize working directory (TO BE CUSTOMIZED)
	
	cd "$journey_to_jah_dtRaw/"

* initialize workflow-specific parameters
*	Set overwrite_old_data to 1 if you use the review and correction
*	workflow and allow un-approving of submissions. If you do this,
*	incoming data will overwrite old data, so you won't want to make
*	changes to data in your local .dta file (such changes can be
*	overwritten with each new import).
local overwrite_old_data 0

* initialize form-specific parameters
local csvfile "jah reference_WIDE.csv"
local dtafile "jah reference.dta"
local corrfile "jah reference_corrections.csv"
local note_fields1 ""
local text_fields1 "deviceid subscriberid simid devicephonenum username duration rasta_other options music_other breakfast food drinksdem whatsthepoint gps_image whatyamap numpoints comment instanceid"
local date_fields1 ""
local datetime_fields1 "submissiondate starttime endtime"

disp
disp "Starting import of: `csvfile'"
disp

* import data from primary .csv file
insheet using "`csvfile'", names clear

* drop extra table-list columns
cap drop reserved_name_for_field_*
cap drop generated_table_list_lab*

* continue only if there's at least one row of data to import
if _N>0 {
	* drop note fields (since they don't contain any real data)
	forvalues i = 1/100 {
		if "`note_fields`i''" ~= "" {
			drop `note_fields`i''
		}
	}
	
	* format date and date/time fields
	forvalues i = 1/100 {
		if "`datetime_fields`i''" ~= "" {
			foreach dtvarlist in `datetime_fields`i'' {
				cap unab dtvarlist : `dtvarlist'
				if _rc==0 {
					foreach dtvar in `dtvarlist' {
						tempvar tempdtvar
						rename `dtvar' `tempdtvar'
						gen double `dtvar'=.
						cap replace `dtvar'=clock(`tempdtvar',"MDYhms",2025)
						* automatically try without seconds, just in case
						cap replace `dtvar'=clock(`tempdtvar',"MDYhm",2025) if `dtvar'==. & `tempdtvar'~=""
						format %tc `dtvar'
						drop `tempdtvar'
					}
				}
			}
		}
		if "`date_fields`i''" ~= "" {
			foreach dtvarlist in `date_fields`i'' {
				cap unab dtvarlist : `dtvarlist'
				if _rc==0 {
					foreach dtvar in `dtvarlist' {
						tempvar tempdtvar
						rename `dtvar' `tempdtvar'
						gen double `dtvar'=.
						cap replace `dtvar'=date(`tempdtvar',"MDY",2025)
						format %td `dtvar'
						drop `tempdtvar'
					}
				}
			}
		}
	}

	* ensure that text fields are always imported as strings (with "" for missing values)
	* (note that we treat "calculate" fields as text; you can destring later if you wish)
	tempvar ismissingvar
	quietly: gen `ismissingvar'=.
	forvalues i = 1/100 {
		if "`text_fields`i''" ~= "" {
			foreach svarlist in `text_fields`i'' {
				cap unab svarlist : `svarlist'
				if _rc==0 {
					foreach stringvar in `svarlist' {
						quietly: replace `ismissingvar'=.
						quietly: cap replace `ismissingvar'=1 if `stringvar'==.
						cap tostring `stringvar', format(%100.0g) replace
						cap replace `stringvar'="" if `ismissingvar'==1
					}
				}
			}
		}
	}
	quietly: drop `ismissingvar'


	* consolidate unique ID into "key" variable
	replace key=instanceid if key==""
	drop instanceid


	* label variables
	label variable key "Unique submission ID"
	cap label variable submissiondate "Date/time submitted"
	cap label variable formdef_version "Form version used on device"
	cap label variable review_status "Review status"
	cap label variable review_comments "Comments made during review"
	cap label variable review_corrections "Corrections made during review"


	label variable rasta "Please select your ** RASTA IDENTITY ** :"
	note rasta: "Please select your ** RASTA IDENTITY ** :"
	label define rasta 1 "Hanna" 2 "Julie" 3 "Matteo" 4 "Jonas" 5 "Michael" 77 "Kabaka" 99 "Other" -999 "I don't know" -888 "refuse to answer"
	label values rasta rasta

	label variable rasta_other "Please specify your **RASTA IDENTITY ** :"
	note rasta_other: "Please specify your **RASTA IDENTITY ** :"

	label variable options "Wha gwaan bredren?"
	note options: "Wha gwaan bredren?"

	label variable afternoon "How was your afternoon?"
	note afternoon: "How was your afternoon?"
	label define afternoon 1 "Hazy" 2 "High and windy" 3 "No clue" -999 "I don't know" -888 "refuse to answer"
	label values afternoon afternoon

	label variable balance "How is your ** unbalance ** ?"
	note balance: "How is your ** unbalance ** ?"
	label define balance 1 "Aight" 2 "You've no clue what you're talking about" 3 "Shut up"
	label values balance balance

	label variable temperature "How hot is it?"
	note temperature: "How hot is it?"
	label define temperature 1 "Hella hot" 2 "Hot" 3 "Not so hot" 4 "Actually, Hitzewelle"
	label values temperature temperature

	label variable smell "What do you smell ?"
	note smell: "What do you smell ?"
	label define smell 1 "Life" 2 "Julie's shoes" 3 "Matteo's speedos" 4 "Undefined (overused) underwear" 5 "Rosemary"
	label values smell smell

	label variable music "Whats your favorite artist of the day?"
	note music: "Whats your favorite artist of the day?"
	label define music 1 "Alborosie aka Alba" 2 "Pitura Freska" 3 "Buju" 4 "Why is Ed Sheeran in the reggae playlist?!!" 5 "Other"
	label values music music

	label variable music_other "Please specify:"
	note music_other: "Please specify:"

	label variable breakfast "What did you have for breakfast?"
	note breakfast: "What did you have for breakfast?"

	label variable food "What did you eat?"
	note food: "What did you eat?"

	label variable drinksdem "What did you drink?"
	note drinksdem: "What did you drink?"

	label variable jonas "How is Jonas driving?"
	note jonas: "How is Jonas driving?"
	label define jonas 1 "Uber driver in Marrekech" 2 "He's staying on the road (mostly)." 3 "Is Jonas driving?"
	label values jonas jonas

	label variable julie "How is Julie behaving?"
	note julie: "How is Julie behaving?"
	label define julie 1 "Out of control" 2 "Pain in the ass" 3 "'Why doesn't she shut up!!!'" 4 "God safe the Queen"
	label values julie julie

	label variable hanna "Where did Hanna disappear?"
	note hanna: "Where did Hanna disappear?"
	label define hanna 1 "The new ETC is working, dah?!" 2 "MIA" 3 "AWOL" 4 "She found her love - a real Rasta."
	label values hanna hanna

	label variable matteo "**How ** much of control did the brother Matteo get?"
	note matteo: "**How ** much of control did the brother Matteo get?"
	label define matteo 1 "He's still at the dance." 2 "We found him by the beach." 3 "Don't even ask."
	label values matteo matteo

	label variable michael "What's the brother up to?"
	note michael: "What's the brother up to?"
	label define michael 1 "He's better running high-frequency checks." 2 "Still eating the green beans." 3 "This is unacceptable. It's time to call Sakina." 4 "He's working from home. AWS?" 5 "He already left"
	label values michael michael

	label variable map_type "What are you trying to catch?"
	note map_type: "What are you trying to catch?"
	label define map_type 1 "1 Point" 2 "Many points"
	label values map_type map_type

	label variable whatsthepoint "Where are you?"
	note whatsthepoint: "Where are you?"

	label variable gps_pointlatitude "Please record your amazing location! (latitude)"
	note gps_pointlatitude: "Please record your amazing location! (latitude)"

	label variable gps_pointlongitude "Please record your amazing location! (longitude)"
	note gps_pointlongitude: "Please record your amazing location! (longitude)"

	label variable gps_pointaltitude "Please record your amazing location! (altitude)"
	note gps_pointaltitude: "Please record your amazing location! (altitude)"

	label variable gps_pointaccuracy "Please record your amazing location! (accuracy)"
	note gps_pointaccuracy: "Please record your amazing location! (accuracy)"

	label variable gps_image "Here you can take a picture"
	note gps_image: "Here you can take a picture"

	label variable max_points "How many points would you like to maappp ?"
	note max_points: "How many points would you like to maappp ?"

	label variable whatyamap "What are you mapping:"
	note whatyamap: "What are you mapping:"

	label variable gps1latitude "* Point 1 * (latitude)"
	note gps1latitude: "* Point 1 * (latitude)"

	label variable gps1longitude "* Point 1 * (longitude)"
	note gps1longitude: "* Point 1 * (longitude)"

	label variable gps1altitude "* Point 1 * (altitude)"
	note gps1altitude: "* Point 1 * (altitude)"

	label variable gps1accuracy "* Point 1 * (accuracy)"
	note gps1accuracy: "* Point 1 * (accuracy)"

	label variable gps2latitude "* Point 2 * (latitude)"
	note gps2latitude: "* Point 2 * (latitude)"

	label variable gps2longitude "* Point 2 * (longitude)"
	note gps2longitude: "* Point 2 * (longitude)"

	label variable gps2altitude "* Point 2 * (altitude)"
	note gps2altitude: "* Point 2 * (altitude)"

	label variable gps2accuracy "* Point 2 * (accuracy)"
	note gps2accuracy: "* Point 2 * (accuracy)"

	label variable gps3latitude "* Point 3 * (latitude)"
	note gps3latitude: "* Point 3 * (latitude)"

	label variable gps3longitude "* Point 3 * (longitude)"
	note gps3longitude: "* Point 3 * (longitude)"

	label variable gps3altitude "* Point 3 * (altitude)"
	note gps3altitude: "* Point 3 * (altitude)"

	label variable gps3accuracy "* Point 3 * (accuracy)"
	note gps3accuracy: "* Point 3 * (accuracy)"

	label variable done3 "Point 3 was recorded! Still have more coordinates of GPS to take?"
	note done3: "Point 3 was recorded! Still have more coordinates of GPS to take?"
	label define done3 1 "Yes" 0 "No"
	label values done3 done3

	label variable gps4latitude "* Point 4 * (latitude)"
	note gps4latitude: "* Point 4 * (latitude)"

	label variable gps4longitude "* Point 4 * (longitude)"
	note gps4longitude: "* Point 4 * (longitude)"

	label variable gps4altitude "* Point 4 * (altitude)"
	note gps4altitude: "* Point 4 * (altitude)"

	label variable gps4accuracy "* Point 4 * (accuracy)"
	note gps4accuracy: "* Point 4 * (accuracy)"

	label variable done4 "Point 4 was recorded! Still have more coordinates of GPS to take?"
	note done4: "Point 4 was recorded! Still have more coordinates of GPS to take?"
	label define done4 1 "Yes" 0 "No"
	label values done4 done4

	label variable gps5latitude "* Point 5 * (latitude)"
	note gps5latitude: "* Point 5 * (latitude)"

	label variable gps5longitude "* Point 5 * (longitude)"
	note gps5longitude: "* Point 5 * (longitude)"

	label variable gps5altitude "* Point 5 * (altitude)"
	note gps5altitude: "* Point 5 * (altitude)"

	label variable gps5accuracy "* Point 5 * (accuracy)"
	note gps5accuracy: "* Point 5 * (accuracy)"

	label variable done5 "Point 5 was recorded! Still have more coordinates of GPS to take ?"
	note done5: "Point 5 was recorded! Still have more coordinates of GPS to take ?"
	label define done5 1 "Yes" 0 "No"
	label values done5 done5

	label variable end_geolatitude "Record your location, where you ended the survey: (latitude)"
	note end_geolatitude: "Record your location, where you ended the survey: (latitude)"

	label variable end_geolongitude "Record your location, where you ended the survey: (longitude)"
	note end_geolongitude: "Record your location, where you ended the survey: (longitude)"

	label variable end_geoaltitude "Record your location, where you ended the survey: (altitude)"
	note end_geoaltitude: "Record your location, where you ended the survey: (altitude)"

	label variable end_geoaccuracy "Record your location, where you ended the survey: (accuracy)"
	note end_geoaccuracy: "Record your location, where you ended the survey: (accuracy)"

	label variable comment "Please leave a comment for the brother"
	note comment: "Please leave a comment for the brother"






	* append old, previously-imported data (if any)
	cap confirm file "`dtafile'"
	if _rc == 0 {
		* mark all new data before merging with old data
		gen new_data_row=1
		
		* pull in old data
		append using "`dtafile'"
		
		* drop duplicates in favor of old, previously-imported data if overwrite_old_data is 0
		* (alternatively drop in favor of new data if overwrite_old_data is 1)
		sort key
		by key: gen num_for_key = _N
		drop if num_for_key > 1 & ((`overwrite_old_data' == 0 & new_data_row == 1) | (`overwrite_old_data' == 1 & new_data_row ~= 1))
		drop num_for_key

		* drop new-data flag
		drop new_data_row
	}
	
	* save data to Stata format
	save "`dtafile'", replace

	* show codebook and notes
	codebook
	notes list
}

disp
disp "Finished import of: `csvfile'"
disp

* apply corrections (if any)
capture confirm file "`corrfile'"
if _rc==0 {
	disp
	disp "Starting application of corrections in: `corrfile'"
	disp

	* save primary data in memory
	preserve

	* load corrections
	insheet using "`corrfile'", names clear
	
	if _N>0 {
		* number all rows (with +1 offset so that it matches row numbers in Excel)
		gen rownum=_n+1
		
		* drop notes field (for information only)
		drop notes
		
		* make sure that all values are in string format to start
		gen origvalue=value
		tostring value, format(%100.0g) replace
		cap replace value="" if origvalue==.
		drop origvalue
		replace value=trim(value)
		
		* correct field names to match Stata field names (lowercase, drop -'s and .'s)
		replace fieldname=lower(subinstr(subinstr(fieldname,"-","",.),".","",.))
		
		* format date and date/time fields (taking account of possible wildcards for repeat groups)
		forvalues i = 1/100 {
			if "`datetime_fields`i''" ~= "" {
				foreach dtvar in `datetime_fields`i'' {
					* skip fields that aren't yet in the data
					cap unab dtvarignore : `dtvar'
					if _rc==0 {
						gen origvalue=value
						replace value=string(clock(value,"MDYhms",2025),"%25.0g") if strmatch(fieldname,"`dtvar'")
						* allow for cases where seconds haven't been specified
						replace value=string(clock(origvalue,"MDYhm",2025),"%25.0g") if strmatch(fieldname,"`dtvar'") & value=="." & origvalue~="."
						drop origvalue
					}
				}
			}
			if "`date_fields`i''" ~= "" {
				foreach dtvar in `date_fields`i'' {
					* skip fields that aren't yet in the data
					cap unab dtvarignore : `dtvar'
					if _rc==0 {
						replace value=string(clock(value,"MDY",2025),"%25.0g") if strmatch(fieldname,"`dtvar'")
					}
				}
			}
		}

		* write out a temp file with the commands necessary to apply each correction
		tempfile tempdo
		file open dofile using "`tempdo'", write replace
		local N = _N
		forvalues i = 1/`N' {
			local fieldnameval=fieldname[`i']
			local valueval=value[`i']
			local keyval=key[`i']
			local rownumval=rownum[`i']
			file write dofile `"cap replace `fieldnameval'="`valueval'" if key=="`keyval'""' _n
			file write dofile `"if _rc ~= 0 {"' _n
			if "`valueval'" == "" {
				file write dofile _tab `"cap replace `fieldnameval'=. if key=="`keyval'""' _n
			}
			else {
				file write dofile _tab `"cap replace `fieldnameval'=`valueval' if key=="`keyval'""' _n
			}
			file write dofile _tab `"if _rc ~= 0 {"' _n
			file write dofile _tab _tab `"disp"' _n
			file write dofile _tab _tab `"disp "CAN'T APPLY CORRECTION IN ROW #`rownumval'""' _n
			file write dofile _tab _tab `"disp"' _n
			file write dofile _tab `"}"' _n
			file write dofile `"}"' _n
		}
		file close dofile
	
		* restore primary data
		restore
		
		* execute the .do file to actually apply all corrections
		do "`tempdo'"

		* re-save data
		save "`dtafile'", replace
	}
	else {
		* restore primary data		
		restore
	}

	disp
	disp "Finished applying corrections in: `corrfile'"
	disp
}

*! version 0.1 26APR2019 Matteo Ruzzante mruzzante@worldbank.org

// Reggae music random generator

cap prog drop REGgae_music
	prog def  REGgae_music

	syntax	,									/// No variable required
												///
	   [BRowse]									/// Directly open the link in browser
	   [NUMber(numlist int min=1)]				/// Number of songs (must be an interger equal or greater than 1)
	   [PLAYlist]								/// Full playlist
	   [PLATFORM(string)]						/// Music platform or website
	   [ARTIST(string)]							/// Name of the artist
	   [COUNTRY(string)]						/// Country of origin
	   [GENDER(string)]        					/// Gender of (one of) the singer(s)
	   
	   
	// Set minimum version for this command
	version 10
		
	if "`playlist'" != "" {
		
		// Error for playlist and other option incorrectly used together
		
		foreach optionName in number artist country gender {
	
			if "``optionName''" != "" {
			
				noi di as error "Option {bf:`optionName'} may not be used in combination with option {bf:playlist}."
						  error  197
			}
		}
	}
	
	// If 'platform' option is used, check that it exists in our package
	if "`platform'" != "" {
	
		if "`platform'" != "Youtube" &  "`platform'" != "Spotify" {
			
			noi di as error "The {bf:platform} you selected is not available in our package."
			noi di as error "Feel free to suggest it by opening an issue in:""
			noi di as error `" {browse "https://github.com/MRuzzante/Jah-referencing/issues":https://github.com/MRuzzante/Jah-referencing/issues}
					  exit
		}
	}	
	
	// If `platform' option is not used, we will use Youtube
	if "`platform'" == "" local platform "Youtube"
	
	// If 'playlist' option is selected, we display the link to the Youtube playlist and exit the program
	if "`playlist'" != "" {
		
		if "`platform'" == "Youtube" {
			
			di as txt   "Enjoy the reggae playlist for rasta Stata users in Youtube."
			di as txt   "Blessing!"
			di		    ""
			di as text 			`"  {browse "https://www.youtube.com/watch?v=hzqFmXZ8tOE&list=PLC-aST3UH2m5tfv3RALnUA-z753ZDYSm7":https://www.youtube.com/watch?v=hzqFmXZ8tOE&list=PLC-aST3UH2m5tfv3RALnUA-z753ZDYSm7}
			
			if "`browse'" != "" view browse "https://www.youtube.com/watch?v=hzqFmXZ8tOE&list=PLC-aST3UH2m5tfv3RALnUA-z753ZDYSm7"
			exit
		}
		
		if "`platform'" == "Spotify" {
			
			di as txt   "Enjoy the reggae playlist for rasta Stata users in Spotify."
			di as txt   "Blessing!"
			di		    ""
			di as text 			`"  {browse "https://open.spotify.com/user/ruzzante.matteo/playlist/100XebrUHtUthBEoaKo0Ge?si=d592jMbFRl2EDf9w0QlPLA":https://open.spotify.com/user/ruzzante.matteo/playlist/100XebrUHtUthBEoaKo0Ge?si=d592jMbFRl2EDf9w0QlPLA}
			
			if "`browse'" != "" view browse "https://open.spotify.com/user/ruzzante.matteo/playlist/100XebrUHtUthBEoaKo0Ge?si=d592jMbFRl2EDf9w0QlPLA"
			exit
		}
	}
		
	// Error for artist, country and/or gender option incorrectly used together
	if   "`artist'" != "" {
	
		if "`country'" != "" {
			
				noi di as error "Option {bf:country} may not be used in combination with option {bf:artist}."
						  error  197
		}
		
		if "`gender'" != "" {
			
				noi di as error "Option {bf:gender} may not be used in combination with option {bf:artist}."
						  error  197
		}
	}	
	
	// If 'number' option is not used, we display one song
	if 	 "`number'" == "" local number = 1
	
	// If 'artist' option is used, check that artist exists in our list
	local  artistList `" "99 Posse" "Alborosie" "Anthony B" "Bob Marley" "Chronixx" "Damian Marley" "Etana" "Gentleman" "Jah Cure" "Junior Kelly" "Kabaka Pyramid" "Ky-Mani Marley" "Mama Marjas" "Mellow Mood" "Protoje" "Sara Lugo" "'
	
	if	 "`artist'"	   != "" {
	
		if   "`artist'"    != "99 Posse"  		& ///
			 "`artist'"    != "Alborosie"  		& ///
			 "`artist'"	   != "Anthony B"		& ///
			 "`artist'"    != "Bob Marley" 		& ///
			 "`artist'"    != "Chronixx"   		& ///
			 "`artist'"    != "Damian Marley"   & ///
			 "`artist'"	   != "Etana"			& ///
			 "`artist'"	   != "Jah Cure"		& ///
			 "`artist'"	   != "Junior Kelly"	& ///
			 "`artist'"	   != "Kabaka Pyramid"  & ///
			 "`artist'"	   != "Ky-Mani Marley"	& ///
			 "`artist'"    != "Gentleman"  		& ///
			 "`artist'"    != "Mama Marjas"  	& ///
			 "`artist'"    != "Mellow Mood"  	& ///
			 "`artist'"    != "Protoje"	   		& ///			 
			 "`artist'"	   != "Sara Lugo" 		{
			 
				 noi di as error "The {bf:artist} you selected is not present in our playlist."
				 noi di as error "If he/she is a reggae artist you like, feel free to suggest it by opening an issue in:""
				 noi di as error `" {browse "https://github.com/MRuzzante/Jah-referencing/issues":https://github.com/MRuzzante/Jah-referencing/issues}
						   exit
		}
	}
	
	// If 'artist' option is used, we switch artist locals on
	if	 "`artist'"	   != "" {
		
		foreach artistName of local artistList {
			
			// Abbreviate names with spaces
				 if "`artistName'" == "99 Posse"   		local artistShortName "99Posse"
			else if "`artistName'" == "Anthony B"	 	local artistShortName "AnthonyB"
			else if "`artistName'" == "Bob Marley"   	local artistShortName "BobMarley"
			else if "`artistName'" == "Damian Marley"	local artistShortName "DamianMarley"
			else if "`artistName'" == "Jah Cure" 		local artistShortName "JahCure"
			else if "`artistName'" == "Junior Kelly" 	local artistShortName "JuniorKelly"
			else if "`artistName'" == "Kabaka Pyramid"	local artistShortName "KabakaPyramid"
			else if "`artistName'" == "Ky-Mani Marley"  local artistShortName "KyManiMarley"
			else if "`artistName'" == "Mama Marjas"		local artistShortName "MamaMarjas"
			else if "`artistName'" == "Mellow Mood"		local artistShortName "MellowMood" 
			else if "`artistName'" == "Sara Lugo"		local artistShortName "SaraLugo"
			else 										local artistShortName `artistName'
			
			// Start local
			local `artistShortName' = 0
			
			// Turn local to 1 if the name matches
			if "`artist'" == "`artistName'" local `artistShortName' = 1
		}		
	}
		
	// If 'artist' option is not used, we switch all artist locals on
	if	 "`artist'"	   == "" {
		
		local 99Posse		= 1
		local Alborosie   	= 1		
		local AnthonyB    	= 1
		local BobMarley   	= 1
		local Chronixx 	  	= 1
		local DamianMarley 	= 1
		local Etana 	  	= 1
		local Gentleman   	= 1
		local JahCure	 	= 1
		local JuniorKelly 	= 1
		local KabakaPyramid = 1
		local MamaMarjas	= 1
		local MellowMood	= 1
		local Protoje 	  	= 1
		local SaraLugo    	= 1
	}
	
	//Do the same process for countries
	local countryList `" "Jamaica" "Italy" "Germany" "United States" "'
	
	if	 "`country'"	   != "" {
		
		if   "`country'"   != "Jamaica" 	  & ///
			 "`country'"   != "Italy"   	  & ///
			 "`country'"   != "Germany" 	  & ///
			 "`country'"   != "United States" {
				
				 noi di as error "The {bf:country} you selected is not present in our playlist."
				 noi di as error "If you like any reggae artist from there, feel free to suggest it by opening an issue in:""
				 noi di as error `" {browse "https://github.com/MRuzzante/Jah-referencing/issues":https://github.com/MRuzzante/Jah-referencing/issues}
						   exit
		}
	}
	
	if	 "`country'"	   != "" {
	
		foreach countryName of local countryList {
			
											  local `countryName' = 0
			if "`country'" == "`countryName'" local `countryName' = 1
		}
	}
	
	if	  "`country'"	   == "" {
	
		foreach countryName of local countryList {
		
			local `countryName' = 1
		}
	}
	
	//Do the same process for gender
	if	 "`gender'"	   != "" {
		
		if   "`gender'"   != "Female" & ///
			 "`gender'"   != "Male"   {
				
				 noi di as error "The {bf:gender} you selected is not available. Please make sure to type Female or Male in the option argument."
						   exit
		}
	}
	
	if	 "`gender'"	   != "" {
	
		foreach genderType in Female Male {
			
											local `genderType' = 0
			if "`gender'" == "`genderType'" local `genderType' = 1
		}
	}
	
	if	  "`gender'"   == "" {
	
		foreach genderType in Female Male {
		
			local `genderType' = 1
		}
	}
	
	
	// Initialize song counter
	local  totalSong  = 50
	local  songCount  =  0
		
	
	// Randomly pick song(s)
	// ---------------------
	
	// Loop on number of songs
	while `songCount' 	 < `number' {
		
		// Set locals for randomizing song
		local  rangeMin	 =  0
		local  interval	 =  1 		  / `totalSong'
		local  rangeMax	 = `rangeMin' + `interval'
	
		// Generate random number
		local randomSong = runiform()

		// 1) "Curre Curre Guagliò Still Running"
		if `randomSong' <= `rangeMax' {
			if (`99Posse' == 1 | `Alborosie' == 1 | `MamaMarjas' == 1) & `Italy' == 1 & (`Male' == 1 | `Female' == 1) {
				
				di  		""
				di as txt  `""A Sud curre cumbà"'
				di as txt  `" A Nord curre cumbà"'
				di as txt  `" Tandè'anna c'am'a scappà"'
				di as txt  `" Camine nu te ferma.""'

				di as txt   " {bf:99 Posse & Alborosie & Mama Marjas}"
				
				if "`platform'" == "Youtube" {
				
					di as text `"  {browse "https://www.youtube.com/watch?v=E4aVwfumPkk":https://www.youtube.com/watch?v=E4aVwfumPkk}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=E4aVwfumPkk"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/2T4bVyARdbXLMzQ3XOCHyU?si=aGPP7hjbRz-Pf_nowqa3JQ":https://open.spotify.com/track/2T4bVyARdbXLMzQ3XOCHyU?si=aGPP7hjbRz-Pf_nowqa3JQ}
					if "`browse'" != "" view browse "https://open.spotify.com/track/2T4bVyARdbXLMzQ3XOCHyU?si=aGPP7hjbRz-Pf_nowqa3JQ"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 2) "Combat Reggae"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if (`99Posse' == 1 | `MamaMarjas' == 1) & `Italy' == 1 & (`Male' == 1 | `Female' == 1) {
				
				di  		""
				di as txt  `"""Combat reggae I see the light""'
				di as txt  `" Combat reggae roots of my style."'
				
				di as txt   " {bf:99 Posse & Mama Marjas}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=N_mwZugEs28":https://www.youtube.com/watch?v=N_mwZugEs28}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=N_mwZugEs28"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/6g2pNZmhhPoxU03trjii4M?si=-zUYuEzeQKGdTkjozSKuBg":https://open.spotify.com/track/6g2pNZmhhPoxU03trjii4M?si=-zUYuEzeQKGdTkjozSKuBg}
					if "`browse'" != "" view browse "https://open.spotify.com/track/6g2pNZmhhPoxU03trjii4M?si=-zUYuEzeQKGdTkjozSKuBg"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 3) "Herbalist"
        if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Alborosie' & `Italy' & `Male' {
			
				di  		""
				di as txt  `""Babylon dem thief my herb dem thief my herb.""'
				di as txt   " {bf:Alborosie}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=MYp_gJQwRx8":https://www.youtube.com/watch?v=MYp_gJQwRx8}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=MYp_gJQwRx8"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/1UOhKnE2fZJuGdB7ssn9nf?si=qQdKxu_tQoa2mp55McLfQg":https://open.spotify.com/track/1UOhKnE2fZJuGdB7ssn9nf?si=qQdKxu_tQoa2mp55McLfQg}
					if "`browse'" != "" view browse "https://open.spotify.com/track/1UOhKnE2fZJuGdB7ssn9nf?si=qQdKxu_tQoa2mp55McLfQg"
				}
				
				local songCount = `songCount' + 1
			}
        }

        local rangeMin    = `rangeMin' + `interval'
        local rangeMax    = `rangeMax' + `interval' 
		
		// 4) "Kingston Town"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Alborosie' & `Italy' & `Male' {
			
				di  		""
				di as txt  `""Sipple it down down, sipple it down down."'
				di as txt  `" It's a rudeboy town, it's Kingston Town.""'
				di as txt   " {bf:Alborosie}"
				
				if "`platform'" == "Youtube" {
					
					di as text 			`"  {browse "https://www.youtube.com/watch?v=w0c_dv0TUmU":https://www.youtube.com/watch?v=w0c_dv0TUmU}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=w0c_dv0TUmU"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/2OHQhOiGIYaXqqJVIMpNrF?si=pt2K4eo7QOG6W-3sAyD7Xg":https://open.spotify.com/track/2OHQhOiGIYaXqqJVIMpNrF?si=pt2K4eo7QOG6W-3sAyD7Xg}
					if "`browse'" != "" view browse "https://open.spotify.com/track/2OHQhOiGIYaXqqJVIMpNrF?si=pt2K4eo7QOG6W-3sAyD7Xg"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 5) "Living Dread"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Alborosie' & `Italy' & `Male' {
				
				di  		""
				di as txt  `""I and I are the living dread"'
				di as txt  `" Inna these ya dawn of the living dead.""'
				di as txt   " {bf:Alborosie}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=FxEubwOGzqY":https://www.youtube.com/watch?v=FxEubwOGzqY}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=FxEubwOGzqY"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/1desgoyWi5qgAHbtC0VRQJ?si=kyY7od-LTYyY2MmQNMOltA":https://open.spotify.com/track/1desgoyWi5qgAHbtC0VRQJ?si=kyY7od-LTYyY2MmQNMOltA}
					if "`browse'" != "" view browse "https://open.spotify.com/track/1desgoyWi5qgAHbtC0VRQJ?si=kyY7od-LTYyY2MmQNMOltA"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 6) "No Cocaine"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Alborosie' & `Italy' & `Male' {
				
				di  		""
				di as txt  `""No coca, no coca, no coca inna mi brain""'
				di as txt  `" No coca and nuh ero inga go inna mi vein.""'
				di as txt   " {bf:Alborosie}"
				
				if "`platform'" == "Youtube" {
				
					di as text			`"  {browse "https://www.youtube.com/watch?v=4dYSkCVcPuc":https://www.youtube.com/watch?v=4dYSkCVcPuc}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=4dYSkCVcPuc"
				}
				
				if "`platform'" == "Spotify" {
				
					di as text			`"  {browse "https://open.spotify.com/track/07QuKUTu5O40AibYYPx98I?si=CCTF9h40Syu98E_0aVuWUQ":https://open.spotify.com/track/07QuKUTu5O40AibYYPx98I?si=CCTF9h40Syu98E_0aVuWUQ}
					if "`browse'" != "" view browse "https://open.spotify.com/track/07QuKUTu5O40AibYYPx98I?si=CCTF9h40Syu98E_0aVuWUQ"
				}
				
				local songCount = `songCount' + 1
			}
		}

		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 7) "Rastafari Anthem"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Alborosie' & `Italy' & `Male' {
				
				di  		""
				di as txt  `""I and I a praise""'
				di as txt  `" King Selassie"'
				di as txt  `" And endorse di ghetto youth dem.""'
				di as txt   " {bf:Alborosie}"
				
				if "`platform'" == "Youtube" {
				
					di as text			`"  {browse "https://www.youtube.com/watch?v=3A0ETb9z_PQ":https://www.youtube.com/watch?v=3A0ETb9z_PQ}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=3A0ETb9z_PQ"
				}
				
				if "`platform'" == "Spotify" {
				
					di as text			`"  {browse "https://open.spotify.com/track/3pn1vCQMA2wNQiaPkiIHI7?si=rPcW6nETQmKJ1B-whXs1cw":https://open.spotify.com/track/3pn1vCQMA2wNQiaPkiIHI7?si=rPcW6nETQmKJ1B-whXs1cw}
					if "`browse'" != "" view browse "https://open.spotify.com/track/3pn1vCQMA2wNQiaPkiIHI7?si=rPcW6nETQmKJ1B-whXs1cw"
				}
				
				local songCount = `songCount' + 1
			}
		}

		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 8) "Still Blazing"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Alborosie' & `Italy' & `Male' {
				
				di  		""
				di as txt  `""Don't let nobody rule your soul, no way.""'
				di as txt   " {bf:Alborosie}"
				
				if "`platform'" == "Youtube" {
					
					di as text 			`"  {browse "https://www.youtube.com/watch?v=uA112N_meog":https://www.youtube.com/watch?v=uA112N_meog}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=uA112N_meog"
				}
				
				if "`platform'" == "Spotify" {
				
					di as text 			`"  {browse "https://open.spotify.com/track/3sbBOn0ifcgoX3MfaTeFKr?si=eonpS3P0QcS2h_6O0yGmiA":https://open.spotify.com/track/3sbBOn0ifcgoX3MfaTeFKr?si=eonpS3P0QcS2h_6O0yGmiA}
					if "`browse'" != "" view browse "https://open.spotify.com/track/3sbBOn0ifcgoX3MfaTeFKr?si=eonpS3P0QcS2h_6O0yGmiA"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 9) "Contradiction"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if (`Alborosie' == 1 | `Chronixx' == 1) & (`Italy' == 1 | `Jamaica' == 1) & `Male' == 1{	
				
				di  		""
				di as txt  `""Contradiction global"'
				di as txt  `" Madness taking over.""'
				di as txt   " {bf:Alborosie & Chronixx}"
				
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=kuFI_jOSyGw":https://www.youtube.com/watch?v=kuFI_jOSyGw}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=kuFI_jOSyGw"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/4A2EuH7CRXeUpLh84TLsav?si=CXsKn2SASYWTUI9fYtBvSg":https://open.spotify.com/track/4A2EuH7CRXeUpLh84TLsav?si=CXsKn2SASYWTUI9fYtBvSg}
					if "`browse'" != "" view browse "https://open.spotify.com/track/4A2EuH7CRXeUpLh84TLsav?si=CXsKn2SASYWTUI9fYtBvSg"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 10) "Blessings"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if (`Alborosie' == 1 | `Etana' == 1) & ((`Italy' == 1  & `Male' == 1) | (`Jamaica' == 1 & `Female' == 1)) {
				
				di  		""
				di as txt  `""Cause when a man love a woman and a woman love a man"'
				di as txt  `" a Jah Jah blessing.""'
				di as txt   " {bf:Alborosie & Etana}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=gAMZMWvAxjo":https://www.youtube.com/watch?v=gAMZMWvAxjo}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=gAMZMWvAxjo"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/4T1YRV5aIiOD7i0TB9yKKA?si=GIgj0g4hTc2uZTju6F9lPw":https://open.spotify.com/track/4T1YRV5aIiOD7i0TB9yKKA?si=GIgj0g4hTc2uZTju6F9lPw}
					if "`browse'" != "" view browse "https://open.spotify.com/track/4T1YRV5aIiOD7i0TB9yKKA?si=GIgj0g4hTc2uZTju6F9lPw"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 11) "Journey to Jah"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if (`Alborosie' == 1 | `Gentleman' == 1) & (`Italy' == 1 | `Germany' == 1) & `Male' == 1 {
				
				//"Journey to Jah" is only availabe on Youtube
				if "`platform'" == "Youtube" {
					
					di  		""
					di as txt  `""Crossing border, divine is the order.""'
					di as txt   " {bf:Alborosie & Gentleman}"
					
					di as text `"  {browse "https://www.youtube.com/watch?v=dN8FTAx06rE":https://www.youtube.com/watch?v=dN8FTAx06rE}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=dN8FTAx06rE"
					
					local songCount = `songCount' + 1
				}
				
				if "`platform'" == "Spotify" continue				

			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 12) "Mystical Reggae"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if (`Alborosie' == 1 | `JahCure' == 1) & (`Italy' == 1 | `Jamaica' == 1) & `Male' == 1 {
				
				//"Mystical Reggae" is only availabe on Spotify
				if "`platform'" == "Youtube" continue
								
				if "`platform'" == "Spotify" {
					
					di  		""
					di as txt  `""There's a natural mystic inna di air.""'
					di as txt   " {bf:Alborosie & Jah Cure}"
					
					di as text 			`"  {browse "https://open.spotify.com/track/3yjjW4ajNwJ5ikNb4fxGy2?si=zaS3l5eASauRPOSgpHuC9Q":https://open.spotify.com/track/3yjjW4ajNwJ5ikNb4fxGy2?si=zaS3l5eASauRPOSgpHuC9Q}
					if "`browse'" != "" view browse "https://open.spotify.com/track/3yjjW4ajNwJ5ikNb4fxGy2?si=zaS3l5eASauRPOSgpHuC9Q"
				
					local songCount = `songCount' + 1
				}
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 13) "Strolling"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if (`Alborosie' == 1 | `Protoje' == 1) & (`Italy' == 1 | `Jamaica' == 1) & `Male' == 1 {
				
				di  		""
				di as txt  `""Over the mountains, across the seas"'
				di as txt  `" You feel it mystically in the breeze"'
				di as txt  `" When the Rastaman strolling into town.""'
				di as txt   " {bf:Alborosie & Protoje}"
								
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=QXczfq3MCYQ":https://www.youtube.com/watch?v=QXczfq3MCYQ}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=QXczfq3MCYQ"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/3NAw0zn9VETypbwkJMt747?si=YRb-WvlxRPWfiCDjkrsAXw":https://open.spotify.com/track/3NAw0zn9VETypbwkJMt747?si=YRb-WvlxRPWfiCDjkrsAXw}
					if "`browse'" != "" view browse "https://open.spotify.com/track/3NAw0zn9VETypbwkJMt747?si=YRb-WvlxRPWfiCDjkrsAXw"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 14) "Can't Stop The Fire"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `AnthonyB' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""Can't stop di fiyah keep it burning.""'
				di as txt   " {bf:Anthony B}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=g9D1wowY7q4":https://www.youtube.com/watch?v=g9D1wowY7q4}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=g9D1wowY7q4"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/4jmULYj986UBTySibS1Bdn?si=6-PDscBZQVabfVqgzNuwkA":https://open.spotify.com/track/4jmULYj986UBTySibS1Bdn?si=6-PDscBZQVabfVqgzNuwkA}
					if "`browse'" != "" view browse "https://open.spotify.com/track/4jmULYj986UBTySibS1Bdn?si=6-PDscBZQVabfVqgzNuwkA"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 15) "Freedom Fighter"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `AnthonyB' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""Run for cover"'
				di as txt  `" Rebel is taking over, right now.""'
				di as txt   " {bf:Anthony B}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=Ov--KAGEuaw":https://www.youtube.com/watch?v=Ov--KAGEuaw}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=Ov--KAGEuaw"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/37L9OjM5qrJMa29gT9HKGW?si=NnRf59oATqm7_yQ07V_Y0g":https://open.spotify.com/track/37L9OjM5qrJMa29gT9HKGW?si=NnRf59oATqm7_yQ07V_Y0g}
					if "`browse'" != "" view browse "https://open.spotify.com/track/37L9OjM5qrJMa29gT9HKGW?si=NnRf59oATqm7_yQ07V_Y0g"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 16) "Good Cop Bad Cop"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `AnthonyB' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `"".""'
				di as txt   " {bf:Anthony B}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=Zpe2zHk0m4s":https://www.youtube.com/watch?v=Zpe2zHk0m4s}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=Zpe2zHk0m4s"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/3nkhq24WT28eKVYta3yyhE?si=cD1N-FdWQ1aCwT-sZV-Frw":https://open.spotify.com/track/3nkhq24WT28eKVYta3yyhE?si=cD1N-FdWQ1aCwT-sZV-Frw}
					if "`browse'" != "" view browse "https://open.spotify.com/track/3nkhq24WT28eKVYta3yyhE?si=cD1N-FdWQ1aCwT-sZV-Frw"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 18) "Love Come Down"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `AnthonyB' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""Girl you make my love come down.""'
				di as txt   " {bf:Anthony B}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=cAZPBv28dpA":https://www.youtube.com/watch?v=cAZPBv28dpA}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=cAZPBv28dpA"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/63SqSUAOIcPxCt4piwgyFh?si=k4h8eRNzRg26gF_fauR7YA":https://open.spotify.com/track/63SqSUAOIcPxCt4piwgyFh?si=k4h8eRNzRg26gF_fauR7YA}
					if "`browse'" != "" view browse "https://open.spotify.com/track/63SqSUAOIcPxCt4piwgyFh?si=k4h8eRNzRg26gF_fauR7YA"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 19) "My Yes & My No"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `AnthonyB' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""You are my yes and my no"'
				di as txt  `" My high and my low".""'
				di as txt   " {bf:Anthony B}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=qJlAANOTQjE":https://www.youtube.com/watch?v=qJlAANOTQjE}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=qJlAANOTQjE"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/7HwzUApZNxS4ZzUhyyokx7?si=hasSCIShRHmF_VaGFlExWA":https://open.spotify.com/track/7HwzUApZNxS4ZzUhyyokx7?si=hasSCIShRHmF_VaGFlExWA}
					if "`browse'" != "" view browse "https://open.spotify.com/track/7HwzUApZNxS4ZzUhyyokx7?si=hasSCIShRHmF_VaGFlExWA"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 20) "Police"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `AnthonyB' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""Who want the dancehall fi stop?""'
				di as txt   " {bf:Anthony B}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=mN1-hI19p9k":https://www.youtube.com/watch?v=mN1-hI19p9k}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=mN1-hI19p9k"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/6LtaXQAwy6qy3lnSP0BuZ3?si=lHfeWkPdTICj08LoI3fuaA":https://open.spotify.com/track/6LtaXQAwy6qy3lnSP0BuZ3?si=lHfeWkPdTICj08LoI3fuaA}
					if "`browse'" != "" view browse "https://open.spotify.com/track/6LtaXQAwy6qy3lnSP0BuZ3?si=lHfeWkPdTICj08LoI3fuaA"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// 21) "Unbalance"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `AnthonyB' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""Unbalance"'
				di as txt  `" You don't see that I'm unbalanced.""'
				di as txt   " {bf:Anthony B}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=UqeAr1gqxyU":https://www.youtube.com/watch?v=UqeAr1gqxyU}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=UqeAr1gqxyU"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/74LWzRoSPSOPDgmcMlCUVs?si=n9ePvGN2SIuS-ZvxVU5t8g":https://open.spotify.com/track/74LWzRoSPSOPDgmcMlCUVs?si=n9ePvGN2SIuS-ZvxVU5t8g}
					if "`browse'" != "" view browse "https://open.spotify.com/track/74LWzRoSPSOPDgmcMlCUVs?si=n9ePvGN2SIuS-ZvxVU5t8g"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
			
		// 22) "World A Reggae Music"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `AnthonyB' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `"""World a reggae music on ya - eh"'
				di as txt  `" Keep me rockin with me daughter - eh-a.""'
				di as txt   " {bf:Anthony B}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=nsa_I6nbZo0":https://www.youtube.com/watch?v=nsa_I6nbZo0}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=nsa_I6nbZo0"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/3Gym3Rtm6FHpTrLlJTcz3j?si=5Xkwl1UkRG6PjyicqqtCjA":https://open.spotify.com/track/3Gym3Rtm6FHpTrLlJTcz3j?si=5Xkwl1UkRG6PjyicqqtCjA}
					if "`browse'" != "" view browse "https://open.spotify.com/track/3Gym3Rtm6FHpTrLlJTcz3j?si=5Xkwl1UkRG6PjyicqqtCjA"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Here Comes Trouble"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Chronixx' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""Welcome the savior"'
				di as txt  `" Welcome the rasta youths.""'
				di as txt   " {bf:Chronixx}"
				
				if "`platform'" == "Youtube" {
					
					di as text 			`"  {browse "https://www.youtube.com/watch?v=LfeIfiiBTfY":https://www.youtube.com/watch?v=LfeIfiiBTfY}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=LfeIfiiBTfY"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/5Wwr2S7QZTR5PVJn6jhgdk?si=p1vSLV5RSmqU9G21KrmNhg":https://open.spotify.com/track/5Wwr2S7QZTR5PVJn6jhgdk?si=p1vSLV5RSmqU9G21KrmNhg}
					if "`browse'" != "" view browse "https://open.spotify.com/track/5Wwr2S7QZTR5PVJn6jhgdk?si=p1vSLV5RSmqU9G21KrmNhg"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Skankin' Sweet"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Chronixx' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""Skankin' sweet"'
				di as txt  `" Everybody wanna feel irie.""'
				di as txt   " {bf:Chronixx}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=049km3Vc02c":https://www.youtube.com/watch?v=049km3Vc02c}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=049km3Vc02c"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/5SQaQWvBDEAeug4EPyYEGE?si=0Rw6KzRfQ_OmBgmx8kGcKg":https://open.spotify.com/track/5SQaQWvBDEAeug4EPyYEGE?si=0Rw6KzRfQ_OmBgmx8kGcKg}
					if "`browse'" != "" view browse "https://open.spotify.com/track/5SQaQWvBDEAeug4EPyYEGE?si=0Rw6KzRfQ_OmBgmx8kGcKg"
				}
				
				local songCount = `songCount' + 1
			}
		}	
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Smile Jamaica"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Chronixx' & `Jamaica' & `Male'{
				
				di  		""
				di as txt  `""Smile girl smile"'
				di as txt  `" Smile for me Jamaica.""'
				di as txt   " {bf:Chronixx}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=vofff0Ei3kk":https://www.youtube.com/watch?v=vofff0Ei3kk}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=vofff0Ei3kk"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/7KhQx2EJaZIPGsbMAjf4jg?si=Hct-rsyBReemG39GQsxURQ":https://open.spotify.com/track/7KhQx2EJaZIPGsbMAjf4jg?si=Hct-rsyBReemG39GQsxURQ}
					if "`browse'" != "" view browse "https://open.spotify.com/track/7KhQx2EJaZIPGsbMAjf4jg?si=Hct-rsyBReemG39GQsxURQ"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Spanish Town Rockin'"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Chronixx' & `Jamaica' & `Male'{
				
				di  		""
				di as txt  `""Spanish Town groovy"'
				di as txt  `" Everybody nice.""'
				di as txt   " {bf:Chronixx}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=K2grZsqpvEI":https://www.youtube.com/watch?v=K2grZsqpvEI}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=K2grZsqpvEI"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/4Qup2zholspnhLpgkO77C2?si=ZoWaBjb-Rs232yhw-jvC9w":https://open.spotify.com/track/4Qup2zholspnhLpgkO77C2?si=ZoWaBjb-Rs232yhw-jvC9w}
					if "`browse'" != "" view browse "https://open.spotify.com/track/4Qup2zholspnhLpgkO77C2?si=ZoWaBjb-Rs232yhw-jvC9w"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
								
		// "Intoxication"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Gentleman' & `Germany' & `Male' {
				
				di  		""
				di as txt  `""Joy ina your eyes me nuh see no tears"'
				di as txt  `" Love is what you giving me troughout the years.""'
				di as txt   " {bf:Gentleman}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=BtzGQIDOCkM":https://www.youtube.com/watch?v=BtzGQIDOCkM}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=BtzGQIDOCkM"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/76GvclaeLjwJV408jF2NgZ?si=BNxknVFET96AJZLB_JG16g":https://open.spotify.com/track/76GvclaeLjwJV408jF2NgZ?si=BNxknVFET96AJZLB_JG16g}
					if "`browse'" != "" view browse "https://open.spotify.com/track/76GvclaeLjwJV408jF2NgZ?si=BNxknVFET96AJZLB_JG16g"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'

		// "Red Town"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Gentleman' & `Germany' & `Male' {
			
				di  		""
				di as txt  `""The destination is freedom from stress"'
				di as txt  `" That's the getaway.""'
				di as txt   " {bf:Gentleman}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=aktSkJ3USR4":https://www.youtube.com/watch?v=aktSkJ3USR4}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=aktSkJ3USR4"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/7IH9KJrlF1xteGD2nssZTp?si=sZxDUkVySYGn60S3Md3rWQ":https://open.spotify.com/track/7IH9KJrlF1xteGD2nssZTp?si=sZxDUkVySYGn60S3Md3rWQ}
					if "`browse'" != "" view browse "https://open.spotify.com/track/7IH9KJrlF1xteGD2nssZTp?si=sZxDUkVySYGn60S3Md3rWQ"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Signs Of The Times"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if (`Gentleman' == 1 | `KyManiMarley' == 1) & (`Germany' == 1 | `Jamaica' == 1) & (`Male' == 1) {
			
				di  		""
				di as txt  `""These are the signs of the times"'
				di as txt  `" It is time for us to define."'
				di as txt  `" Who destroys, who design.""'
				di as txt   " {bf:Gentleman & Ky-Mani Marley}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=Dmpgi7POB88":https://www.youtube.com/watch?v=Dmpgi7POB88}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=Dmpgi7POB88"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/7kkJPjjepAoiBUiXQWXdRj?si=5xe4bqIAQsOP3wZT6f_Xow":https://open.spotify.com/track/7kkJPjjepAoiBUiXQWXdRj?si=5xe4bqIAQsOP3wZT6f_Xow}
					if "`browse'" != "" view browse "https://open.spotify.com/track/7kkJPjjepAoiBUiXQWXdRj?si=5xe4bqIAQsOP3wZT6f_Xow"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Redemption Song"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `BobMarley' & `Jamaica' & `Male' {
			
				di  		""
				di as txt  `""Emancipate yourselves from mental slavery"'
				di as txt  `" None but ourselves can free our minds.""'
				di as txt   " {bf:Bob Marley}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=kOFu6b3w6c0":https://www.youtube.com/watch?v=kOFu6b3w6c0}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=kOFu6b3w6c0"
				}
				
				local songCount = `songCount' + 1
			}
		}

		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "One Love"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `BobMarley' & `Jamaica' & `Male' {
			
				di  		""
				di as txt  `""Let's get together and feel all right.""'
				di as txt   " {bf:Bob Marley}"
				
				if "`platform'" == "Youtube" {
					
					di as text			`"  {browse "https://www.youtube.com/watch?v=vdB-8eLEW8g":https://www.youtube.com/watch?v=vdB-8eLEW8g}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=vdB-8eLEW8g"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Iron Lion Zion"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `BobMarley' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""I had to run like a fugitive just to save the life I live"'
				di as txt  `" I'm gonna be Iron like a Lion in Zion.""'
				di as txt   " {bf:Bob Marley}"
				
				if "`platform'" == "Youtube" {
				
					di as text			`"  {browse "https://www.youtube.com/watch?v=HgXMoZdY5A0":https://www.youtube.com/watch?v=HgXMoZdY5A0}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=HgXMoZdY5A0"
				}
				local songCount = `songCount' + 1
			}
		}

		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
									
		// "If Love So Nice"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `JuniorKelly' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""Tell me if love so nice.""'
				di as txt   " {bf:Junior Kelly}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=tSkuJJnKk7o":https://www.youtube.com/watch?v=tSkuJJnKk7o}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=tSkuJJnKk7o"
				}
				
				if "`platform'" == "Spotify" {
				
					di as text 			`"  {browse "https://open.spotify.com/track/5hAOJvfhTB07VcFhno9EY1?si=WvqK4YC-QVa_VnZi4KftFA":https://open.spotify.com/track/5hAOJvfhTB07VcFhno9EY1?si=WvqK4YC-QVa_VnZi4KftFA}
					if "`browse'" != "" view browse "https://open.spotify.com/track/5hAOJvfhTB07VcFhno9EY1?si=WvqK4YC-QVa_VnZi4KftFA"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "I Am Not Afraid"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Etana' & `Jamaica' & `Female' {
				
				di  		""
				di as txt  `""If dem a come let them come 'cause I am protected by the most one.""'
				di as txt   " {bf:Etana}"
				
				if "`platform'" == "Youtube" {
				
					di as text			`"  {browse "https://www.youtube.com/watch?v=jI7Y1SXPNXI":https://www.youtube.com/watch?v=jI7Y1SXPNXI}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=jI7Y1SXPNXI"
				}
				
				if "`platform'" == "Spotify" {
				
					di as text 			`"  {browse "https://open.spotify.com/track/0EhMnGX0ayyKkwBiHCzfQy?si=UCi_BqkgT1ueod7C3PAO1Q":https://open.spotify.com/track/0EhMnGX0ayyKkwBiHCzfQy?si=UCi_BqkgT1ueod7C3PAO1Q}
					if "`browse'" != "" view browse "https://open.spotify.com/track/0EhMnGX0ayyKkwBiHCzfQy?si=UCi_BqkgT1ueod7C3PAO1Q"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Can't Breathe"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `KabakaPyramid' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""Me say me cyaan breathe"'
				di as txt  `" Inna this yah suffocation"'
				di as txt  `" The people living inna sufferation.""'
				di as txt   " {bf:Kabaka Pyramid}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=BOx3nqWBe1c":https://www.youtube.com/watch?v=BOx3nqWBe1c}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=BOx3nqWBe1c"
				}
				
				if "`platform'" == "Spotify" {
				
					di as text 			`"  {browse "https://open.spotify.com/track/4DfCv5IfEsFeYJE87liL47?si=-WV83RsfQy29EJ-0dtTNHw":https://open.spotify.com/track/4DfCv5IfEsFeYJE87liL47?si=-WV83RsfQy29EJ-0dtTNHw}
					if "`browse'" != "" view browse "https://open.spotify.com/track/4DfCv5IfEsFeYJE87liL47?si=-WV83RsfQy29EJ-0dtTNHw"
				}
				
				
				local songCount = `songCount' + 1
			}
		}

		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Make Way"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `KabakaPyramid' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""Mi go say"'
				di as txt  `" Make way"'
				di as txt  `" Rastaman bursting through your gateway.""'
				di as txt   " {bf:Kabaka Pyramid}"
				
				if "`platform'" == "Youtube" {
				
					di as text			`"  {browse "https://www.youtube.com/watch?v=yAbSe6JXOZs":https://www.youtube.com/watch?v=yAbSe6JXOZs}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=yAbSe6JXOZs"
				}
				
				if "`platform'" == "Spotify" {
				
					di as text 			`"  {browse "https://open.spotify.com/track/0hWI17CuUzsbBG38bqdfDH?si=QcXu1ZimQr6iuvY86sp4zQ":https://open.spotify.com/track/0hWI17CuUzsbBG38bqdfDH?si=QcXu1ZimQr6iuvY86sp4zQ}
					if "`browse'" != "" view browse "https://open.spotify.com/track/0hWI17CuUzsbBG38bqdfDH?si=QcXu1ZimQr6iuvY86sp4zQ"
				}
				
				local songCount = `songCount' + 1
			}
		}

		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Reggae Music"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `KabakaPyramid' & `Jamaica' & `Male' {
			
				di  		""
				di as txt  `""Well, if the music sounds sweet and the people dem a dance"'
				di as txt  `" A must the reggae music, nothing else no have a chance.""'
				di as txt   " {bf:Kabaka Pyramid}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=q05liMm3LI4":https://www.youtube.com/watch?v=q05liMm3LI4}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=q05liMm3LI4"
				}
				
				if "`platform'" == "Spotify" {
				
					di as text 			`"  {browse "https://open.spotify.com/track/4LH6TQajTVHlPz1283KHAw?si=BHToHoGTSoal5GCtAqjPvA":https://open.spotify.com/track/4LH6TQajTVHlPz1283KHAw?si=BHToHoGTSoal5GCtAqjPvA}
					if "`browse'" != "" view browse "https://open.spotify.com/track/4LH6TQajTVHlPz1283KHAw?si=BHToHoGTSoal5GCtAqjPvA"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Well Done"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `KabakaPyramid' & `Jamaica' & `Male' {
			
				di  		""
				di as txt  `""Well done, well done, Mr. Politician Man"'
				di as txt  `" You done a wonderful job a tear down we country, demolition man.""'
				di as txt   " {bf:Kabaka Pyramid}"
				
				if "`platform'" == "Youtube" {
				
					di as text 			`"  {browse "https://www.youtube.com/watch?v=h8rClH-Jbno":https://www.youtube.com/watch?v=h8rClH-Jbno}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=h8rClH-Jbno"
				}
				
				if "`platform'" == "Spotify" {
				
					di as text 			`"  {browse "https://open.spotify.com/track/33Xl6nfOScCLuvgZyohurw?si=aHMtQNG7SVOuabEflJQNwA":https://open.spotify.com/track/33Xl6nfOScCLuvgZyohurw?si=aHMtQNG7SVOuabEflJQNwA}
					if "`browse'" != "" view browse "https://open.spotify.com/track/33Xl6nfOScCLuvgZyohurw?si=aHMtQNG7SVOuabEflJQNwA"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'

		// "Kontraband"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if (`KabakaPyramid' == 1 | `DamianMarley' == 1) & (`Jamaica' == 1) & (`Male' == 1) {
			
				di  		""
				di as txt  `""Kontraband"'
				di as txt  `" Now what's in that recipe?"'
				di as txt  `" Kontraband"'
				di as txt  `" Dat giving me the stress relief.""'
				di as txt   " {bf:Kabaka Pyramid & Damian Marley}"
				
				if "`platform'" == "Youtube" {
					
					di as text 			`"  {browse "https://www.youtube.com/watch?v=DFqRUKTDvn4":https://www.youtube.com/watch?v=DFqRUKTDvn4}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=DFqRUKTDvn4"
				}
				
				if "`platform'" == "Spotify" {
				
					di as text 			`"  {browse "https://open.spotify.com/track/4xSgbZ1CFc7f3PZd7RLwF3?si=SKWzvvlTRFSyFY0uTpk5cw":https://open.spotify.com/track/4xSgbZ1CFc7f3PZd7RLwF3?si=SKWzvvlTRFSyFY0uTpk5cw}
					if "`browse'" != "" view browse "https://open.spotify.com/track/4xSgbZ1CFc7f3PZd7RLwF3?si=SKWzvvlTRFSyFY0uTpk5cw"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		// "A Matter of Time"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Protoje' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""And I got to get what's mine"'
				di as txt  `" It's only a matter of time.""'
				di as txt   " {bf:Protoje}"
				
				if "`platform'" == "Youtube" {
					
					di as text 			`"  {browse "https://www.youtube.com/watch?v=Z1LOOZeh7qA":https://www.youtube.com/watch?v=Z1LOOZeh7qA}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=Z1LOOZeh7qA"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/62yLFzTjO2shNlxoIiMQrb?si=xLVx9foZRfCSZI13bSfozA":https://open.spotify.com/track/62yLFzTjO2shNlxoIiMQrb?si=xLVx9foZRfCSZI13bSfozA}
					if "`browse'" != "" view browse "https://open.spotify.com/track/62yLFzTjO2shNlxoIiMQrb?si=xLVx9foZRfCSZI13bSfozA"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'

		// "All Will Have To Change"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Protoje' & `Jamaica' & `Male' {

				di  		""
				di as txt  `""I say we all will have to change"'
				di as txt  `" In each his own way.""'
				di as txt   " {bf:Protoje}"
				
				if "`platform'" == "Youtube" {
					
					di as text 			`"  {browse "https://www.youtube.com/watch?v=eenWXAyUMSw":https://www.youtube.com/watch?v=eenWXAyUMSw}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=eenWXAyUMSw"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/1UwY88aleBy0U4NAwqF8JG?si=_x_Zd-KsS-6-DpWdaLcPqg":https://open.spotify.com/track/1UwY88aleBy0U4NAwqF8JG?si=_x_Zd-KsS-6-DpWdaLcPqg}
					if "`browse'" != "" view browse "https://open.spotify.com/track/1UwY88aleBy0U4NAwqF8JG?si=_x_Zd-KsS-6-DpWdaLcPqg"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'

		// "Blood Money"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Protoje' & `Jamaica' & `Male' {

				di  		""
				di as txt  `""If what you see no really phase you"'
				di as txt  `" Then you a the problem that we face too.""'
				di as txt   " {bf:Protoje}"
				
				if "`platform'" == "Youtube" {
					
					di as text 			`"  {browse "https://www.youtube.com/watch?v=etdnIFC4erw":https://www.youtube.com/watch?v=etdnIFC4erw}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=etdnIFC4erw"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/3WzNtP1VFi5QYoO3io6Ybl?si=5HQtwUoySJaIdmLz2Guwmw":https://open.spotify.com/track/3WzNtP1VFi5QYoO3io6Ybl?si=5HQtwUoySJaIdmLz2Guwmw}
					if "`browse'" != "" view browse "https://open.spotify.com/track/3WzNtP1VFi5QYoO3io6Ybl?si=5HQtwUoySJaIdmLz2Guwmw"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Kingston Be Wise"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Protoje' & `Jamaica' & `Male' {

				di  		""
				di as txt  `""Kingston, be wise"'
				di as txt  `" Kingston, free up your mind.""'
				di as txt   " {bf:Protoje}"
				
				if "`platform'" == "Youtube" {
					
					di as text 			`"  {browse "https://www.youtube.com/watch?v=FFA5e_1Mrvo":https://www.youtube.com/watch?v=FFA5e_1Mrvo}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=FFA5e_1Mrvo"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/0qbouIdcN4lrj49jem7TEz?si=eYeXCU4gTsi_V64WxikFjw":https://open.spotify.com/track/0qbouIdcN4lrj49jem7TEz?si=eYeXCU4gTsi_V64WxikFjw}
					if "`browse'" != "" view browse "https://open.spotify.com/track/0qbouIdcN4lrj49jem7TEz?si=eYeXCU4gTsi_V64WxikFjw"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'

		// "Like This"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Protoje' & `Jamaica' & `Male' {

				di  		""
				di as txt  `""I’ma do my thing like this"'
				di as txt  `" Rock to the riddim like this.""'
				di as txt   " {bf:Protoje}"
				
				if "`platform'" == "Youtube" {
					
					di as text 			`"  {browse "https://www.youtube.com/watch?v=JLO4IoWCk-8":https://www.youtube.com/watch?v=JLO4IoWCk-8}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=JLO4IoWCk-8"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/40Y6wU9MHPSCTFs5QoO23X?si=kvLwWqh2Q6S4sME9gFFsKA":https://open.spotify.com/track/40Y6wU9MHPSCTFs5QoO23X?si=kvLwWqh2Q6S4sME9gFFsKA}
					if "`browse'" != "" view browse "https://open.spotify.com/track/40Y6wU9MHPSCTFs5QoO23X?si=kvLwWqh2Q6S4sME9gFFsKA"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Mind of a King"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Protoje' & `Jamaica' & `Male' {

				di  		""
				di as txt  `""Every country, every town"'
				di as txt  `" Calling for the sound.""'
				di as txt   " {bf:Protoje}"
				
				if "`platform'" == "Youtube" {
					
					di as text 			`"  {browse "https://www.youtube.com/watch?v=iPG7Wlluf_E":https://www.youtube.com/watch?v=iPG7Wlluf_E}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=iPG7Wlluf_E"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/3vor1l4dID6poAHLvsTLp3?si=BJE4qrdtTHu2bxcnPMOzIg":https://open.spotify.com/track/3vor1l4dID6poAHLvsTLp3?si=BJE4qrdtTHu2bxcnPMOzIg}
					if "`browse'" != "" view browse "https://open.spotify.com/track/3vor1l4dID6poAHLvsTLp3?si=BJE4qrdtTHu2bxcnPMOzIg"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Who Knows"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if ((`Protoje' == 1) | (`Chronixx' == 1)) & `Jamaica' == 1 & `Male' == 1 {
				
				di  		""
				di as txt  `""I'm pleased to be chilling in the West Indies.""'
				di as txt   " {bf:Protoje & Chronixx}"
				
				if "`platform'" == "Youtube" {
					
					di as text 			`"  {browse "https://www.youtube.com/watch?v=hzqFmXZ8tOE":https://www.youtube.com/watch?v=hzqFmXZ8tOE}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=hzqFmXZ8tOE"
				}
				
				if "`platform'" == "Spotify" {
					
					di as text 			`"  {browse "https://open.spotify.com/track/2WPurGHHJunuAkFCczyEe3?si=HtVvBAzQRgq82VgAKSCa8g":https://open.spotify.com/track/2WPurGHHJunuAkFCczyEe3?si=HtVvBAzQRgq82VgAKSCa8g}
					if "`browse'" != "" view browse "https://open.spotify.com/track/2WPurGHHJunuAkFCczyEe3?si=HtVvBAzQRgq82VgAKSCa8g"
				}
				
				local songCount = `songCount' + 1
			}
		}
			
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		
		// "High & Windy"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if (`KabakaPyramid' == 1 | `SaraLugo' == 1) & ((`Jamaica' == 1  & `Male' == 1) | (`Germany' == 1 & `Female' == 1)) {
			
				di  		""
				di as txt  `""Riding on a high and windy day"'
				di as txt  `" Riding my troubles away.""'
				di as txt   " {bf:Sara Lugo & Kabaka Pyramid}"
				
				if "`platform'" == "Youtube" {
					
					di as text 			`"  {browse "https://www.youtube.com/watch?v=XDng01g3Ejw":https://www.youtube.com/watch?v=XDng01g3Ejw}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=XDng01g3Ejw"
				}
				
				if "`platform'" == "Spotify" {
				
					di as text 			`"  {browse "https://open.spotify.com/track/0E1HHOAk52Z5STOKrUmBhR?si=ErZazDuITPiiVZu5keORTQ":https://open.spotify.com/track/0E1HHOAk52Z5STOKrUmBhR?si=ErZazDuITPiiVZu5keORTQ}
					if "`browse'" != "" view browse "https://open.spotify.com/track/0E1HHOAk52Z5STOKrUmBhR?si=ErZazDuITPiiVZu5keORTQ"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Really Like You"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if (`SaraLugo' == 1 | `Protoje' == 1) & ((`Jamaica' == 1  & `Male' == 1) | (`Germany' == 1 & `Female' == 1)) {
				
				di  		""
				di as txt  `""Cos I really really like you"'
				di as txt  `""There's something about you"'
				di as txt  `" Don't you think so, too.""'
				di as txt   " {bf:Sara Lugo & Protoje}"
				
				if "`platform'" == "Youtube" {
					
					di as text			`"  {browse "https://www.youtube.com/watch?v=dr9OXGqR8Tg":https://www.youtube.com/watch?v=dr9OXGqR8Tg}
					if "`browse'" != "" view browse "https://www.youtube.com/watch?v=dr9OXGqR8Tg"
				}
				
				if "`platform'" == "Spotify" {
				
					di as text 			`"  {browse "https://open.spotify.com/track/21HsvKIyvp2HtVIqg4LHQH?si=wZxN3WEtQtCxMd6cEFQYWw":https://open.spotify.com/track/21HsvKIyvp2HtVIqg4LHQH?si=wZxN3WEtQtCxMd6cEFQYWw}
					if "`browse'" != "" view browse "https://open.spotify.com/track/21HsvKIyvp2HtVIqg4LHQH?si=wZxN3WEtQtCxMd6cEFQYWw"
				}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
	}
	
// End
end

// Blessings!


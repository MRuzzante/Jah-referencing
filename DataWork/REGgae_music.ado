*! version 0.1 18APR2019 Matteo Ruzzante mruzzante@worldbank.org

// Reggae music random generator

cap prog drop REGgae_music
	prog def  REGgae_music

	syntax	,									/// No variable required
												///
	   [NUMber(numlist int min=1)]				/// Number of songs (must be an interger equal or greater than 1)
	   [PLAYlist]								///
	   [PLATFORM(string)]						/// Music platform or website
	   [ARTIST(string)]							/// Name of the artist
	   [COUNTRY(string)]						/// Country of origin
	   [GENDER(string)]        					/// Gender of (one of) the singer(s)
	   
	   
	// Set minimum version for this command
	version 10
		
	if   "`playlist'" != "" {
		
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
	
	// If 'playlist' option is selected, we display the link to the Youtube playlist and exit the program
	if  "`playlist'" != "" {
		
		if "`platform'" == "Youtube" {
			
			di as txt   "Enjoy the reggae playlist for rasta Stata users in Youtube."
			di as txt   "Blessing!"
			di		    ""
			di as text `"  {browse "https://www.youtube.com/watch?v=hzqFmXZ8tOE&list=PLC-aST3UH2m5tfv3RALnUA-z753ZDYSm7":https://www.youtube.com/watch?v=hzqFmXZ8tOE&list=PLC-aST3UH2m5tfv3RALnUA-z753ZDYSm7}
			exit
		}
		
		if "`platform'" == "Spotify" {
			
			di as txt   "Enjoy the reggae playlist for rasta Stata users in Spotify."
			di as txt   "Blessing!"
			di		    ""
			di as text `"  {browse "https://open.spotify.com/user/ruzzante.matteo/playlist/100XebrUHtUthBEoaKo0Ge?si=d592jMbFRl2EDf9w0QlPLA":https://open.spotify.com/user/ruzzante.matteo/playlist/100XebrUHtUthBEoaKo0Ge?si=d592jMbFRl2EDf9w0QlPLA}
			exit
		}
	}
	
	// If 'playlist' option is selected, we display the link to the Youtube playlist and exit the program
	if  "`playlist'" != "" {
		
		di as txt   "Enjoy the reggae playlist for rasta Stata users."
		di as txt   "Blessing!"
		di		    ""
		di as text `"  {browse "https://www.youtube.com/watch?v=hzqFmXZ8tOE&list=PLC-aST3UH2m5tfv3RALnUA-z753ZDYSm7":https://www.youtube.com/watch?v=hzqFmXZ8tOE&list=PLC-aST3UH2m5tfv3RALnUA-z753ZDYSm7}
		exit
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
	if 	  "`number'"   == "" local number = 1
	
	// If 'artist' option is used, check that artist exists in our list
	local  artistList `" "Chronixx""Protoje" "Alborosie" "Gentleman" "Bob Marley" "Etana" "Junior Kelly" "Anthony B" "Kabaka Pyramid" "Sara Lugo" "'
	
	if	 "`artist'"	   != "" {
	
		if   "`artist'"    != "Chronixx"   		& ///
			 "`artist'"    != "Alborosie"  		& ///
			 "`artist'"    != "Gentleman"  		& ///
			 "`artist'"    != "Protoje"	   		& ///
			 "`artist'"    != "Bob Marley" 		& ///
			 "`artist'"	   != "Etana"			& ///
			 "`artist'"	   != "Junior Kelly"	& ///
			 "`artist'"	   != "Anthony B"		& ///
			 "`artist'"	   != "Kabaka Pyramid"  & ///
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
				 if "`artistName'" == "Bob Marley"   	local artistShortName "BobMarley"
			else if "`artistName'" == "Junior Kelly" 	local artistShortName "JuniorKelly"
			else if "`artistName'" == "Anthony B"	 	local artistShortName "AnthonyB"
			else if "`artistName'" == "Kabaka Pyramid"	local artistShortName "KabakaPyramid"
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
		
		local Chronixx 	  	= 1
		local Alborosie   	= 1
		local Gentleman   	= 1
		local Protoje 	  	= 1
		local BobMarley   	= 1
		local Etana 	  	= 1
		local JuniorKelly 	= 1
		local AnthonyB    	= 1
		local KabakaPyramid = 1
		local SaraLugo    	= 1
	}
	
	//Do the same process for countries
	local countryList Jamaica Italy Germany 
	
	if	 "`country'"	   != "" {
		
		if   "`country'"   != "Jamaica" & ///
			 "`country'"   != "Italy"   & ///
			 "`country'"   != "Germany" & {
				
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
				
				 noi di as error "The {bf:gender} you selected is not availble. Please make sure to type Female or Male in the option argument."
						   exit
		}
	}
	
	if	 "`gender'"	   != "" {
	
		foreach genderType in Female Male {
			
											local `genderType' = 0
			if "`gender'" == "`genderType'" local `genderType' = 1
		}
	}
	
	if	  "`gender'"	   == "" {
	
		foreach genderType in Female Male {
		
			local `genderType' = 1
		}
	}
	
	if	  "`gender'" == "Female" & "`country'" == "Italy" {
		
		noi di as error "We are sorry but we do not have any female reggae artist from Italy."
		noi di as error "If you like any female reggae artist from there, feel free to suggest it by opening an issue in:""
		noi di as error `" {browse "https://github.com/MRuzzante/Jah-referencing/issues":https://github.com/MRuzzante/Jah-referencing/issues}
						   exit
	}
	
	// Initialize song counter
	local  totalSong  = 26
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

		// "Who Knows"
		if `randomSong' <= `rangeMax' {
			if (`Chronixx' == 1 | `Protoje' == 1) & `Jamaica' == 1 & `Male' == 1 {
				
				di  		""
				di as txt  `""I'm pleased to be chilling in the West Indies.""'
				di as txt   " {bf:Protoje & Chronixx}"
				di as text `"  {browse "https://www.youtube.com/watch?v=hzqFmXZ8tOE":https://www.youtube.com/watch?v=hzqFmXZ8tOE}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=049km3Vc02c":https://www.youtube.com/watch?v=049km3Vc02c}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=vofff0Ei3kk":https://www.youtube.com/watch?v=vofff0Ei3kk}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=LfeIfiiBTfY":https://www.youtube.com/watch?v=LfeIfiiBTfY}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Living Dread"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Alborosie' & `Italy' & `Male' {
				
				di  		""
				di as txt  `""I and I are the living dread"'
				di as txt  `" Inna these ya dawn of the living dead.""'
				di as txt   " {bf:Alborosie}"
				di as text `"  {browse "https://www.youtube.com/watch?v=FxEubwOGzqY":https://www.youtube.com/watch?v=FxEubwOGzqY}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Kingston Town"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Alborosie' & `Italy' & `Male' {
			
				di  		""
				di as txt  `""Sipple it down down, sipple it down down."'
				di as txt  `" It's a rudeboy town, it's Kingston Town.""'
				di as txt   " {bf:Alborosie}"
				di as text `"  {browse "https://www.youtube.com/watch?v=w0c_dv0TUmU":https://www.youtube.com/watch?v=w0c_dv0TUmU}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Journey to Jah"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if (`Alborosie' == 1 | `Gentleman' == 1) & (`Italy' == 1 | `Germany' == 1) & `Male' == 1 {
				
				di  		""
				di as txt  `""Crossing border, divine is the order.""'
				di as txt   " {bf:Alborosie & Gentleman}"
				di as text `"  {browse "https://www.youtube.com/watch?v=dN8FTAx06rE":https://www.youtube.com/watch?v=dN8FTAx06rE}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Still Blazing"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Alborosie' & `Italy' & `Male' {
				
				di  		""
				di as txt  `""Don't let nobody rule your soul, no way.""'
				di as txt   " {bf:Alborosie}"
				di as text `"  {browse "https://www.youtube.com/watch?v=uA112N_meog":https://www.youtube.com/watch?v=uA112N_meog}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'

		// "No Cocaine"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Alborosie' & `Italy' & `Male' {
				
				di  		""
				di as txt  `""No coca, no coca, no coca inna mi brain""'
				di as txt  `" No coca and nuh ero inga go inna mi vein.""'
				di as txt   " {bf:Alborosie}"
				di as text `"  {browse "https://www.youtube.com/watch?v=4dYSkCVcPuc":https://www.youtube.com/watch?v=4dYSkCVcPuc}
				
				local songCount = `songCount' + 1
			}
		}

		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Herbalist"
        if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `Alborosie' & `Italy' & `Male' {
			
				di  		""
				di as txt  `""Babylon dem thief my herb dem thief my herb.""'
				di as txt   " {bf:Alborosie}"
				di as text `"  {browse "https://www.youtube.com/watch?v=MYp_gJQwRx8":https://www.youtube.com/watch?v=MYp_gJQwRx8}
				
				local songCount = `songCount' + 1
			}
        }

        local rangeMin    = `rangeMin' + `interval'
        local rangeMax    = `rangeMax' + `interval' 
		
		// "Contradiction"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if (`Alborosie' == 1 | `Chronixx' == 1) & (`Italy' == 1 | `Jamaica' == 1) & `Male' == 1{	
				
				di  		""
				di as txt  `""Contradiction global"'
				di as txt  `" Madness taking over.""'
				di as txt   " {bf:Alborosie & Chronixx}"
				di as text `"  {browse "https://www.youtube.com/watch?v=kuFI_jOSyGw":https://www.youtube.com/watch?v=kuFI_jOSyGw}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=BtzGQIDOCkM":https://www.youtube.com/watch?v=BtzGQIDOCkM}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=aktSkJ3USR4":https://www.youtube.com/watch?v=aktSkJ3USR4}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=kOFu6b3w6c0":https://www.youtube.com/watch?v=kOFu6b3w6c0}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=vdB-8eLEW8g":https://www.youtube.com/watch?v=vdB-8eLEW8g}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=HgXMoZdY5A0":https://www.youtube.com/watch?v=HgXMoZdY5A0}
				
				local songCount = `songCount' + 1
			}
		}

		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
				
		// "Unbalance"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `AnthonyB' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""Unbalance"'
				di as txt  `" You don't see that I'm unbalanced.""'
				di as txt   " {bf:Anthony B}"
				di as text `"  {browse "https://www.youtube.com/watch?v=UqeAr1gqxyU":https://www.youtube.com/watch?v=UqeAr1gqxyU}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=tSkuJJnKk7o":https://www.youtube.com/watch?v=tSkuJJnKk7o}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=jI7Y1SXPNXI":https://www.youtube.com/watch?v=jI7Y1SXPNXI}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Good Cop Bad Cop"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if `AnthonyB' & `Jamaica' & `Male' {
				
				di  		""
				di as txt  `""Tell me if love so nice.""'
				di as txt   " {bf:Junior Kelly}"
				di as text `"  {browse "https://www.youtube.com/watch?v=tSkuJJnKk7o":https://www.youtube.com/watch?v=tSkuJJnKk7o}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=yAbSe6JXOZs":https://www.youtube.com/watch?v=yAbSe6JXOZs}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=BOx3nqWBe1c":https://www.youtube.com/watch?v=BOx3nqWBe1c}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=q05liMm3LI4":https://www.youtube.com/watch?v=q05liMm3LI4}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=h8rClH-Jbno":https://www.youtube.com/watch?v=h8rClH-Jbno}
				
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
				di as text `"  {browse "https://www.youtube.com/watch?v=XDng01g3Ejw":https://www.youtube.com/watch?v=XDng01g3Ejw}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "I Really Like You"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			if (`SaraLugo' == 1 | `Protoje' == 1) & ((`Jamaica' == 1  & `Male' == 1) | (`Germany' == 1 & `Female' == 1)) {
				
				di  		""
				di as txt  `""Cos I really really like you"'
				di as txt  `""There's something about you"'
				di as txt  `" Don't you think so, too.""'
				di as txt   " {bf:Sara Lugo & Protoje}"
				di as text `"  {browse "https://www.youtube.com/watch?v=dr9OXGqR8Tg":https://www.youtube.com/watch?v=dr9OXGqR8Tg}
				
				local songCount = `songCount' + 1
			}
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
	}
	
// End
end

// Blessings!

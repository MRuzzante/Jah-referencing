*! version 0.1 9APR2019 Matteo Ruzzante mruzzante@worldbank.org

// Reggae music random generator

cap prog drop REGgae_music
	prog def  REGgae_music

	syntax	,									/// No variable required
												///
	   [NUMber(numlist int min=1)]				/// Number of songs (must be an interger equal or greater than 1)
	   [PLAYlist]								///
	   [PLATFORM(string)]						/// Music platform or website
	   [COUNTRY(string)]						/// Country of origin
	   [GENDER(string)]        					/// Gender of (one of) the singer(s)
	   
	// Set minimum version for this command
	version 10
		
	if   "`playlist'" != "" {
		if "`number'" != "" {
		
		* Error for playlist and number incorrectly used together
		noi di as error "{phang}Option number may not be used in combination with option playlist."
				  error   197
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
	
	// If 'number' option is not used, we display one song
	if 	  "`number'"   == "" local number = 1
	
	// Initialize song counter
	local  totalSong  = 25
	local  songCount  =  0
	
	// Add initial space
	di  ""
	
	
	// Randomly pick song(s)
	// ---------------------
	
	// Loop on number of songs
	while `songCount' 	 < `number'   {
		
		// Set locals for randomizing song
		local  rangeMin	 =  0
		local  interval	 =  1 		  / `totalSong'
		local  rangeMax	 = `rangeMin' + `interval'
	
		// Generate random number
		local randomSong = runiform()

		// "Who Knows"
		if `randomSong' <= `rangeMax' {
			di as txt  `""I'm pleased to be chilling in the West Indies.""'
			di as txt   " {bf:Chronixx & Protoje}"
			di as text `"  {browse "https://www.youtube.com/watch?v=hzqFmXZ8tOE":https://www.youtube.com/watch?v=hzqFmXZ8tOE}
			
			local songCount = `songCount' + 1
		}
			
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Skankin' Sweet"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Skankin' sweet"'
			di as txt  `" Everybody wanna feel irie.""'
			di as txt   " {bf:Chronixx}"
			di as text `"  {browse "https://www.youtube.com/watch?v=049km3Vc02c":https://www.youtube.com/watch?v=049km3Vc02c}
			
			local songCount = `songCount' + 1
		}	
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Smile Jamaica"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Smile girl smile"'
			di as txt  `" Smile for me Jamaica.""'
			di as txt   " {bf:Chronixx}"
			di as text `"  {browse "https://www.youtube.com/watch?v=vofff0Ei3kk":https://www.youtube.com/watch?v=vofff0Ei3kk}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Here Comes Trouble"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Welcome the savior"'
			di as txt  `" Welcome the rasta youths.""'
			di as txt   " {bf:Chronixx}"
			di as text `"  {browse "https://www.youtube.com/watch?v=LfeIfiiBTfY":https://www.youtube.com/watch?v=LfeIfiiBTfY}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Living Dread"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""I and I are the living dread"'
			di as txt  `" Inna these ya dawn of the living dead.""'
			di as txt   " {bf:Alborosie}"
			di as text `"  {browse "https://www.youtube.com/watch?v=FxEubwOGzqY":https://www.youtube.com/watch?v=FxEubwOGzqY}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Kingston Town"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Sipple it down down, sipple it down down."'
			di as txt  `" It's a rudeboy town, it's Kingston Town.""'
			di as txt   " {bf:Alborosie}"
			di as text `"  {browse "https://www.youtube.com/watch?v=w0c_dv0TUmU":https://www.youtube.com/watch?v=w0c_dv0TUmU}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Journey to Jah"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Crossing border, divine is the order.""'
			di as txt   " {bf:Alborosie & Gentleman}"
			di as text `"  {browse "https://www.youtube.com/watch?v=dN8FTAx06rE":https://www.youtube.com/watch?v=dN8FTAx06rE}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Still Blazing"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Don't let nobody rule your soul, no way.""'
			di as txt   " {bf:Alborosie}"
			di as text `"  {browse "https://www.youtube.com/watch?v=uA112N_meog":https://www.youtube.com/watch?v=uA112N_meog}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'

		// "No Cocaine"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""No coca, no coca, no coca inna mi brain""'
			di as txt  `" No coca and nuh ero inga go inna mi vein.""'
			di as txt   " {bf:Alborosie}"
			di as text `"  {browse "https://www.youtube.com/watch?v=4dYSkCVcPuc":https://www.youtube.com/watch?v=4dYSkCVcPuc}
			
			local songCount = `songCount' + 1
		}

		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'

		// "Contradiction"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Contradiction global"'
			di as txt  `" Madness taking over.""'
			di as txt   " {bf:Alborosie & Chronixx}"
			di as text `"  {browse "https://www.youtube.com/watch?v=kuFI_jOSyGw":https://www.youtube.com/watch?v=kuFI_jOSyGw}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Intoxication"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Joy ina your eyes me nuh see no tears"'
			di as txt  `" Love is what you giving me troughout the years.""'
			di as txt   " {bf:Gentleman}"
			di as text `"  {browse "https://www.youtube.com/watch?v=BtzGQIDOCkM":https://www.youtube.com/watch?v=BtzGQIDOCkM}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'

		// "Red Town"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""The destination is freedom from stress"'
			di as txt  `" That's the getaway.""'
			di as txt   " {bf:Gentleman}"
			di as text `"  {browse "https://www.youtube.com/watch?v=aktSkJ3USR4":https://www.youtube.com/watch?v=aktSkJ3USR4}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Redemption Song"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Emancipate yourselves from mental slavery"'
			di as txt  `" None but ourselves can free our minds.""'
			di as txt   " {bf:Bob Marley}"
			di as text `"  {browse "https://www.youtube.com/watch?v=kOFu6b3w6c0":https://www.youtube.com/watch?v=kOFu6b3w6c0}
			
			local songCount = `songCount' + 1
		}

		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "One Love"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Let's get together and feel all right.""'
			di as txt   " {bf:Bob Marley}"
			di as text `"  {browse "https://www.youtube.com/watch?v=vdB-8eLEW8g":https://www.youtube.com/watch?v=vdB-8eLEW8g}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Iron Lion Zion"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""I had to run like a fugitive just to save the life I live"'
			di as txt  `" I'm gonna be Iron like a Lion in Zion.""'
			di as txt   " {bf:Bob Marley}"
			di as text `"  {browse "https://www.youtube.com/watch?v=HgXMoZdY5A0":https://www.youtube.com/watch?v=HgXMoZdY5A0}
			
			local songCount = `songCount' + 1
		}

		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
				
		// "Unbalance"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Unbalance"'
			di as txt  `" You don't see that I'm unbalanced.""'
			di as txt   " {bf:Anthony B}"
			di as text `"  {browse "https://www.youtube.com/watch?v=UqeAr1gqxyU":https://www.youtube.com/watch?v=UqeAr1gqxyU}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
					
		// "If Love So Nice"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Tell me if love so nice.""'
			di as txt   " {bf:Junior Kelly}"
			di as text `"  {browse "https://www.youtube.com/watch?v=tSkuJJnKk7o":https://www.youtube.com/watch?v=tSkuJJnKk7o}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "I Am Not Afraid"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""If dem a come let them come 'cause I am protected by the most one.""'
			di as txt   " {bf:Etana}"
			di as text `"  {browse "https://www.youtube.com/watch?v=jI7Y1SXPNXI":https://www.youtube.com/watch?v=jI7Y1SXPNXI}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Good Cop Bad Cop"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Tell me if love so nice.""'
			di as txt   " {bf:Junior Kelly}"
			di as text `"  {browse "https://www.youtube.com/watch?v=tSkuJJnKk7o":https://www.youtube.com/watch?v=tSkuJJnKk7o}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Make Way"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Mi go say"'
			di as txt  `" Make way"'
			di as txt  `" Rastaman bursting through your gateway.""'
			di as txt   " {bf:Kabaka Pyramid}"
			di as text `"  {browse "https://www.youtube.com/watch?v=yAbSe6JXOZs":https://www.youtube.com/watch?v=yAbSe6JXOZs}
			
			local songCount = `songCount' + 1			
		}

		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'

		// "Can't Breathe"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Me say me cyaan breathe"'
			di as txt  `" Inna this yah suffocation"'
			di as txt  `" The people living inna sufferation.""'
			di as txt   " {bf:Kabaka Pyramid}"
			di as text `"  {browse "https://www.youtube.com/watch?v=BOx3nqWBe1c":https://www.youtube.com/watch?v=BOx3nqWBe1c}
			
			local songCount = `songCount' + 1
		}

		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Reggae Music"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Well, if the music sounds sweet and the people dem a dance"'
			di as txt  `" A must the reggae music, nothing else no have a chance.""'
			di as txt   " {bf:Kabaka Pyramid}"
			di as text `"  {browse "https://www.youtube.com/watch?v=q05liMm3LI4":https://www.youtube.com/watch?v=q05liMm3LI4}
			
			local songCount = `songCount' + 1	
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "Well Done"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Well done, well done, Mr. Politician Man"'
			di as txt  `" You done a wonderful job a tear down we country, demolition man.""'
			di as txt   " {bf:Kabaka Pyramid}"
			di as text `"  {browse "https://www.youtube.com/watch?v=h8rClH-Jbno":https://www.youtube.com/watch?v=h8rClH-Jbno}
			
			local songCount = `songCount' + 1

		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "High & Windy"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Riding on a high and windy day"'
			di as txt  `" Riding my troubles away.""'
			di as txt   " {bf:Sara Lugo & Kabaka Pyramid}"
			di as text `"  {browse "https://www.youtube.com/watch?v=XDng01g3Ejw":https://www.youtube.com/watch?v=XDng01g3Ejw}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// "I Really Like You"
		if `randomSong' > `rangeMin' & `randomSong' <= `rangeMax' {
			di as txt  `""Cos I really really like you"'
			di as txt  `""There's something about you"'
			di as txt  `" Don't you think so, too.""'
			di as txt   " {bf:Sara Lugo & Protoje}"
			di as text `"  {browse "https://www.youtube.com/watch?v=dr9OXGqR8Tg":https://www.youtube.com/watch?v=dr9OXGqR8Tg}
			
			local songCount = `songCount' + 1
		}
		
		local rangeMin	= `rangeMin' + `interval'
		local rangeMax	= `rangeMax' + `interval'
		
		// Add final space
		di	""

	}
	
// End
end

// Blessings!

# NEW stasiek_selldrugsv2 VERSION HERE
https://github.com/xxxstasiek/stasiek_selldrugsv2

# OLD stasiek_selldrugsv1
[ESX stasiek_selldrugs] Sell Drugs to NPC +dispatch NEW!
It’s 100% WORKING with ESX! Plugin has been created by Stasiek, witch allows player to sell drugs to npc/ped! + police/cops call/dispatch
I would be proud if you send me your language translation!

Waiting for your opinion and feedback guys! :slight_smile: Greetings from poland!
Sorry for my english.

# Installation
1. put 'stasiek_selldrugs' to your 'resources' folder
2. add line 'start stasiek_selldrugs' in your server.cfg and save it
3. restart server

# Requirements
1. [esx_drugs](https://forum.fivem.net/t/release-esx-drugs/42637)
2. [esx_policejob](https://forum.fivem.net/t/release-esx-police-job/41559)

# About
1. You can edit this variables in config.lua 

	Config.Locale = 'en'    -- your language, It would be nice if you send me your translation on fivem forum
	
	Config.TimeToSell = 10  -- how many seconds player have to wait/stand near ped
	
	Config.CallCops = true  -- if true and if ped reject your offer then there is [Config.CallCopsPercent]% to call cops
	
	Config.CopsRequiredToSell = 1 -- required cops on server to sell drugs
	
	Config.CallCopsPercent = 1 -- (min1) if 1 cops will be called every time=100%, 2=50%, 3=33%, 4=25%, 5=20%
	
	Config.PedRejectPercent = 1 -- (min1) if 1 ped reject offer=100%, 2=50%, 3=33%, 4=25%, 5=20%
	
	Config.SellPooch = true -- if true, players can sell pooch like weed_pooch, meth_pooch
	
	Config.SellSingle = true -- if true, players can sell single item like weed, meth	
	
	Config.SellWeed = true	-- if true, players can sell weed
	
	Config.SellMeth = true	-- if true, players can sell meth
	
	Config.SellCoke = true	-- if true, players can sell coke
	
	Config.SellOpiu = true	-- if true, players can sell opium
	
	Config.WeedPrice = 50	-- sell price for single, not pooch(black money)
	
	Config.MethPrice = 70	-- sell price for single, not pooch (black money)
	
	Config.CokePrice = 90	-- sell price for single, not pooch (black money)
	
	Config.OpiuPrice = 110	-- sell price for single, not pooch (black money)
	
	Config.DistanceFromCity = 10000 -- set distance that player cant sell drugs too far from city
	
	Config.CityPoint = {x= -255.94, y= -983.93, z= 30.21}

2. You can edit 'locales/en.lua' to your language and send it to fivem forum on my topic

3. In 'server/main.lua' at line 77 and 82  and in 'client/main.lua' in line 242 and 244 there's a lines you should change to your language!

4. You have to have weed_pooch or meth_pooch or coke_pooch or opium_pooch in your inventory and in your database in 'items' 

My plugin is based on 'onlyserenity/drugsToNPCs' and 'nynjardin/outlawalert'

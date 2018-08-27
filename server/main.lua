ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sell:sellDrugs')
AddEventHandler('sell:sellDrugs', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local weedqty = xPlayer.getInventoryItem('weed_pooch').count
	local weedqtySingle = xPlayer.getInventoryItem('weed').count
	local methqty = xPlayer.getInventoryItem('meth_pooch').count
	local methqtySingle = xPlayer.getInventoryItem('meth').count
	local cokeqty = xPlayer.getInventoryItem('coke_pooch').count
	local cokeqtySingle = xPlayer.getInventoryItem('coke').count
	local opiuqty = xPlayer.getInventoryItem('opium_pooch').count
	local opiuqtySingle = xPlayer.getInventoryItem('opium').count
	local payment = math.random(100,300)
	local x = 0
	local blackMoney = 0
	local drugType
	
	if Config.SellWeed then
		if weedqty > 0 and Config.SellPooch then
		drugType = "weedpooch"
			if weedqty == 1 then
				x = 1
			elseif weedqty == 2 then
				x = math.random(1,2)
			elseif weedqty == 3 then
				x = math.random(1,3)
			elseif weedqty == 4 then
				x = math.random(1,4)
			elseif weedqty >= 5 then
				x = math.random(1,5)
			end
		xPlayer.removeInventoryItem('weed_pooch', x)
		elseif weedqtySingle > 0 and Config.SellSingle then
		drugType = "weed"
			if weedqtySingle == 1 then
				x = 1
			elseif weedqtySingle == 2 then
				x = math.random(1,2)
			elseif weedqtySingle == 3 then
				x = math.random(1,3)
			elseif weedqtySingle == 4 then
				x = math.random(1,4)
			elseif weedqtySingle >= 5 then
				x = math.random(1,5)
			end
		xPlayer.removeInventoryItem('weed', x)
		end
	elseif Config.SellMeth then
			if methqty > 0 and Config.SellPooch then
		drugType = "methpooch"
			if methqty == 1 then
				x = 1
			elseif methqty == 2 then
				x = math.random(1,2)
			elseif methqty == 3 then
				x = math.random(1,3)
			elseif methqty == 4 then
				x = math.random(1,4)
			elseif methqty >= 5 then
				x = math.random(1,5)
			end
		xPlayer.removeInventoryItem('weed_pooch', x)
		elseif methqtySingle > 0 and Config.SellSingle then
		drugType = "meth"
			if methqtySingle == 1 then
				x = 1
			elseif methqtySingle == 2 then
				x = math.random(1,2)
			elseif methqtySingle == 3 then
				x = math.random(1,3)
			elseif methqtySingle == 4 then
				x = math.random(1,4)
			elseif methqtySingle >= 5 then
				x = math.random(1,5)
			end
		xPlayer.removeInventoryItem('meth', x)
		end
	elseif Config.SellCoke then
			if cokeqty > 0 and Config.SellPooch then
		drugType = "cokepooch"
			if cokeqty == 1 then
				x = 1
			elseif cokeqty == 2 then
				x = math.random(1,2)
			elseif cokeqty == 3 then
				x = math.random(1,3)
			elseif cokeqty == 4 then
				x = math.random(1,4)
			elseif cokeqty >= 5 then
				x = math.random(1,5)
			end
		xPlayer.removeInventoryItem('coke_pooch', x)
		elseif cokeqtySingle > 0 and Config.SellSingle then
		drugType = "coke"
			if cokeqtySingle == 1 then
				x = 1
			elseif cokeqtySingle == 2 then
				x = math.random(1,2)
			elseif cokeqtySingle == 3 then
				x = math.random(1,3)
			elseif cokeqtySingle == 4 then
				x = math.random(1,4)
			elseif cokeqtySingle >= 5 then
				x = math.random(1,5)
			end
		xPlayer.removeInventoryItem('coke', x)
		end
	elseif Config.SellOpiu then
			if opiuqty > 0 and Config.SellPooch then
		drugType = "opiumpooch"
			if opiuqty == 1 then
				x = 1
			elseif opiuqty == 2 then
				x = math.random(1,2)
			elseif opiuqty == 3 then
				x = math.random(1,3)
			elseif opiuqty == 4 then
				x = math.random(1,4)
			elseif opiuqty >= 5 then
				x = math.random(1,5)
			end
		xPlayer.removeInventoryItem('opium_pooch', x)
		elseif opiuqtySingle > 0 and Config.SellSingle then
		drugType = "opium"
			if opiuqtySingle == 1 then
				x = 1
			elseif opiuqtySingle == 2 then
				x = math.random(1,2)
			elseif opiuqtySingle == 3 then
				x = math.random(1,3)
			elseif opiuqtySingle == 4 then
				x = math.random(1,4)
			elseif opiuqtySingle >= 5 then
				x = math.random(1,5)
			end
		xPlayer.removeInventoryItem('opium', x)
		end
	end
	
	blackMoney = payment * x
	xPlayer.addAccountMoney('black_money', blackMoney)
	TriggerClientEvent('showSellInfo', _source, x, blackMoney, drugType)
	TriggerClientEvent('sold', _source)
end)


RegisterServerEvent('sell:check')
AddEventHandler('sell:check', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local weedqty = xPlayer.getInventoryItem('weed_pooch').count
	local weedqtySingle = xPlayer.getInventoryItem('weed').count
	local methqty = xPlayer.getInventoryItem('meth_pooch').count
	local methqtySingle = xPlayer.getInventoryItem('meth').count
	local cokeqty = xPlayer.getInventoryItem('coke_pooch').count
	local cokeqtySingle = xPlayer.getInventoryItem('coke').count
	local opiuqty = xPlayer.getInventoryItem('opium_pooch').count
	local opiuqtySingle = xPlayer.getInventoryItem('opium').count
	
	if Config.SellPooch or Config.SellSingle then
		if Config.SellWeed then
			if weedqty > 0 or weedqtySingle > 0 then
				TriggerClientEvent('playerhasdrugs', _source)
			end
		elseif Config.SellMeth then
			if methqty > 0 or methqtySingle > 0 then
				TriggerClientEvent('playerhasdrugs', _source)
			end
		elseif Config.SellCoke then
			if cokeqty > 0 or cokeqtySingle > 0 then
				TriggerClientEvent('playerhasdrugs', _source)
			end
		elseif Config.SellOpiu then
			if opiuqty > 0 or opiuqtySingle > 0 then
				TriggerClientEvent('playerhasdrugs', _source)
			end
		end
	end
end)


RegisterServerEvent('drugsNotify')
AddEventHandler('drugsNotify', function()
	TriggerClientEvent("drugsEnable", source)
end)

--if you need you can translate it to your language
RegisterServerEvent('drugsInProgress')
AddEventHandler('drugsInProgress', function(street1, street2, sex)
      --TriggerClientEvent("outlawNotify", -1, "~r~Selling drugs by ~w~"..sex.."~r~near~w~"..street1.."~r~ and ~w~"..street2)
	TriggerClientEvent("outlawNotify", -1, "~r~Sprzedarz dragów przez ~w~"..sex.." ~r~między ~w~"..street1.."~r~ a ~w~"..street2)
end)
--if you need you can translate it to your language too
RegisterServerEvent('drugsInProgressS1')
AddEventHandler('drugsInProgressS1', function(street1, sex)
      --TriggerClientEvent("outlawNotify", -1, "~r~Selling drugs by ~w~"..sex.."~r~near~w~"..street1)
	TriggerClientEvent("outlawNotify", -1, "~r~Sprzedarz dragów przez ~w~"..sex.." ~r~przy ulicy ~w~"..street1)
end)

RegisterServerEvent('drugsInProgressPos')
AddEventHandler('drugsInProgressPos', function(gx, gy, gz)
	TriggerClientEvent('drugsPlace', -1, gx, gy, gz)
end)

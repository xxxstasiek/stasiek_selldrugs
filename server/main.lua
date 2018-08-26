ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('sell:sellDrugs')
AddEventHandler('sell:sellDrugs', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local weedqty = xPlayer.getInventoryItem('weed_pooch').count
	local methqty = xPlayer.getInventoryItem('meth_pooch').count
	local payment = math.random(100,300)
	local x = 0
	local blackMoney = 0
	local itsWeed = false
	
	if weedqty > 0 then
	itsWeed = true
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
	elseif methqty > 0 then
	itsWeed = false
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
	xPlayer.removeInventoryItem('meth_pooch', x)
	end
	
	if weedqty == 0 and methqty == 0 then
		TriggerClientEvent('nomoredrugs', _source)
	end
	blackMoney = payment * x
	xPlayer.addAccountMoney('black_money', blackMoney)
	TriggerClientEvent('showSellInfo', _source, x, blackMoney, itsWeed)
	TriggerClientEvent('sold', _source)
end)


RegisterServerEvent('sell:check')
AddEventHandler('sell:check', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local weedqty = xPlayer.getInventoryItem('weed_pooch').count
	local methqty = xPlayer.getInventoryItem('meth_pooch').count
		
	if weedqty > 0 or methqty > 0 then
		TriggerClientEvent('playerhasdrugs', _source)	
	end
end)


RegisterServerEvent('drugsNotify')
AddEventHandler('drugsNotify', function()
	TriggerClientEvent("drugsEnableDispatch", source)
end)

--if you need you can translate it to your language
RegisterServerEvent('drugsInProgress')
AddEventHandler('drugsInProgress', function(street1, street2, sex)
	TriggerClientEvent("outlawNotify", -1, "~r~Sprzedarz dragów przez ~w~"..sex.." ~r~między ~w~"..street1.."~r~ a ~w~"..street2)
end)
--if you need you can translate it to your language too
RegisterServerEvent('drugsInProgressS1')
AddEventHandler('drugsInProgressS1', function(street1, sex)
	TriggerClientEvent("outlawNotify", -1, "~r~Sprzedarz dragów przez ~w~"..sex.." ~r~przy ulicy ~w~"..street1)
end)

RegisterServerEvent('drugsInProgressPos')
AddEventHandler('drugsInProgressPos', function(gx, gy, gz)
	TriggerClientEvent('drugsPlace', -1, gx, gy, gz)
end)
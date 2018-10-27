ESX = nil
local selling = false
local secondsRemaining
local sold = false
local playerHasDrugs = false
local pedIsTryingToSellDrugs = false
local PlayerData		= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

--TIME TO SELL
Citizen.CreateThread(function()
	while true do
		if selling then
			if secondsRemaining > 0 then
				secondsRemaining = secondsRemaining - 1
				ESX.ShowNotification(_U('remained') .. secondsRemaining .. 's')
			end
			Citizen.Wait(1000)
		end
		Citizen.Wait(100)
	end
end)

currentped = nil
Citizen.CreateThread(function()
	while true do
		Wait(10)
		local player = GetPlayerPed(-1)
		local pid = PlayerPedId()
  		local playerloc = GetEntityCoords(player, 0)
		local handle, ped = FindFirstPed()
		local success
		repeat
		    success, ped = FindNextPed(handle)
		   	local pos = GetEntityCoords(ped)
	 		local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
			local distanceFromCity = GetDistanceBetweenCoords(Config.CityPoint.x, Config.CityPoint.y, Config.CityPoint.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
			if IsPedInAnyVehicle(GetPlayerPed(-1)) == false then
				if DoesEntityExist(ped)then
					if IsPedDeadOrDying(ped) == false then
						if IsPedInAnyVehicle(ped) == false then
							local pedType = GetPedType(ped)
							if pedType ~= 28 and IsPedAPlayer(ped) == false then
								currentped = pos
								if distance <= 3 and ped  ~= GetPlayerPed(-1) and ped ~= oldped and IsControlJustPressed(1, 38) then
									TriggerServerEvent('check')
									if distanceFromCity < Config.DistanceFromCity then
										if playerHasDrugs and sold == false and selling == false then 
											--PED REJECT OFFER
											local random = math.random(1, Config.PedRejectPercent)
											if random == Config.PedRejectPercent then
												ESX.ShowNotification(_U('reject'))
												oldped = ped
												--PED CALLING COPS
												if Config.CallCops then
													local randomReport = math.random(1, Config.CallCopsPercent)
													print(Config.CallCopsPercent)
													if randomReport == Config.CallCopsPercent then
														TriggerServerEvent('drugsNotify')
													end
												end
												TriggerEvent("sold")
											--PED ACCEPT OFFER
											else
												SetEntityAsMissionEntity(ped)
												ClearPedTasks(ped)
												FreezeEntityPosition(ped,true)
												oldped = ped										
												TaskStandStill(ped, 9)
												pos1 = GetEntityCoords(ped)
												TriggerEvent("sellingdrugs")
											end
										end
									else
										ESX.ShowNotification(_U('too_far_away_from_city'))
									end
								end
							end
						end
					end
				end
			end
		until not success

		EndFindPed(handle)
	end	
end)

Citizen.CreateThread(function()
	while true do
		Wait(100)
		if selling then
			local player = GetPlayerPed(-1)
  			local playerloc = GetEntityCoords(player, 0)
			local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
			local pid = PlayerPedId()
			--TOO FAR
			if distance > 5 then
				ESX.ShowNotification(_U('too_far_away'))
				selling = false
				SetEntityAsMissionEntity(oldped)
				SetPedAsNoLongerNeeded(oldped)
				FreezeEntityPosition(oldped,false)
			end
			--SUCCESS
			if secondsRemaining <= 1 then
				selling = false
				SetEntityAsMissionEntity(oldped)
				SetPedAsNoLongerNeeded(oldped)
				FreezeEntityPosition(oldped,false)
				StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
				playerHasDrugs = false
				sold = false
				TriggerServerEvent('sellDrugs')
			end	
			
			if secondsRemaining == 5 and Config.PlayAnimation then
				Citizen.Wait(1100) 
				RequestAnimDict("amb@prop_human_bum_bin@idle_b")
				while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do 
					Citizen.Wait(0) 
				end
				TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
			end
		end	
	end
end)	
		
RegisterNetEvent('sellingdrugs')
AddEventHandler('sellingdrugs', function()
	secondsRemaining = Config.TimeToSell + 1
	selling = true
end)

RegisterNetEvent('sold')
AddEventHandler('sold', function()
	sold = false
	selling = false
	secondsRemaining = 0
end)

--Info that you dont have drugs
RegisterNetEvent('nomoredrugs')
AddEventHandler('nomoredrugs', function()
	ESX.ShowNotification(_U('no_more_drugs'))
	playerHasDrugs = false
	sold = false
	selling = false
	secondsRemaining = 0
end)

--Show help notification ("PRESS E...")
RegisterNetEvent('playerhasdrugs')
AddEventHandler('playerhasdrugs', function()
	ESX.ShowHelpNotification(_U('input'))
	playerHasDrugs = true
end)

--DISPATCH BEGIN (better do not touch)
--Only if Config.CallCops = true
GetPlayerName()
RegisterNetEvent('outlawNotify')
AddEventHandler('outlawNotify', function(alert)
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
            Notify(alert)
        end
end)

function Notify(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentString(text)
    DrawNotification(false, false)
end


--Config
local timer = 1 --in minutes - Set the time during the player is outlaw
local showOutlaw = true --Set if show outlaw act on map
local blipTime = 25 --in second
local showcopsmisbehave = true --show notification when cops steal too
--End config

local timing = timer * 60000 --Don't touche it

Citizen.CreateThread(function()
    while true do
        Wait(100)
        if NetworkIsSessionStarted() then
            DecorRegister("IsOutlaw",  3)
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
            return
        end
    end
end)

Citizen.CreateThread( function()
    while true do
        Wait(100)
        local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
        local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        local street1 = GetStreetNameFromHashKey(s1)
        local street2 = GetStreetNameFromHashKey(s2)
        if pedIsTryingToSellDrugs then
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 2)
			if PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave == false then
			elseif PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local sex = nil
					if skin.sex == 0 then
						sex = "mężczyznę" --male/change it to your language
					else
						sex = "kobietę" --female/change it to your language
					end
					TriggerServerEvent('drugsInProgressPos', plyPos.x, plyPos.y, plyPos.z)
					if s2 == 0 then
						TriggerServerEvent('drugsInProgressS1', street1, sex)
					elseif s2 ~= 0 then
						TriggerServerEvent('drugsInProgress', street1, street2, sex)
					end
				end)
				Wait(3000)
				pedIsTryingToSellDrugs = false
			else
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local sex = nil
					if skin.sex == 0 then
						sex = "mężczyznę"
					else
						sex = "kobietę"
					end
					TriggerServerEvent('drugsInProgressPos', plyPos.x, plyPos.y, plyPos.z)
					if s2 == 0 then
						TriggerServerEvent('drugsInProgressS1', street1, sex)
					elseif s2 ~= 0 then
						TriggerServerEvent('drugsInProgress', street1, street2, sex)
					end
				end)
				Wait(3000)
				pedIsTryingToSellDrugs = false
			end
        end
    end
end)

RegisterNetEvent('drugsPlace')
AddEventHandler('drugsPlace', function(tx, ty, tz)
	if PlayerData.job.name == 'police' then
		local transT = 250
		local Blip = AddBlipForCoord(tx, ty, tz)
		SetBlipSprite(Blip,  10)
		SetBlipColour(Blip,  1)
		SetBlipAlpha(Blip,  transT)
		SetBlipAsShortRange(Blip,  false)
		while transT ~= 0 do
			Wait(blipTime * 4)
			transT = transT - 1
			SetBlipAlpha(Blip,  transT)
			if transT == 0 then
				SetBlipSprite(Blip,  2)
				return
			end
		end
	end
end)


RegisterNetEvent('drugsEnable')
AddEventHandler('drugsEnable', function()
	pedIsTryingToSellDrugs = true
end)
--DISPATCH END

Citizen.CreateThread(function()

	local Surrender = false;
	local NoWep = GetHashKey("WEAPON_UNARMED");
	local WeaponDropped = false;

	while true do
		local PID = PlayerId()
		local Player = GetPlayerPed(PID)
	
		Citizen.Wait(0)
		RequestAnimDict("missminuteman_1ig_2")
		if IsControlPressed(1, 323) then
			DisableControlAction(1, 37, true) -- Disable weapon wheel
			DisableControlAction(1, 142, true) -- Disable punching
			DisableControlAction(1, 25, true) -- Disable ads
			DisablePlayerFiring(Player, true) -- Disable firing
			DisableControlAction(1, 106, true) --Don't disarm for Car
			DisableControlAction(1, 23, true)  -- F	
			if DoesEntityExist(Player) then
				while not HasAnimDictLoaded("missminuteman_1ig_2") do
					Citizen.Wait(1)
				end
			
				if not Surrender and IsPedOnFoot(Player) then
					Surrender = true
					Gun = GetSelectedPedWeapon(Player)
					TaskPlayAnim(Player, "missminuteman_1ig_2", "handsup_base", 1.0, -8, -1, 50, 0, 0, 0, 0)
						if Gun ~= NoWep then
							SetPedDropsInventoryWeapon(Player, Gun, 0, -2.5, 1, 0)
							GiveWeaponToPed(Player, NoWep, 0, 0, 1)
						end
				end
			end
		end
	

		if IsControlReleased(1, 323) then
			if DoesEntityExist(Player) then
				RequestAnimDict("missminuteman_1ig_2")
					while not HasAnimDictLoaded("missminuteman_1ig_2") do
						Citizen.Wait(100)
					end
				if Surrender then
					Surrender = false
					TaskPlayAnim(Player, "missminuteman_1ig_2", "handsup_base", 1.0, -8, -1, 32, 0, 0, 0, 0)
					ClearPedSecondaryTask(Player)  
				end
			end
		end
	end
end)
--==< Master Thread >==--

Citizen.CreateThread(function()
    while ( true ) do Citizen.Wait(0)
    -- Search for vehicles within proximity --
    local ClosestVehicle, Offset, Index = Zea:VehicleDetection()
    -- If a vehicle has been found and the client is not seated within a vehicle proceed --
    if ( ClosestVehicle and GetVehiclePedIsIn(PlayerPedId(), false) == 0 and Zea:WeaponWhitelist() == true ) then
        -- DrawText to notify the player of the tyres detection --
        Zea:DrawText(Offset.x, Offset.y, Offset.z + 0.6, '~g~E~s~ - ' .. Settings.Translation)
        -- If player inputs [E] then proceed --
        if ( IsControlJustPressed(1, 38) ) then
            -- Burst vehicles specified index tyre --
            Zea:AnimDictionary("Player_Slash") SetVehicleTyreBurst(ClosestVehicle, Index, 0, 100.0)
        end
      end
    end
 end)

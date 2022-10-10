Zea = {}

-- List of all registered entity bones which are tires --
TyreBones = {'wheel_rm1'; 'wheel_rm2'; 'wheel_rm3'; 'wheel_lm1'; 'wheel_lm2'; 'wheel_lf'; 'wheel_lr'; 'wheel_rf'; 'wheel_rr'}
TyreIndex = {["wheel_lf"] = 0; ["wheel_rf"] = 1; ["wheel_lm1"] = 2; ["wheel_rm1"] = 3; ["wheel_lm2"] = 45; ["wheel_rm2"] = 47; ["wheel_lm3"] = 46; ["wheel_rm3"] = 48; ["wheel_lr"] = 4; ["wheel_rr"] = 5}

--==< VehicleDetection >==--

function Zea:VehicleDetection()
  -- Project raycast infront of client and return result --
  local rayHandle = CastRayPointToPoint(GetEntityCoords(GetPlayerPed(-1)), GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, Settings.Vehicle_DetectionDistance, 0.0), 10, GetPlayerPed(-1), 0)
  -- Check raycast result for vehicle handles --
  local _, _, _, _, vehicleHandle = GetRaycastResult(rayHandle)
  -- Read TyreBones table --
  for __ , Data in ipairs(TyreBones) do
    -- Locate closest TyreBones on local vehicle --
    local TyreOffset = GetWorldPositionOfEntityBone(vehicleHandle, GetEntityBoneIndexByName(vehicleHandle, Data))
    -- Compare distance between client and tyre bone --
    local VectorComparison = #(GetEntityCoords(GetPlayerPed(-1)) - TyreOffset)
    -- Send tyre index to master thread --
    local Index = TyreIndex[Data]
    -- If client is within specified distance to the tyre then return the cloestvehicle, TyreOffset and the TyreIndex to the masterthread --
    if ( VectorComparison <= Settings.Tyre_DetectionDistance ) then return ( vehicleHandle ), TyreOffset, Index
    end
  end
end

--==< WeaponWhitelist >==--

function Zea:WeaponWhitelist()
  -- Read Weapon Whitelist Table --
  for Data = 1, #Weapons do
    -- If player is currently holding a whitelisted weapon return true --
    if ( GetHashKey(Weapons[Data]) == GetSelectedPedWeapon(GetPlayerPed(-1)) ) then return ( true )
    -- If player is not holding a whitelisted weapon return false --
    end
  end
  return ( false )
end

--==< AnimDictionary >==--

function Zea:AnimDictionary(Type)
  if ( Type == "Player_Slash" ) then
    while ( not HasAnimDictLoaded(Settings.Animation.AnimationDic) ) do RequestAnimDict(Settings.Animation.AnimationDic) Citizen.Wait(4) end
    TaskPlayAnim(PlayerPedId(), Settings.Animation.AnimationDic, Settings.Animation.AnimationName, 2.0, 2.0, 500, 1, 0, false, false, false) Citizen.Wait(300)
    StopAnimTask(PlayerPedId(), Settings.Animation.AnimationDic, Settings.Animation.AnimationName, 1.0)
  end
end

--==< WeaponWhitelist >==--

function Zea:DrawText(x, y, z, Text)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
  local scale = (1/dist)*10*(1/GetGameplayCamFov())*100
  SetTextScale(0.1*scale, 0.1*scale)
  SetTextFont(4)
  SetTextProportional(1)
  SetTextColour(250, 250, 250, 255)
  SetTextDropshadow(1, 1, 1, 1, 255)
  SetTextEdge(2, 0, 0, 0, 150)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  SetTextCentre(1)
  AddTextComponentString(Text)
  SetDrawOrigin(x,y,z, 0)
  DrawText(0.0, 0.0)
  ClearDrawOrigin()
end

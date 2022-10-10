
-- << Whitelisted Melee Weapons >> --

Weapons = {

  "WEAPON_KNIFE";
  "WEAPON_SWITCHBLADE";

};

-- << Misc Settings >> --

Settings = {

  Vehicle_DetectionDistance = 5.0; -- << Distance between player and closest vehicle >> --
  Tyre_DetectionDistance = 1.5;    -- << Distance where the client is able to slash the vehicles tyre >> --

  Translation = "Slash";           -- << Text which displayed when client is within the slash proximity >> --

  -- << Animation Settings >> --

  Animation = {

    AnimationDic = "melee@knife@streamed_core_fps";
    AnimationName = "ground_attack_on_spot";

}}
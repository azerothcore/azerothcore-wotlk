-- DB update 2025_06_08_03 -> 2025_06_08_04
-- Blackrock Mountain - Searing Gorge Instance?
UPDATE `areatrigger_teleport` SET `Name` = "Blackrock Depths Entrance", `target_position_x` = 456.929, `target_position_y` = 34.0923, `target_position_z` = -68.0896, `target_orientation` = 4.712389 WHERE `ID` = 1466;

-- The Molten Bridge | The Molten Core Window Entrance | The Molten Core Window(Lava) Entrance
UPDATE `areatrigger_teleport` SET `target_position_x` = 1091.89, `target_position_y` = -466.985, `target_position_z` = -105.084, `target_orientation` = 3.1415927 WHERE `ID` IN (2886, 3528, 3529);

-- Molten Core Entrance, Inside
UPDATE `areatrigger_teleport` SET `Name` = "The Molten Core, Exit (from inside of the Instance)", `target_position_x` = -7508.32, `target_position_y` = -1039.74, `target_position_z` = 180.912, `target_orientation` = 3.8397243 WHERE `ID` = 2890;

-- Blackrock Spire, Unknown
UPDATE `areatrigger_teleport` SET `Name` = "Blackrock Spire, Exit (from inside of Blackwing Lair Instance)" WHERE `ID` = 3728;

-- Blackrock Spire - Searing Gorge Instance
UPDATE `areatrigger_teleport` SET `Name` = "Blackrock Spire Entrance", `target_position_x` = -7524.65, `target_position_y` = -1229.13, `target_position_z` = 285.731, `target_orientation` = 2.0943952 WHERE `ID` = 1470;

-- Maraudon
UPDATE `areatrigger_teleport` SET `Name` = "Maraudon, The Wicked Grotto [Purple Wing] (Exit)" WHERE `ID` = 3126;
UPDATE `areatrigger_teleport` SET `Name` = "Maraudon, Foulspore Cavern [Orange Wing] (Exit)" WHERE `ID` = 3131;
UPDATE `areatrigger_teleport` SET `Name` = "Maraudon, The Wicked Grotto [Purple Wing] (Entrance)" WHERE `ID` = 3134;
UPDATE `areatrigger_teleport` SET `Name` = "Maraudon, Foulspore Cavern [Orange Wing] (Entrance)" WHERE `ID` = 3133;

-- Dire Maul
UPDATE `areatrigger_teleport` SET `Name` = "Dire Maul, West Wing [South] (Exit)" WHERE `ID` = 3190;
UPDATE `areatrigger_teleport` SET `Name` = "Dire Maul, West Wing [North](Exit)" WHERE `ID` = 3191;
UPDATE `areatrigger_teleport` SET `Name` = "Dire Maul, North Wing (Exit)" WHERE `ID` = 3193;
UPDATE `areatrigger_teleport` SET `Name` = "Dire Maul, East Wing [West] (Exit)" WHERE `ID` = 3194;
UPDATE `areatrigger_teleport` SET `Name` = "Dire Maul, East Wing [South] (Exit)" WHERE `ID` = 3195;
UPDATE `areatrigger_teleport` SET `Name` = "Dire Maul, East Wing [East] (Exit)" WHERE `ID` = 3196;
UPDATE `areatrigger_teleport` SET `Name` = "Dire Maul, Alzzin the Wildshaper's broken wall [1-Way] (Exit)" WHERE `ID` = 3197;
UPDATE `areatrigger_teleport` SET `Name` = "Dire Maul, East Wing [West] (Entrance)" WHERE `ID` = 3183;
UPDATE `areatrigger_teleport` SET `Name` = "Dire Maul, East Wing [South] (Entrance)" WHERE `ID` = 3184;
UPDATE `areatrigger_teleport` SET `Name` = "Dire Maul, East Wing [East] (Entrance)" WHERE `ID` = 3185;
UPDATE `areatrigger_teleport` SET `Name` = "Dire Maul, West Wing [South] (Entrance)" WHERE `ID` = 3186;
UPDATE `areatrigger_teleport` SET `Name` = "Dire Maul, West Wing [North] (Entrance)" WHERE `ID` = 3187;
UPDATE `areatrigger_teleport` SET `Name` = "Dire Maul, North Wing (Entrance)" WHERE `ID` = 3189;

-- Naxxramas
UPDATE `areatrigger_teleport` SET `Name` = "Naxxramas, East (Entrance)" WHERE `ID` = 5191;
UPDATE `areatrigger_teleport` SET `Name` = "Naxxramas, North (Entrance)" WHERE `ID` = 5192;
UPDATE `areatrigger_teleport` SET `Name` = "Naxxramas, West (Entrance)" WHERE `ID` = 5193;
UPDATE `areatrigger_teleport` SET `Name` = "Naxxramas, South (Entrance)" WHERE `ID` = 5194;

UPDATE `areatrigger_teleport` SET `Name` = "Naxxramas, North-East (Exit)" WHERE `ID` = 5196;
UPDATE `areatrigger_teleport` SET `Name` = "Naxxramas, North-West (Exit)" WHERE `ID` = 5197;
UPDATE `areatrigger_teleport` SET `Name` = "Naxxramas, South-East (Exit)" WHERE `ID` = 5198;
UPDATE `areatrigger_teleport` SET `Name` = "Naxxramas, South-West (Exit)" WHERE `ID` = 5199;

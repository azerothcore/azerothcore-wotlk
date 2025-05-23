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

UPDATE `areatrigger_teleport` SET `Name` = "Maraudon (Inside) - Purple Wing: The Wicked Grotto" WHERE `ID` = 3134;
UPDATE `areatrigger_teleport` SET `Name` = "Maraudon (Inside) - Orange Wing: Foulspore Cavern" WHERE `ID` = 3133;

-- Dire Maul
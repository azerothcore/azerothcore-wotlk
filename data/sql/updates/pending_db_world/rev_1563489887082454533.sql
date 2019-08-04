INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1563489887082454533');

-- Equip a throwing knife for Instructor Razuvious to use with his ability "Jagged Knife"
UPDATE `creature_equip_template` SET `ItemID3` = 29010 WHERE `CreatureID` = 16061;

-- Ensure that the Drakkari Battle Riders can use their ability "Poisoned Spear" (otherwise they would constantly use "Throw")
UPDATE `smart_scripts` SET `action_param2` = 1 WHERE `entryorguid` = 29836 AND `source_type` = 0 AND `id` IN (2,3);

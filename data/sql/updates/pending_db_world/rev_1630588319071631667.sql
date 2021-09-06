INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1630588319071631667');

-- Add Slowing poison and fade by aura
UPDATE `creature_template_addon` SET `auras` = '22766 8601' WHERE (`entry` = 7110);

-- Remove the casting of the slowing posion and sneak from smartAi as they now works on auras
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 7110) AND (`source_type` = 0) AND (`id` IN (0, 2));


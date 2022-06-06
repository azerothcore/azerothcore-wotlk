SET @NESTLEWOOD_OWLKIN  = 16518;
SET @SPELL_INOCULATE    = 29528;

-- Clearing Owlkin's SmartAI
DELETE FROM `smart_scripts` WHERE `entryorguid` = @NESTLEWOOD_OWLKIN * 100 AND `source_type` = 9;

UPDATE `creature_template` SET `AIName` = '' WHERE `entry` = @NESTLEWOOD_OWLKIN;

DELETE FROM `smart_scripts` WHERE (`entryorguid` = @NESTLEWOOD_OWLKIN) AND (`source_type` = 0);

DELETE FROM `spell_script_names` WHERE `spell_id` = @SPELL_INOCULATE;
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (@SPELL_INOCULATE, 'spell_inoculate_nestlewood_owlkin');

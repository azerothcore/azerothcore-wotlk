-- Wintergrasp Defender's Portal: teleport to the World Trigger nearest the portal used
DELETE FROM `spell_script_names` WHERE `spell_id` = 54643 AND `ScriptName` = 'spell_wintergrasp_defender_teleport_trigger';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(54643, 'spell_wintergrasp_defender_teleport_trigger');

-- DB update 2025_04_17_01 -> 2025_04_19_00
-- replace noblegarden gameobject script by spell script
UPDATE `gameobject_template` SET `ScriptName` = '' WHERE (`ScriptName` = 'go_noblegarden_colored_egg') AND (`entry` BETWEEN 113768 AND 113772);

-- 61712 Summon Noblegarden Bunny Controller
DELETE FROM `spell_script_names` WHERE (`spell_id` = 61712) AND (`ScriptName` = 'spell_summon_noblegarden_bunny_controller');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (61712, 'spell_summon_noblegarden_bunny_controller');

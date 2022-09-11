--
UPDATE `creature_template` SET `ScriptName`='npc_eye_of_kilrogg' WHERE `entry`=4277;

-- class Warlock
DELETE FROM `creature_template_addon` WHERE `entry`=4277;

DELETE FROM `spell_script_names` WHERE  `spell_id`=126 AND `ScriptName`='spell_warl_eye_of_kilrogg';

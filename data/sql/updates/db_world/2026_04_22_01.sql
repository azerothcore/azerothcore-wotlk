-- DB update 2026_04_22_00 -> 2026_04_22_01
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 31242 AND `id` = 3;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 31271 AND `id` = 2;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 31277 AND `id` = 6;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryorguid` = 14688 AND `id` = 23;
INSERT INTO `smart_scripts` (`entryorguid`,`source_type`,`id`,`link`,`event_type`,`event_phase_mask`,`event_chance`,`event_flags`,`event_param1`,`event_param2`,`event_param3`,`event_param4`,`event_param5`,`event_param6`,`action_type`,`action_param1`,`action_param2`,`action_param3`,`action_param4`,`action_param5`,`action_param6`,`target_type`,`target_param1`,`target_param2`,`target_param3`,`target_param4`,`target_x`,`target_y`,`target_z`,`target_o`,`comment`) VALUES
(31242, 0, 3, 0, 54, 0, 100, 0,     0,     0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sigrid Iceborn - On Just Summoned - Remove Flags Immune To PC/NPC'),
(31271, 0, 2, 0, 54, 0, 100, 0,     0,     0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Carnage - On Just Summoned - Remove Flags Immune To PC/NPC'),
(31277, 0, 6, 0, 54, 0, 100, 0,     0,     0, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Thane Banahogg - On Just Summoned - Remove Flags Immune To PC/NPC'),
(14688, 0,23, 0,  1, 0, 100, 0, 14000, 14000, 0, 0, 0, 0, 19, 768, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Prince Sandoval - Out of Combat 14s - Remove Flags Immune To PC/NPC');

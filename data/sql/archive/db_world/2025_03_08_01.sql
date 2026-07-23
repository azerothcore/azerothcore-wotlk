-- DB update 2025_03_08_00 -> 2025_03_08_01
--
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_sunblade_scout' WHERE (`entry` = 25372);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 25372);

-- DB update 2025_12_21_03 -> 2025_12_22_00
--
UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_traveler_mammoth_vendor' WHERE (`entry` IN (32638, 32639, 32641, 32642));

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` IN (32638, 32639, 32641, 32642));

UPDATE `vehicle_template_accessory` SET `minion` = 0 WHERE `entry` IN (32633, 32640) AND `accessory_entry` IN (32638, 32639, 32641, 32642);

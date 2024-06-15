-- DB update 2023_03_29_01 -> 2023_03_29_02
--
UPDATE `creature_template` SET `flags_extra`=512 WHERE `entry` IN (36725,38058);
UPDATE `creature_template_addon` SET `bytes1`=0 WHERE `entry` IN (36725,38058);
UPDATE `creature_template_movement` SET `Flight`=0, `Ground`=1 WHERE `CreatureId` IN (36725,38058);
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 512 WHERE `entry` IN (37501, 37502, 38197, 38198);
UPDATE `smart_scripts` SET `event_param1` = 16 WHERE `entryorguid` IN (37501, 37502) AND `source_type` = 0 AND `event_type` = 34;

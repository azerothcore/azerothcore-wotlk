-- DB update 2023_04_18_02 -> 2023_04_18_03
--
UPDATE `creature_template` SET `mechanic_immune_mask`=`mechanic_immune_mask`|33554432 WHERE (`entry` IN (18708, 20657));

UPDATE `smart_scripts` SET `event_flags` = 1 WHERE (`entryorguid` = 18634) AND (`source_type` = 0) AND (`id` IN (3, 4));

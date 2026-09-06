-- DB update 2025_02_21_02 -> 2025_02_21_03
--
UPDATE `creature_onkill_reputation` SET `RewOnKillRepValue1` = 120 WHERE (`creature_id` = 24664);
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 7 WHERE `creature_id` IN (24723, 24560, 24664, 24744);

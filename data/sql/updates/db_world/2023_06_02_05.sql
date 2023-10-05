-- DB update 2023_06_02_04 -> 2023_06_02_05
--
-- remove Sha\'tar reputation gain from Restless Skeletons
DELETE FROM `creature_onkill_reputation` WHERE `creature_id` = 17261;

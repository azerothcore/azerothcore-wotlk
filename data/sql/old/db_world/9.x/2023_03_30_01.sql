-- DB update 2023_03_30_00 -> 2023_03_30_01
--
DELETE FROM `creature_onkill_reputation` WHERE (`creature_id` IN (21466, 21467));

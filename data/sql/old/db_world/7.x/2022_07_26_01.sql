-- DB update 2022_07_26_00 -> 2022_07_26_01
UPDATE `creature_onkill_reputation` SET `MaxStanding1` = 5 WHERE (`creature_id` IN (7157, 7156, 7158));

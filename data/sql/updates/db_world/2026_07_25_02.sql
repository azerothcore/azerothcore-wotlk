-- DB update 2026_07_25_01 -> 2026_07_25_02
--
UPDATE `creature_template` SET `KillCredit1` = 0 WHERE (`entry` = 27370);

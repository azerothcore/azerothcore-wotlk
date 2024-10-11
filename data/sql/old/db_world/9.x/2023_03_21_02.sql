-- DB update 2023_03_21_01 -> 2023_03_21_02
--
UPDATE `creature_addon` SET `visibilityDistanceType` = 3 WHERE `guid` IN (130964, 130961, 130962, 130963);


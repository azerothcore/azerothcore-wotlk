-- DB update 2023_09_27_02 -> 2023_09_29_00
--
UPDATE `conditions` SET `ConditionTypeOrReference` = 8 WHERE `SourceGroup` = 8441 AND `ConditionTypeOrReference` = 9;

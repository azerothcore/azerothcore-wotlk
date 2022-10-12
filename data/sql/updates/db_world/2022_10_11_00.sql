-- DB update 2022_10_09_00 -> 2022_10_11_00
--
UPDATE `creature_template_addon` SET `auras` = '25801' WHERE (`entry` = 15229);
UPDATE `creature_addon` SET `auras` = '25801' WHERE `guid` BETWEEN 87901 AND 87906;

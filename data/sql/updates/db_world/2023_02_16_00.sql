-- DB update 2023_02_15_00 -> 2023_02_16_00
--
DELETE FROM `skinning_loot_template` WHERE (`Entry` = 17952);

UPDATE `creature_template` SET `skinloot` = 70068 WHERE (`entry` IN (17952, 22163));

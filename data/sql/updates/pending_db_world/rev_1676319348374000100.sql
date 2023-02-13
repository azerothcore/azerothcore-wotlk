--
DELETE FROM `skinning_loot_template` WHERE (`Entry` IN (17952, 22163));

UPDATE `creature_template` SET `skinloot` = 70068 WHERE (`entry` = 17952);

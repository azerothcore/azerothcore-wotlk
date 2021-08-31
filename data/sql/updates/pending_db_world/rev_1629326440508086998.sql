INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629326440508086998');
DELETE FROM `skinning_loot_template` WHERE `Entry` IN (684, 768, 1713, 10237) AND (`Item` IN (7428));

-- Adjust skinning drop rates for Shadowmaw Panther
UPDATE `skinning_loot_template` SET `Chance` = 73.4 WHERE `Entry` = 684 AND `Item` = 4234;
UPDATE `skinning_loot_template` SET `Chance` = 3.3 WHERE `Entry` = 684 AND `Item` = 4235;
UPDATE `skinning_loot_template` SET `Chance` = 23.3 WHERE `Entry` = 684 AND `Item` = 4304;

-- Adjust skinning drop rates for Shadow Panther
UPDATE `skinning_loot_template` SET `Chance` = 72.7 WHERE `Entry` = 768 AND `Item` = 4234;
UPDATE `skinning_loot_template` SET `Chance` = 4.2 WHERE `Entry` = 768 AND `Item` = 4235;
UPDATE `skinning_loot_template` SET `Chance` = 23.1 WHERE `Entry` = 768 AND `Item` = 4304;

-- Adjust skinning drop rates for Elder Shadowmaw Panther
UPDATE `skinning_loot_template` SET `Chance` = 72.8 WHERE `Entry` = 1713 AND `Item` = 4234;
UPDATE `skinning_loot_template` SET `Chance` = 3.3 WHERE `Entry` = 1713 AND `Item` = 4235;
UPDATE `skinning_loot_template` SET `Chance` = 23.9 WHERE `Entry` = 1713 AND `Item` = 4304;

UPDATE `creature_template` SET `skinloot` = 0 WHERE (`entry` = 10237);
DELETE FROM `skinning_loot_template` WHERE `Entry` = 10237;

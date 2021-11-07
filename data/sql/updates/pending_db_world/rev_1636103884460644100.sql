INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636103884460644100');

-- Westfall Deed
UPDATE `creature_loot_template` SET `Chance`=4 WHERE `Item`=1972 AND `Entry` IN (6866,6846);
UPDATE `creature_loot_template` SET `Chance`=3 WHERE `Item`=1972 AND `Entry` IN (116,474,880,6927);
DELETE FROM `creature_loot_template` WHERE `Item`=1972 AND `Entry`=583;
DELETE FROM `creature_loot_template` WHERE `Item`=1972 AND `Entry`=881;

-- Gold Pickup Schedule
UPDATE `creature_loot_template` SET `Chance`=86 WHERE `Item`=1307 AND `Entry`=100;
UPDATE `creature_loot_template` SET `Chance`=3 WHERE `Item`=1307 AND `Entry` IN (478,97);
UPDATE `creature_loot_template` SET `Chance`=1.9 WHERE `Item`=1307 AND `Entry`=448;

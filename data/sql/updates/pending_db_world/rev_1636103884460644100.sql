INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636103884460644100');

-- Correct drop chance for Westfall Deed
UPDATE `creature_loot_template` SET `Chance`=4 WHERE `Item`=1972 AND `Entry` IN (6866,6846);
UPDATE `creature_loot_template` SET `Chance`=3 WHERE `Item`=1972 AND `Entry` IN (116,474,880,6927);

-- Defias Ambusher and Surena Caledon should not drop Westfall Deed
DELETE FROM `creature_loot_template` WHERE `Item`=1972 AND `Entry` IN (583,881);
DELETE FROM `conditions` WHERE `SourceEntry`=1972 AND `SourceGroup` IN (583,881);

-- Correct drop chance for Gold Pickup Schedule
UPDATE `creature_loot_template` SET `Chance`=86 WHERE `Item`=1307 AND `Entry`=100;
UPDATE `creature_loot_template` SET `Chance`=3 WHERE `Item`=1307 AND `Entry` IN (478,97);
UPDATE `creature_loot_template` SET `Chance`=1.9 WHERE `Item`=1307 AND `Entry`=448;

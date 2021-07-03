INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1625295995097462808');

-- Warmaster Laggond
DELETE FROM `creature_loot_template` WHERE `Entry` = 13840 AND `Item` IN (17422, 17423, 17503, 17504);

-- Corporal Teeka Bloodsnarl
DELETE FROM `creature_loot_template` WHERE `Entry` = 13776 AND `Item` IN (17422, 17423, 17502, 17503);

-- Frostwolf Battleguard 
DELETE FROM `creature_loot_template` WHERE `Entry` = 14285 AND `Item` IN (17422, 17423, 17503);

-- Lieutenant Haggerdin 
DELETE FROM `creature_loot_template` WHERE `Entry` = 13841 AND `Item` IN (17306, 17327, 17328, 17422);

-- Stormpike Mountaineer
DELETE FROM `creature_loot_template` WHERE `Entry` = 12047 AND `Item` IN (17306, 17326, 17327, 17328, 17422, 17423, 17502, 17503, 17504, 18143, 18144, 18145, 18146, 18147, 18206, 18207, 18225, 18231, 18233);

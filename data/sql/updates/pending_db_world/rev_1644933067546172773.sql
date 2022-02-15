INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644933067546172773');

-- removes items to align with udb
-- https://tbc.wowhead.com/item=22389/plans-sageblade
-- https://tbc.wowhead.com/item=22390/plans-persuader
DELETE FROM `creature_loot_template` WHERE  `Entry`=12397 AND `Item`=22389 AND `Reference`=0 AND `GroupId`=0;
DELETE FROM `creature_loot_template` WHERE  `Entry`=12397 AND `Item`=22390 AND `Reference`=0 AND `GroupId`=0;
INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644933067546172773');

-- This NPC does not exsist in wotlk since when the dark portal open for TBC he went back to outland and is now know as Doom Lord Kazzak NPC 18728.
UPDATE `creature_template` SET `lootid`='0' WHERE  `entry`=12397;
DELETE FROM `creature_loot_template` WHERE  `Entry`=12397;

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640263955874251100');

-- Set 100% drop chance for Abyssal crest in Crimson Templar / Azure Templar / Hoary Templar / Earthen Templar
UPDATE `creature_loot_template` SET `Chance`='100' WHERE `Item`=20513 AND `Reference`=0 AND `GroupId`=0;

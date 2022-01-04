INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1641307926630364064');

-- removes Frigid Ring from creature loot template
DELETE FROM `creature_loot_template` WHERE  `Entry`=14457 AND `Item`=18679 AND `Reference`=0 AND `GroupId`=0;

-- Add Frigid Ring to Reference Loot Template where it is suppose to be
DELETE FROM `reference_loot_template` WHERE `Entry`=24016 AND `Item`=18679;
INSERT INTO `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(24016, 18679, 0, 0, 0, 1, 1, 1, 1, 'Frigid Ring');

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640972252071688181');

-- removes unverified corrections of loot drop of the abyssal crest with drop rate based on udb from consolidated sniffs
DELETE FROM `creature_loot_template` WHERE `Entry`=15209 AND `Item`=20513 AND `Reference`=0 AND `GroupId`=0;
DELETE FROM `creature_loot_template` WHERE `Entry`=15211 AND `Item`=20513 AND `Reference`=0 AND `GroupId`=0;
DELETE FROM `creature_loot_template` WHERE `Entry`=15212 AND `Item`=20513 AND `Reference`=0 AND `GroupId`=0;
DELETE FROM `creature_loot_template` WHERE `Entry`=15307 AND `Item`=20513 AND `Reference`=0 AND `GroupId`=0;
INSERT INTO `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) VALUES 
(15209, 20513, 0, 83.7314, 0, 1, 0, 1, 1, 'Crimson Templar - Abyssal Crest'),
(15211, 20513, 0, 83.5982, 0, 1, 0, 1, 1, 'Azure Templar - Abyssal Crest'),
(15212, 20513, 0, 83.8428, 0, 1, 0, 1, 1, 'Hoary Templar - Abyssal Crest'),
(15307, 20513, 0, 83.9362, 0, 1, 0, 1, 1, 'Earthen Templar - Abyssal Crest');

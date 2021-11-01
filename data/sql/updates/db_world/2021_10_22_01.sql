-- DB update 2021_10_22_00 -> 2021_10_22_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_22_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_22_00 2021_10_22_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634699890992468941'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634699890992468941');

-- fixed reference_loot_template id 44011 and 44012
DELETE FROM `reference_loot_template` WHERE `Entry` IN (44011,44012);
insert into `reference_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) values
('44011','2725','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 1'),
('44011','2728','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 4'),
('44011','2730','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 6'),
('44011','2732','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 8'),
('44011','2734','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 10'),
('44011','2735','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 11'),
('44011','2738','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 14'),
('44011','2740','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 16'),
('44011','2742','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 18'),
('44011','2744','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 20'),
('44011','2745','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 21'),
('44011','2748','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 24'),
('44011','2749','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 25'),
('44011','2750','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 26'),
('44011','2751','0','0','0','1','1','1','1','Green Hills of Stranglethorn - Page 27'),
('44012','22450','0','100','0','1','0','1','1','Void Crystal');

-- fixed creature_loot_template id 435
DELETE FROM `creature_loot_template` WHERE `Entry` = 435;
insert into `creature_loot_template` (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`) values
('435','422','0','0.0098','0','1','0','1','1','Blackrock Champion - Dwarven Mild'),
('435','774','0','0.02','0','1','0','1','1','Blackrock Champion - Malachite'),
('435','785','0','0.02','0','1','0','1','1','Blackrock Champion - Mageroyal'),
('435','804','0','0.0098','0','1','0','1','1','Blackrock Champion - Large Blue Sack'),
('435','857','0','0.02','0','1','0','1','1','Blackrock Champion - Large Red Sack'),
('435','858','0','0.04','0','1','0','1','1','Blackrock Champion - Lesser Healing Potion'),
('435','929','0','1.4555','0','1','0','1','1','Blackrock Champion - Healing Potion'),
('435','954','0','0.58','0','1','0','1','1','Blackrock Champion - Scroll of Strength'),
('435','1205','0','2.313','0','1','0','1','1','Blackrock Champion - Melon Juice'),
('435','1206','0','0.24','0','1','0','1','1','Blackrock Champion - Moss Agate'),
('435','1210','0','0.12','0','1','0','1','1','Blackrock Champion - Shadowgem'),
('435','1478','0','0.34','0','1','0','1','1','Blackrock Champion - Scroll of Protection II'),
('435','1529','0','0.02','0','1','0','1','1','Blackrock Champion - Jade'),
('435','1705','0','0.0343','0','1','0','1','1','Blackrock Champion - Lesser Moonstone'),
('435','1712','0','0.36','0','1','0','1','1','Blackrock Champion - Scroll of Spirit II'),
('435','2409','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Dark Leather Tunic'),
('435','2449','0','0.02','0','1','0','1','1','Blackrock Champion - Earthroot'),
('435','2450','0','0.02','0','1','0','1','1','Blackrock Champion - Briarthorn'),
('435','2452','0','0.02','0','1','0','1','1','Blackrock Champion - Swiftthistle'),
('435','2453','0','0.02','0','1','0','1','1','Blackrock Champion - Bruiseweed'),
('435','2455','0','0.02','0','1','0','1','1','Blackrock Champion - Minor Mana Potion'),
('435','2589','0','12.9276','0','1','0','1','3','Blackrock Champion - Linen Cloth'),
('435','2592','0','23.8508','0','1','0','1','2','Blackrock Champion - Wool Cloth'),
('435','2601','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Gray Woolen Robe'),
('435','2700','0','0.02','0','1','0','1','1','Blackrock Champion - Recipe: Succulent Pork Ribs'),
('435','2835','0','0.22','0','1','0','1','1','Blackrock Champion - Rough Stone'),
('435','2836','0','0.26','0','1','0','1','1','Blackrock Champion - Coarse Stone'),
('435','2881','0','0.02','0','1','0','1','1','Blackrock Champion - Plans: Runed Copper Breastplate'),
('435','2882','0','0.02','0','1','0','1','1','Blackrock Champion - Plans: Silvered Bronze Shoulders'),
('435','2883','0','0.02','0','1','0','1','1','Blackrock Champion - Plans: Deadly Bronze Poniard'),
('435','2996','0','0.02','0','1','0','1','1','Blackrock Champion - Bolt of Linen Cloth'),
('435','2997','0','0.02','0','1','0','1','1','Blackrock Champion - Bolt of Woolen Cloth'),
('435','3012','0','0.52','0','1','0','1','1','Blackrock Champion - Scroll of Agility'),
('435','3014','14012','100','0','1','0','1','1','Blackrock Champion - (ReferenceTable)'),
('435','3355','0','0.02','0','1','0','1','1','Blackrock Champion - Wild Steelbloom'),
('435','3356','0','0.02','0','1','0','1','1','Blackrock Champion - Kingsblood'),
('435','3385','0','0.7253','0','1','0','1','1','Blackrock Champion - Lesser Mana Potion'),
('435','3393','0','0.02','0','1','0','1','1','Blackrock Champion - Recipe: Minor Magic Resistance Potion'),
('435','3394','0','0.02','0','1','0','1','1','Blackrock Champion - Recipe: Potion of Curing'),
('435','3396','0','0.02','0','1','0','1','1','Blackrock Champion - Recipe: Elixir of Lesser Agility'),
('435','3608','0','0.02','0','1','0','1','1','Blackrock Champion - Plans: Mighty Iron Hammer'),
('435','3611','0','0.02','0','1','0','1','1','Blackrock Champion - Plans: Green Iron Boots'),
('435','3612','0','0.02','0','1','0','1','1','Blackrock Champion - Plans: Green Iron Gauntlets'),
('435','3770','0','4.6261','0','1','0','1','1','Blackrock Champion - Mutton Chop'),
('435','4292','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Green Woolen Bag'),
('435','4293','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Hillman\'s Leather Vest'),
('435','4294','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Hillman\'s Belt'),
('435','4296','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Dark Leather Shoulders'),
('435','4306','0','4.8858','0','1','0','1','1','Blackrock Champion - Silk Cloth'),
('435','4345','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Red Woolen Boots'),
('435','4346','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Heavy Woolen Cloak'),
('435','4347','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Reinforced Woolen Shoulders'),
('435','4348','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Phoenix Gloves'),
('435','4349','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Phoenix Pants'),
('435','4350','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Spider Silk Slippers'),
('435','4409','0','0.02','0','1','0','1','1','Blackrock Champion - Schematic: Small Seaforium Charge'),
('435','4410','0','0.02','0','1','0','1','1','Blackrock Champion - Schematic: Shadow Goggles'),
('435','4412','0','0.02','0','1','0','1','1','Blackrock Champion - Schematic: Moonsight Rifle'),
('435','4538','0','0.04','0','1','0','1','1','Blackrock Champion - Snapvine Watermelon'),
('435','4542','0','0.0098','0','1','0','1','1','Blackrock Champion - Moist Cornbread'),
('435','4593','0','0.02','0','1','0','1','1','Blackrock Champion - Bristle Whisker Catfish'),
('435','4606','0','0.0196','0','1','0','1','1','Blackrock Champion - Spongy Morel'),
('435','4632','0','0.0294','0','1','0','1','1','Blackrock Champion - Ornate Bronze Lockbox'),
('435','4700','0','0.02','0','1','0','1','1','Blackrock Champion - Inscribed Leather Spaulders'),
('435','5543','0','0.02','0','1','0','1','1','Blackrock Champion - Plans: Iridescent Hammer'),
('435','5575','0','0.02','0','1','0','1','1','Blackrock Champion - Large Green Sack'),
('435','5576','0','0.02','0','1','0','1','1','Blackrock Champion - Large Brown Sack'),
('435','5578','0','0.02','0','1','0','1','1','Blackrock Champion - Plans: Silvered Bronze Breastplate'),
('435','5972','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Fine Leather Pants'),
('435','6044','0','0.02','0','1','0','1','1','Blackrock Champion - Plans: Iron Shield Spike'),
('435','6211','0','0.02','0','1','0','1','1','Blackrock Champion - Recipe: Elixir of Ogre\'s Strength'),
('435','6344','0','0.02','0','1','0','1','1','Blackrock Champion - Formula: Enchant Bracer - Minor Spirit'),
('435','6347','0','0.02','0','1','0','1','1','Blackrock Champion - Formula: Enchant Bracer - Minor Strength'),
('435','6348','0','0.02','0','1','0','1','1','Blackrock Champion - Formula: Enchant Weapon - Minor Beastslayer'),
('435','6375','0','0.02','0','1','0','1','1','Blackrock Champion - Formula: Enchant Bracer - Lesser Spirit'),
('435','6390','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Stylish Blue Shirt'),
('435','6391','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Stylish Green Shirt'),
('435','6454','0','0.02','0','1','0','1','1','Blackrock Champion - Manual: Strong Anti-Venom'),
('435','6566','0','0.0294','0','1','0','1','1','Blackrock Champion - Shimmering Amice'),
('435','6579','0','0.0343','0','1','0','1','1','Blackrock Champion - Defender Spaulders'),
('435','6588','0','0.0245','0','1','0','1','1','Blackrock Champion - Scouting Spaulders'),
('435','6716','0','0.02','0','1','0','1','1','Blackrock Champion - Schematic: EZ-Thro Dynamite'),
('435','7091','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Truefaith Gloves'),
('435','7092','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Hands of Darkness'),
('435','7360','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Dark Leather Gloves'),
('435','7363','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Pilferer\'s Gloves'),
('435','7364','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Heavy Earthen Gloves'),
('435','9355','0','0.02','0','1','0','1','1','Blackrock Champion - Hoop Earring'),
('435','10316','0','0.02','0','1','0','1','1','Blackrock Champion - Pattern: Colorful Kilt'),
('435','10405','0','0.02','0','1','0','1','1','Blackrock Champion - Bandit Shoulders'),
('435','10424','0','0.02','0','1','0','1','1','Blackrock Champion - Plans: Silvered Bronze Leggings'),
('435','11038','0','0.02','0','1','0','1','1','Blackrock Champion - Formula: Enchant 2H Weapon - Lesser Spirit'),
('435','11039','0','0.02','0','1','0','1','1','Blackrock Champion - Formula: Enchant Cloak - Minor Agility'),
('435','11081','0','0.02','0','1','0','1','1','Blackrock Champion - Formula: Enchant Shield - Lesser Protection'),
('435','11098','0','0.02','0','1','0','1','1','Blackrock Champion - Formula: Enchant Cloak - Lesser Shadow Resistance'),
('435','24059','24059','5','0','1','1','1','1','Blackrock Champion - (ReferenceTable)'),
('435','24060','24060','1','0','1','1','1','1','Blackrock Champion - (ReferenceTable)'),
('435','24061','24061','0.5','0','1','1','1','1','Blackrock Champion - (ReferenceTable)'),
('435','24062','24062','1','0','1','1','1','1','Blackrock Champion - (ReferenceTable)'),
('435','24063','24063','0.5','0','1','1','1','1','Blackrock Champion - (ReferenceTable)'),
('435','24064','24064','1','0','1','1','1','1','Blackrock Champion - (ReferenceTable)'),
('435','24065','24065','0.05','0','1','1','1','1','Blackrock Champion - (ReferenceTable)'),
('435','24066','24066','0.5','0','1','1','1','1','Blackrock Champion - (ReferenceTable)'),
('435','24067','24067','0.5','0','1','1','1','1','Blackrock Champion - (ReferenceTable)'),
('435','24068','24068','1','0','1','1','1','1','Blackrock Champion - (ReferenceTable)'),
('435','24069','24069','0.5','0','1','1','1','1','Blackrock Champion - (ReferenceTable)');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_22_01' WHERE sql_rev = '1634699890992468941';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

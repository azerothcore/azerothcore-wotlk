UPDATE `item_template` SET `Flags` = 64, `ScriptName` = 'azth_main_morph', stackable = 1, `spellid_1` = 36177, maxcount = 5 WHERE (entry = 32561);
  
DROP TABLE IF EXISTS `azth_morph_template`;
CREATE TABLE `azth_morph_template`(  
  `entry` INT NOT NULL UNIQUE,
  `flags` INT DEFAULT 0,
  `default_name` TEXT,
  `scale` FLOAT DEFAULT 1,
  `aura` INT DEFAULT -1,
  `comment` TEXT
);

-- some morph
DELETE FROM `azth_morph_template` WHERE entry = 1060;
INSERT INTO `azth_morph_template` VALUES (1060, 0, "MUCCA!", 3, 17, "prova muccaaa");
UPDATE `item_template` SET `Flags` = 64, `ScriptName` = 'azth_get_morph', `spellid_1` = 36177, stackable = 1060, NAME = "Mucca" WHERE (entry = 32543);

DELETE FROM `azth_morph_template` WHERE entry = 30721;
INSERT INTO `azth_morph_template` VALUES (30721, 0, "The Lich King", 3, 17, "Lich King Morph");
UPDATE `item_template` SET `Flags` = 64, `ScriptName` = 'azth_get_morph', `spellid_1` = 36177, stackable = 30721, NAME = "The Lich King" WHERE (entry = 32544);

  
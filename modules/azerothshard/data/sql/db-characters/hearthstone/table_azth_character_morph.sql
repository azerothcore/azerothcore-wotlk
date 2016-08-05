DROP TABLE IF EXISTS `azth_character_morph`;
CREATE TABLE `azth_character_morph`(  
  `guid` INT NOT NULL,
  `entry` INT NOT NULL,
  `name` TEXT,
  `comment` TEXT
);
ALTER TABLE `azth_character_morph`
  ADD CONSTRAINT `azth_character_morph` UNIQUE(guid, entry);
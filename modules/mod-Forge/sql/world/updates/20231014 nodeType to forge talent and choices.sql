DROP TABLE IF EXISTS `acore_world`.`forge_talent_exclusive`;
DROP TABLE IF EXISTS `acore_characters`.`forge_character_node_choices`;
CREATE TABLE `acore_characters`.`forge_character_node_choices` (
  `guid` INT UNSIGNED NOT NULL,
  `spec` INT UNSIGNED NOT NULL,
  `tabId` INT UNSIGNED NOT NULL,
  `node` TINYINT UNSIGNED NOT NULL,
  `choice` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`guid`, `spec`, `tabId`, `node`));
  
DROP TABLE IF EXISTS `acore_world`.`forge_talent_choice_nodes`;
CREATE TABLE `acore_world`.`forge_talent_choice_nodes` (
  `choiceNodeId` MEDIUMINT UNSIGNED NOT NULL,
  `talentTabId` INT UNSIGNED NOT NULL,
  `choiceSpellId` MEDIUMINT UNSIGNED NOT NULL,
  PRIMARY KEY (`choiceNodeId`, `talentTabId`, `choiceSpellId`));
  
 ALTER TABLE `acore_world`.`forge_talents`
	ADD COLUMN `nodeType` TINYINT NOT null default 0;
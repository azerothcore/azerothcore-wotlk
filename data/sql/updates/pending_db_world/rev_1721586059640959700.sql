--
DELETE FROM `command` WHERE `name`='aura stack';
INSERT INTO `command` VALUES ('aura stack', 2, 'Syntax: .aurastack #spellid #stacks\r\n\r\nModify #stacks of an already applied #spellid to the selected Unit.');

DELETE FROM `acore_string` WHERE `entry` IN (373,374,375);
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(373, 'Target unit does not have aura {}!'),
(374, 'No stack amount specified!'),
(375, 'Spell {} cannot have stacks!');

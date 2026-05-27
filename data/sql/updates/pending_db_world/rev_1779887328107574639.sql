--
CREATE TABLE IF NOT EXISTS `spell_gameobject_faction` (
    `spell_id` INT UNSIGNED NOT NULL COMMENT 'Spell that creates the gameobject',
    `team_id`  TINYINT UNSIGNED NOT NULL COMMENT '0=Alliance, 1=Horde',
    `comment`  VARCHAR(255) DEFAULT NULL,
    PRIMARY KEY (`spell_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Faction restriction for gameobjects created by spells';

DELETE FROM `spell_gameobject_faction` WHERE `spell_id` IN (10059, 11416, 11419, 32266, 49360, 11417, 11418, 11420, 32267, 49361, 33691, 35717);
INSERT INTO `spell_gameobject_faction` (`spell_id`, `team_id`, `comment`) VALUES
(10059, 0, 'Portal: Stormwind - Alliance'),
(11416, 0, 'Portal: Ironforge - Alliance'),
(11419, 0, 'Portal: Darnassus - Alliance'),
(32266, 0, 'Portal: Exodar - Alliance'),
(49360, 0, 'Portal: Theramore - Alliance'),
(33691, 0, 'Portal: Shattrath - Alliance'),
(11417, 1, 'Portal: Orgrimmar - Horde'),
(11418, 1, 'Portal: Undercity - Horde'),
(11420, 1, 'Portal: Thunder Bluff - Horde'),
(32267, 1, 'Portal: Silvermoon City - Horde'),
(49361, 1, 'Portal: Stonard - Horde'),
(35717, 1, 'Portal: Shattrath - Horde');

DELETE FROM `command` WHERE `name` IN ('spell gobject faction add', 'spell gobject faction remove', 'spell gobject faction list', 'reload spell_gameobject_faction');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('spell gobject faction add',    3, 'Syntax: .spell gobject faction add <spell_id|spelllink> <team_id> [comment]\r\nAdds or updates a gameobject faction restriction for the given spell. team_id: 0 = Alliance, 1 = Horde.'),
('spell gobject faction remove', 3, 'Syntax: .spell gobject faction remove <spell_id|spelllink>\r\nRemoves the gameobject faction restriction for the given spell.'),
('spell gobject faction list',   2, 'Syntax: .spell gobject faction list [nameFilter]\r\nLists all spell gameobject faction restrictions. Optional name filter is case-insensitive.'),
('reload spell_gameobject_faction', 3, 'Syntax: .reload spell_gameobject_faction\r\nReloads the spell_gameobject_faction table from the database.');

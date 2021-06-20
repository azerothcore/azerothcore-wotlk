-- DB update 2019_02_23_00 -> 2019_02_24_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_02_23_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_02_23_00 2019_02_24_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1549320792563626100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1549320792563626100');

DELETE FROM `command` WHERE `name`='taxicheat';
DELETE FROM `command` WHERE `name`='waterwalk';

DELETE FROM `command` WHERE `name`='cheat' OR `name` LIKE 'cheat%';
INSERT INTO `command` (`name`, `security`, `help`) VALUES 
('cheat',           2, 'Syntax: .cheat $subcommand\r\nType .cheat to see the list of possible subcommands or .help cheat $subcommand to see info on subcommands'),
('cheat god',       2, 'Syntax: .cheat god [on/off]\r\nTurn the user invulnerable.'),
('cheat casttime',  2, 'Syntax: .cheat casttime [on/off]\r\nRemove spells\' casting time.'),
('cheat cooldown',  2, 'Syntax: .cheat cooldown [on/off]\r\nDisable spells\' cooldowns.'),
('cheat power',     2, 'Syntax: .cheat power [on/off]\r\nRemove spells\' cost (mana, energy, rage...).'),
('cheat waterwalk', 2, 'Syntax: .cheat waterwalk on/off\r\nAllow to walk on water (self or selected character).'),
('cheat taxi',      2, 'Syntax: .cheat taxi on/off\r\nTemporary grant access to all taxi routes for the selected character.\r\n If no character is selected, hide or reveal all routes to you. Visited taxi nodes are still accessible after removing access.');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

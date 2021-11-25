INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637791407206032100');

DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (334500, 334501, 334600, 334601, 334700, 334701, 334800, 334801, 652300, 652301, 652400, 652401, 652500, 652501, 652600, 652601, 652700, 652701, 737200, 737201, 737300, 737301, 737400, 737401, 737500, 737501)) AND (`source_type` = 9) AND (`id` IN (2, 12, 21));
DELETE FROM `creature_text` WHERE `CreatureID`=10556 AND `GroupID`=0 AND (`ID` IN (0,1,2));

INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(10556, 0, 0, 'Ow!  OK, I\'ll get back to work, $n!', 12, 1, 100, 0, 0, 6292, 5774, 0, 'lazy peon SAY_WP_0'),
(10556, 0, 1, 'Ow!  OK, I\'ll get back to work, $n!', 12, 1, 100, 0, 0, 6294, 5774, 0, 'lazy peon SAY_WP_0'),
(10556, 0, 2, 'Ow!  OK, I\'ll get back to work, $n!', 12, 1, 100, 0, 0, 6197, 5774, 0, 'lazy peon SAY_WP_0');

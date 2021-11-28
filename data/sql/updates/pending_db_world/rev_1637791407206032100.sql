INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637791407206032100');

SET @LAZY_PEON_ENTRY = 10556;

-- Removed the SmartAI that made 'Lazy Peons' play the 'Work Work' sound on Valley of Trials
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (334500, 334600, 334700, 334800, 652300, 652400, 652500, 652600, 652700, 737200, 737300, 737400, 737500) AND (`source_type` = 9) AND (`id` IN (8, 17));
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (334501, 334601, 334701, 334801, 652301, 652401, 652501, 652601, 652701, 737201, 737301, 737401, 737501) AND (`source_type` = 9) AND (`id` IN (2, 12, 21));

-- Added the played sounds to when creatures talk, targeting only the player.
DELETE FROM `creature_text` WHERE `CreatureID`=@LAZY_PEON_ENTRY AND `GroupID`=0 AND (`ID` IN (0,1,2));
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES 
(@LAZY_PEON_ENTRY, 0, 0, 'Ow!  OK, I\'ll get back to work, $n!', 12, 1, 100, 0, 0, 6292, 5774, 0, 'lazy peon SAY_WP_0'),
(@LAZY_PEON_ENTRY, 0, 1, 'Ow!  OK, I\'ll get back to work, $n!', 12, 1, 100, 0, 0, 6294, 5774, 0, 'lazy peon SAY_WP_0'),
(@LAZY_PEON_ENTRY, 0, 2, 'Ow!  OK, I\'ll get back to work, $n!', 12, 1, 100, 0, 0, 6197, 5774, 0, 'lazy peon SAY_WP_0');

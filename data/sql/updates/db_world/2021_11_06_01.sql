-- DB update 2021_11_06_00 -> 2021_11_06_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_06_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_06_00 2021_11_06_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1636050414423889017'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1636050414423889017');

-- Condition for Wind Stone Gossip menu option
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`= 15 AND `SourceGroup` IN (6540,6542,6543) AND `SourceEntry` IN (0,1,2,3,4) AND `SourceId`=0;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 6540, 0, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6540 option id 0 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6540, 1, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6540 option id 1 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6540, 1, 0, 0, 2, 0, 20416, 1, 0, 0, 0, 0, '', 'Show gossip menu 6540 option id 1 if player has 1 of Crest of Beckoning: Fire. Item cannot be in bank.'),
(15, 6540, 2, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6540 option id 2 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6540, 2, 0, 0, 2, 0, 20420, 1, 0, 0, 0, 0, '', 'Show gossip menu 6540 option id 2 if player has 1 of Crest of Beckoning: Water. Item cannot be in bank.'),
(15, 6540, 3, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6540 option id 3 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6540, 3, 0, 0, 2, 0, 20419, 1, 0, 0, 0, 0, '', 'Show gossip menu 6540 option id 3 if player has 1 of Crest of Beckoning: Earth. Item cannot be in bank.'),
(15, 6540, 4, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6540 option id 4 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6540, 4, 0, 0, 2, 0, 20418, 1, 0, 0, 0, 0, '', 'Show gossip menu 6540 option id 4 if player has 1 of Crest of Beckoning: Thunder. Item cannot be in bank.'),
(15, 6542, 0, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 0 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6542, 0, 0, 0, 1, 0, 24748, 0, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 0 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6542, 1, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 1 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6542, 1, 0, 0, 1, 0, 24748, 0, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 1 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6542, 1, 0, 0, 2, 0, 20432, 1, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 1 if player has 1 of Signet of Beckoning: Fire. Item cannot be in bank.'),
(15, 6542, 2, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 2 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6542, 2, 0, 0, 1, 0, 24748, 0, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 2 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6542, 2, 0, 0, 2, 0, 20436, 1, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 2 if player has 1 of Signet of Beckoning: Water. Item cannot be in bank.'),
(15, 6542, 3, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 3 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6542, 3, 0, 0, 1, 0, 24748, 0, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 3 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6542, 3, 0, 0, 2, 0, 20435, 1, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 3 if player has 1 of Signet of Beckoning: Earth. Item cannot be in bank.'),
(15, 6542, 4, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 4 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6542, 4, 0, 0, 1, 0, 24748, 0, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 4 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6542, 4, 0, 0, 2, 0, 20433, 1, 0, 0, 0, 0, '', 'Show gossip menu 6542 option id 4 if player has 1 of Signet of Beckoning: Thunder. Item cannot be in bank.'),
(15, 6543, 0, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 0 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 0, 0, 0, 1, 0, 24748, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 0 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 0, 0, 0, 1, 0, 24782, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 0 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 1, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 1 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 1, 0, 0, 1, 0, 24748, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 1 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 1, 0, 0, 1, 0, 24782, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 1 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 1, 0, 0, 2, 0, 20447, 1, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 1 if player has 1 of Scepter of Beckoning: Fire. Item cannot be in bank.'),
(15, 6543, 2, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 2 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 2, 0, 0, 1, 0, 24748, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 2 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 2, 0, 0, 1, 0, 24782, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 2 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 2, 0, 0, 2, 0, 20450, 1, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 2 if player has 1 of Scepter of Beckoning: Water. Item cannot be in bank.'),
(15, 6543, 3, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 3 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 3, 0, 0, 1, 0, 24748, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 3 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 3, 0, 0, 1, 0, 24782, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 3 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 3, 0, 0, 2, 0, 20449, 1, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 3 if player has 1 of Scepter of Beckoning: Earth. Item cannot be in bank.'),
(15, 6543, 4, 0, 0, 1, 0, 24746, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 4 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 4, 0, 0, 1, 0, 24748, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 4 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 4, 0, 0, 1, 0, 24782, 0, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 4 if target has aura Twilight Cultist Disguise (effect 0).'),
(15, 6543, 4, 0, 0, 2, 0, 20448, 1, 0, 0, 0, 0, '', 'Show gossip menu 6543 option id 4 if player has 1 of Scepter of Beckoning: Thunder. Item cannot be in bank.');


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_06_01' WHERE sql_rev = '1636050414423889017';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

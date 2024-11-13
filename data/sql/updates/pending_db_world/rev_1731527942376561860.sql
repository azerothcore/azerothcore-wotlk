--
DELETE FROM `areatrigger_scripts` WHERE `entry` IN (4116, 4117) AND `ScriptName` IN ('at_gothik_entrance', 'at_deathknight_wing_entrance');
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
(4117, 'at_deathknight_wing_entrance'),
(4116, 'at_gothik_entrance');

SET @ZELIEK = 16063;
UPDATE `creature_text` SET `Comment` = 'zeliek SAY_ZELI_DIALOG1' WHERE (`CreatureID` = @ZELIEK) AND (`GroupID` = 5);
UPDATE `creature_text` SET `Comment` = 'zeliek SAY_ZELI_DIALOG2' WHERE (`CreatureID` = @ZELIEK) AND (`GroupID` = 6);
-- remove duplicate DIALOG1 and DIALOG2 from TAUNT group
DELETE FROM `creature_text` WHERE (`CreatureID` = @ZELIEK) AND (`GroupID` = 1) AND (`ID` IN (0, 1)) AND (`Sound` IN (8917, 8918));
-- Zeliek only DK wing intro
UPDATE `creature_text` SET `Comment` = 'zeliek SAY_ZELI_INTRO1', `GroupID` = 8, `TextRange` = 3 WHERE  (`CreatureID` = @ZELIEK) AND (`GroupID` = 0);
UPDATE `creature_text` SET `Comment` = 'zeliek SAY_ZELI_INTRO2', `GroupID` = 9, `ID` = 0, `TextRange` = 3 WHERE  (`CreatureID` = @ZELIEK) AND (`GroupID` = 1) AND (`ID` = 2);

SET @KORTHAZZ = 16064;
UPDATE `creature_text` SET `Comment` = 'korthazz SAY_KORT_DIALOG1' WHERE (`CreatureID` = @KORTHAZZ) AND (`GroupID` = 5);
UPDATE `creature_text` SET `Comment` = 'korthazz SAY_KORT_DIALOG2' WHERE (`CreatureID` = @KORTHAZZ) AND (`GroupID` = 6);
-- remove duplicate DIALOG1 and DIALOG2 from TAUNT group
DELETE FROM `creature_text` WHERE (`CreatureID` = @KORTHAZZ) AND (`GroupID` = 1) AND (`ID` IN (0, 1)) AND (`Sound` IN (8903, 8904));
UPDATE `creature_text` SET `Comment` = 'korthazz SAY_KORT_TAUNT1', `ID` = 0 WHERE  (`CreatureID` = @KORTHAZZ) AND (`GroupID` = 1) AND (`ID` = 2);

SET @BLAUMEUX = 16065;
UPDATE `creature_text` SET `Comment` = 'blaumeux SAY_BLAU_DIALOG1' WHERE (`CreatureID` = @BLAUMEUX) AND (`GroupID` = 5);
UPDATE `creature_text` SET `Comment` = 'blaumeux SAY_BLAU_DIALOG2' WHERE (`CreatureID` = @BLAUMEUX) AND (`GroupID` = 6);
-- remove duplicate DIALOG1 and DIALOG2 from TAUNT group
DELETE FROM `creature_text` WHERE (`CreatureID` = @BLAUMEUX) AND (`GroupID` = 1) AND (`ID` IN (0, 1)) AND (`Sound` IN (8896, 8897));
UPDATE `creature_text` SET `Comment` = 'blaumeux SAY_BLAU_TAUNT1', `ID` = 0 WHERE  (`CreatureID` = @BLAUMEUX) AND (`GroupID` = 1) AND (`ID` = 2);

SET @RIVENDARE = 30549;
UPDATE `creature_text` SET `Comment` = 'rivendare SAY_RIVE_DIALOG1' WHERE (`CreatureID` = @RIVENDARE) AND (`GroupID` = 5);
UPDATE `creature_text` SET `Comment` = 'rivendare SAY_RIVE_DIALOG2' WHERE (`CreatureID` = @RIVENDARE) AND (`GroupID` = 6);
-- remove duplicate DIALOG1 and DIALOG2 from TAUNT group
DELETE FROM `creature_text` WHERE (`CreatureID` = @RIVENDARE) AND (`GroupID` = 1) AND (`ID` IN (0, 1)) AND (`Sound` IN (14577, 14578));
UPDATE `creature_text` SET `Comment` = 'rivendare SAY_RIVE_TAUNT1', `ID` = 0 WHERE  (`CreatureID` = @RIVENDARE) AND (`GroupID` = 1) AND (`ID` = 2);

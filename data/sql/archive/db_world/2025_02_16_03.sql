-- DB update 2025_02_16_02 -> 2025_02_16_03
--
SET @ZELIEK = 16063;
UPDATE `creature_text` SET `Comment` = 'zeliek SAY_ZELI_DIALOG1' WHERE (`CreatureID` = @ZELIEK) AND (`GroupID` = 5);
UPDATE `creature_text` SET `Comment` = 'zeliek SAY_ZELI_DIALOG2' WHERE (`CreatureID` = @ZELIEK) AND (`GroupID` = 6);
SET @KORTHAZZ = 16064;
UPDATE `creature_text` SET `Comment` = 'korthazz SAY_KORT_DIALOG1' WHERE (`CreatureID` = @KORTHAZZ) AND (`GroupID` = 5);
UPDATE `creature_text` SET `Comment` = 'korthazz SAY_KORT_DIALOG2' WHERE (`CreatureID` = @KORTHAZZ) AND (`GroupID` = 6);
SET @BLAUMEUX = 16065;
UPDATE `creature_text` SET `Comment` = 'blaumeux SAY_BLAU_DIALOG1' WHERE (`CreatureID` = @BLAUMEUX) AND (`GroupID` = 5);
UPDATE `creature_text` SET `Comment` = 'blaumeux SAY_BLAU_DIALOG2' WHERE (`CreatureID` = @BLAUMEUX) AND (`GroupID` = 6);
SET @RIVENDARE = 30549;
UPDATE `creature_text` SET `Comment` = 'rivendare SAY_RIVE_DIALOG1' WHERE (`CreatureID` = @RIVENDARE) AND (`GroupID` = 5);
UPDATE `creature_text` SET `Comment` = 'rivendare SAY_RIVE_DIALOG2' WHERE (`CreatureID` = @RIVENDARE) AND (`GroupID` = 6);

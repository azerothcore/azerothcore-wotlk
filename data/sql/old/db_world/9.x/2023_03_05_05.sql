-- DB update 2023_03_05_04 -> 2023_03_05_05
--
UPDATE `spell_dbc` SET `Effect_1` = 28, `EffectMiscValueB_1` = 64, `EffectBasePoints_1` = 0 WHERE `ID` = 39111;

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceEntry` = 39105);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 39105, 0, 0, 47, 0, 10832, 8, 0, 0, 0, 0, '', 'Player can only use Nether-wraith Beacon (31742) while quest Becoming a Spellfire Tailor (10832) is in progress');

UPDATE `item_template` SET `ScriptName` = '' WHERE (`entry` = 31742);

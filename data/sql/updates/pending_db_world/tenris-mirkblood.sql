SET @SAY_APPROACH = 0,
@SAY_AGGRO = 1,
@SAY_SUMMON = 2;

UPDATE `creature_template` SET `ScriptName` = 'boss_tenris_mirkblood' WHERE `entry` = 28194;

DELETE FROM `creature_text` WHERE `CreatureID` = 28167;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(28194, @SAY_APPROACH, 0, 'I smell... $r.  Delicious!', 14, 0, 100, 0, 0, 0, 27780, 0, 'Prince Tenris Mirkblood - SAY_APPROACH'), -- Nothing sniffed, types need verification
(28194, @SAY_AGGRO, 0, 'I shall consume you!', 14, 0, 100, 0, 0, 0, 27781, 0, 'Prince Tenris Mirkblood - SAY_AGGRO'),
(28194, @SAY_SUMMON, 0, 'Drink, mortals!  Taste my blood!  Taste your death!', 12, 0, 100, 0, 0, 0, 27712, 0, 'Prince Tenris Mirkblood - SAY_SUMMON');

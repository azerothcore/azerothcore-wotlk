-- DB update 2023_01_07_04 -> 2023_01_07_05
--
DELETE FROM `spell_script_names` WHERE `spell_id` IN (31704,31701,31702,31703);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(31704,'spell_the_black_stalker_levitate'),
(31701,'spell_the_black_stalker_levitation_pulse'),
(31702,'spell_the_black_stalker_someone_grab_me'),
(31703,'spell_the_black_stalker_magnetic_pull');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` = 31702;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,31702,0,0,31,0,3,17992,0,0,0,0,"","Group 0: Spell 'Someone Grab Me' (Effect 0) targets creature 'Coilfang Invisible Vacuum Dummy'");

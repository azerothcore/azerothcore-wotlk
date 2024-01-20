-- DB update 2023_05_13_07 -> 2023_05_13_08
--
UPDATE `creature_template` SET `AIName`='', `ScriptName`='npc_violet_hold_defense_system' WHERE `entry`=30837;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 30837);

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 and `SourceEntry` IN (57912, 57930, 58152);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorType`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,57912,0,0,31,0,3,29425,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,57930,0,0,31,0,3,30857,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,0,31,0,3,30661,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,1,31,0,3,30662,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,2,31,0,3,30663,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,3,31,0,3,30664,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,4,31,0,3,30665,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,5,31,0,3,30666,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,6,31,0,3,30667,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,7,31,0,3,30668,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,8,31,0,3,30918,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,9,31,0,3,30961,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,10,31,0,3,30962,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,11,31,0,3,30963,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,12,31,0,3,31007,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,13,31,0,3,31008,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,14,31,0,3,31009,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,15,31,0,3,31010,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,16,31,0,3,31118,0,0,0,0,'','Defense System - Arcane Lightning'),
(13,1,58152,0,17,31,0,3,32191,0,0,0,0,'','Defense System - Arcane Lightning');

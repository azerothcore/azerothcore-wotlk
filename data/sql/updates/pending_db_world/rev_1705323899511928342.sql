DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=698;

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceGroup`=0 AND `SourceEntry` IN (698, 28148) AND `ConditionTypeOrReference`=22 AND `ConditionValue1` IN (30, 489, 529, 566, 607, 628);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 698, 0, 0, 22, 0, 30, 0, 0, 1, 166, 0, '', 'Ritual of Summoning - Restrict Alterac Valley'),
(17, 0, 698, 0, 0, 22, 0, 489, 0, 0, 1, 166, 0, '', 'Ritual of Summoning - Restrict Warsong Gluch'),
(17, 0, 698, 0, 0, 22, 0, 529, 0, 0, 1, 166, 0, '', 'Ritual of Summoning - Restrict Arathi Basin'),
(17, 0, 698, 0, 0, 22, 0, 566, 0, 0, 1, 166, 0, '', 'Ritual of Summoning - Restrict Eye of the Storm'),
(17, 0, 698, 0, 0, 22, 0, 607, 0, 0, 1, 166, 0, '', 'Ritual of Summoning - Restrict Strand of the Ancients'),
(17, 0, 698, 0, 0, 22, 0, 628, 0, 0, 1, 166, 0, '', 'Ritual of Summoning - Restrict Isle of Conquest'),
(17, 0, 28148, 0, 0, 22, 0, 30, 0, 0, 1, 166, 0, '', 'Portal: Karazhan - Restrict Alterac Valley'),
(17, 0, 28148, 0, 0, 22, 0, 489, 0, 0, 1, 166, 0, '', 'Portal: Karazhan - Restrict Warsong Gluch'),
(17, 0, 28148, 0, 0, 22, 0, 529, 0, 0, 1, 166, 0, '', 'Portal: Karazhan - Restrict Arathi Basin'),
(17, 0, 28148, 0, 0, 22, 0, 566, 0, 0, 1, 166, 0, '', 'Portal: Karazhan - Restrict Eye of the Storm'),
(17, 0, 28148, 0, 0, 22, 0, 607, 0, 0, 1, 166, 0, '', 'Portal: Karazhan - Restrict Strand of the Ancients'),
(17, 0, 28148, 0, 0, 22, 0, 628, 0, 0, 1, 166, 0, '', 'Portal: Karazhan - Restrict Isle of Conquest');

--
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceEntry` IN (65875, 67303, 67304, 67305, 65876, 67306, 67307, 67308);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(13, 2, 65875, 0, 0, 31, 0, 3, 34497, 0, 0, 0, 0, '', 'Twin''s Pact (Dark) - Target Fjola Lightbane'),
(13, 2, 67303, 0, 0, 31, 0, 3, 34497, 0, 0, 0, 0, '', 'Twin''s Pact (Dark) - Target Fjola Lightbane'),
(13, 2, 67304, 0, 0, 31, 0, 3, 34497, 0, 0, 0, 0, '', 'Twin''s Pact (Dark) - Target Fjola Lightbane'),
(13, 2, 67305, 0, 0, 31, 0, 3, 34497, 0, 0, 0, 0, '', 'Twin''s Pact (Dark) - Target Fjola Lightbane'),
(13, 2, 65876, 0, 0, 31, 0, 3, 34496, 0, 0, 0, 0, '', 'Twin''s Pact (Light) - Target Eydis Darkbane'),
(13, 2, 67306, 0, 0, 31, 0, 3, 34496, 0, 0, 0, 0, '', 'Twin''s Pact (Light) - Target Eydis Darkbane'),
(13, 2, 67307, 0, 0, 31, 0, 3, 34496, 0, 0, 0, 0, '', 'Twin''s Pact (Light) - Target Eydis Darkbane'),
(13, 2, 67308, 0, 0, 31, 0, 3, 34496, 0, 0, 0, 0, '', 'Twin''s Pact (Light) - Target Eydis Darkbane');

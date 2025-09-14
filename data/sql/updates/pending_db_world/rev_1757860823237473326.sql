-- Update gossip option 0 to show after completing quest The Frostborn King 12873
UPDATE `conditions` 
SET `ConditionTypeOrReference` = 8,
    `ConditionValue1` = 12873,
    `Comment` = 'Show frostborn test gossip only after completing quest The Frostborn King 12873'
WHERE `SourceTypeOrReferenceId` = 15 
AND `SourceGroup` = 9891 
AND `SourceEntry` = 0 
AND `ConditionValue1` = 12874;

-- Add new condition for gossip option 1 to show after accepting quest Pushed too Far 12869
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 15 AND `SourceGroup` = 9891 AND `SourceEntry` = 1;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES 
(15, 9891, 1, 0, 0, 9, 0, 12869, 0, 0, 0, 0, 0, '', 'Show wyrm battle gossip only after accepting quest Pushed too Far 12869');

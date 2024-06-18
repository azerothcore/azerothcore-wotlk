-- 
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 14) AND (`SourceGroup` IN (7552, 7581, 7706));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Jaina Text
(14, 7552, 9168, 0, 0, 13, 0, 0, 3, 2, 1, 0, 0, '', 'Show gossip text if Rage Winterchill is not defeated'),

(14, 7552, 9380, 0, 0, 13, 0, 0, 3, 2, 0, 0, 0, '', 'Show gossip text if Rage Winterchill is defeated'),
(14, 7552, 9380, 0, 0, 13, 0, 1, 3, 2, 1, 0, 0, '', 'Show gossip text if Anetheron is not defeated'),

(14, 7552, 9387, 0, 0, 13, 0, 0, 3, 2, 0, 0, 0, '', 'Show gossip text if Rage Winterchill is defeated'),
(14, 7552, 9387, 0, 0, 13, 0, 1, 3, 2, 0, 0, 0, '', 'Show gossip text if Anetheron is defeated'),

-- Thrall Text
(14, 7581, 9224, 0, 0, 13, 0, 1, 3, 2, 1, 0, 0, '', 'Show gossip text if Anetheron is not defeated'),

(14, 7581, 9225, 0, 0, 13, 0, 1, 3, 2, 0, 0, 0, '', 'Show gossip text if Anetheron is defeated'),
(14, 7581, 9225, 0, 0, 13, 0, 2, 3, 2, 1, 0, 0, '', 'Show gossip text if Kaz\'rogal is not defeated'),

(14, 7581, 9396, 0, 0, 13, 0, 2, 3, 2, 0, 0, 0, '', 'Show gossip text if Kaz\'rogal is defeated'),
(14, 7581, 9396, 0, 0, 13, 0, 3, 3, 2, 1, 0, 0, '', 'Show gossip text if Azgalor is not defeated'),

(14, 7581, 9398, 0, 0, 13, 0, 2, 3, 2, 0, 0, 0, '', 'Show gossip text if Kaz\'rogal is defeated'),
(14, 7581, 9398, 0, 0, 13, 0, 3, 3, 2, 0, 0, 0, '', 'Show gossip text if Azgalor is defeated'),

-- Tyrande Text
(14, 7706, 9408, 0, 0, 13, 0, 1, 3, 2, 1, 0, 0, '', 'Show gossip text if Anetheron is not defeated'),
(14, 7706, 9408, 0, 0, 13, 0, 3, 3, 2, 1, 0, 0, '', 'Show gossip text if Azgalor is not defeated'),

(14, 7706, 9409, 0, 0, 13, 0, 1, 3, 2, 0, 0, 0, '', 'Show gossip text if Anetheron is defeated'),
(14, 7706, 9409, 0, 0, 13, 0, 3, 3, 2, 1, 0, 0, '', 'Show gossip text if Azgalor is not defeated'),

(14, 7706, 9410, 0, 0, 13, 0, 3, 3, 2, 0, 0, 0, '', 'Show gossip text if Azgalor is defeated'),

(14, 7706, 9415, 0, 0, 13, 0, 4, 3, 2, 0, 0, 0, '', 'Show gossip text if Archimonde is defeated');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` IN (7552, 7581, 7706));
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Jaina Options
(15, 7552, 32918, 0, 0, 13, 0, 0, 3, 2, 1, 0, 0, '', 'Show gossip option if Rage Winterchill is not defeated'),

(15, 7552, 32919, 0, 0, 13, 0, 0, 3, 2, 0, 0, 0, '', 'Show gossip option if Rage Winterchill is defeated'),
(15, 7552, 32919, 0, 0, 13, 0, 1, 3, 2, 1, 0, 0, '', 'Show gossip option if Anetheron is not defeated'),

(15, 7552, 32920, 0, 0, 13, 0, 0, 3, 2, 0, 0, 0, '', 'Show gossip option if Rage Winterchill is defeated'),
(15, 7552, 32920, 0, 0, 13, 0, 1, 3, 2, 0, 0, 0, '', 'Show gossip option if Anetheron is defeated'),

-- Thrall Options
(15, 7581, 35378, 0, 0, 13, 0, 1, 3, 2, 0, 0, 0, '', 'Show gossip option if Anetheron is defeated'),
(15, 7581, 35378, 0, 0, 13, 0, 2, 3, 2, 1, 0, 0, '', 'Show gossip option if Kaz\'rogal is not defeated'),

(15, 7581, 35377, 0, 0, 13, 0, 2, 3, 2, 0, 0, 0, '', 'Show gossip option if Kaz\'rogal is defeated'),
(15, 7581, 35377, 0, 0, 13, 0, 3, 3, 2, 1, 0, 0, '', 'Show gossip option if Azgalor is not defeated'),

(15, 7581, 35379, 0, 0, 13, 0, 2, 3, 2, 0, 0, 0, '', 'Show gossip option if Kaz\'rogal is defeated'),
(15, 7581, 35379, 0, 0, 13, 0, 3, 3, 2, 0, 0, 0, '', 'Show gossip option if Azgalor is defeated'),

-- Tyrande Options
(15, 7706, 34158, 0, 0, 13, 0, 3, 3, 2, 0, 0, 0, '', 'Show gossip option if Azgalor is defeated'),
(15, 7706, 34158, 0, 0, 13, 0, 4, 3, 2, 1, 0, 0, '', 'Show gossip option if Archimonde is not defeated');

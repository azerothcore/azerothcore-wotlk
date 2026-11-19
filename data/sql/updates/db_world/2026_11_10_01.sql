-- DB update 2026_11_10_00 -> 2026_11_10_01
--
-- Barrett Ramsey (35909) offered the Trial of the Grand Crusader only for the raid size whose Call of the Crusade
-- the player owned, because each achievement was ANDed with a matching 10/25 player heroic spawn mask.
-- Either achievement now unlocks the encounter on both heroic sizes.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 10704) AND (`SourceEntry` = 1) AND (`ElseGroup` = 1);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 10704) AND (`SourceEntry` = 1) AND (`ConditionTypeOrReference` = 17) AND (`ConditionValue1` = 3917);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 10704, 1, 0, 0, 17, 0, 3917, 0, 0, 1, 0, 0, '', 'Barrett Ramsey - Show gossip option if player lacks Call of the Crusade (10 player)');
UPDATE `conditions` SET `ConditionValue1` = 12, `Comment` = 'Barrett Ramsey - Show gossip option if in 10 or 25 player heroic' WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 10704) AND (`ConditionTypeOrReference` = 19) AND (`ConditionValue1` IN (4, 8));

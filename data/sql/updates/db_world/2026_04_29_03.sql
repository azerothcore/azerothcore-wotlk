-- DB update 2026_04_29_02 -> 2026_04_29_03
-- Allow Eye of Dominion (Rise of Suffering, GO 193424 / gossip menu 10111) to
-- show its "Seize control of a Lithe Stalker" gossip option for quest 13160
-- (Stunning View). Without this row players who have only Stunning View active
-- see no gossip option and cannot progress the quest.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 15) AND (`SourceGroup` = 10111) AND (`SourceEntry` = 0) AND (`SourceId` = 0) AND (`ElseGroup` = 3) AND (`ConditionTypeOrReference` = 9) AND (`ConditionValue1` = 13160);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(15, 10111, 0, 0, 3, 9, 0, 13160, 0, 0, 0, 0, 0, '', 'Show Gossip option only if player has quest Stunning View active');

-- DB update 2026_06_18_01 -> 2026_06_18_02
-- DB update 2026_06_11_02 -> 2026_06_15_00
--
-- Fix Brann Bronzebeard (33235) SAI condition for Assembly of Iron completion check.
-- ConditionValue3=0 (INSTANCE_INFO_DATA) calls GetData() which has no handler for
-- BOSS_ASSEMBLY_OF_IRON (4) in Ulduar, always returning 0. The correct type is
-- ConditionValue3=2 (INSTANCE_INFO_BOSS_STATE) which calls GetBossState(4) == DONE(3).
DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceGroup` = 13 AND `SourceEntry` = 33235;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 13, 33235, 0, 0, 13, 1, 4, 3, 2, 0, 0, 0, '', 'Execute SAI only if Assembly of Iron Done');

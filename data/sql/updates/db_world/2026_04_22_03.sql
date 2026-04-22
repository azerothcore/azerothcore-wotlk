-- DB update 2026_04_22_02 -> 2026_04_22_03
--
-- Removes 'Twilight Torment - Target players which has phase mask 1';
-- This does not work as described in the comment, nor is it accurate.
-- This condition is also only set for the Vesperon Twilight Torment
-- application, not for the Sartharion fight.
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 57935) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 26) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 1) AND (`ConditionValue2` = 0) AND (`ConditionValue3` = 0);

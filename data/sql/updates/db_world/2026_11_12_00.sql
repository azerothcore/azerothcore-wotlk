-- DB update 2026_11_11_00 -> 2026_11_12_00
--
-- AQ40 boss state ids now match DungeonEncounter.dbc encounter indexes (Skeram 0 ... C'thun 8), so the
-- Andorgos gossip conditions that check Twin Emperors and Ouro have to move down by one as well.
-- ConditionValue1 is part of the conditions primary key (NegativeCondition is not), so every statement is
-- keyed on SourceEntry + NegativeCondition; anchoring on the old value alone makes a re-run collide.

-- Twin Emperors: 7 -> 6
UPDATE `conditions` SET `ConditionValue1`=6 WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=6644 AND `SourceEntry`=7899 AND `ConditionTypeOrReference`=13 AND `ConditionValue3`=2 AND `ConditionValue1`=7 AND `NegativeCondition`=1;
UPDATE `conditions` SET `ConditionValue1`=6 WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=6644 AND `SourceEntry`=8701 AND `ConditionTypeOrReference`=13 AND `ConditionValue3`=2 AND `ConditionValue1`=7 AND `NegativeCondition`=0;
UPDATE `conditions` SET `ConditionValue1`=6 WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=6644 AND `SourceEntry`=0 AND `ConditionTypeOrReference`=13 AND `ConditionValue3`=2 AND `ConditionValue1`=7;

-- Ouro: 8 -> 7
UPDATE `conditions` SET `ConditionValue1`=7 WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=6644 AND `SourceEntry`=8701 AND `ConditionTypeOrReference`=13 AND `ConditionValue3`=2 AND `ConditionValue1`=8 AND `NegativeCondition`=1;
UPDATE `conditions` SET `ConditionValue1`=7 WHERE `SourceTypeOrReferenceId`=14 AND `SourceGroup`=6644 AND `SourceEntry`=8702 AND `ConditionTypeOrReference`=13 AND `ConditionValue3`=2 AND `ConditionValue1`=8 AND `NegativeCondition`=0;
UPDATE `conditions` SET `ConditionValue1`=7 WHERE `SourceTypeOrReferenceId`=15 AND `SourceGroup`=6644 AND `SourceEntry`=1 AND `ConditionTypeOrReference`=13 AND `ConditionValue3`=2 AND `ConditionValue1`=8;

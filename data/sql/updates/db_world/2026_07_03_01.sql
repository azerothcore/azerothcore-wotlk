-- DB update 2026_07_03_00 -> 2026_07_03_01
-- Ulduar Teleporter (194569) activation SAI + conditions (entry-level, targets
-- each guid explicitly so the shared gossip menu isn't overridden)
UPDATE `gameobject` SET `state` = 0 WHERE `guid` = 34283;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 194569 AND `source_type` = 1 AND `id` BETWEEN 13 AND 20;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
     `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`,
     `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`,
     `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`,
     `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
    (194569, 1, 13, 0, 1, 0, 100, 0, 1000, 3000, 10000, 15000, 0, 0, 118, 0, 0, 0, 0, 0, 0,
     14, 34288, 194569, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Update OOC - Activate Formation Grounds'),
    (194569, 1, 14, 0, 1, 0, 100, 0, 1000, 3000, 10000, 15000, 0, 0, 118, 0, 0, 0, 0, 0, 0,
     14, 34223, 194569, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Update OOC - Activate Colossal Forge'),
    (194569, 1, 15, 0, 1, 0, 100, 0, 1000, 3000, 10000, 15000, 0, 0, 118, 0, 0, 0, 0, 0, 0,
     14, 34296, 194569, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Update OOC - Activate Scrapyard'),
    (194569, 1, 16, 0, 1, 0, 100, 0, 1000, 3000, 10000, 15000, 0, 0, 118, 0, 0, 0, 0, 0, 0,
     14, 34935, 194569, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Update OOC - Activate Antechamber'),
    (194569, 1, 17, 0, 1, 0, 100, 0, 1000, 3000, 10000, 15000, 0, 0, 118, 0, 0, 0, 0, 0, 0,
     14, 34219, 194569, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Update OOC - Activate Shattered Walkway'),
    (194569, 1, 18, 0, 1, 0, 100, 0, 1000, 3000, 10000, 15000, 0, 0, 118, 0, 0, 0, 0, 0, 0,
     14, 34281, 194569, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Update OOC - Activate Conservatory'),
    (194569, 1, 19, 0, 1, 0, 100, 0, 1000, 3000, 10000, 15000, 0, 0, 118, 0, 0, 0, 0, 0, 0,
     14, 56100, 194569, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Update OOC - Activate Halls of Invention'),
    (194569, 1, 20, 0, 1, 0, 100, 0, 1000, 3000, 10000, 15000, 0, 0, 118, 0, 0, 0, 0, 0, 0,
     14, 34923, 194569, 0, 0, 0, 0, 0, 0, 'Ulduar Teleporter - On Update OOC - Activate Prison of Yogg-Saron');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 194569 AND `SourceId` = 1 AND `SourceGroup` BETWEEN 14 AND 21;
INSERT INTO `conditions`
    (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`,
     `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`,
     `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`)
VALUES
    (22, 14, 194569, 1, 0, 13, 1, 0, 0, 2, 1, 0, 0, '', 'Formation Grounds active once Leviathan engaged'),
    (22, 15, 194569, 1, 0, 13, 1, 0, 3, 2, 0, 0, 0, '', 'Colossal Forge active once Leviathan defeated'),
    (22, 16, 194569, 1, 0, 13, 1, 3, 3, 2, 0, 0, 0, '', 'Scrapyard active once XT-002 defeated'),
    (22, 17, 194569, 1, 0, 13, 1, 3, 3, 2, 0, 0, 0, '', 'Antechamber active once XT-002 defeated'),
    (22, 18, 194569, 1, 0, 13, 1, 5, 3, 2, 0, 0, 0, '', 'Shattered Walkway active once Kologarn defeated'),
    (22, 19, 194569, 1, 0, 13, 1, 6, 3, 2, 0, 0, 0, '', 'Conservatory active once Auriaya defeated'),
    (22, 20, 194569, 1, 0, 13, 1, 9, 0, 2, 1, 0, 0, '', 'Halls of Invention active once Mimiron engaged'),
    (22, 21, 194569, 1, 0, 13, 1, 11, 3, 2, 0, 0, 0, '', 'Prison of Yogg-Saron active once Vezax defeated');

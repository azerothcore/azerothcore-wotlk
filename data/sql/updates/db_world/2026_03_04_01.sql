-- DB update 2026_03_04_00 -> 2026_03_04_01
--
DELETE FROM `gameobject_summon_groups` WHERE `summonerId` = 3737 AND `summonerType` = 1;
INSERT INTO `gameobject_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `respawnTime`, `Comment`) VALUES
(3737, 1, 0, 3743, -1271.309814453125, -3013.196533203125, 71.92229461669921875, 0.488691210746765136, 0, 0, 0.241921424865722656, 0.970295846462249755, 120, 'Bubbling Fissure - Fissure Plant'),
(3737, 1, 0, 3743, -1272.32763671875, -3010.503662109375, 71.3295440673828125, 5.602506637573242187, 0, 0, -0.33380699157714843, 0.942641437053680419, 120, 'Bubbling Fissure - Fissure Plant'),
(3737, 1, 0, 3743, -1272.4622802734375, -3016.277099609375, 72.82135009765625, 0.593410074710845947, 0, 0, 0.292370796203613281, 0.95630502700805664, 120, 'Bubbling Fissure - Fissure Plant'),
(3737, 1, 0, 3743, -1273.7415771484375, -3017.27490234375, 73.04929351806640625, 3.78736734390258789, 0, 0, -0.94832324981689453, 0.317305892705917358, 120, 'Bubbling Fissure - Fissure Plant'),
(3737, 1, 0, 3743, -1274.7701416015625, -3008.184814453125, 71.509735107421875, 0, 0, 0, 0, 1, 120, 'Bubbling Fissure - Fissure Plant'),
(3737, 1, 0, 3743, -1275.597900390625, -3016.52978515625, 72.68366241455078125, 3.508116960525512695, 0, 0, -0.98325443267822265, 0.182238012552261352, 120, 'Bubbling Fissure - Fissure Plant'),
(3737, 1, 0, 3743, -1277.4346923828125, -3009.509521484375, 71.5238800048828125, 0, 0, 0, 0, 1, 120, 'Bubbling Fissure - Fissure Plant'),
(3737, 1, 0, 3743, -1278.46435546875, -3015.849853515625, 72.256317138671875, 0, 0, 0, 0, 1, 120, 'Bubbling Fissure - Fissure Plant'),
(3737, 1, 0, 3743, -1279.0081787109375, -3010.58642578125, 71.55875396728515625, 2.076939344406127929, 0, 0, 0.861628532409667968, 0.50753939151763916, 120, 'Bubbling Fissure - Fissure Plant'),
(3737, 1, 0, 3743, -1279.7412109375, -3013.78369140625, 71.58141326904296875, 3.804818391799926757, 0, 0, -0.94551849365234375, 0.325568377971649169, 120, 'Bubbling Fissure - Fissure Plant');

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 3737) AND (`source_type` = 1) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(3737, 1, 1, 0, 71, 0, 100, 0, 525, 0, 0, 0, 0, 0, 241, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Bubbling Fissure - On Event 525 Inform - Spawn Fissure Plants Nearby');

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` = 2) AND (`SourceEntry` = 3737) AND (`SourceId` = 1) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 30) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 3743) AND (`ConditionValue2` = 10) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(22, 2, 3737, 1, 0, 30, 1, 3743, 10, 0, 1, 0, 0, '', 'Only Spawn Fissure Plants if there are none already nearby.');

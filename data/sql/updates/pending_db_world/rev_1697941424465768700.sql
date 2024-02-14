-- 28282 is buff
DELETE
FROM `spell_custom_attr`
WHERE `spell_id` = 28282;
INSERT INTO `spell_custom_attr` (`spell_id`, `attributes`) VALUES (28282, 67108864);

-- It takes time to open the door with a key in Blizzard servers
UPDATE `gameobject_template_addon` SET `flags` = 34
WHERE (`entry` = 104591);


-- Add a trigger for Ashbringer events Fire once after approaching
DELETE
FROM `areatrigger_scripts`
WHERE `entry` = 4089;
INSERT INTO `areatrigger_scripts` (`entry`, `ScriptName`) VALUES
 (4089, 'at_scarlet_monastery_cathedral_entrance');

-- Scarlet Commander Mograine say--
DELETE
FROM `creature_text`
WHERE `CreatureID`=3976;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
 (3976, 0, 0, 'Infidels! They must be purified!', 14, 0, 100, 0, 0, 5835, 2847, 0, 'mograine SAY_MO_AGGRO'),
 (3976, 1, 0, 'Unworthy.', 14, 0, 100, 0, 0, 5836, 6197, 0, 'mograine SAY_MO_KILL'),
 (3976, 2, 0, 'At your side, milady!', 14, 0, 100, 15, 0, 5837, 18026, 0, 'mograine SAY_MO_RESSURECTED'),
 (3976, 3, 0, 'You hold my father\'s blade, $n. My soldiers are yours TO control, my $g Lord:Lady;. Take them... LEAD them... The impure must be purged. They must be cleansed of their taint.', 12, 0, 100, 1, 0, 0, 12390, 0, 'mograine SAY_ASHBRINGER_ONE'),
 (3976, 4, 0, 'Father... But... How?', 12, 0, 100, 6, 0, 0, 12470, 0, 'mograine SAY_ASHBRINGER_TWO'),
 (3976, 5, 0, 'Forgive me, father! Please...', 12, 0, 100, 20, 0, 0, 12472, 0, 'mograine SAY_ASHBRINGER_THREE'),
 (3976, 6, 0, 'Bow down! Kneel BEFORE the Ashbringer! A NEW dawn approaches, brothers AND sisters! Our message will be delivered TO the filth of this world through the chosen one!', 14, 0, 100, 0, 0, 0, 12389, 0, 'Ashbringer EVENT intro yell');

-- Highlord Mograine ---
-- Highlord Mograine say
DELETE FROM `creature_text` WHERE `CreatureID`=16062;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `Type`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
 (16062, 0, 0, 'Renault...', 0, 100, 25, 0, 0, 12, 12469, 0, 'mograine MOGRAINE_ONE'),
 (16062, 1, 0, 'Did you think that your betrayal would be forgotten? Lost in the carefully planned cover up of my death? Blood of my blood, the blade felt your cruelty long after my heart had stopped beating. And in death, I knew what you had done. But now, the chains of Kel\'thuzad hold me NO more. I come TO serve justice. I AM ASHBRINGER.', 0, 100, 6, 0, 0, 12, 12471, 0, 'mograine MOGRAINE_TWO'),
 (16062, 2, 0, 'You are forgiven...', 0, 100, 0, 0, 0, 12, 12473, 0, 'mograine MOGRAINE_THREE');

-- Highlord Mograine smart_scripts---
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 16062;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 16062);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(16062, 0, 0, 0, 54, 0, 100, 0, 0, 0, 0, 0, 0, 0, 53, 0, 16062, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine Transform - Just_Summoned - Start Waypoint (No Repeat)'),
(16062, 0, 1, 0, 40, 0, 100, 0, 12, 0, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 19, 3976, 0, 0, 0, 0, 0, 0, 0, 'Highlord Mograine Transform - On Waypoint 12 Reached - Set Rooted On');



-- The coordinates of the movement sniffed
DELETE
FROM `waypoints`
WHERE `entry`=16062;
INSERT INTO `waypoints` (`entry`, `pointid`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `point_comment`) VALUES
(16062, 1, 1033.4642, 1399.1022, 27.337427, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 2, 1034.9252, 1399.0653, 27.393204, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 3, 1036.3861, 1399.0284, 27.44898, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 4, 1045.484, 1398.7991, 27.448977, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 5, 1059.524, 1399.0273, 28.271557, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 6, 1068.8096, 1399.2064, 30.7867, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 7, 1086.6564, 1399.2048, 30.44898, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 8, 1101.5681, 1399.3694, 30.485447, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 9, 1116.6019, 1399.4752, 30.485447, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 10, 1129.5881, 1399.2926, 30.524086, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 11, 1149.4045, 1399.0231, 32.528877, NULL, 0, 'Ashbringer Event Move Points'),
(16062, 12, 1150.3911, 1398.723, 32.54613, NULL, 0, 'Ashbringer Event Move Points');

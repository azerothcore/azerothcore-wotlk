--
-- Quest 12478 "Frostmourne Cavern": Arthas (27455) spoke his opening line before he was
-- visible, his replies overtook their cues, he repeated his last line, and Muradin (27480)
-- vanished on the spot instead of leaving. Retimed against the quest cinematic.
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` = 2745500);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
    (2745500,9,0,0,0,0,100,0,7000,7000,0,0,0,0,47,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Set Visible'),
    (2745500,9,1,0,0,0,100,0,0,0,0,0,0,0,118,0,0,0,0,0,0,15,190332,20,0,0,0,0,0,0,'Script9 - Set GO State'),
    (2745500,9,2,0,0,0,100,0,0,0,0,0,0,0,12,27480,8,0,0,0,0,8,0,0,0,0,4816.75,-580.34,162.99,5.37,'Script9 - Summon Creature'),
    (2745500,9,3,0,0,0,100,0,2000,2000,0,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Talk'),
    (2745500,9,4,0,0,0,100,0,40000,40000,0,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Talk'),
    (2745500,9,5,0,0,0,100,0,13000,13000,0,0,0,0,1,6,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Talk'),
    (2745500,9,6,0,0,0,100,0,8000,8000,0,0,0,0,1,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Talk'),
    (2745500,9,8,0,0,0,100,0,0,0,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,4820.36,-582.3,163.8,4,'Script9 - Move Point'),
    (2745500,9,9,0,0,0,100,0,5000,5000,0,0,0,0,11,49824,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Cast Spell'),
    (2745500,9,10,0,0,0,100,0,11000,11000,0,0,0,0,118,1,0,0,0,0,0,15,190332,20,0,0,0,0,0,0,'Script9 - Set GO State'),
    (2745500,9,11,0,0,0,100,0,0,0,0,0,0,0,71,0,1,36942,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Set Equip'),
    (2745500,9,12,0,0,0,100,0,500,500,0,0,0,0,5,25,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Play Emote'),
    (2745500,9,13,0,0,0,100,0,0,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Set Run'),
    (2745500,9,14,0,0,0,100,0,4000,4000,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,4809.08,-574.8,160.91,2.9,'Script9 - Move Point'),
    (2745500,9,15,0,0,0,100,0,4000,4000,0,0,0,0,5,15,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Play Emote'),
    (2745500,9,16,0,0,0,100,0,4000,4000,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,4767,-567,163,3,'Script9 - Move Point'),
    (2745500,9,17,0,0,0,100,0,7000,7000,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Despawn');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` = 2748000);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
    (2748000,9,0,0,0,0,100,0,8000,8000,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,4818.63,-582.84,163.54,5.2,'Script9 - Move Point'),
    (2748000,9,1,0,0,0,100,0,5000,5000,0,0,0,0,1,2,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Talk'),
    (2748000,9,2,0,0,0,100,0,0,0,0,0,0,0,11,68442,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Cast Spell'),
    (2748000,9,3,0,0,0,100,0,16000,16000,0,0,0,0,28,68442,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Remove Aura'),
    (2748000,9,4,0,0,0,100,0,0,0,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0.7,'Script9 - Set Orientation'),
    (2748000,9,5,0,0,0,100,0,5000,5000,0,0,0,0,5,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Play Emote'),
    (2748000,9,6,0,0,0,100,0,2000,2000,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,4816.75,-580.34,162.99,5.37,'Script9 - Move Point'),
    (2748000,9,7,0,0,0,100,0,2000,2000,0,0,0,0,66,0,0,0,0,0,0,8,0,0,0,0,0,0,0,6.13,'Script9 - Set Orientation'),
    (2748000,9,8,0,0,0,100,0,9000,9000,0,0,0,0,1,3,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Script9 - Talk'),
    (2748000,9,9,0,0,0,100,0,32000,32000,0,0,0,0,40,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Muradin - On Script - Set Sheath Unarmed'),
    (2748000,9,10,0,0,0,100,0,0,0,0,0,0,0,90,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Muradin - On Script - Set Stand State Dead'),
    (2748000,9,11,0,0,0,100,0,13000,13000,0,0,0,0,91,7,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Muradin - On Script - Remove Stand State Dead'),
    (2748000,9,12,0,0,0,100,0,500,500,0,0,0,0,17,64,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Muradin - On Script - Set Emote State 64'),
    (2748000,9,13,0,0,0,100,0,5000,5000,0,0,0,0,1,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Muradin - On Script - Say Line 4'),
    (2748000,9,14,0,0,0,100,0,3000,3000,0,0,0,0,1,5,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Muradin - On Script - Say Line 5'),
    (2748000,9,15,0,0,0,100,0,4000,4000,0,0,0,0,17,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Muradin - On Script - Set Emote State 0'),
    (2748000,9,16,0,0,0,100,0,1000,1000,0,0,0,0,11,49829,3,0,0,0,0,1,0,0,0,0,0,0,0,0,'Muradin - On Script - Cast \'Frostmourne Cavern Quest Credit\''),
    (2748000,9,17,0,0,0,100,0,0,0,0,0,0,0,59,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Muradin - On Script - Set Run'),
    (2748000,9,18,0,0,0,100,0,0,0,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,4809.08,-574.8,160.91,2.9,'Muradin - On Script - Move Point'),
    (2748000,9,19,0,0,0,100,0,1000,1000,0,0,0,0,69,0,0,0,0,0,0,8,0,0,0,0,4767,-567,163,3,'Muradin - On Script - Move Point'),
    (2748000,9,20,0,0,0,100,0,7000,7000,0,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Muradin - On Script - Despawn');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9) AND (`entryorguid` = 2748001);
DELETE FROM `waypoints` WHERE (`entry` = 27480);

-- Group 8 is a duplicate of group 7, unreferenced once the repeated line is gone.
DELETE FROM `creature_text_locale` WHERE (`CreatureID` = 27455) AND (`GroupID` = 8);
DELETE FROM `creature_text` WHERE (`CreatureID` = 27455) AND (`GroupID` = 8);

-- DB update 2022_08_27_02 -> 2022_08_27_03
--
UPDATE `creature_template` SET `ScriptName`='npc_wintergarde_gryphon' WHERE `entry`=27258;

DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 48397) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 30) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 188679) AND (`ConditionValue2` = 15) AND (`ConditionValue3` = 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 48363) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 27315) AND (`ConditionValue2` = 5) AND (`ConditionValue3` = 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 48363) AND (`SourceId` = 0) AND (`ElseGroup` = 1) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 27336) AND (`ConditionValue2` = 5) AND (`ConditionValue3` = 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 48397) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 27315) AND (`ConditionValue2` = 5) AND (`ConditionValue3` = 0);
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 48397) AND (`SourceId` = 0) AND (`ElseGroup` = 1) AND (`ConditionTypeOrReference` = 29) AND (`ConditionTarget` = 0) AND (`ConditionValue1` = 27336) AND (`ConditionValue2` = 5) AND (`ConditionValue3` = 0);

-- fly speed 200%
UPDATE `creature_template_addon` SET `bytes1` = 50331648, `auras` = '60534' WHERE (`entry` = 27258);

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_q12237_rescue_villager';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_q12237_drop_off_villager';
DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_call_wintergarde_gryphon';
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(48363, 'spell_q12237_rescue_villager'),
(48397, 'spell_q12237_drop_off_villager'),
(48388, 'spell_call_wintergarde_gryphon');

DELETE FROM `creature_text` WHERE `creatureid` IN (27336,27315);
INSERT INTO `creature_text` (`creatureid`,`groupid`,`id`,`text`,`type`,`language`,`probability`,`emote`,`duration`,`sound`,`broadcasttextid`,`textrange`,`comment`) VALUES
(27336,0,0,"HELP! HELP!",12,0,100,0,0,0,26342,0, "Helpless Wintergarde Villager"),
(27336,0,1,"I'll die before I let one of you fiends turn me!",12,0,100,0,0,0,26347,0, "Helpless Wintergarde Villager"),
(27336,0,2,"THEY'RE TRYING TO KILL ME! HELP!",12,0,100,0,0,0,26346,0, "Helpless Wintergarde Villager"),
(27336,0,3,"Where did this all come from! Somebody help!",12,0,100,0,0,0,26348,0, "Helpless Wintergarde Villager"),
(27336,0,4,"YOU'LL NEVER CATCH ME, FIENDS!",12,0,100,0,0,0,26343,0, "Helpless Wintergarde Villager"),
(27336,1,0,"Are you sure you know how to fly this thing? Feels a little wobbly.",12,0,100,0,0,0,26359,0, "Helpless Wintergarde Villager"),
(27336,1,1,"For the love of the Light, get me out of here!",12,0,100,0,0,0,26344,0, "Helpless Wintergarde Villager"),
(27336,1,2,"I don't mean to sound ungrateful, but could you fly a little closer to the ground? I hate heights!",12,0,100,0,0,0,26360,0, "Helpless Wintergarde Villager"),
(27336,1,3,"I picked a bad day to stop drinking!",12,0,100,0,0,0,26345,0, "Helpless Wintergarde Villager"),
(27336,1,4,"I'm gettin' a little woozy... Oooooof...",12,0,100,0,0,0,26364,0, "Helpless Wintergarde Villager"),
(27336,1,5,"Who woulda thought that we'd have this problem again? Oh wait, EVERYBODY DID!",12,0,100,0,0,0,26349,0, "Helpless Wintergarde Villager"),
(27336,2,0,"How can I ever repay you for this, friend?",12,0,100,0,0,0,26363,0, "Helpless Wintergarde Villager"),
(27336,2,1,"HURRAY!",12,0,100,0,0,0,26382,0, "Helpless Wintergarde Villager"),
(27336,2,2,"Kindness is not lost with this one, Urik. Thank you, hero!",12,0,100,0,0,0,26383,0, "Helpless Wintergarde Villager"),
(27336,2,3,"My shop's doors will always be open to you, friend.",12,0,100,0,0,0,26385,0, "Helpless Wintergarde Villager"),
(27336,2,4,"Safe at last! Thank you, stranger!",12,0,100,0,0,0,26381,0, "Helpless Wintergarde Villager"),
(27336,2,5,"Thanks for your help, hero!",12,0,100,0,0,0,26357,0, "Helpless Wintergarde Villager"),
(27336,2,6,"We made it! We actually made it!",12,0,100,0,0,0,26384,0, "Helpless Wintergarde Villager"),
(27336,2,7,"You are my guardian angel! Like a white knight you flew in from the heavens and lifted me from the pit of damnation!",12,0,100,0,0,0,26362,0, "Helpless Wintergarde Villager"),
(27336,2,8,"You saved my life! Thanks!",12,0,100,0,0,0,26358,0, "Helpless Wintergarde Villager"),
(27315,0,0,"HELP! HELP!",12,0,100,0,0,0,26342,0, "Helpless Wintergarde Villager"),
(27315,0,1,"I'll die before I let one of you fiends turn me!",12,0,100,0,0,0,26347,0, "Helpless Wintergarde Villager"),
(27315,0,2,"THEY'RE TRYING TO KILL ME! HELP!",12,0,100,0,0,0,26346,0, "Helpless Wintergarde Villager"),
(27315,0,3,"Where did this all come from! Somebody help!",12,0,100,0,0,0,26348,0, "Helpless Wintergarde Villager"),
(27315,0,4,"YOU'LL NEVER CATCH ME, FIENDS!",12,0,100,0,0,0,26343,0, "Helpless Wintergarde Villager"),
(27315,1,0,"Are you sure you know how to fly this thing? Feels a little wobbly.",12,0,100,0,0,0,26359,0, "Helpless Wintergarde Villager"),
(27315,1,1,"For the love of the Light, get me out of here!",12,0,100,0,0,0,26344,0, "Helpless Wintergarde Villager"),
(27315,1,2,"I don't mean to sound ungrateful, but could you fly a little closer to the ground? I hate heights!",12,0,100,0,0,0,26360,0, "Helpless Wintergarde Villager"),
(27315,1,3,"I picked a bad day to stop drinking!",12,0,100,0,0,0,26345,0, "Helpless Wintergarde Villager"),
(27315,1,4,"I'm gettin' a little woozy... Oooooof...",12,0,100,0,0,0,26364,0, "Helpless Wintergarde Villager"),
(27315,1,5,"Who woulda thought that we'd have this problem again? Oh wait, EVERYBODY DID!",12,0,100,0,0,0,26349,0, "Helpless Wintergarde Villager"),
(27315,2,0,"How can I ever repay you for this, friend?",12,0,100,0,0,0,26363,0, "Helpless Wintergarde Villager"),
(27315,2,1,"HURRAY!",12,0,100,0,0,0,26382,0, "Helpless Wintergarde Villager"),
(27315,2,2,"Kindness is not lost with this one, Urik. Thank you, hero!",12,0,100,0,0,0,26383,0, "Helpless Wintergarde Villager"),
(27315,2,3,"My shop's doors will always be open to you, friend.",12,0,100,0,0,0,26385,0, "Helpless Wintergarde Villager"),
(27315,2,4,"Safe at last! Thank you, stranger!",12,0,100,0,0,0,26381,0, "Helpless Wintergarde Villager"),
(27315,2,5,"Thanks for your help, hero!",12,0,100,0,0,0,26357,0, "Helpless Wintergarde Villager"),
(27315,2,6,"We made it! We actually made it!",12,0,100,0,0,0,26384,0, "Helpless Wintergarde Villager"),
(27315,2,7,"You are my guardian angel! Like a white knight you flew in from the heavens and lifted me from the pit of damnation!",12,0,100,0,0,0,26362,0, "Helpless Wintergarde Villager"),
(27315,2,8,"You saved my life! Thanks!",12,0,100,0,0,0,26358,0, "Helpless Wintergarde Villager");

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27315;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27315);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27315, 0, 0, 1, 8, 0, 100, 512, 48363, 0, 0, 0, 0, 28, 49774, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - On Spellhit \'Rescue Villager\' - Remove Aura \'Cower + Fear Visual\''),
(27315, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - On Spellhit \'Rescue Villager\' - Set Event Phase 2'),
(27315, 0, 2, 0, 1, 2, 100, 1, 18000, 18000, 18000, 18000, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - Out of Combat - Say Line 1 (Phase 2) (No Repeat)'),
(27315, 0, 3, 0, 23, 2, 100, 1, 43671, 0, 1000, 1000, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - On Aura \'Ride Vehicle\' - Say Line 2 (Phase 2) (No Repeat)'),
(27315, 0, 4, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - On Update - Set Event Phase 1 (No Repeat)'),
(27315, 0, 5, 0, 1, 1, 100, 0, 30000, 45000, 50000, 50000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - Out of Combat - Say Line 0 (Phase 1)'),
(27315, 0, 6, 0, 1, 1, 100, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - Out of Combat - Set Reactstate Passive (Phase 1)');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 27336;

DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = 27336);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(27336, 0, 0, 1, 8, 0, 100, 512, 48363, 0, 0, 0, 0, 28, 49774, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - On Spellhit \'Rescue Villager\' - Remove Aura \'Cower + Fear Visual\''),
(27336, 0, 1, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - On Spellhit \'Rescue Villager\' - Set Event Phase 2'),
(27336, 0, 2, 0, 1, 2, 100, 1, 18000, 18000, 18000, 18000, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - Out of Combat - Say Line 1 (Phase 2) (No Repeat)'),
(27336, 0, 3, 0, 23, 2, 100, 1, 43671, 0, 1000, 1000, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - On Aura \'Ride Vehicle\' - Say Line 2 (Phase 2) (No Repeat)'),
(27336, 0, 4, 0, 60, 0, 100, 1, 0, 0, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - On Update - Set Event Phase 1 (No Repeat)'),
(27336, 0, 5, 0, 1, 1, 100, 0, 30000, 45000, 50000, 50000, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - Out of Combat - Say Line 0 (Phase 1)'),
(27336, 0, 6, 0, 1, 1, 100, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Helpless Wintergarde Villager - Out of Combat - Set Reactstate Passive (Phase 1)');

-- ------------------------------------------------------------------------------------
-- SKADI THE RUTHLESS - ENABLE Achievement GIRL LOVE TO SKADI and grauf - complete boss rework
-- ------------------------------------------------------------------------------------

UPDATE `creature_template` SET `InhabitType`=4 WHERE  `entry`=26893;
UPDATE `creature_template` SET `InhabitType`=4 WHERE  `entry`=30775;
UPDATE `creature_template` SET `ScriptName`='npc_grauf' WHERE  `entry`=26893;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=23472;
UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=19871;

DELETE FROM `conditions` where `SourceTypeOrReferenceId` = 13 AND   `SourceGroup` = 1 AND  `SourceEntry` IN (47593,47594,47563,51368);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES (13, 1, 47593, 31, 3, 28351);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES (13, 1, 47594, 31, 3, 28351);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES (13, 1, 47563, 31, 3, 28351);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES (13, 1, 51368, 31, 3, 26893);

DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (47563,47593);
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (47563, 47574, 0, 'Freezin Trap - Left');
INSERT INTO `spell_linked_spell` (`spell_trigger`, `spell_effect`, `type`, `comment`) VALUES (47593, 47594, 0, 'Freezin Trap - Right');

DELETE FROM `spell_script_names` WHERE `spell_id` IN ( 47574,47594,50255,59331);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (47574, 'spell_freezing_cloud_area_left');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (47594, 'spell_freezing_cloud_area_right');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (50255, 'spell_skadi_poisoned_spear');
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES (59331, 'spell_skadi_poisoned_spear');

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=28351;

DELETE FROM smart_scripts where entryorguid = 28351 and source_type = 0 and id IN (0,1);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (28351, 0, 0, 0, 8, 0, 100, 0, 47594, 0, 0, 0, 11, 47579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flame Breath Trigger - Cast Freezing Trap AoE');
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (28351, 0, 1, 0, 8, 0, 100, 0, 47574, 0, 0, 0, 11, 47579, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Flame Breath Trigger - Cast Freezing Trap AoE');

DELETE FROM creature_text where entry IN (26893,23472,19871) and groupid = 0 and id = 0;
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextID`) VALUES (26893, 0, 0, '%s takes a deep breath!', 41, 0, 100, 0, 0, 0, 'Grauf - Emote', 20774);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextID`) VALUES (23472, 0, 0, 'Skadi the Ruthless is within range of the harpoon launchers!', 41, 0, 100, 0, 0, 0, 'Skadi Emote', 27809);
INSERT INTO `creature_text` (`entry`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextID`) VALUES (19871, 0, 0, 'Skadi the Ruthless is within range of the harpoon launchers!', 41, 0, 100, 0, 0, 0, 'Skadi Emote', 27809);

DELETE FROM smart_scripts where entryorguid IN ( -126150, -126127) and event_type = 38;
INSERT INTO `smart_scripts` (`entryorguid`, `event_type`, `action_type`, `target_type`, `comment`) VALUES (-126150, 38, 1, 1, 'Skadi Trigger - Emote');
INSERT INTO `smart_scripts` (`entryorguid`, `event_type`, `action_type`, `target_type`, `comment`) VALUES (-126127, 38, 1, 1, 'Skadi Trigger - Emote');

DELETE FROM `spelldifficulty_dbc` WHERE `id` IN ( 49089,49084,49091,50255,50258,50228,47579);
INSERT INTO `spelldifficulty_dbc` (`id`, `spellid0`, `spellid1`) VALUES (49089, 49089, 59246);
INSERT INTO `spelldifficulty_dbc` (`id`, `spellid0`, `spellid1`) VALUES (49084, 49084, 59246);
INSERT INTO `spelldifficulty_dbc` (`id`, `spellid0`, `spellid1`) VALUES (49091, 49091, 59249);
INSERT INTO `spelldifficulty_dbc` (`id`, `spellid0`, `spellid1`) VALUES (50228, 50228, 59322);
INSERT INTO `spelldifficulty_dbc` (`id`, `spellid0`, `spellid1`) VALUES (50255, 50255, 59331);
INSERT INTO `spelldifficulty_dbc` (`id`, `spellid0`, `spellid1`) VALUES (50258, 50258, 59334);
INSERT INTO `spelldifficulty_dbc` (`id`, `spellid0`, `spellid1`) VALUES (47579, 47579, 60020 );

UPDATE `smart_scripts` SET `target_type`=17, `target_param1`=5, `target_param2`=30 WHERE  `entryorguid`=26692 AND `source_type`=0 AND `id`=1 AND `link`=0;
UPDATE `smart_scripts` SET `target_type`=17, `target_param1`=5, `target_param2`=30 WHERE  `entryorguid`=26692 AND `source_type`=0 AND `id`=0 AND `link`=0;

DELETE FROM `disables` WHERE  `sourceType`=4 AND `entry`=7595;
DELETE FROM achievement_criteria_data WHERE criteria_id = 7595;
INSERT INTO `achievement_criteria_data` (`criteria_id`, `type`, `ScriptName`) VALUES (7595, 11, 'achievement_girl_love_to_skadi');
UPDATE `gameobject_template` SET `data10`=0 WHERE  `entry`=192175;
UPDATE `gameobject_template` SET `data10`=0 WHERE  `entry`=192176;
UPDATE `gameobject_template` SET `data10`=0 WHERE  `entry`=192177;

DELETE FROM spell_target_position where id = 61790;
INSERT INTO `spell_target_position` (`id`, `effectIndex`, `MapID`, `PositionX`, `PositionY`, `PositionZ`, `Orientation`, `VerifiedBuild`) VALUES (61790, 0, 575, 342.887, -507.782, 104.471, 3.13678, 12340);

-- ------------------------------------------------------------------------------------
-- OCULUS - INSTANCE REWORK
-- ------------------------------------------------------------------------------------
DELETE FROM conditions WHERE SourceTypeOrReferenceId = 13 AND SourceGroup = 1 AND SourceEntry IN (50036,51518,50087) AND  ConditionValue2 = 27641;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES (13, 1, 50036, 31, 3, 27641);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES (13, 1, 51518, 31, 3, 27641);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `ConditionTypeOrReference`, `ConditionValue1`, `ConditionValue2`) VALUES (13, 1, 50087, 31, 3, 27641);


DELETE FROM spelldifficulty_dbc where id = 50044 AND spellid0 = 50044 and spellid1 = 59213;
INSERT INTO `spelldifficulty_dbc` (`id`, `spellid0`, `spellid1`) VALUES (50044, 50044, 59213);

UPDATE `creature_template` SET `AIName`='SmartAI' WHERE  `entry`=27641;

DELETE from smart_scripts where  entryorguid = 27641 and id =1;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES (27641, 0, 1, 0, 1, 0, 100, 1, 0, 0, 0, 0, 11, 50044, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Centrifuge Core - Out of Combat - Cast Empowering Blows');

DELETE FROM spell_script_names where spell_id IN (51121,51132,59376);
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (51121,'spell_urom_time_bomb');
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (51132,'spell_urom_time_bomb_detonation');
INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES (59376,'spell_urom_time_bomb');

UPDATE `gameobject_template` SET `ScriptName`='go_call_tram' , faction='35' 
WHERE `entry` IN (194437 ,194914 ,194912 ,194937);


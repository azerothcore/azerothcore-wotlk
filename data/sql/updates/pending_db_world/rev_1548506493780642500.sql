INSERT INTO version_db_world (`sql_rev`) VALUES ('1548506493780642500');

SET @ENTRY := 6492;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 1, 8, 0, 100, 0, 9095, 0, 0, 0, 28, 34426, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On spell Cantation of Manifestation (9095) hit - Self: Remove aura due to spell Greater Invisibility (34426) // Rift Spawn - On Spellhit - Remove Aura"),
(@ENTRY, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 28, 9095, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, " Linked - Self: Remove aura due to spell Cantation of Manifestation (9095) // Rift Spawn - On Spellhit - Remove Aura"),
(@ENTRY, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 11, 9096, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, " Linked - Self: Cast spell Rift Spawn Manifestation (9096) on Self // Rift Spawn - On Spellhit - Cast Rift Spawn Manifestation"),
(@ENTRY, 0, 3, 0, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, " Linked - Self: Attack Action invoker // Rift Spawn - On Spellhit - Attack ActionInvoker"),
(@ENTRY, 0, 4, 5, 11, 0, 100, 0, 0, 0, 0, 0, 11, 34426, 19, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On respawn - Self: Cast spell Greater Invisibility (34426) on Self // Rift Spawn - on spawn - add aura"),
(@ENTRY, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 19, 33685508, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, " Linked - Self: Remove UNIT_FLAGS to UNIT_FLAG_DISABLE_MOVE, UNIT_FLAG_PACIFIED, UNIT_FLAG_NOT_SELECTABLE // Rift Spawn - On spawn - remove Flag"),
(@ENTRY, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 2, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, " Linked - Self: Set faction to 7 // Rift Spawn - on spawn - set faction"),
(@ENTRY, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, " Linked - What is it? // Rift Spawn - on Spawn - Set Invincible HP"),
(@ENTRY, 0, 8, 9, 2, 0, 100, 1, 0, 1, 0, 0, 41, 3500, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "When health between 0% and 1% (check every 0 - 0 ms) - Self: Despawn in 3500 ms // "),
(@ENTRY, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 11, 9032, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, " Linked - Self: Cast spell Self Stun - 30 seconds (9032) on Self // Rift Spawn - On On 1% HP - Cast Self Stun - 30 seconds"),
(@ENTRY, 0, 10, 11, 61, 0, 100, 0, 0, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, " Linked - Self: Set event phase to 2 // Rift Spawn - On 1% HP - Set Phase 2"),
(@ENTRY, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 41, 31000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, " Linked - Self: Despawn in 31000 ms // Rift Spawn - On 1% HP - despawn"),
(@ENTRY, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 12, 23837, 1, 15000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, " Linked - Self: Summon creature ELM General Purpose Bunny (23837) at Self, moved by offset (0, 0, 0, 0) // "),
(@ENTRY, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 32, 32, 0, 0, 0, 0, 19, 23837, 0, 0, 0, 0, 0, 0, " Linked - Closest alive creature ELM General Purpose Bunny (23837) in 100 yards: Set creature data #32 to 32 // "),
(@ENTRY, 0, 14, 0, 25, 0, 100, 0, 0, 0, 0, 0, 11, 34426, 19, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On reset (e.g. after reaching home) - Self: Cast spell Greater Invisibility (34426) on Self // Rift Spawn - on reset - add aura"),
(@ENTRY, 0, 15, 0, 25, 0, 100, 0, 0, 0, 0, 0, 19, 33685508, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On reset (e.g. after reaching home) - Self: Remove UNIT_FLAGS to UNIT_FLAG_DISABLE_MOVE, UNIT_FLAG_PACIFIED, UNIT_FLAG_NOT_SELECTABLE // Rift Spawn - on reset - remove aura"),
(@ENTRY, 0, 16, 0, 4, 0, 100, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On aggro - Self: Talk 0 // Rift Spawn - On Aggro - Say Line 0"),
(@ENTRY, 0, 17, 0, 7, 2, 100, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On evade - Self: Talk 1 // Rift Spawn - On Evade (Phase 2) - Say line 1");


DELETE FROM `creature_text` WHERE `creatureId`=6492;
INSERT INTO `creature_text` (`creatureId`, `groupid`, `id`, `text`, `type`, `language`, `probability`, `emote`, `duration`, `sound`, `comment`, `BroadcastTextID`) VALUES 
(6492, 0, 0, '%s is angered and attacks!', 16, 0, 100, 0, 0, 0, 'Rift Spawn', 3074),
(6492, 1, 0, '%s escapes into the void!', 16, 0, 100, 0, 0, 0, 'Rift Spawn', 2564);

UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI' WHERE `entry`=122088;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (122088, 12208800);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(122088, 1, 0, 0, 1, 0, 100, 1, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 6492, 1, 0, 0, 0, 0, 0, 'Containment Coffer - On reset - Set data to Rift Spawn'),
(122088, 1, 1, 0, 1, 0, 100, 1, 0, 0, 0, 0, 45, 2, 2, 0, 0, 0, 0, 19, 6492, 1, 0, 0, 0, 0, 0, 'Containment Coffer - On reset - Set data to Rift Spawn'),
(122088, 1, 2, 0, 1, 0, 100, 1, 0, 0, 0, 0, 9, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Containment Coffer - On reset - activate self'),
(122088, 1, 3, 0, 1, 0, 100, 1, 4000, 4000, 4000, 4000, 44, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Containment Coffer - On reset - set phasemask');

 -- Creature ELM General Purpose Bunny 23837 SAI
SET @ENTRY := 23837;
UPDATE `creature_template` SET `AIName`="SmartAI" WHERE `entry`= @ENTRY;
DELETE FROM `smart_scripts` WHERE `entryorguid`=@ENTRY AND `source_type`=0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 1, 54, 0, 100, 0, 0, 0, 0, 0, 11, 52388, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, "On just summoned - Self: Cast spell You Reap What You Sow: Ritual Bunny Channel (52388) on Self // ELM General Purpose Bunny - On Just Summoned - Cast 'You Reap What You Sow: Ritual Bunny Channel'"),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 45, 0, 1, 0, 0, 0, 0, 19, 28671, 30, 0, 0, 0, 0, 0, " Linked - Closest alive creature Prophet of Quetz'lun (28671) in 30 yards: Set creature data #0 to 1 // ELM General Purpose Bunny - On Just Summoned - Set Data 0 1"),
(@ENTRY, 0, 2, 0, 38, 0, 100, 0, 31, 31, 0, 0, 87, 1636401, 1636403, 1636404, 1636406, 1636407, 1636408, 1, 0, 0, 0, 0, 0, 0, 0, "On data 31 set to 31 - Self: Call random timed action list: 1636401, 1636403, 1636404, 1636406, 1636407, 1636408 // ELM General Purpose Bunny - On Data Set - Run Random Script"),
(@ENTRY, 0, 3, 0, 38, 0, 100, 0, 30, 30, 0, 0, 87, 1636401, 1636402, 1636403, 1636405, 1636406, 1636408, 1, 0, 0, 0, 0, 0, 0, 0, "On data 30 set to 30 - Self: Call random timed action list: 1636401, 1636402, 1636403, 1636405, 1636406, 1636408 // ELM General Purpose Bunny - On Data Set - Run Random Script"),
(@ENTRY, 0, 4, 0, 11, 0, 100, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 19, 27249, 0, 0, 0, 0, 0, 0, "On respawn - Closest alive creature Alystros the Verdant Keeper (27249) in 100 yards: Set creature data #1 to 1 // ELM General Purpose Bunny - On Just Summoned - Set Data to Alystros the Verdant Keeper");

DELETE FROM `smart_scripts` WHERE `entryorguid`=23837 AND `source_type`=0 AND `id`=5;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(23837, 0, 5, 0, 38, 0, 100, 1, 32, 32, 0, 0, 11, 9010, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'ELM General Purpose Bunny - On Data Set - Cast Create Filled Containment Coffer');

DELETE FROM `disables` WHERE `sourceType`=0 AND `entry`=9095;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES 
(0, 9095, 64, '', '', 'Ignore LOS on Cantation of Manifestation');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=17 AND `SourceEntry`=9082;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES 
(17, 0, 9082, 0, 0, 29, 0, 6492, 10, 0, 0, 0, 0, '', 'Create Containment Coffer can only be cast if there is rift spawn near');

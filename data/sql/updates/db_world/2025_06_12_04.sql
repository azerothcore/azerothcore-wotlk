-- DB update 2025_06_12_03 -> 2025_06_12_04
SET @ARTRUIS := 28659;
SET @ARTRUISGUID := 202971;
SET @JALOOT   := 28667;
SET @JALOOTGUID   := 202969;
SET @ZEPIK    := 28668;
SET @ZEPIKGUID    := 202970;

DELETE FROM `creature` WHERE (`id1` = @JALOOT) AND (`guid` IN (@JALOOTGUID));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@JALOOTGUID, @JALOOT, 0, 0, 571, 0, 0, 1, 1, 0, 5616.92, 3772.68, -94.258, 1.78024, 120, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);

DELETE FROM `creature` WHERE (`id1` = @ZEPIK) AND (`guid` IN (@ZEPIKGUID));
INSERT INTO `creature` (`guid`, `id1`, `id2`, `id3`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`, `ScriptName`, `VerifiedBuild`) VALUES
(@ZEPIKGUID, @ZEPIK, 0, 0, 571, 0, 0, 1, 1, 0, 5631.63, 3794.36, -92.236, 3.45575, 120, 0, 0, 1, 0, 0, 0, 0, 0, '', 0);

UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE (`entry` = @ARTRUIS);
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @ARTRUIS);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ARTRUIS, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, @JALOOTGUID, @JALOOT, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Respawn - Respawn Closest Creature \'Jaloot\''),
(@ARTRUIS, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, @ZEPIKGUID, @ZEPIK, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Respawn - Respawn Closest Creature \'Zepik the Gorloc Hunter\''),
(@ARTRUIS, 0, 2, 0, 0, 0, 100, 0, 7000, 11000, 11000, 15000, 0, 0, 11, 54261, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - In Combat - Cast \'Ice Lance\''),
(@ARTRUIS, 0, 3, 0, 0, 0, 100, 0, 3000, 5000, 3000, 5000, 0, 0, 11, 15530, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - In Combat - Cast \'Frostbolt\''),
(@ARTRUIS, 0, 4, 0, 0, 0, 100, 0, 9000, 13000, 25000, 35000, 0, 0, 11, 54792, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - In Combat - Cast \'Icy Veins\''),
(@ARTRUIS, 0, 5, 0, 9, 0, 100, 0, 7000, 9000, 14000, 18000, 0, 10, 11, 11831, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - Within 0-10 Range - Cast \'Frost Nova\''),
(@ARTRUIS, 0, 6, 7, 2, 0, 100, 0, 0, 30, 0, 0, 0, 0, 11, 52185, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - Between 0-30% Health - Cast \'Bindings of Submission\''),
(@ARTRUIS, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, @JALOOTGUID, @JALOOT, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - Between 0-30% Health - Set Data 1 1 for Jaloot'),
(@ARTRUIS, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, @ZEPIKGUID, @ZEPIK, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - Between 0-30% Health - Set Data 1 1 for Zepik the Gorloc Hunter'),
(@ARTRUIS, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 3, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - Between 0-30% Health - Say Line 3'),
(@ARTRUIS, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 4, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - Between 0-30% Health - Say Line 4'),
(@ARTRUIS, 0, 11, 12, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 10, @JALOOTGUID, @JALOOT, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Reset - Set Data 1 2 for Jaloot'),
(@ARTRUIS, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 10, @ZEPIKGUID, @ZEPIK, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Reset - Set Data 1 2 for Zepik the Gorloc Hunter'),
(@ARTRUIS, 0, 13, 0, 2, 0, 100, 0, 0, 75, 0, 0, 0, 0, 1, 1, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - Between 0-75% Health - Say Line 1'),
(@ARTRUIS, 0, 14, 0, 2, 0, 100, 0, 0, 50, 0, 0, 0, 0, 1, 2, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - Between 0-50% Health - Say Line 2'),
(@ARTRUIS, 0, 15, 16, 4, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, @JALOOTGUID, @JALOOT, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Aggro - Respawn Closest Creature \'Jaloot\''),
(@ARTRUIS, 0, 16, 17, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 70, 0, 0, 0, 0, 0, 0, 10, @ZEPIKGUID, @ZEPIK, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Aggro - Respawn Closest Creature \'Zepik the Gorloc Hunter\''),
(@ARTRUIS, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Aggro - Say Line 0'),
(@ARTRUIS, 0, 18, 19, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52518, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Just Died - Cast \'Summon Artruis Quest Complete\''),
(@ARTRUIS, 0, 19, 20, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 10, @JALOOTGUID, @JALOOT, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Just Died - Set Data 1 3 for Jaloot'),
(@ARTRUIS, 0, 20, 21, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 10, @ZEPIKGUID, @ZEPIK, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Just Died - Set Data 1 3 for Zepik the Gorloc Hunter'),
(@ARTRUIS, 0, 21, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 5, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Just Died - Say Line 5'),
(@ARTRUIS, 0, 22, 23, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 45, 1, 4, 0, 0, 0, 0, 10, @ZEPIKGUID, @ZEPIK, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Data Set 1 1 - Set Data 1 4 for Zepik the Gorloc Hunter'),
(@ARTRUIS, 0, 23, 24, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 52185, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Data Set 1 1 - Remove Aura \'Bindings of Submission\''),
(@ARTRUIS, 0, 24, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Data Set 1 1 - Set Data 1 0 for self'),
(@ARTRUIS, 0, 25, 26, 38, 0, 100, 0, 1, 2, 0, 0, 0, 0, 45, 1, 4, 0, 0, 0, 0, 10, @JALOOTGUID, @JALOOT, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Data Set 1 2 - Set Data 1 4 for Jaloot'),
(@ARTRUIS, 0, 26, 27, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 52185, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Data Set 1 2 - Remove Aura \'Bindings of Submission\''),
(@ARTRUIS, 0, 27, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - On Data Set 1 2 - Set Data 1 0'),
(@ARTRUIS, 0, 28, 0, 0, 0, 100, 0, 1000, 1000, 1000, 1000, 0, 0, 11, 53163, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Artruis the Heartless - In Combat - Cast \'Dessawn Retainer\'');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @JALOOT;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @JALOOT);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@JALOOT, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Respawn - Set Npc Flag '),
(@JALOOT, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Respawn - Set Flags Immune To NPC\'s'),
(@JALOOT, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52182, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Respawn - Cast \'Tomb of the Heartless\''),
(@JALOOT, 0, 3, 0, 9, 0, 100, 0, 7500, 10000, 15000, 20000, 0, 5, 11, 52943, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - Within 0-5 Range - Cast \'Lightning Whirl\''),
(@JALOOT, 0, 4, 0, 9, 0, 100, 0, 7500, 9000, 15000, 18000, 0, 40, 11, 52944, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - Within 0-40 Range - Cast \'Lightning Strike\''),
(@JALOOT, 0, 5, 0, 9, 0, 100, 0, 10000, 12500, 20000, 25000, 0, 5, 11, 52964, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - Within 0-5 Range - Cast \'Spark Frenzy\''),
(@JALOOT, 0, 6, 0, 2, 0, 100, 0, 0, 30, 9000, 12000, 0, 0, 11, 52969, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - Between 0-30% Health - Cast \'Energy Siphon\''),
(@JALOOT, 0, 7, 8, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 1 - Set Faction 14'),
(@JALOOT, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 52182, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 1 - Remove Aura \'Tomb of the Heartless\''),
(@JALOOT, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 1 - Start Attacking'),
(@JALOOT, 0, 10, 11, 38, 0, 100, 0, 1, 2, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 2 - Set Faction 250 - Friendly'),
(@JALOOT, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 2 - Set Flags Immune To NPC\'s'),
(@JALOOT, 0, 12, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52182, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 2 - Cast \'Tomb of the Heartless\''),
(@JALOOT, 0, 13, 14, 38, 0, 100, 0, 1, 3, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 3 - Set Faction 250 - Friendly'),
(@JALOOT, 0, 14, 15, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 3 - Set Flags Immune To NPC\'s'),
(@JALOOT, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 3 - Set Npc Flags Questgiver'),
(@JALOOT, 0, 16, 17, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 90000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 3 - Despawn In 90000 ms'),
(@JALOOT, 0, 17, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 3 - Evade'),
(@JALOOT, 0, 18, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 1, 0, 0, 0, 0, 10, @ARTRUISGUID, @ARTRUIS, 0, 0, 0, 0, 0, 0, 'Jaloot - On Just Died - Set Data 1 1 for Artruis the Heartless'),
(@JALOOT, 0, 19, 20, 38, 0, 100, 0, 1, 4, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 4 - Set Faction 250 - Friendly'),
(@JALOOT, 0, 20, 21, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 52185, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 4 - Remove Aura \'Bindings of Submission\''),
(@JALOOT, 0, 21, 22, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 4 - Remove Flags Immune To NPC\'s'),
(@JALOOT, 0, 22, 23, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 10000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 4 - Say Line 0'),
(@JALOOT, 0, 23, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, @ARTRUISGUID, @ARTRUIS, 0, 0, 0, 0, 0, 0, 'Jaloot - On Data Set 1 4 - Start Attacking Artruis the Heartless');

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @ZEPIK;
DELETE FROM `smart_scripts` WHERE (`source_type` = 0 AND `entryorguid` = @ZEPIK);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ZEPIK, 0, 0, 1, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Respawn - Set Npc Flag '),
(@ZEPIK, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Respawn - Set Flags Immune To NPC\'s'),
(@ZEPIK, 0, 2, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52182, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Respawn - Cast \'Tomb of the Heartless\''),
(@ZEPIK, 0, 3, 0, 9, 0, 100, 0, 7500, 9000, 15000, 18000, 0, 20, 11, 52761, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - Within 0-20 Range - Cast \'Barbed Net\''),
(@ZEPIK, 0, 4, 0, 9, 0, 100, 0, 6000, 7500, 12000, 15000, 5, 30, 11, 52889, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - Within 5-30 Range - Cast \'Envenomed Shot\''),
(@ZEPIK, 0, 5, 0, 9, 0, 100, 0, 3000, 7000, 3000, 7000, 0, 5, 11, 52873, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - Within 0-5 Range - Cast \'Open Wound\''),
(@ZEPIK, 0, 6, 0, 9, 0, 100, 0, 15000, 20000, 30000, 40000, 0, 5, 11, 52886, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - Within 0-5 Range - Cast \'Spike Trap\''),
(@ZEPIK, 0, 7, 0, 2, 0, 100, 0, 0, 30, 30000, 30000, 0, 0, 11, 52895, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - Between 0-30% Health - Cast \'Bandage\''),
(@ZEPIK, 0, 8, 9, 38, 0, 100, 0, 1, 1, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 1 - Set Faction 14'),
(@ZEPIK, 0, 9, 10, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 52182, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 1 - Remove Aura \'Tomb of the Heartless\''),
(@ZEPIK, 0, 10, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 18, 40, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 1 - Start Attacking'),
(@ZEPIK, 0, 11, 12, 38, 0, 100, 0, 1, 2, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 2 - Set Faction 250 - Friendly'),
(@ZEPIK, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 2 - Set Flags Immune To NPC\'s'),
(@ZEPIK, 0, 13, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 52182, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 2 - Cast \'Tomb of the Heartless\''),
(@ZEPIK, 0, 14, 15, 38, 0, 100, 0, 1, 3, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 3 - Set Faction 250 - Friendly'),
(@ZEPIK, 0, 15, 16, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 3 - Evade'),
(@ZEPIK, 0, 16, 17, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 3 - Set Flags Immune To NPC\'s'),
(@ZEPIK, 0, 17, 18, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 81, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 3 - Set Npc Flags Questgiver'),
(@ZEPIK, 0, 18, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 41, 90000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 3 - Despawn In 90000 ms'),
(@ZEPIK, 0, 19, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 2, 0, 0, 0, 0, 10, @ARTRUISGUID, @ARTRUIS, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Just Died - Set Data 1 2 for Artruis the Heartless'),
(@ZEPIK, 0, 20, 21, 38, 0, 100, 0, 1, 4, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 4 - Set Faction 250 - Friendly'),
(@ZEPIK, 0, 21, 22, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 28, 52185, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 4 - Remove Aura \'Bindings of Submission\''),
(@ZEPIK, 0, 22, 23, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 19, 512, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 4 - Remove Flags Immune To NPC\'s'),
(@ZEPIK, 0, 23, 24, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 4 - Say Line 0'),
(@ZEPIK, 0, 24, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 10, @ARTRUISGUID, @ARTRUIS, 0, 0, 0, 0, 0, 0, 'Zepik the Gorloc Hunter - On Data Set 1 4 - Start Attacking Artruis the Heartless');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId`=13 AND `SourceGroup`=1 AND `SourceEntry`=52185;
INSERT INTO `conditions` (`SourceTypeOrReferenceId`,`SourceGroup`,`SourceEntry`,`SourceId`,`ElseGroup`,`ConditionTypeOrReference`,`ConditionTarget`,`ConditionValue1`,`ConditionValue2`,`ConditionValue3`,`NegativeCondition`,`ErrorTextId`,`ScriptName`,`Comment`) VALUES
(13,1,52185,0,0,31,0,3,@ZEPIK,0,0,0,'','Bindings of Submission for Zepik'),
(13,1,52185,0,1,31,0,3,@JALOOT,0,0,0,'','Bindings of Submission for Jaloot'),
(13,1,52185,0,2,31,0,3,@ARTRUIS,0,0,0,'','Bindings of Submission for Artruis the Heartless');

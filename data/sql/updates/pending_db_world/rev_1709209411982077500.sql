DELETE FROM `creature_text` WHERE `CreatureID` = 26828;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(26828, 0, 0, 'You test my patience, you now see the true might of the Blue.', 12, 0, 100, 0, 0, 0, 28122, 0, 'Magister Keldonus'),
(26828, 1, 0, 'My lady, the surge needle is fully operational.', 12, 0, 100, 1, 0, 0, 26020, 0, 'Magister Keldonus'),
(26828, 2, 0, 'The ley line beneath this night elf temple is now flowing into the Azure Dragonshrine. Our brothers should have all the power they need to crush our enemies.', 12, 0, 100, 0, 0, 0, 26024, 0, 'Magister Keldonus'),
(26828, 3, 0, 'I live only to serve the master, my lady.', 12, 0, 100, 1, 0, 0, 26022, 0, 'Magister Keldonus to Magister Keldonus');

DELETE FROM `creature_text` WHERE `CreatureID` = 26832;
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`) VALUES
(26832, 0, 0, 'You have done well, Keldonus. Lord Malygos will be quite pleased with your progress.', 12, 0, 100, 1, 0, 0, 26021, 0, 'Grand Magus Telestra to Magister Keldonus'),
(26832, 1, 0, 'Deal with this interruption, Keldonus. After you are through, bring me the head of the one they call $n. I will decorate my chambers with $g his:her; skull.', 12, 0, 100, 397, 0, 0, 26025, 0, 'Grand Magus Telestra to Player'),
(26832, 2, 0, 'This transgression against the Blue Dragonflight has been noted. I will take extra pleasure in separating the life energy from your body!', 12, 0, 100, 1, 0, 0, 26026, 0, 'Grand Magus Telestra to Player');

 -- Magister Keldonus smart ai
SET @ENTRY := 26828;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` = @ENTRY * 100;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 0, 0, 0, 100, 0, 5000, 9000, 9000, 15000, 11, 51830, 0, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Magister Keldonus - Self: Cast spell \'Arcane Blast (51830)\' on Random hostile'),
(@ENTRY, 0, 1, 0, 106, 0, 100, 0, 24000, 28000, 24000, 28000, 11, 51806, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Magister Keldonus - Self: Cast spell \'Power Flux (51806)\' with flags interrupt previous on Self'),
(@ENTRY, 0, 2, 0, 0, 0, 100, 0, 7000, 12000, 14000, 22000, 11, 51804, 32, 0, 0, 0, 0, 5, 0, 0, 0, 0, 0, 0, 0, 'Magister Keldonus - Self: Cast spell \'Power Siphon (51804)\' with flags aura not present on Random hostile'),
(@ENTRY, 0, 3, 0, 0, 0, 100, 0, 9000, 12000, 20000, 25000, 11, 51808, 1, 0, 0, 0, 0, 6, 0, 0, 0, 0, 0, 0, 0, 'Magister Keldonus - Self: Cast spell \'Fury of the Blue (51808)\' with flags interrupt previous on Random hostile (not top)'),
(@ENTRY, 0, 4, 5, 2, 0, 100, 0, 0, 30, 120000, 130000, 11, 51800, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 'Magister Keldonus - Self: Cast spell \'Might of Malygos (51800)\' on Victim'),
(@ENTRY, 0, 5, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Magister Keldonus - Self: Talk line (0) to invoker'),
(@ENTRY, 0, 6, 0, 60, 0, 100, 0, 106800, 160000, 135600, 172900, 80, 2682800, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Magister Keldonus - Self: Start timed action list id #Magister Keldonus #0 (2682800) (update out of combat) // -inline'),
(@ENTRY * 100, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Keldonus - Self: Talk line (1) to None'),
(@ENTRY * 100, 9, 1, 0, 0, 0, 100, 0, 4500, 4500, 0, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Magister Keldonus - Self: Talk line (2) to None'),
(@ENTRY * 100, 9, 2, 0, 0, 0, 100, 0, 6400, 6400, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 26832, 15, 0, 0, 0, 0, 0, 'Grand Magus Telestra - Closest alive creature Grand Magus Telestra (26832) in 15 yards:Talk line (0) to invoker'),
(@ENTRY * 100, 9, 3, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 1, 3, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Magister Keldonus - Self: Talk line (3) to Self'),
(@ENTRY, 0, 7, 0, 6, 0, 100, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 19, 26832, 15, 0, 0, 0, 0, 0, 'On death - Grand Magus Telestra: Talk line (2) to invoker'),
(@ENTRY, 0, 8, 0, 4, 0, 100, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 19, 26832, 15, 0, 0, 0, 0, 0, 'On aggro - Grand Magus Telestra Talk line (1) to invoker');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 22 AND `SourceEntry` = 26828 AND `SourceId` = 0;

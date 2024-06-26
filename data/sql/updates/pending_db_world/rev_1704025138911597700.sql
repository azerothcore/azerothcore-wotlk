-- Calvin Montague smart ai
SET @ENTRY := 6784;
UPDATE `creature_template` SET `AIName` = 'SmartAI', `ScriptName` = '' WHERE `entry` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
DELETE FROM `smart_scripts` WHERE `source_type` = 9 AND `entryOrGuid` IN (678400, 678401);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES 
(@ENTRY, 0, 0, 1, 19, 0, 100, 0, 590, 0, 0, 0, 22, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On player accepted quest A Rogue\'s Deal (590) - Set event phase to phase 1'),
(@ENTRY, 0, 1, 2, 61, 0, 100, 0, 0, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On player accepted quest A Rogue\'s Deal (590) - Self: storedTarget[0] = Player who accepted quest'),
(@ENTRY, 0, 2, 3, 61, 0, 100, 0, 0, 0, 0, 0, 2, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On player accepted quest A Rogue\'s Deal (590) - Self: Set faction to Monster (14)'),
(@ENTRY, 0, 3, 4, 61, 0, 100, 0, 0, 0, 0, 0, 83, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On player accepted quest A Rogue\'s Deal (590) - Self: Remove npc flags QUESTGIVER'),
(@ENTRY, 0, 4, 5, 61, 0, 100, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On player accepted quest A Rogue\'s Deal (590) - Self: Remove UNIT_FLAGS to IMMUNE_TO_PC'),
(@ENTRY, 0, 5, 6, 61, 0, 100, 0, 0, 0, 0, 0, 18, 2048, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On player accepted quest A Rogue\'s Deal (590) - Self: Set UNIT_FLAGS to PET_IN_COMBAT'),
(@ENTRY, 0, 6, 7, 61, 0, 100, 0, 0, 0, 0, 0, 8, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On player accepted quest A Rogue\'s Deal (590) - Self: Set react state to Aggressive'),
(@ENTRY, 0, 7, 8, 61, 0, 100, 0, 0, 0, 0, 0, 49, 0, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'On player accepted quest A Rogue\'s Deal (590) - Self: Attack Player who accepted quest'),
(@ENTRY, 0, 8, 9, 61, 0, 100, 0, 0, 0, 0, 0, 42, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'On player accepted quest A Rogue\'s Deal (590) - Self: Set invincibility to 1 HP'),
(@ENTRY, 0, 9, 0, 61, 0, 100, 0, 0, 0, 0, 0, 211, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'On player accepted quest A Rogue\'s Deal (590) - Self: Disallow SAI phase reset'),
(@ENTRY, 0, 10, 11, 2, 1, 100, 513, 0, 30, 0, 0, 22, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - When health between 0%-30%% (once phase 1) - Set event phase to phase 2'),
(@ENTRY, 0, 11, 12, 61, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - When health between 0%-30%% (once phase 1) - Reset faction'),
(@ENTRY, 0, 12, 13, 61, 0, 100, 0, 0, 0, 0, 0, 28, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - When health between 0%-30%% (once phase 1) - Remove all auras'),
(@ENTRY, 0, 13, 14, 61, 0, 100, 0, 0, 0, 0, 0, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - When health between 0%-30%% (once phase 1) - Stop combat'),
(@ENTRY, 0, 14, 0, 61, 0, 100, 0, 0, 0, 0, 0, 24, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - When health between 0%-30%% (once phase 1) - Evade'),
(@ENTRY, 0, 15, 16, 7, 1, 100, 0, 0, 0, 0, 0, 19, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On evade(phase 1) - Remove UNIT_FLAGS to IMMUNE_TO_PC'),
(@ENTRY, 0, 16, 0, 61, 0, 100, 0, 0, 0, 0, 0, 8, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On evade (phase 1)- Set react state to Defensive'),
(@ENTRY, 0, 17, 0, 21, 1, 100, 0, 0, 0, 0, 0, 80, 678400, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On home reached (phase 1) - Self: Start timed action list id #Calvin Montague #0 (678400) (update out of combat) override existing // -inline'),
(@ENTRY * 100, 9, 0, 0, 0, 0, 100, 0, 150000, 150000, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Reset faction'),
(@ENTRY * 100, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Set UNIT_FLAGS to IMMUNE_TO_PC'),
(@ENTRY * 100, 9, 2, 0, 0, 0, 100, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Add npc flags QUESTGIVER'),
(@ENTRY * 100, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 90, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Set stand state to STAND'),
(@ENTRY * 100, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Set sheath to Melee'),
(@ENTRY * 100, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - storedTarget[0] = None'),
(@ENTRY * 100, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Set invincibility to 0 HP'),
(@ENTRY * 100, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 211, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Allow SAI phase reset'),
(@ENTRY * 100, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Set event phase to default (0)'),
(@ENTRY, 0, 18, 0, 21, 2, 100, 0, 0, 0, 0, 0, 80, 678401, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - On home reached (phase 2) - Start timed action list id #Calvin Montague #1 (678401) (update out of combat) override existing // -inline'),
(@ENTRY * 100 + 1, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Look at storedTarget[0]'),
(@ENTRY * 100 + 1, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 5, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Play emote ONESHOT_RUDE(DNR) (14)'),
(@ENTRY * 100 + 1, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Talk 0 to invoker'),
(@ENTRY * 100 + 1, 9, 3, 0, 0, 0, 100, 0, 6300, 6300, 0, 0, 11, 7737, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Cast spell Food(7737) on Self'),
(@ENTRY * 100 + 1, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 26, 590, 0, 0, 0, 0, 0, 12, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - storedTarget[0]: Call group event happened from quest A Rogue\'s Deal (590)'),
(@ENTRY * 100 + 1, 9, 5, 0, 0, 0, 100, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Reset faction'),
(@ENTRY * 100 + 1, 9, 6, 0, 0, 0, 100, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Set UNIT_FLAGS to IMMUNE_TO_PC'),
(@ENTRY * 100 + 1, 9, 7, 0, 0, 0, 100, 0, 0, 0, 0, 0, 82, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Add npc flags QUESTGIVER'),
(@ENTRY * 100 + 1, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 19, 2048, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Remove UNIT_FLAGS to PET_IN_COMBAT'),
(@ENTRY * 100 + 1, 9, 9, 0, 0, 0, 100, 0, 0, 0, 0, 0, 91, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Remove stand state SIT'),
(@ENTRY * 100 + 1, 9, 10, 0, 0, 0, 100, 0, 0, 0, 0, 0, 40, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Set sheath to Melee'),
(@ENTRY * 100 + 1, 9, 11, 0, 0, 0, 100, 0, 0, 0, 0, 0, 64, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - storedTarget[0] = None'),
(@ENTRY * 100 + 1, 9, 12, 0, 0, 0, 100, 0, 0, 0, 0, 0, 42, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Set invincibility to 0 HP'),
(@ENTRY * 100 + 1, 9, 13, 0, 0, 0, 100, 0, 0, 0, 0, 0, 211, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Allow SAI phase reset'),
(@ENTRY * 100 + 1, 9, 14, 0, 0, 0, 100, 0, 0, 0, 0, 0, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 'Calvin Montague - action list - Set event phase to default (0)');

DELETE
FROM `quest_details`
WHERE `ID` IN (590,8);
INSERT INTO `quest_details` (`ID`, `Emote1`, `Emote2`, `Emote3`, `Emote4`, `EmoteDelay1`, `EmoteDelay2`, `EmoteDelay3`, `EmoteDelay4`, `VerifiedBuild`) VALUES
(8, 2, 1, 1, 0, 0, 0, 0, 0, 52237),
(590, 6, 1, 14, 0, 0, 0, 0, 0, 52237);

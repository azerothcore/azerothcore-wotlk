-- Manual test aid for the ForceAttack() mechanism added by this PR (issue #26659). Makes
-- Lady Alistra (29195) periodically summon a Cenarion Scout (29220) - mutually Neutral to her
-- per FactionTemplate.dbc, confirmed via get_faction_template_from_dbc - and force-attack it,
-- looping until killed. Demo/test content only, not meant to ship as real Acherus content;
-- see the matching cleanup file to revert.
--
-- Uses SMART_ACTION_CALL_RANDOM_TIMED_ACTIONLIST (one roll per out-of-combat pulse) instead of
-- multiple independent SMART_EVENT_UPDATE_OOC rows, which was tried first and raced: several
-- rows could each fire within the same initial delay window, summoning duplicates before any
-- single one reached real combat, and SMART_TARGET_CLOSEST_CREATURE would then pick an
-- arbitrary one among ties standing on the same spot, leaving the others uncombated.
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 29195;

DELETE FROM `smart_scripts` WHERE `entryorguid` = 29195 AND `source_type` = 0 AND `id` = 0;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
     `event_param1`, `event_param2`, `event_param3`, `event_param4`,
     `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`,
     `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(29195, 0, 0, 0, 1, 0, 100, 0, 3000, 5000, 12000, 18000, 87, 2919500, 2919501, 2919502, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'TEST #26659 - Lady Alistra - On OOC Pulse - Call Random Ambient Fight');

DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2919500, 2919501, 2919502) AND `source_type` = 9;
INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`,
     `event_param1`, `event_param2`, `event_param3`, `event_param4`,
     `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`,
     `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2919500, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 29220, 6, 15000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'TEST #26659 - Actionlist slot 1 - Summon Cenarion Scout'),
(2919500, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 243, 0, 0, 0, 0, 0, 0, 19, 29220, 10, 0, 0, 0, 0, 0, 'TEST #26659 - Actionlist slot 1 - Force Attack'),
(2919501, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 29220, 6, 15000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'TEST #26659 - Actionlist slot 2 - Summon Cenarion Scout'),
(2919501, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 243, 0, 0, 0, 0, 0, 0, 19, 29220, 10, 0, 0, 0, 0, 0, 'TEST #26659 - Actionlist slot 2 - Force Attack'),
(2919502, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 12, 29220, 6, 15000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'TEST #26659 - Actionlist slot 3 - Summon Cenarion Scout'),
(2919502, 9, 1, 0, 0, 0, 100, 0, 500, 500, 0, 0, 243, 0, 0, 0, 0, 0, 0, 19, 29220, 10, 0, 0, 0, 0, 0, 'TEST #26659 - Actionlist slot 3 - Force Attack');

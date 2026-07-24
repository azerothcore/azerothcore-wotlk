-- Issue #26736: Bloodmaul Brutebane Brew (item 29443, GO 184315) should draw the
-- named quest targets (and the Bladespire Shaman/Brute guards) away from their
-- posts so they can be fought without their escort. The trap GO itself has no
-- radius/trigger spell configured (Data2/Data3 = 0) and cannot pull anything on
-- its own, and no comparable "investigate a nearby object" script exists anywhere
-- else in the DB to copy from - this SmartAI is original, not ported from
-- elsewhere in the game. Confirmed working in-game 2026-07-22.
--
-- Pattern per creature: while out of combat, periodically check for the closest
-- Bloodmaul Brew GO within 30y and walk to it (SMART_ACTION_MOVE_TO_POS reads the
-- GO's live position via SMART_TARGET_CLOSEST_GAMEOBJECT, not a fixed spot); the
-- instant it's claimed, a linked row despawns that same GO so no other nearby
-- creature can also react to it; once the creature reaches the spot
-- (SMART_EVENT_MOVEMENTINFORM on the matching pointId) it evades back to its own
-- tracked home position via SMART_ACTION_EVADE, which works correctly per-spawn
-- without hardcoding coordinates (needed since the guard entries have many spawns
-- across the zone).
--
-- Bladespire Sober Defender (21975) was deliberately left out - the reporter
-- confirmed it should not react to the brew.

DELETE FROM `smart_scripts` WHERE `entryorguid` = 20731 AND `source_type` = 0 AND `id` IN (4,5,6);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 20726 AND `source_type` = 0 AND `id` IN (4,5,6);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 20732 AND `source_type` = 0 AND `id` IN (3,4,5);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 19998 AND `source_type` = 0 AND `id` IN (4,5,6);
DELETE FROM `smart_scripts` WHERE `entryorguid` = 19995 AND `source_type` = 0 AND `id` IN (7,8,9);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(20731,0,4,5,1,0,100,0,1000,2000,3000,5000,0,0,69,1,0,0,3,0,0,20,184315,30,1,0,0,0,0,0,'Droggam - Out of Combat - Move To Closest Bloodmaul Brew GO'),
(20731,0,5,0,61,0,100,0,0,0,0,0,0,0,41,0,0,1,0,0,0,20,184315,30,1,0,0,0,0,0,'Droggam - Linked - Despawn Claimed Bloodmaul Brew GO'),
(20731,0,6,0,34,0,100,0,8,1,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Droggam - Reached Brew Spot - Evade Home'),
(20726,0,4,5,1,0,100,0,1000,2000,3000,5000,0,0,69,1,0,0,3,0,0,20,184315,30,1,0,0,0,0,0,'Mugdorg - Out of Combat - Move To Closest Bloodmaul Brew GO'),
(20726,0,5,0,61,0,100,0,0,0,0,0,0,0,41,0,0,1,0,0,0,20,184315,30,1,0,0,0,0,0,'Mugdorg - Linked - Despawn Claimed Bloodmaul Brew GO'),
(20726,0,6,0,34,0,100,0,8,1,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Mugdorg - Reached Brew Spot - Evade Home'),
(20732,0,3,4,1,0,100,0,1000,2000,3000,5000,0,0,69,1,0,0,3,0,0,20,184315,30,1,0,0,0,0,0,'Gorr\'Dim - Out of Combat - Move To Closest Bloodmaul Brew GO'),
(20732,0,4,0,61,0,100,0,0,0,0,0,0,0,41,0,0,1,0,0,0,20,184315,30,1,0,0,0,0,0,'Gorr\'Dim - Linked - Despawn Claimed Bloodmaul Brew GO'),
(20732,0,5,0,34,0,100,0,8,1,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Gorr\'Dim - Reached Brew Spot - Evade Home'),
(19998,0,4,5,1,0,100,0,1000,2000,3000,5000,0,0,69,1,0,0,3,0,0,20,184315,30,1,0,0,0,0,0,'Bladespire Shaman - Out of Combat - Move To Closest Bloodmaul Brew GO'),
(19998,0,5,0,61,0,100,0,0,0,0,0,0,0,41,0,0,1,0,0,0,20,184315,30,1,0,0,0,0,0,'Bladespire Shaman - Linked - Despawn Claimed Bloodmaul Brew GO'),
(19998,0,6,0,34,0,100,0,8,1,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Bladespire Shaman - Reached Brew Spot - Evade Home'),
(19995,0,7,8,1,0,100,0,1000,2000,3000,5000,0,0,69,1,0,0,3,0,0,20,184315,30,1,0,0,0,0,0,'Bladespire Brute - Out of Combat - Move To Closest Bloodmaul Brew GO'),
(19995,0,8,0,61,0,100,0,0,0,0,0,0,0,41,0,0,1,0,0,0,20,184315,30,1,0,0,0,0,0,'Bladespire Brute - Linked - Despawn Claimed Bloodmaul Brew GO'),
(19995,0,9,0,34,0,100,0,8,1,0,0,0,0,24,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Bladespire Brute - Reached Brew Spot - Evade Home');

-- DB update 2026_10_09_07 -> 2026_10_09_08
-- Nagrand (Nesingwary Safari): Gankly Rottenfist (18297) kept piling up in the camp.
-- He has no spawns in creature, he only exists as a summon from Kristen Dipswitch's event,
-- and the summon was created with summonType 8 and duration 0. TempSummon::InitStats turns
-- that combination into TEMPSUMMON_DEAD_DESPAWN, so a copy that was still alive never went
-- away, and nothing else in the event despawned him. Kristen's On Respawn rows restart her
-- walk every 30 minutes, so every cycle left one more copy behind.
--
-- 1) Despawn him when the branch where Kristen dies has finished. The event is over at that
--    point: he grabbed the skins, Harold stalled him and the camp reacts.
-- 2) Give the summon itself a bounded lifetime. The Set Data in step 1 targets the closest
--    creature with entry 18297 within 100 yards (SmartScript.cpp, SMART_TARGET_CLOSEST_CREATURE
--    falls back to 100 when target_param2 is 0), so a copy dragged away from Kristen would
--    never run action list 1829701. The timer only runs out of combat, so a fight is never
--    cut short, and a copy that dies is still removed right away.

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1829701 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1829701, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 18, 256, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gankly Rottenfist - On Script - Add Unit Flag \'Immune To PC\''),
(1829701, 9, 1, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gankly Rottenfist - On Script - Set React State \'Passive\''),
(1829701, 9, 2, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 28, 32199, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gankly Rottenfist - On Script - Remove Aura \'Stealth\''),
(1829701, 9, 3, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gankly Rottenfist - On Script - Say Line 1'),
(1829701, 9, 4, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 3.13852, 'Gankly Rottenfist - On Script - Set Orientation 3,13852'),
(1829701, 9, 5, 0, 0, 0, 100, 0, 500, 500, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gankly Rottenfist - On Script - Say Line 2'),
(1829701, 9, 6, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 19, 18218, 0, 0, 0, 0, 0, 0, 0, 'Gankly Rottenfist - On Script - Say Line 0 (Harold Lane)'),
(1829701, 9, 7, 0, 0, 0, 100, 0, 5000, 5000, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 18200, 0, 0, 0, 0, 0, 0, 0, 'Gankly Rottenfist - On Script - Set Data 1-3 to Shado \'Fitz\' Farstrider'),
(1829701, 9, 8, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 45, 1, 3, 0, 0, 0, 0, 19, 18180, 0, 0, 0, 0, 0, 0, 0, 'Gankly Rottenfist - On Script - Set Data 1-3 to Hemet Nesingwary'),
(1829701, 9, 9, 0, 0, 0, 100, 0, 20000, 20000, 0, 0, 0, 0, 41, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Gankly Rottenfist - On Script - Despawn');

DELETE FROM `smart_scripts` WHERE `entryorguid` = 1829400 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(1829400, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 12, 18297, 1, 300000, 0, 0, 0, 8, 0, 0, 0, 0, -1463.63, 6363.4, 36.9237, 0, 'Kristen Dipswitch - On Script - Summon Creature \'Gankly Rottenfist\''),
(1829400, 9, 1, 0, 0, 0, 100, 0, 2000, 2000, 0, 0, 0, 0, 43, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kristen Dipswitch - On Script - Dismount'),
(1829400, 9, 2, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 66, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 0, 0, 0, 0, 2.97859, 'Kristen Dipswitch - On Script - Set Orientation'),
(1829400, 9, 3, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 0, 0, 2, 250, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kristen Dipswitch - On Script - Set Faction 250'),
(1829400, 9, 4, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Kristen Dipswitch - On Script - Say Line 0');

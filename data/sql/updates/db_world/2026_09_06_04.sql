-- DB update 2026_09_06_03 -> 2026_09_06_04
--
-- Mobile Databank (entry 30313) narrates quest 12986 "Fate of the Titans" at the four
-- titan temples. Every SMART_ACTION_TALK in its escort script reads a creature_text
-- GroupID one higher than the line it should play, so each temple skips its own
-- "analysis commencing" opener and closes with the next temple's opener instead. The
-- Temple of Order run then overruns into group 19, a duplicate of group 18, so its
-- closing line is spoken twice.
--
-- Shift all 19 talk GroupIDs down by one (1..19 -> 0..18). That matches creature_text
-- groups 0..18 and the four unreferenced actionlists 3031300 (Invention, lines 0-4),
-- 3031301 (Winter, 5-9), 3031302 (Life, 10-14) and 3031303 (Order, 15-18), which
-- already use the correct numbering and cast the matching kill credit spells. Those
-- actionlists are dead code and are left untouched here.
--
-- Event ids 0..45 are preserved so the four conditions rows (SourceTypeOrReferenceId 22,
-- SourceEntry 30313, SourceGroup = id + 1) keep gating each temple on its bunny NPC.
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 0) AND (`entryorguid` = 30313);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(30313, 0, 0, 0, 60, 0, 100, 513, 2000, 2000, 2000, 2000, 0, 0, 53, 1, 30315, 0, 0, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - OnCreature In Range (Temple of Invention) - Start wp'),
(30313, 0, 1, 0, 60, 0, 100, 513, 2000, 2000, 2000, 2000, 0, 0, 53, 1, 30316, 0, 0, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - OnCreature In Range (Temple of Life) - Start wp'),
(30313, 0, 2, 0, 60, 0, 100, 513, 2000, 2000, 2000, 2000, 0, 0, 53, 1, 30317, 0, 0, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - OnCreature In Range (Temple of Winter) - Start wp'),
(30313, 0, 3, 0, 60, 0, 100, 513, 2000, 2000, 2000, 2000, 0, 0, 53, 1, 30318, 0, 0, 5000, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - OnCreature In Range (Temple of Order) - Start wp'),
(30313, 0, 4, 5, 40, 0, 100, 512, 2, 30315, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - pause'),
(30313, 0, 5, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - say_1'),
(30313, 0, 6, 7, 40, 0, 100, 512, 3, 30315, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - pause'),
(30313, 0, 7, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - say_2'),
(30313, 0, 8, 9, 40, 0, 100, 512, 5, 30315, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - pause'),
(30313, 0, 9, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - say_3'),
(30313, 0, 10, 11, 40, 0, 100, 512, 6, 30315, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - pause'),
(30313, 0, 11, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - say_4'),
(30313, 0, 12, 13, 40, 0, 100, 512, 7, 30315, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_5 - pause'),
(30313, 0, 13, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 4, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_5 - say_5'),
(30313, 0, 14, 15, 40, 0, 100, 512, 2, 30316, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - pause'),
(30313, 0, 15, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 10, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - say_1'),
(30313, 0, 16, 17, 40, 0, 100, 512, 3, 30316, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - pause'),
(30313, 0, 17, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 11, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - say_2'),
(30313, 0, 18, 19, 40, 0, 100, 512, 5, 30316, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - pause'),
(30313, 0, 19, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 12, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - say_3'),
(30313, 0, 20, 21, 40, 0, 100, 512, 6, 30316, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - pause'),
(30313, 0, 21, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 13, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - say_4'),
(30313, 0, 22, 23, 40, 0, 100, 512, 7, 30316, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_5 - pause'),
(30313, 0, 23, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 14, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_5 - say_5'),
(30313, 0, 24, 25, 40, 0, 100, 512, 2, 30317, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - pause'),
(30313, 0, 25, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 5, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - say_1'),
(30313, 0, 26, 27, 40, 0, 100, 512, 3, 30317, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - pause'),
(30313, 0, 27, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 6, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - say_2'),
(30313, 0, 28, 29, 40, 0, 100, 512, 5, 30317, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - pause'),
(30313, 0, 29, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 7, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - say_3'),
(30313, 0, 30, 31, 40, 0, 100, 512, 6, 30317, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - pause'),
(30313, 0, 31, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 8, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - say_4'),
(30313, 0, 32, 33, 40, 0, 100, 512, 7, 30317, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_5 - pause'),
(30313, 0, 33, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 9, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_5 - say_5'),
(30313, 0, 34, 35, 40, 0, 100, 512, 2, 30318, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - pause'),
(30313, 0, 35, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 15, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_1 - say_1'),
(30313, 0, 36, 37, 40, 0, 100, 512, 3, 30318, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - pause'),
(30313, 0, 37, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_2 - say_2'),
(30313, 0, 38, 39, 40, 0, 100, 512, 5, 30318, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - pause'),
(30313, 0, 39, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 17, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_3 - say_3'),
(30313, 0, 40, 41, 40, 0, 100, 512, 6, 30318, 0, 0, 0, 0, 54, 8000, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - pause'),
(30313, 0, 41, 0, 61, 0, 100, 512, 0, 0, 0, 0, 0, 0, 1, 18, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_4 - say_4'),
(30313, 0, 42, 0, 58, 0, 100, 0, 8, 30315, 0, 0, 0, 0, 11, 56532, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_end_invention - cast killcredit'),
(30313, 0, 43, 0, 58, 0, 100, 0, 8, 30316, 0, 0, 0, 0, 11, 56534, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_end_life - cast killcredit'),
(30313, 0, 44, 0, 58, 0, 100, 0, 8, 30317, 0, 0, 0, 0, 11, 56533, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_end_winter - cast killcredit'),
(30313, 0, 45, 0, 58, 0, 100, 0, 8, 30318, 0, 0, 0, 0, 11, 56535, 0, 0, 0, 0, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 'Mobile Databank - On wp_end_order - cast killcredit');

-- creature_text group 19 duplicates group 18 and exists only to absorb the overrun
-- described above. Nothing references it once the talk ids are corrected.
DELETE FROM `creature_text_locale` WHERE (`CreatureID` = 30313) AND (`GroupID` = 19);
DELETE FROM `creature_text` WHERE (`CreatureID` = 30313) AND (`GroupID` = 19);

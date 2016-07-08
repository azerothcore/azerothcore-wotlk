
-- Primal Ooze (6557)
UPDATE creature_template SET AIName='SmartAI', ScriptName='' WHERE entry=6557;
DELETE FROM smart_scripts WHERE entryorguid=6557 AND source_type=0;
INSERT INTO smart_scripts VALUES (6557, 0, 0, 0, 8, 0, 100, 0, 16031, 0, 0, 0, 22, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Primal Ooze - On Spellhit ''Releasing Corrupt Ooze'' - Set Event Phase 2');
INSERT INTO smart_scripts VALUES (6557, 0, 1, 2, 60, 2, 100, 1, 1500, 1500, 0, 0, 45, 0, 1, 0, 0, 0, 0, 9, 10290, 0, 35, 0, 0, 0, 0, 'Primal Ooze - On Update - Set Data 0 1 (Phase 2) (No Repeat)');
INSERT INTO smart_scripts VALUES (6557, 0, 2, 0, 61, 2, 100, 0, 0, 0, 0, 0, 29, 0, 0, 10290, 1, 1, 0, 9, 10290, 0, 35, 0, 0, 0, 0, 'Primal Ooze - On Update - Start Follow Closest Creature ''Captured Felwood Ooze'' (Phase 2) (No Repeat)');
INSERT INTO smart_scripts VALUES (6557, 0, 3, 4, 65, 2, 100, 0, 0, 0, 0, 0, 47, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Primal Ooze - On Follow Complete - Set Visibility Off (Phase 2)');
INSERT INTO smart_scripts VALUES (6557, 0, 4, 5, 61, 2, 100, 0, 0, 0, 0, 0, 12, 9621, 6, 20000, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Primal Ooze - On Follow Complete - Summon Creature ''Gargantuan Ooze'' (Phase 2)');
INSERT INTO smart_scripts VALUES (6557, 0, 5, 6, 61, 2, 100, 0, 0, 0, 0, 0, 11, 16032, 0, 0, 0, 0, 0, 9, 9621, 0, 5, 0, 0, 0, 0, 'Primal Ooze - On Follow Complete - Cast ''Merging Oozes'' (Phase 2)');
INSERT INTO smart_scripts VALUES (6557, 0, 6, 0, 61, 2, 100, 0, 0, 0, 0, 0, 41, 50, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Primal Ooze - On Follow Complete - Despawn In 50 ms (Phase 2)');

-- Scarlet Monastery wing entrance gates for mod-nostrum-progression.
-- Each entrance AreaTrigger is bound to the same script; the script checks
-- kAreaTriggerLock to determine the required era/phase per wing.
--
-- AreaTrigger IDs (from areatrigger_teleport):
--   45  = Graveyard entrance  (Phase 1,2)
--   614 = Library entrance    (Phase 1,3)
--   612 = Armory entrance     (Phase 1,3)
--   610 = Cathedral entrance  (Phase 1,3)

DELETE FROM areatrigger_scripts WHERE entry IN (45, 610, 612, 614);
INSERT INTO areatrigger_scripts (entry, ScriptName) VALUES
(45,  'nostrum_progression_at'),
(610, 'nostrum_progression_at'),
(612, 'nostrum_progression_at'),
(614, 'nostrum_progression_at');

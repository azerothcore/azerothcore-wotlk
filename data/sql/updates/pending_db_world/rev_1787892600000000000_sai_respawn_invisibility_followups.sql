-- Additional SmartAI spawn-state fixes for the InitializeAI / JustRespawned race.
-- SmartAI::JustRespawned() forces SetVisible(true) and RestoreFaction() before
-- ProcessEventsFor(SMART_EVENT_RESPAWN). Setup on AI_INIT (37), JUST_CREATED (63),
-- or RESET (25) with NOT_REPEATABLE is lost; only RESPAWN (11) re-fires after that.
-- When moving hide/faction setup to RESPAWN, drop NOT_REPEATABLE so the second fire
-- can re-apply. One-shot emerge scripts use a separate RESPAWN+NOT_REPEATABLE row.

-- Darkmaster Gandling (1853): same Timmy pattern (RESET+NOT_REPEATABLE invis + faction)
UPDATE `smart_scripts` SET `event_type` = 11, `event_flags` = 768, `comment` = 'Darkmaster Gandling - On Respawn - Set Invisible' WHERE (`entryorguid` = 1853) AND (`source_type` = 0) AND (`id` = 8);

-- Ironbark the Redeemed (14241)
UPDATE `smart_scripts` SET `event_type` = 11, `comment` = 'Ironbark the Redeemed - On Respawn - Set Invisible' WHERE (`entryorguid` = 14241) AND (`source_type` = 0) AND (`id` = 1);

-- Ancient Equine Spirit (14566)
UPDATE `smart_scripts` SET `event_type` = 11, `event_flags` = 768, `comment` = 'Ancient Equine Spirit - On Respawn - Set Invisible' WHERE (`entryorguid` = 14566) AND (`source_type` = 0) AND (`id` = 3);

-- Horrified Drakkari Shaman (guid -116602): JUST_CREATED chain includes set invisible
UPDATE `smart_scripts` SET `event_type` = 11, `comment` = 'Horrified Drakkari Shaman - On Respawn - Set Active On' WHERE (`entryorguid` = -116602) AND (`source_type` = 0) AND (`id` = 1);

-- Magrami Spectre (11560): AI_INIT faction undone by RestoreFaction in JustRespawned
UPDATE `smart_scripts` SET `event_type` = 11, `comment` = 'Magrami Spectre - On Respawn - Set Faction' WHERE (`entryorguid` = 11560) AND (`source_type` = 0) AND (`id` = 0);

-- Lady Falther'ess (14686): AI_INIT transform+friendly faction undone by RestoreFaction
UPDATE `smart_scripts` SET `event_type` = 11, `comment` = 'Lady Falther''ess - On Respawn - Cast Transform' WHERE (`entryorguid` = 14686) AND (`source_type` = 0) AND (`id` = 0);

-- Prince Arthas (27455): hide on every RESPAWN; start emerge script once (NOT_REPEATABLE)
UPDATE `smart_scripts` SET `event_type` = 11, `link` = 0, `comment` = 'Prince Arthas - On Respawn - Set Invisible' WHERE (`entryorguid` = 27455) AND (`source_type` = 0) AND (`id` = 0);
UPDATE `smart_scripts` SET `event_type` = 11, `event_flags` = 513, `comment` = 'Prince Arthas - On Respawn - Run Script (No Repeat)' WHERE (`entryorguid` = 27455) AND (`source_type` = 0) AND (`id` = 1);

-- Risen Deathspeaker Servant (36844): hide on every RESPAWN; emerge setup once (NOT_REPEATABLE)
UPDATE `smart_scripts` SET `event_type` = 11, `link` = 0, `comment` = 'Risen Deathspeaker Servant - On Respawn - Set Invisible' WHERE (`entryorguid` = 36844) AND (`source_type` = 0) AND (`id` = 3);
UPDATE `smart_scripts` SET `event_type` = 11, `event_flags` = 513, `comment` = 'Risen Deathspeaker Servant - On Respawn - Set Unit Flags (No Repeat)' WHERE (`entryorguid` = 36844) AND (`source_type` = 0) AND (`id` = 4);

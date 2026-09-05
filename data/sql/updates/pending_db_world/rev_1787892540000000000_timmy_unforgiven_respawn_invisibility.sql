-- Timmy the Cruel / The Unforgiven: apply invisibility on SMART_EVENT_RESPAWN (11) so it
-- survives SmartAI::JustRespawned() forcing SetVisible(true) before ProcessEventsFor(RESPAWN).

UPDATE `smart_scripts` SET `event_type` = 11, `event_flags` = 768, `comment` = 'Timmy the Cruel - On Respawn - Set Invisible' WHERE (`entryorguid` = 10808) AND (`source_type` = 0) AND (`id` = 3);
UPDATE `smart_scripts` SET `event_type` = 11, `comment` = 'The Unforgiven - On Respawn - Set Invisible' WHERE (`entryorguid` = 10516) AND (`source_type` = 0) AND (`id` = 0);

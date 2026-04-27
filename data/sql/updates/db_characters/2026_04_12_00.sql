-- DB update 2026_04_03_00 -> 2026_04_12_00
-- Flush all respawn times to ensure a clean slate for the spawn group system.
-- Compat-mode creatures/GOs will respawn naturally on next grid load;
-- non-compat spawns will be handled by ProcessRespawns().
TRUNCATE TABLE `creature_respawn`;
TRUNCATE TABLE `gameobject_respawn`;

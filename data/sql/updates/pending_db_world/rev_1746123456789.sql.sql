-- [Howling Fjord] Quest 11280: Draconis Gastritis
-- Assign C++ script to NPC 24170 (Draconis Gastritis Bunny)
UPDATE `creature_template`
SET `AIName` = '',
    `ScriptName` = 'npc_draconis_gastritis_bunny'
WHERE `entry` = 24170;
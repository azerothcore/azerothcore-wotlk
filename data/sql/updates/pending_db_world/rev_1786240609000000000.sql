-- Negolash is summoned onto the beach right next to the player instead of rising out
-- of the sea, so he never makes the walk towards the boat where the food was laid out
-- (issue #27049). The SmartAI on the Ruined Lifeboat spawns him at z = 1.72, which is
-- above the waterline.
--
-- VMaNGOS, whose data for this vanilla quest is researched down to respawning each
-- buzzard wing, summons him at -14598.6 76.0563 -11.249, well below the surface:
-- sql/migrations/20211001113141_world.sql, "Ruined Lifeboat - Summon Creature Negolash".
UPDATE `smart_scripts` SET `target_x` = -14598.6, `target_y` = 76.0563, `target_z` = -11.249, `target_o` = 0.925025
WHERE `entryorguid` = 2289 AND `source_type` = 1 AND `id` = 0 AND `event_type` = 20 AND `action_type` = 12;

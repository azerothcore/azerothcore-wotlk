-- Transmog NPC spawns (entry 190010 — Warpweaver)
--
-- GUIDs 9000010–9000011 (NostrumWoW custom range, following guide NPCs 9000001–9000009)
--
-- To remove:
--   DELETE FROM creature WHERE guid IN (9000010, 9000011);

DELETE FROM creature WHERE guid IN (9000010, 9000011);
INSERT INTO creature
    (guid, id1, map, position_x, position_y, position_z, orientation,
     spawnMask, phaseMask, equipment_id, spawntimesecs, wander_distance,
     curhealth, MovementType)
VALUES
-- Alliance — Stormwind (map 0)
(9000010, 190010, 0, -8845.938,  626.84357, 94.52685,  0.4212306, 1, 1, 0, 120, 0, 100, 0),
-- Horde — Orgrimmar (map 1)
(9000011, 190010, 1,  1645.059, -4430.303, 16.679878, 1.5652533, 1, 1, 0, 120, 0, 100, 0);

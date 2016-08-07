-- spawned transmorg npc in dalaran
DELETE FROM creature WHERE id = 190010;
INSERT INTO creature (guid, id , map, spawnMask, phaseMask, modelid, equipment_id, position_x, position_y, position_z, orientation, spawntimesecs, spawndist, currentwaypoint, curhealth, curmana, MovementType, npcflag, unit_flags, dynamicflags) 
VALUES (NULL, 190010, 571, 1, 1, 0, 0, 5805.05, 658.984, 648.01, 4.79024, 300, 0, 0, 12600, 0, 0, 0, 0, 0)

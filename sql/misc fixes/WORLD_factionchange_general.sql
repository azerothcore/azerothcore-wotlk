
-- achievement Flirt With Disaster
DELETE FROM player_factionchange_achievement WHERE alliance_id IN(1279, 1280) OR horde_id IN(1279, 1280);
INSERT INTO player_factionchange_achievement VALUES(1279, 1280);

-- achievement Stormpike Perfection (A) / Frostwolf Perfection (H)
DELETE FROM player_factionchange_achievement WHERE alliance_id IN(220, 873) OR horde_id IN(220, 873);
INSERT INTO player_factionchange_achievement VALUES(220, 873);

-- Quests
DELETE FROM player_factionchange_quests WHERE alliance_id IN(12887, 12896, 12898) OR horde_id IN(12892, 12897, 12899);
INSERT INTO player_factionchange_quests VALUES(12887, 12892);
INSERT INTO player_factionchange_quests VALUES(12896, 12897);
INSERT INTO player_factionchange_quests VALUES(12898, 12899);

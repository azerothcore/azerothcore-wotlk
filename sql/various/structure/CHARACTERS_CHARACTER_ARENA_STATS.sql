ALTER TABLE character_arena_stats ADD COLUMN maxMMR SMALLINT(5) NOT NULL;
UPDATE character_arena_stats SET maxMMR = matchMakerRating;

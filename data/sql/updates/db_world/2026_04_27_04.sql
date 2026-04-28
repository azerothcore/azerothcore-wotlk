-- DB update 2026_04_27_03 -> 2026_04_27_04
-- Re-enable Troll racial Regeneration (20555): scaling is handled in core
-- (Player::RegenerateHealth). Remove any player spell disable for 20555.

DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` = 20555;


-- Death Knight levels 1-54 in player_class_stats (copy warrior baseline).
-- Stock acore_world only defines class 6 from level 55; StartHeroicPlayerLevel = 1
-- requires non-zero stats at index (StartHeroicPlayerLevel - 1) or worldserver exits:
-- "Race X class 6 initial level does not have stats data!"

DELETE FROM `player_class_stats` WHERE `Class` = 6 AND `Level` BETWEEN 1 AND 54;

INSERT INTO `player_class_stats` (`Class`, `Level`, `BaseHP`, `BaseMana`, `Strength`, `Agility`, `Stamina`, `Intellect`, `Spirit`)
SELECT 6, `Level`, `BaseHP`, `BaseMana`, `Strength`, `Agility`, `Stamina`, `Intellect`, `Spirit`
FROM `player_class_stats`
WHERE `Class` = 1 AND `Level` BETWEEN 1 AND 54;

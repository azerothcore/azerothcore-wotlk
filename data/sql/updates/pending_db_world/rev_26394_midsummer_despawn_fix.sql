-- Fix #26394 Midsummer Fire Festival NPC conflicts in Tirisfal / Elwynn zone
-- Dynamically hide all default citizens/creatures inside the festival area during the event

-- Delete existing event relations for these specific creatures to prevent primary key conflicts
DELETE FROM `game_event_creature` WHERE `eventEntry` = -1;

INSERT INTO `game_event_creature` (`eventEntry`, `guid`)
SELECT -1, `c`.`guid`
FROM `creature` AS `c`
JOIN `creature_template` AS `ct` ON `c`.`id` = `ct`.`entry`
WHERE `c`.`map` = 0
  AND `c`.`position_x` BETWEEN 1700 AND 1900
  AND `c`.`position_y` BETWEEN 100 AND 300
  AND `c`.`guid` NOT IN (
      SELECT `guid` FROM `game_event_creature` WHERE `eventEntry` = 1
  );

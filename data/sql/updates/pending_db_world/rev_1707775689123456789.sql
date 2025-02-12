ALTER TABLE `npc_vendor`
ADD COLUMN `buycount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `maxcount`;
ALTER TABLE `game_event_npc_vendor`
ADD COLUMN `buycount` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0' AFTER `maxcount`;

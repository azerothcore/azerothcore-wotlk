-- DB update 2025_06_17_00 -> 2025_06_17_01
--
ALTER TABLE `game_event_creature` MODIFY COLUMN `eventEntry` smallint NOT NULL COMMENT 'Entry of the game event. Put negative entry to remove during event.';
ALTER TABLE `game_event_gameobject` MODIFY COLUMN `eventEntry` smallint NOT NULL COMMENT 'Entry of the game event. Put negative entry to remove during event.';
ALTER TABLE `game_event_model_equip` MODIFY COLUMN `eventEntry` tinyint unsigned NOT NULL COMMENT 'Entry of the game event.';
ALTER TABLE `game_event_npc_vendor` MODIFY COLUMN `eventEntry` smallint NOT NULL COMMENT 'Entry of the game event.';
ALTER TABLE `game_event_pool` MODIFY COLUMN `eventEntry` smallint NOT NULL COMMENT 'Entry of the game event. Put negative entry to remove during event.';

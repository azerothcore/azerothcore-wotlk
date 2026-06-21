-- branding_event_spawn (design §9.1): event (zone, type) -> manual spawn_group + map.
-- Created here so EventScheduler can read it on a fresh DB before any authoring-tool export runs.
-- The invasion authoring tool refreshes the rows (and the spawn_group_template/spawn_group content).
CREATE TABLE IF NOT EXISTS `branding_event_spawn`
(
    `zone_id` INT UNSIGNED NOT NULL,
    `event_type` TINYINT UNSIGNED NOT NULL COMMENT '0=Invasion,1=Surge,2=EliteHunt,3=ProfAnomaly',
    `group_id` INT UNSIGNED NOT NULL COMMENT 'spawn_group_template.groupId (manual-spawn group)',
    `map_id` SMALLINT UNSIGNED NOT NULL COMMENT 'map the group lives on',
    PRIMARY KEY (`zone_id`, `event_type`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Admin-tunable per-zone downscaling brackets for mod-branding (§2.1).
-- A row overrides the built-in AreaTableEntry.area_level for the player's zone; zones with no row
-- keep the v1 area_level fallback. Studied after mod-zone-difficulty `zone_difficulty_info` shape.
CREATE TABLE IF NOT EXISTS `branding_zone_bracket` (
    `zone_id` INT UNSIGNED NOT NULL COMMENT 'Zone id (Player::GetZoneId).',
    `target_level` TINYINT UNSIGNED NOT NULL COMMENT 'Downscale bracket: players above this level are scaled down to it.',
    PRIMARY KEY (`zone_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='mod-branding per-zone downscaling brackets (overrides area_level).';

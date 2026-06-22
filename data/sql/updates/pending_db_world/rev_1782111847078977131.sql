-- Heroic-overlay mechanic exceptions (§2.4.6). ADVISORY recommended group size for body-count-dependent
-- encounters (e.g. Four Horsemen, Razorgore). Surfaced to players via `.branding heroic`; does NOT gate
-- entry, force a minimum, or disable the overlay -- the group's call to bring a larger raid.
CREATE TABLE IF NOT EXISTS `branding_heroic_exception`
(
    `map_id` INT UNSIGNED NOT NULL,
    `boss_entry` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT '0 = whole map',
    `recommended_min_bodies` TINYINT UNSIGNED NOT NULL DEFAULT 1,
    `note` VARCHAR(255) NOT NULL DEFAULT '',
    PRIMARY KEY (`map_id`, `boss_entry`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

DELETE FROM `branding_heroic_exception` WHERE `map_id` IN (469, 531, 533);
INSERT INTO `branding_heroic_exception` (`map_id`, `boss_entry`, `recommended_min_bodies`, `note`) VALUES
(469, 0,  8, 'Blackwing Lair: Razorgore orb control and the Vaelastrasz burn need a fuller raid.'),
(531, 0, 10, 'Temple of Ahn''Qiraj: C''Thun spread/dispel checks assume a fuller raid.'),
(533, 0, 10, 'Naxxramas: Four Horsemen needs 4+ tank-capable positions; bring a 10-man.');

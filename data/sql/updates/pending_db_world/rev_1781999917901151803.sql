-- Branding economy/crafting (§8.6): recipe table consumed by EconomyMgr.
-- inputs (materials + fragments, config-mapped item entries) -> output item + character XP.
CREATE TABLE IF NOT EXISTS `branding_recipe` (
    `id` INT UNSIGNED NOT NULL COMMENT 'Recipe id used by .branding craft <id>',
    `materials` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Material items consumed (Branding.Economy.MaterialItemId)',
    `fragments` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Fragment items consumed (Branding.Economy.FragmentItemId)',
    `output_item` INT UNSIGNED NOT NULL COMMENT 'item_template.entry produced (1 unit)',
    `char_xp` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Character XP granted on craft',
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='mod-branding closed-loop crafting recipes';

DELETE FROM `branding_recipe` WHERE `id` IN (1, 2, 3);
INSERT INTO `branding_recipe` (`id`, `materials`, `fragments`, `output_item`, `char_xp`) VALUES
    (1, 5, 0, 2589, 100),
    (2, 10, 5, 4338, 250),
    (3, 20, 10, 7191, 600);

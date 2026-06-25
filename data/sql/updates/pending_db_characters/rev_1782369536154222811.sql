-- Player-selected role per loadout (design §7.9 / §14.11 talent-spec seam): adds the chosen role to
-- the per-character brand loadout. 0 = None = unset -> resolved at runtime by the default RolePolicy;
-- an explicit value is gated by class capability before persistence. Mirrors RoleContribution enum.
ALTER TABLE `character_brand_loadout`
    ADD COLUMN `selected_role` TINYINT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'RoleContribution enum value; 0=None (auto)';

-- branding_event_spawn crowd-scaling extension (design §2.5): per-tier threshold + goal contribution.
-- Invasions spawn MORE mobs as the enrolled crowd grows -- each (zone_id, event_type) now owns
-- multiple additive spawn tiers (base tier at min_participants 0, reinforcements above), so the
-- primary key gains group_id. goal_contribution lets containment track the live spawn volume.
ALTER TABLE `branding_event_spawn`
    ADD COLUMN `min_participants` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'enrolled headcount to spawn this tier (0 = base, always up)',
    ADD COLUMN `goal_contribution` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'containment goal this tier adds while active (2.5.4)',
    DROP PRIMARY KEY,
    ADD PRIMARY KEY (`zone_id`, `event_type`, `group_id`);

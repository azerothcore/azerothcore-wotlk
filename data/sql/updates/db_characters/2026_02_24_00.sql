-- DB update 2025_09_03_00 -> 2026_02_24_00
--
ALTER TABLE `quest_tracker`
  MODIFY COLUMN `id` int UNSIGNED NOT NULL DEFAULT 0 FIRST,
  ADD UNIQUE INDEX `idx_latest_quest_for_character`(`id`, `character_guid`, `quest_accept_time` DESC);

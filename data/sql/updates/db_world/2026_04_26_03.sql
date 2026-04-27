-- DB update 2026_04_26_02 -> 2026_04_26_03
-- Re-enable Troll racial Regeneration (20555): scaling is handled in core
-- (Player::RegenerateHealth). Remove any player spell disable for 20555.

DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` = 20555;

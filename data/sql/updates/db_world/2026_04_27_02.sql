-- DB update 2026_04_27_01 -> 2026_04_27_02
-- Lasagna HC: disable Troll racial Regeneration (spell 20555) for players.
-- Core applies `disables` during Player::_addSpell (passives learned at
-- creation or load were not blocked by cast-time checks alone).

DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` = 20555;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(0, 20555, 1, '', '', 'Disable Troll racial Regeneration for players');

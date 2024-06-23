-- disable spell 28784 'Summon Midsummer Bonfire Bunnies'
DELETE FROM `disables` WHERE `sourceType` = 0 AND `entry` = 28784;
INSERT INTO `disables` (`sourceType`, `entry`, `flags`, `params_0`, `params_1`, `comment`) VALUES
(0, 28784, 8, '', '', 'Spell Summon Midsummer Bonfire Bunnies unused');

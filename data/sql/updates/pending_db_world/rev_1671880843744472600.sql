--
DELETE FROM `acore_string` WHERE `entry` = 5084;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(5084, 'Spell cast failed! SpellCastResult returned: %s (%u).');

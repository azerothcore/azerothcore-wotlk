-- New acore_string for LANG_COMMAND_LEARN_CLASS_TALENT_POINTS (Language.h), used by
-- ".learn all my class" now that it grants free talent points instead of learning every talent -
-- the old LANG_COMMAND_LEARN_CLASS_TALENTS message ("You learned all talents for class.") would
-- no longer be accurate for that command.
DELETE FROM `acore_string` WHERE `entry` = 35471;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(35471, 'You have been granted your free class talent points to spend.');

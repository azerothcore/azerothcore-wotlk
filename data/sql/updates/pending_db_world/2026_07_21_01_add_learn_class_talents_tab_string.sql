-- New acore_string for LANG_COMMAND_LEARN_CLASS_TALENTS_TAB (Language.h), used by
-- ".learn all my talents <1|2|3>" to report which talent tab was force-learned.
DELETE FROM `acore_string` WHERE `entry` = 35471;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(35471, 'You have activated all talents in tab {}.');

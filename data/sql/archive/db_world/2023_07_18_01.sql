-- DB update 2023_07_18_00 -> 2023_07_18_01

SET @HELP_TEXT := 'Syntax: .wp show $option\nOptions:\non $pathid (or selected creature with loaded path) - Show path\noff - Hide path\ninfo $selected_waypoint - Show info for selected waypoint.';
UPDATE `command` SET `help` = @HELP_TEXT WHERE `name` = 'wp show';

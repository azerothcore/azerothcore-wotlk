-- DB update 2025_08_28_00 -> 2025_08_28_01
-- add wp show first/last to command help
UPDATE `command` SET
`help`='Syntax: .wp show $option\nOptions:\non $pathid (or selected creature with loaded path) - Show path\nfirst $pathid (or selected creature with loaded path) - Show first waypoint\nlast $pathid (or selected creature with loaded path) - Show last waypoint\noff - Hide path (all waypoints in current map)\ninfo $selected_waypoint - Show info for selected waypoint.'
WHERE `name` = 'wp show';

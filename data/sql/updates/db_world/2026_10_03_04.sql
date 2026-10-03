-- DB update 2026_10_03_03 -> 2026_10_03_04
--
UPDATE `command` SET `help` = 'Syntax: .wp modify $option [$value]\nChange the selected waypoint (show the path with .wp show on and target a waypoint first).\ndel - delete the waypoint\nmove - move the waypoint to your position\ndelay $milliseconds - wait time at the waypoint\naction $id - waypoint_scripts id to run at the waypoint\naction_chance $percent - chance to run that action\nmove_type $type - 0 walk, 1 run, 2 land, 3 takeoff' WHERE `name` = 'wp modify';

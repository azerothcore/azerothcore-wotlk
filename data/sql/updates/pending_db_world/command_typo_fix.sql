
UPDATE command 
SET help = 'Syntax: .wp show $option\nOptions:\non $pathid (or selected creature with loaded path) - Show path\noff - Hide path\ninfo $selected_waypoint - Show info for selected waypoint.'
WHERE 
  name = 'wp show';

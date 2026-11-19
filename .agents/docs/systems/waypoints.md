# Waypoints

Creature paths in the world DB's `waypoint_data`.

- A path built from a sniffed creation spline (the points a create block's movement carries, e.g. a flying loop)
  keeps each point once per lap. The spline repeats points to close the loop, in a layout that varies by creature
  (Monstrous Kaliri 23051: last 3 = first 3; Emerald Skytalon 27244: P0 = P[-4], P1 = P[-3] = P[-1]), and a spline
  that starts at the spawn (CO2) has 2 lead-in points the loop never uses (P1 is the spawn position), so its repeats
  start at P2. Drop P0-P1 when the first repeated point is P2, then keep each point's first occurrence; never slice a
  fixed count. A kept repeat makes the creature turn back every lap.

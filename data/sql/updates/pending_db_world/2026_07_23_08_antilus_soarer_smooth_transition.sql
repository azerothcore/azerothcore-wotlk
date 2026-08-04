-- Antilus the Soarer (5347) flaps far slower than the rest of its family: it is the only one
-- with a fixed patrol path. A waypoint's own Velocity overrides speed_flight for that leg, so
-- set it on the path instead of touching the creature's flight speed.
UPDATE `waypoint_data` SET `smoothTransition` = 1, `velocity` = 9.0 WHERE `id` = 518400;

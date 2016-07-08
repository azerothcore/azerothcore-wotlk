
-- Misc spawns under ground
UPDATE creature SET spawndist=0, MovementType=0 WHERE guid IN(66057, 66080, 66400, 66551);
UPDATE creature SET position_z=6.0 WHERE guid=66400;
UPDATE creature SET position_z=-2.0 WHERE guid=66551;

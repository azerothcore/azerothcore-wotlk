DELETE FROM creature WHERE id IN (100100, 100101, 100102);

-- Quartermaster ozorg (DK start) location: under acherus, eastern plaguelands
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
('100100','0','1','1','0','0','2395.91','-5748.07','153.92','3.83941','300','50','0','29520','0','1','0','0','0');

-- Raymond George (T3) location: light's hope chapel, eastern plaguelands
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
('100101','0','1','1','10479','0','2242.38','-5348.8','86.1457','3.01702','300','0','0','29520','0','0','0','0','0');

-- Arsenio (Heirloom) location: the underbelly, dalaran
INSERT INTO `creature` (`id`, `map`, `spawnMask`, `phaseMask`, `modelid`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `spawndist`, `currentwaypoint`, `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`) VALUES
('100102','571','1','1','0','0','5779.37','730.04','618.556','3.97813','300','0','0','29520','0','0','0','0','0');

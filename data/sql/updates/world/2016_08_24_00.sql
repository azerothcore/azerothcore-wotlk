ALTER TABLE world_db_version CHANGE COLUMN 2016_08_21_00 2016_08_24_00 bit;

-- Insert MovementType to Fizzle Darkstorm (GUID = 6455) and Burning Blade Fanatic (GUID = 6432) npc

DELETE FROM `waypoint_data` WHERE `id` IN (645500,643200);
-- Fizzle Darkstorm
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
('645500', '1', '870.331', '-4202.85', '-14.0742', '0', '45000', '0', '0', '100', '0'),
('645500', '2', '869.751', '-4190.07', '-14.1105', '0', '45000', '0', '0', '100', '0'),
-- Burning Blade Fanatic
('643200', '1', '843.944', '-4207.75', '-9.11563', '0', '0', '0', '0', '100', '0'),
('643200', '2', '855.389', '-4212.85', '-9.99841', '0', '0', '0', '0', '100', '0'),
('643200', '3', '867.336', '-4204.73', '-13.9766', '0', '0', '0', '0', '100', '0'),
('643200', '4', '879.138', '-4186.37', '-13.9981', '0', '0', '0', '0', '100', '0'),
('643200', '5', '898.795', '-4170.9', '-9.24759', '0', '0', '0', '0', '100', '0'),
('643200', '6', '894.318', '-4165.13', '-9.10758', '0', '0', '0', '0', '100', '0'),
('643200', '7', '881.809', '-4167.77', '-13.8924', '0', '0', '0', '0', '100', '0'),
('643200', '8', '864.355', '-4183.45', '-14.0399', '0', '0', '0', '0', '100', '0'),
('643200', '9', '847.975', '-4191.54', '-10.0094', '0', '0', '0', '0', '100', '0'),
('643200', '10', '847.094', '-4194.71', '-9.9878', '0', '0', '0', '0', '100', '0');

-- Fizzle Darkstorm
UPDATE `creature_addon` SET `path_id`='645500' WHERE `guid`='6455';
UPDATE `creature` SET `MovementType`='2' WHERE `guid`='6455';

-- Burning Blade Fanatic
DELETE FROM `creature_addon` WHERE `guid` = 6432;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`) VALUES ('6432', '643200', '0', '0', '0', '0', '0');
UPDATE `creature` SET `MovementType`='2' WHERE `guid`='6432';


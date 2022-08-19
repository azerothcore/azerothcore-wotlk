/*
-- ################################################################################### --
--  ____    __                                         ____                           
-- /\  _`\ /\ \__                  __                 /\  _`\                         
-- \ \,\L\_\ \ ,_\  __  __     __ /\_\     __      ___\ \ \/\_\    ___   _ __    __   
--  \/_\__ \\ \ \/ /\ \/\ \  /'_ `\/\ \  /'__`\  /' _ `\ \ \/_/_  / __`\/\`'__\/'__`\ 
--    /\ \L\ \ \ \_\ \ \_\ \/\ \L\ \ \ \/\ \L\.\_/\ \/\ \ \ \L\ \/\ \L\ \ \ \//\  __/ 
--    \ `\____\ \__\\/`____ \ \____ \ \_\ \__/.\_\ \_\ \_\ \____/\ \____/\ \_\\ \____\
--     \/_____/\/__/ `/___/> \/___L\ \/_/\/__/\/_/\/_/\/_/\/___/  \/___/  \/_/ \/____/
--                      /\___/ /\____/                                                
--                      \/__/  \_/__/          http://stygianthebest.github.io                                         
-- 
-- ################################################################################### --
-- 
-- WORLD: TELEPORT LOCATIONS (.tele)
--
-- Adds additional teleport destinations for use with StygianCore.
-- 
-- 2021.04.07:
--			Update to latest AC database by Anhedonie
-- ################################################################################### --
*/



-- --------------------------------------------------------------------------------------
-- Clean Up
-- --------------------------------------------------------------------------------------
DELETE FROM `game_tele` WHERE `id` > 1423;

-- --------------------------------------------------------------------------------------
-- Add Teleport Locations
-- --------------------------------------------------------------------------------------
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1473', '1485.96', '5399.54', '0.496111', '2.13523', '571', 'terkyscave');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1472', '-12879.3', '-1408.12', '120.106', '0.488073', '0', 'tigercave');

-- --------------------------------------------------------------------------------------
-- Programmer Isle & Designer Isle (Will crash without client patch and/or updated DBC)
-- --------------------------------------------------------------------------------------
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1471', '16302.5', '16220.3', '69', '1.5394', '451', 'programisle');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1470', '16303', '-16173', '40', '0.361313', '451', 'designisle'); 


-- --------------------------------------------------------------------------------------
-- Emerald Dream (Requires an Updated MAP.DBC file on the server)
-- --------------------------------------------------------------------------------------
-- INSERT INTO `instance_template` (`map`, `parent`, `script`, `allowMount`) VALUES ('169', '0', 'emerald_dream', '0');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1469', '-4199.78', '-2597.09', '138.207', '6.17003', '169', 'emdream4');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1468', '-2716.34', '-2519.49', '142.365', '3.22479', '169', 'emdream3');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1467', '3249.74', '-3140.2', '99.7819', '3.38187', '169', 'emdream2');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1466', '2729.99', '2987.88', '23.2229', '0.326661', '169', 'emdream1'); 

-- --------------------------------------------------------------------------------------
-- Teleport (maybe you need to insert these manually - just copy the INSERT INTO commands below and use them on you database) 

INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1465', '-700.315', '-1322.47', '259.742', '4.90748', '1', 'e3');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1464', '-745.952', '-989.286', '194.098', '2.01729', '1', 'e2');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1463', '-703.015', '-1066.34', '179.364', '0.0823302', '1', 'e1');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1462', '-827.503', '-1177.36', '150.009', '0.389758', '1', 'tb1');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1461', '3984.85', '-4764.04', '304.79', '4.60842', '1', 'bearsheadtower');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1460', '-8755.09', '853.976', '97.635', '3.84566', '0', 'stockades');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1459', '-6581.37', '-3485.41', '318.13', '0.474687', '0', 'deadkingscrypt');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1458', '-396.86', '-2183.42', '158.1', '0.162564', '1', 'koiter');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1457', '-10806.2', '2448.78', '2.12592', '5.56451', '1', 'campsilithus');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1456', '7758.24', '-2409.7', '489.282', '4.14574', '1', 'gemmoon');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1455', '-10733.8', '2509.35', '5.88962', '0.899085', '1', 'campadventure');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1454', '481.382', '-58.6908', '-62.1367', '4.98928', '230', 'brdtorturedslave');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1453', '1301.16', '-497.658', '-26.9183', '2.51131', '230', 'brdfallsbridge');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1452', '843.684', '-129.753', '-54.1222', '5.24943', '230', 'grimguzzler');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1451', '-10806.2', '2448.78', '2.12592', '5.56451', '1', 'silithuscamp');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1450', '-9875.18', '-3383.5', '0.243638', '2.67424', '1', 'fishspot1');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1449', '-4138.98', '-4044.9', '2.93043', '4.4622', '1', 'natpagle');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1448', '-3979.26', '-1307.83', '149.979', '2.79157', '0', 'dwarvenfarm');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1447', '-4599.19', '-1705.24', '523.829', '2.77195', '0', 'dwarvenairport');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1446', '-4278.03', '-1405.15', '224.025', '3.22358', '0', 'dfarmtunnel');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1445', '-8826.02', '-4751.94', '1.99467', '4.16024', '1', 'winky');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1444', '-9477.33', '-5463.35', '-345.285', '3.82645', '1', 'uwgnomecity');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1443', '-7646.74', '-634.162', '200.452', '3.08536', '0', 'morzul');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1442', '2621.28', '1782.65', '341.111', '1.27309', '1', 'UnchartedZone');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1441', '2302.46', '-2296.64', '146.834', '4.11409', '0', 'WeepingCave');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1440', '-1197.59', '31.0478', '256.953', '1.88871', '1', 'TBTotemTop');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1439', '-2706.94', '-4667.63', '10.1641', '4.73316', '1', 'DrWeevil');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1438', '-10295.8', '-4325.3', '-35.9224', '0.392655', '1', 'Mermaiden');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1437', '-11822.1', '-4761.89', '6.72025', '2.47789', '1', 'GadgetShoreIsland');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1436', '-10806.2', '2448.78', '2.12592', '5.56451', '1', 'CaveShoreCamp');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1435', '-10654.1', '2093.47', '-45.4265', '1.28017', '1', 'CaveShore');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1434', '16230.4', '16401.4', '-64.3786', '2.63182', '1', 'Prison');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1433', '2358.17', '-5663.21', '426.027', '5.31323', '609', 'DKzone');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1432', '-23.9044', '9.59795', '-144.709', '1.7014', '25', 'box');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1431', '80.2287', '3.33371', '-144.709', '5.95369', '25', 'minek');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1430', '-7933.11', '1942.26', '5.72931', '4.90082', '1', 'goldbug');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1429', '-4819.56', '-974.088', '464.709', '3.963', '0', 'ironjaskinia');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1428', '-4819.67', '-975.082', '464.709', '3.79802', '0', 'Minastirjaskinia');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1427', '16227.8', '16403.4', '-64.3804', '3.13604', '1', 'Minastirisland');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1425', '16202.2', '16256.5', '21.1869', '6.07893', '1', 'wyspa');
INSERT INTO `world`.`game_tele` (`id`, `position_x`, `position_y`, `position_z`, `orientation`, `map`, `name`) VALUES ('1424', '16218.7', '16403.6', '-64.3789', '3.12191', '1', 'Jail');
INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1616925470382883324');

DELETE FROM `gossip_menu` WHERE MenuID IN (7111, 7112, 7113, 7114, 7115, 7118, 7119, 7120, 7121, 7122, 7123, 7124, 7125);

INSERT INTO `gossip_menu` VALUES 
-- Huntsman Leopold
(7111, 8369),
(7112, 8370),
-- Rimblat Earthshatter
(7113, 8371),
(7114, 8372),
(7115, 8373),
-- Rohan the Assassin
(7118, 8380),
(7119, 8381),
(7120, 8382),
(7121, 8383),
(7122, 8384),
-- Rayne
(7123, 8385),
(7124, 8386),
(7125, 8387);

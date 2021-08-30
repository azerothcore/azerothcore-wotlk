INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1629818510750235317');

-- Removed Manual: Heavy Silk Bandage and Manual: Mageweave Bandage from Deneb Walker (2805)
DELETE FROM `npc_vendor` WHERE (`entry` = 2805) AND (`item` IN (16112, 16113));

-- Removed Manual: Heavy Silk Bandage and Manual: Mageweave Bandage from Balai Lok'Wein (13476)
DELETE FROM `npc_vendor` WHERE (`entry` = 13476) AND (`item` IN (16112, 16113));


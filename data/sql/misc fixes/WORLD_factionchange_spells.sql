
-- ----------------------------
-- Table structure for `player_factionchange_spells`
-- ----------------------------
DROP TABLE IF EXISTS `player_factionchange_spells`;
CREATE TABLE `player_factionchange_spells` (
  `alliance_id` int(10) unsigned NOT NULL,
  `alliance_comment` text NOT NULL,
  `horde_id` int(10) unsigned NOT NULL,
  `horde_comment` text NOT NULL,
  PRIMARY KEY (`alliance_id`,`horde_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of player_factionchange_spells
-- ----------------------------
INSERT INTO `player_factionchange_spells` VALUES ('458', 'Brown Horse', '6654', 'Brown Wolf');
INSERT INTO `player_factionchange_spells` VALUES ('470', 'Black Stallion', '64658', 'Black Wolf');
INSERT INTO `player_factionchange_spells` VALUES ('472', 'Pinto', '580', 'Timber Wolf');
INSERT INTO `player_factionchange_spells` VALUES ('3561', 'Teleport: Stormwind', '3567', 'Teleport: Orgrimmar');
INSERT INTO `player_factionchange_spells` VALUES ('3562', 'Teleport: Ironforge', '3563', 'Teleport: Undercity');
INSERT INTO `player_factionchange_spells` VALUES ('3565', 'Teleport: Darnassus', '3566', 'Teleport: Thunder Bluff');
INSERT INTO `player_factionchange_spells` VALUES ('6648', 'Chestnut Mare', '6653', 'Dire Wolf');
INSERT INTO `player_factionchange_spells` VALUES ('6777', 'Gray Ram', '8395', 'Emerald Raptor');
INSERT INTO `player_factionchange_spells` VALUES ('6898', 'White Ram', '10796', 'Turquoise Raptor');
INSERT INTO `player_factionchange_spells` VALUES ('6899', 'Brown Ram', '10799', 'Violet Raptor');
INSERT INTO `player_factionchange_spells` VALUES ('8394', 'Striped Frostsaber', '64977', 'Black Skeletal Horse');
INSERT INTO `player_factionchange_spells` VALUES ('10059', 'Portal: Stormwind', '11417', 'Portal: Orgrimmar');
INSERT INTO `player_factionchange_spells` VALUES ('10789', 'Spotted Frostsaber', '17464', 'Brown Skeletal Horse');
INSERT INTO `player_factionchange_spells` VALUES ('10793', 'Striped Nightsaber', '17463', 'Blue Skeletal Horse');
INSERT INTO `player_factionchange_spells` VALUES ('10873', 'Red Mechanostrider', '64657', 'White Kodo');
INSERT INTO `player_factionchange_spells` VALUES ('10969', 'Blue Mechanostrider', '35020', 'Blue Hawkstrider');
INSERT INTO `player_factionchange_spells` VALUES ('11416', 'Portal: Ironforge', '11418', 'Portal: Undercity');
INSERT INTO `player_factionchange_spells` VALUES ('11419', 'Portal: Darnassus', '11420', 'Portal: Thunder Bluff');
INSERT INTO `player_factionchange_spells` VALUES ('13819', 'Warhorse', '34769', 'Summon Warhorse');
INSERT INTO `player_factionchange_spells` VALUES ('15779', 'White Mechanostrider Mod B', '18992', 'Teal Kodo');
INSERT INTO `player_factionchange_spells` VALUES ('16082', 'Palomino', '16080', 'Red Wolf');
INSERT INTO `player_factionchange_spells` VALUES ('16083', 'White Stallion', '16081', 'Winter Wolf');
INSERT INTO `player_factionchange_spells` VALUES ('17229', 'Winterspring Frostsaber', '64659', 'Venomhide Ravasaur');
INSERT INTO `player_factionchange_spells` VALUES ('17453', 'Green Mechanostrider', '18989', 'Gray Kodo');
INSERT INTO `player_factionchange_spells` VALUES ('17459', 'Icy Blue Mechanostrider Mod A', '18991', 'Green Kodo');
INSERT INTO `player_factionchange_spells` VALUES ('17460', 'Frost Ram', '17450', 'Ivory Raptor');
INSERT INTO `player_factionchange_spells` VALUES ('17461', 'Black Ram', '16084', 'Mottled Red Raptor');
INSERT INTO `player_factionchange_spells` VALUES ('22717', 'Black War Steed', '22724', 'Black War Wolf');
INSERT INTO `player_factionchange_spells` VALUES ('22719', 'Black Battlestrider', '22718', 'Black War Kodo');
INSERT INTO `player_factionchange_spells` VALUES ('22720', 'Black War Ram', '22721', 'Black War Raptor');
INSERT INTO `player_factionchange_spells` VALUES ('22723', 'Black War Tiger', '22722', 'Red Skeletal Warhorse');
INSERT INTO `player_factionchange_spells` VALUES ('23214', 'Charger', '34767', 'Summon Charger');
INSERT INTO `player_factionchange_spells` VALUES ('23219', 'Swift Mistsaber', '23246', 'Purple Skeletal Warhorse');
INSERT INTO `player_factionchange_spells` VALUES ('23221', 'Swift Frostsaber', '66846', 'Ochre Skeletal Warhorse');
INSERT INTO `player_factionchange_spells` VALUES ('23222', 'Swift Yellow Mechanostrider', '23247', 'Great White Kodo');
INSERT INTO `player_factionchange_spells` VALUES ('23223', 'Swift White Mechanostrider', '23248', 'Great Gray Kodo');
INSERT INTO `player_factionchange_spells` VALUES ('23225', 'Swift Green Mechanostrider', '23249', 'Great Brown Kodo');
INSERT INTO `player_factionchange_spells` VALUES ('23227', 'Swift Palomino', '23251', 'Swift Timber Wolf');
INSERT INTO `player_factionchange_spells` VALUES ('23228', 'Swift White Steed', '23252', 'Swift Gray Wolf');
INSERT INTO `player_factionchange_spells` VALUES ('23229', 'Swift Brown Steed', '23250', 'Swift Brown Wolf');
INSERT INTO `player_factionchange_spells` VALUES ('23238', 'Swift Brown Ram', '23243', 'Swift Orange Raptor');
INSERT INTO `player_factionchange_spells` VALUES ('23239', 'Swift Gray Ram', '23241', 'Swift Blue Raptor');
INSERT INTO `player_factionchange_spells` VALUES ('23240', 'Swift White Ram', '23242', 'Swift Olive Raptor');
INSERT INTO `player_factionchange_spells` VALUES ('23338', 'Swift Stormsaber', '17465', 'Green Skeletal Warhorse');
INSERT INTO `player_factionchange_spells` VALUES ('23510', 'Stormpike Battle Charger', '23509', 'Frostwolf Howler');
INSERT INTO `player_factionchange_spells` VALUES ('31801', 'Seal of Vengeance', '53736', 'Seal of Corruption');
INSERT INTO `player_factionchange_spells` VALUES ('32182', 'Heroism', '2825', 'Bloodlust');
INSERT INTO `player_factionchange_spells` VALUES ('32235', 'Golden Gryphon', '32245', 'Green Wind Rider');
INSERT INTO `player_factionchange_spells` VALUES ('32239', 'Ebon Gryphon', '32243', 'Tawny Wind Rider');
INSERT INTO `player_factionchange_spells` VALUES ('32240', 'Snowy Gryphon', '32244', 'Blue Wind Rider');
INSERT INTO `player_factionchange_spells` VALUES ('32242', 'Swift Blue Gryphon', '32296', 'Swift Yellow Wind Rider');
INSERT INTO `player_factionchange_spells` VALUES ('32266', 'Portal: Exodar', '32267', 'Portal: Silvermoon');
INSERT INTO `player_factionchange_spells` VALUES ('32271', 'Teleport: Exodar', '32272', 'Teleport: Silvermoon');
INSERT INTO `player_factionchange_spells` VALUES ('32289', 'Swift Red Gryphon', '32246', 'Swift Red Wind Rider');
INSERT INTO `player_factionchange_spells` VALUES ('32290', 'Swift Green Gryphon', '32295', 'Swift Green Wind Rider');
INSERT INTO `player_factionchange_spells` VALUES ('32292', 'Swift Purple Gryphon', '32297', 'Swift Purple Wind Rider');
INSERT INTO `player_factionchange_spells` VALUES ('33690', 'Teleport: Shattrath', '35715', 'Teleport: Shattrath');
INSERT INTO `player_factionchange_spells` VALUES ('33691', 'Portal: Shattrath', '35717', 'Portal: Shattrath');
INSERT INTO `player_factionchange_spells` VALUES ('34406', 'Brown Elekk', '35022', 'Black Hawkstrider');
INSERT INTO `player_factionchange_spells` VALUES ('35710', 'Gray Elekk', '34795', 'Red Hawkstrider');
INSERT INTO `player_factionchange_spells` VALUES ('35711', 'Purple Elekk', '35018', 'Purple Hawkstrider');
INSERT INTO `player_factionchange_spells` VALUES ('35712', 'Great Green Elekk', '35027', 'Swift Purple Hawkstrider');
INSERT INTO `player_factionchange_spells` VALUES ('35713', 'Great Blue Elekk', '35025', 'Swift Green Hawkstrider');
INSERT INTO `player_factionchange_spells` VALUES ('35714', 'Great Purple Elekk', '33660', 'Swift Pink Hawkstrider');
INSERT INTO `player_factionchange_spells` VALUES ('48027', 'Black War Elekk', '35028', 'Swift Warstrider');
INSERT INTO `player_factionchange_spells` VALUES ('49359', 'Teleport: Theramore', '49358', 'Teleport: Stonard');
INSERT INTO `player_factionchange_spells` VALUES ('49360', 'Portal: Theramore', '49361', 'Portal: Stonard');
INSERT INTO `player_factionchange_spells` VALUES ('59785', 'Black War Mammoth', '59788', 'Black War Mammoth');
INSERT INTO `player_factionchange_spells` VALUES ('59791', 'Wooly Mammoth', '59793', 'Wooly Mammoth');
INSERT INTO `player_factionchange_spells` VALUES ('59799', 'Ice Mammoth', '59797', 'Ice Mammoth');
INSERT INTO `player_factionchange_spells` VALUES ('60114', 'Armored Brown Bear', '60116', 'Armored Brown Bear');
INSERT INTO `player_factionchange_spells` VALUES ('60118', 'Black War Bear', '60119', 'Black War Bear');
INSERT INTO `player_factionchange_spells` VALUES ('60424', 'Mekgineer''s Chopper', '55531', 'Mechano-hog');
INSERT INTO `player_factionchange_spells` VALUES ('60867', 'Mekgineer''s Chopper', '60866', 'Mechano-hog');
INSERT INTO `player_factionchange_spells` VALUES ('61229', 'Armored Snowy Gryphon', '61230', 'Armored Blue Wind Rider');
INSERT INTO `player_factionchange_spells` VALUES ('61425', 'Traveler''s Tundra Mammoth', '61447', 'Traveler''s Tundra Mammoth');
INSERT INTO `player_factionchange_spells` VALUES ('61470', 'Grand Ice Mammoth', '61469', 'Grand Ice Mammoth');
INSERT INTO `player_factionchange_spells` VALUES ('61996', 'Blue Dragonhawk', '61997', 'Red Dragonhawk');
INSERT INTO `player_factionchange_spells` VALUES ('62609', 'Argent Squire', '62746', 'Argent Gruntling');
INSERT INTO `player_factionchange_spells` VALUES ('63232', 'Stormwind Steed', '63640', 'Orgrimmar Wolf');
INSERT INTO `player_factionchange_spells` VALUES ('63636', 'Ironforge Ram', '63635', 'Darkspear Raptor');
INSERT INTO `player_factionchange_spells` VALUES ('63637', 'Darnassian Nightsaber', '63643', 'Forsaken Warhorse');
INSERT INTO `player_factionchange_spells` VALUES ('63638', 'Gnomeregan Mechanostrider', '63641', 'Thunder Bluff Kodo');
INSERT INTO `player_factionchange_spells` VALUES ('63639', 'Exodar Elekk', '63642', 'Silvermoon Hawkstrider');
INSERT INTO `player_factionchange_spells` VALUES ('65637', 'Great Red Elekk', '65639', 'Swift Red Hawkstrider');
INSERT INTO `player_factionchange_spells` VALUES ('65638', 'Swift Moonsaber', '65645', 'White Skeletal Warhorse');
INSERT INTO `player_factionchange_spells` VALUES ('65640', 'Swift Gray Steed', '65646', 'Swift Burgundy Wolf');
INSERT INTO `player_factionchange_spells` VALUES ('65642', 'Turbostrider', '65641', 'Great Golden Kodo');
INSERT INTO `player_factionchange_spells` VALUES ('65643', 'Swift Violet Ram', '65644', 'Swift Purple Raptor');
INSERT INTO `player_factionchange_spells` VALUES ('66087', 'Silver Covenant Hippogryph', '66088', 'Sunreaver Dragonhawk');
INSERT INTO `player_factionchange_spells` VALUES ('66090', 'Quel''dorei Steed', '66091', 'Sunreaver Hawkstrider');
INSERT INTO `player_factionchange_spells` VALUES ('66847', 'Striped Dawnsaber', '17462', 'Red Skeletal Horse');
INSERT INTO `player_factionchange_spells` VALUES ('67064', 'Royal Moonshroud Robe', '67144', 'Royal Moonshroud Robe');
INSERT INTO `player_factionchange_spells` VALUES ('67065', 'Royal Moonshroud Bracers', '67147', 'Royal Moonshroud Bracers');
INSERT INTO `player_factionchange_spells` VALUES ('67066', 'Merlin''s Robe', '67146', 'Merlin''s Robe');
INSERT INTO `player_factionchange_spells` VALUES ('67079', 'Bejeweled Wizard''s Bracers', '67145', 'Bejeweled Wizard''s Bracers');
INSERT INTO `player_factionchange_spells` VALUES ('67080', 'Ensorcelled Nerubian Breastplate', '67136', 'Ensorcelled Nerubian Breastplate');
INSERT INTO `player_factionchange_spells` VALUES ('67081', 'Black Chitin Bracers', '67137', 'Black Chitin Bracers');
INSERT INTO `player_factionchange_spells` VALUES ('67082', 'Crusader''s Dragonscale Breastplate', '67138', 'Crusader''s Dragonscale Breastplate');
INSERT INTO `player_factionchange_spells` VALUES ('67083', 'Crusader''s Dragonscale Bracers', '67143', 'Crusader''s Dragonscale Bracers');
INSERT INTO `player_factionchange_spells` VALUES ('67084', 'Lunar Eclipse Robes', '67140', 'Lunar Eclipse Robes');
INSERT INTO `player_factionchange_spells` VALUES ('67085', 'Moonshadow Armguards', '67141', 'Moonshadow Armguards');
INSERT INTO `player_factionchange_spells` VALUES ('67086', 'Knightbane Carapace', '67142', 'Knightbane Carapace');
INSERT INTO `player_factionchange_spells` VALUES ('67087', 'Bracers of Swift Death', '67139', 'Bracers of Swift Death');
INSERT INTO `player_factionchange_spells` VALUES ('67091', 'Breastplate of the White Knight', '67130', 'Breastplate of the White Knight');
INSERT INTO `player_factionchange_spells` VALUES ('67092', 'Saronite Swordbreakers', '67131', 'Saronite Swordbreakers');
INSERT INTO `player_factionchange_spells` VALUES ('67093', 'Titanium Razorplate', '67132', 'Titanium Razorplate');
INSERT INTO `player_factionchange_spells` VALUES ('67094', 'Titanium Spikeguards', '67133', 'Titanium Spikeguards');
INSERT INTO `player_factionchange_spells` VALUES ('67095', 'Sunforged Breastplate', '67134', 'Sunforged Breastplate');
INSERT INTO `player_factionchange_spells` VALUES ('67096', 'Sunforged Bracers', '67135', 'Sunforged Bracers');
INSERT INTO `player_factionchange_spells` VALUES ('68057', 'Swift Alliance Steed', '68056', 'Swift Horde Wolf');
INSERT INTO `player_factionchange_spells` VALUES ('68187', 'Crusader''s White Warhorse', '68188', 'Crusader''s Black Warhorse');

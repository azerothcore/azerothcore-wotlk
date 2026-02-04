-- RBAC System for AzerothCore
-- Ported from TrinityCore

-- Permission List table
DROP TABLE IF EXISTS `rbac_account_permissions`;
DROP TABLE IF EXISTS `rbac_default_permissions`;
DROP TABLE IF EXISTS `rbac_linked_permissions`;
DROP TABLE IF EXISTS `rbac_permissions`;

CREATE TABLE `rbac_permissions` (
  `id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Permission id',
  `name` varchar(100) NOT NULL COMMENT 'Permission name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Permission List';

-- Permission to Permission relation (for role inheritance)
CREATE TABLE `rbac_linked_permissions` (
  `id` int unsigned NOT NULL COMMENT 'Permission id',
  `linkedId` int unsigned NOT NULL COMMENT 'Linked Permission id',
  PRIMARY KEY (`id`,`linkedId`),
  KEY `fk__rbac_linked_permissions__rbac_permissions1` (`id`),
  KEY `fk__rbac_linked_permissions__rbac_permissions2` (`linkedId`),
  CONSTRAINT `fk__rbac_linked_permissions__rbac_permissions1` FOREIGN KEY (`id`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__rbac_linked_permissions__rbac_permissions2` FOREIGN KEY (`linkedId`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Permission - Linked Permission relation';

-- Default permissions by security level
CREATE TABLE `rbac_default_permissions` (
  `secId` int unsigned NOT NULL COMMENT 'Security Level id',
  `permissionId` int unsigned NOT NULL COMMENT 'permission id',
  `realmId` int NOT NULL DEFAULT '-1' COMMENT 'Realm Id, -1 means all',
  PRIMARY KEY (`secId`,`permissionId`,`realmId`),
  KEY `fk__rbac_default_permissions__rbac_permissions` (`permissionId`),
  CONSTRAINT `fk__rbac_default_permissions__rbac_permissions` FOREIGN KEY (`permissionId`) REFERENCES `rbac_permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Default permission to assign to different account security levels';

-- Account specific permissions
CREATE TABLE `rbac_account_permissions` (
  `accountId` int unsigned NOT NULL COMMENT 'Account id',
  `permissionId` int unsigned NOT NULL COMMENT 'Permission id',
  `granted` tinyint(1) NOT NULL DEFAULT '1' COMMENT 'Granted = 1, Denied = 0',
  `realmId` int NOT NULL DEFAULT '-1' COMMENT 'Realm Id, -1 means all',
  PRIMARY KEY (`accountId`,`permissionId`,`realmId`),
  KEY `fk__rbac_account_roles__rbac_permissions` (`permissionId`),
  CONSTRAINT `fk__rbac_account_permissions__account` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__rbac_account_roles__rbac_permissions` FOREIGN KEY (`permissionId`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Account-Permission relation';

-- Insert permissions
INSERT INTO `rbac_permissions` VALUES
-- Core permissions (1-99)
(1,'Instant logout'),
(2,'Skip Queue'),
(3,'Join Normal Battleground'),
(4,'Join Random Battleground'),
(5,'Join Arenas'),
(6,'Join Dungeon Finder'),
(7,'Skip idle connection check'),
(8,'Cannot earn achievements'),
(9,'Cannot earn realm first achievements'),
(11,'Log GM trades'),
(13,'Skip Instance required bosses check'),
(14,'Skip character creation team mask check'),
(15,'Skip character creation class mask check'),
(16,'Skip character creation race mask check'),
(17,'Skip character creation reserved name check'),
(18,'Skip character creation death knight min level check'),
(19,'Skip needed requirements to use channel check'),
(20,'Skip disable map check'),
(21,'Skip reset talents when used more than allowed check'),
(22,'Skip spam chat check'),
(23,'Skip over-speed ping check'),
(24,'Two side faction characters on the same account'),
(25,'Allow say chat between factions'),
(26,'Allow channel chat between factions'),
(27,'Two side mail interaction'),
(28,'See two side who list'),
(29,'Add friends of other faction'),
(30,'Save character without delay with .save command'),
(31,'Use params with .unstuck command'),
(32,'Can be assigned tickets with .assign ticket command'),
(33,'Notify if a command was not found'),
(34,'Check if should appear in list using .gm ingame command'),
(35,'See all security levels with who command'),
(36,'Filter whispers'),
(37,'Use staff badge in chat'),
(38,'Resurrect with full Health Points'),
(39,'Restore saved gm setting states'),
(40,'Allows to add a gm to friend list'),
(41,'Use Config option START_GM_LEVEL to assign new character level'),
(42,'Allows to use CMSG_WORLD_TELEPORT opcode'),
(43,'Allows to use CMSG_WHOIS opcode'),
(44,'Receive global GM messages/texts'),
(45,'Join channels without announce'),
(46,'Change channel settings without being channel moderator'),
(47,'Can ignore lower security checks'),
(48,'Enable IP, Last Login and EMail output in pinfo'),
(49,'Forces to enter the email for confirmation on password change'),
(50,'Allow user to check his own email with .account'),
(51,'Allow trading between factions'),
-- Roles (192-199)
(192,'Role: Sec Level Administrator'),
(193,'Role: Sec Level Gamemaster'),
(194,'Role: Sec Level Moderator'),
(195,'Role: Sec Level Player'),
(196,'Role: Administrator Commands'),
(197,'Role: Gamemaster Commands'),
(198,'Role: Moderator Commands'),
(199,'Role: Player Commands'),
-- RBAC commands (200-206)
(200,'Command: rbac'),
(201,'Command: rbac account'),
(202,'Command: rbac account list'),
(203,'Command: rbac account grant'),
(204,'Command: rbac account deny'),
(205,'Command: rbac account revoke'),
(206,'Command: rbac list'),
-- Account commands (217-229)
(217,'Command: account'),
(218,'Command: account addon'),
(219,'Command: account create'),
(220,'Command: account delete'),
(221,'Command: account lock'),
(222,'Command: account lock country'),
(223,'Command: account lock ip'),
(224,'Command: account onlinelist'),
(225,'Command: account password'),
(226,'Command: account set'),
(227,'Command: account set addon'),
(228,'Command: account set gmlevel'),
(229,'Command: account set password'),
-- Achievement commands
(231,'Command: achievement add'),
-- Arena commands
(233,'Command: arena captain'),
(234,'Command: arena create'),
(235,'Command: arena disband'),
(236,'Command: arena info'),
(237,'Command: arena lookup'),
(238,'Command: arena rename'),
-- Ban commands (240-256)
(240,'Command: ban account'),
(241,'Command: ban character'),
(242,'Command: ban ip'),
(243,'Command: ban playeraccount'),
(245,'Command: baninfo account'),
(246,'Command: baninfo character'),
(247,'Command: baninfo ip'),
(249,'Command: banlist account'),
(250,'Command: banlist character'),
(251,'Command: banlist ip'),
(253,'Command: unban account'),
(254,'Command: unban character'),
(255,'Command: unban ip'),
(256,'Command: unban playeraccount'),
-- Battlefield commands
(258,'Command: bf start'),
(259,'Command: bf stop'),
(260,'Command: bf switch'),
(261,'Command: bf timer'),
(262,'Command: bf enable'),
-- Account email commands
(263,'Command: account email'),
(265,'Command: account set sec email'),
(266,'Command: account set sec regmail'),
-- Cast commands
(267,'Command: cast'),
(268,'Command: cast back'),
(269,'Command: cast dist'),
(270,'Command: cast self'),
(271,'Command: cast target'),
(272,'Command: cast dest'),
-- Character commands
(274,'Command: character customize'),
(275,'Command: character changefaction'),
(276,'Command: character changerace'),
(278,'Command: character deleted delete'),
(279,'Command: character deleted list'),
(280,'Command: character deleted restore'),
(281,'Command: character deleted old'),
(282,'Command: character erase'),
(283,'Command: character level'),
(284,'Command: character rename'),
(285,'Command: character reputation'),
(286,'Command: character titles'),
(287,'Command: levelup'),
-- Player dump commands
(289,'Command: pdump load'),
(290,'Command: pdump write'),
-- Cheat commands
(292,'Command: cheat casttime'),
(293,'Command: cheat cooldown'),
(294,'Command: cheat explore'),
(295,'Command: cheat god'),
(296,'Command: cheat power'),
(297,'Command: cheat status'),
(298,'Command: cheat taxi'),
(299,'Command: cheat waterwalk'),
-- Debug command
(300,'Command: debug'),
-- Deserter commands
(343,'Command: deserter bg add'),
(344,'Command: deserter bg remove'),
(346,'Command: deserter instance add'),
(347,'Command: deserter instance remove'),
-- Event commands
(367,'Command: event info'),
(368,'Command: event activelist'),
(369,'Command: event start'),
(370,'Command: event stop'),
-- GM commands
(371,'Command: gm'),
(372,'Command: gm chat'),
(373,'Command: gm fly'),
(374,'Command: gm ingame'),
(375,'Command: gm list'),
(376,'Command: gm visible'),
-- Go commands
(377,'Command: go'),
-- Gobject commands
(388,'Command: gobject activate'),
(389,'Command: gobject add'),
(390,'Command: gobject add temp'),
(391,'Command: gobject delete'),
(392,'Command: gobject info'),
(393,'Command: gobject move'),
(394,'Command: gobject near'),
(396,'Command: gobject set phase'),
(397,'Command: gobject set state'),
(398,'Command: gobject target'),
(399,'Command: gobject turn'),
-- Guild commands
(401,'Command: guild'),
(402,'Command: guild create'),
(403,'Command: guild delete'),
(404,'Command: guild invite'),
(405,'Command: guild uninvite'),
(406,'Command: guild rank'),
(407,'Command: guild rename'),
-- Honor commands
(409,'Command: honor add'),
(410,'Command: honor add kill'),
(411,'Command: honor update'),
-- Instance commands
(413,'Command: instance listbinds'),
(414,'Command: instance unbind'),
(415,'Command: instance stats'),
(416,'Command: instance savedata'),
-- Learn commands
(417,'Command: learn'),
(419,'Command: learn all my'),
(420,'Command: learn all my class'),
(421,'Command: learn my pettalents'),
(422,'Command: learn all my spells'),
(423,'Command: learn all talents'),
(424,'Command: learn all gm'),
(425,'Command: learn all crafts'),
(426,'Command: learn all default'),
(427,'Command: learn all lang'),
(428,'Command: learn all recipes'),
(429,'Command: unlearn'),
-- LFG commands
(431,'Command: lfg player'),
(432,'Command: lfg group'),
(433,'Command: lfg queue'),
(434,'Command: lfg clean'),
(435,'Command: lfg options'),
-- List commands
(437,'Command: list creature'),
(438,'Command: list item'),
(439,'Command: list object'),
(440,'Command: list auras'),
(441,'Command: list mail'),
-- Lookup commands
(442,'Command: lookup'),
(443,'Command: lookup area'),
(444,'Command: lookup creature'),
(445,'Command: lookup event'),
(446,'Command: lookup faction'),
(447,'Command: lookup item'),
(448,'Command: lookup itemset'),
(449,'Command: lookup object'),
(450,'Command: lookup quest'),
(451,'Command: lookup player'),
(452,'Command: lookup player ip'),
(453,'Command: lookup player account'),
(454,'Command: lookup player email'),
(455,'Command: lookup skill'),
(456,'Command: lookup spell'),
(457,'Command: lookup spell id'),
(458,'Command: lookup taxinode'),
(459,'Command: lookup tele'),
(460,'Command: lookup title'),
(461,'Command: lookup map'),
-- Announce commands
(462,'Command: announce'),
(463,'Command: channel'),
(464,'Command: channel set'),
(465,'Command: channel set ownership'),
(466,'Command: gmannounce'),
(467,'Command: gmnameannounce'),
(468,'Command: gmnotify'),
(469,'Command: nameannounce'),
(470,'Command: notify'),
(471,'Command: whispers'),
-- Group commands
(472,'Command: group'),
(473,'Command: group leader'),
(474,'Command: group disband'),
(475,'Command: group remove'),
(476,'Command: group join'),
(477,'Command: group list'),
(478,'Command: group summon'),
-- Pet commands
(479,'Command: pet'),
(480,'Command: pet create'),
(481,'Command: pet learn'),
(482,'Command: pet unlearn'),
-- Send commands
(483,'Command: send'),
(484,'Command: send items'),
(485,'Command: send mail'),
(486,'Command: send message'),
(487,'Command: send money'),
-- Misc commands (488-600)
(488,'Command: additem'),
(489,'Command: additemset'),
(490,'Command: appear'),
(491,'Command: aura'),
(492,'Command: bank'),
(493,'Command: bindsight'),
(494,'Command: combatstop'),
(495,'Command: cometome'),
(496,'Command: commands'),
(497,'Command: cooldown'),
(498,'Command: damage'),
(499,'Command: dev'),
(500,'Command: die'),
(501,'Command: dismount'),
(502,'Command: distance'),
(503,'Command: flusharenapoints'),
(504,'Command: freeze'),
(505,'Command: gps'),
(506,'Command: guid'),
(507,'Command: help'),
(508,'Command: hidearea'),
(509,'Command: itemmove'),
(510,'Command: kick'),
(511,'Command: linkgrave'),
(512,'Command: listfreeze'),
(513,'Command: maxskill'),
(514,'Command: movegens'),
(515,'Command: mute'),
(516,'Command: neargrave'),
(517,'Command: pinfo'),
(518,'Command: playall'),
(519,'Command: possess'),
(520,'Command: recall'),
(521,'Command: repairitems'),
(522,'Command: respawn'),
(523,'Command: revive'),
(524,'Command: saveall'),
(525,'Command: save'),
(526,'Command: setskill'),
(527,'Command: showarea'),
(528,'Command: summon'),
(529,'Command: unaura'),
(530,'Command: unbindsight'),
(531,'Command: unfreeze'),
(532,'Command: unmute'),
(533,'Command: unpossess'),
(534,'Command: unstuck'),
(535,'Command: wchange'),
-- MMap commands
(536,'Command: mmap'),
(537,'Command: mmap loadedtiles'),
(538,'Command: mmap loc'),
(539,'Command: mmap path'),
(540,'Command: mmap stats'),
(541,'Command: mmap testarea'),
-- Morph commands
(542,'Command: morph'),
(543,'Command: demorph'),
-- Modify commands
(544,'Command: modify'),
(545,'Command: modify arenapoints'),
(546,'Command: modify bit'),
(547,'Command: modify drunk'),
(548,'Command: modify energy'),
(549,'Command: modify faction'),
(550,'Command: modify gender'),
(551,'Command: modify honor'),
(552,'Command: modify hp'),
(553,'Command: modify mana'),
(554,'Command: modify money'),
(555,'Command: modify mount'),
(556,'Command: modify phase'),
(557,'Command: modify rage'),
(558,'Command: modify reputation'),
(559,'Command: modify runicpower'),
(560,'Command: modify scale'),
(561,'Command: modify speed'),
(562,'Command: modify speed all'),
(563,'Command: modify speed backwalk'),
(564,'Command: modify speed fly'),
(565,'Command: modify speed walk'),
(566,'Command: modify speed swim'),
(567,'Command: modify spell'),
(568,'Command: modify standstate'),
(569,'Command: modify talentpoints'),
-- NPC commands
(571,'Command: npc add'),
(572,'Command: npc add formation'),
(573,'Command: npc add item'),
(574,'Command: npc add move'),
(575,'Command: npc add temp'),
(576,'Command: npc delete'),
(577,'Command: npc delete item'),
(578,'Command: npc follow'),
(579,'Command: npc follow stop'),
(580,'Command: npc set'),
(581,'Command: npc set allowmove'),
(582,'Command: npc set entry'),
(583,'Command: npc set factionid'),
(584,'Command: npc set flag'),
(585,'Command: npc set level'),
(586,'Command: npc set link'),
(587,'Command: npc set model'),
(588,'Command: npc set movetype'),
(589,'Command: npc set phase'),
(590,'Command: npc set spawndist'),
(591,'Command: npc set spawntime'),
(592,'Command: npc set data'),
(593,'Command: npc info'),
(594,'Command: npc near'),
(595,'Command: npc move'),
(596,'Command: npc playemote'),
(597,'Command: npc say'),
(598,'Command: npc textemote'),
(599,'Command: npc whisper'),
(600,'Command: npc yell'),
(601,'Command: npc tame'),
-- Quest commands
(602,'Command: quest'),
(603,'Command: quest add'),
(604,'Command: quest complete'),
(605,'Command: quest remove'),
(606,'Command: quest reward'),
-- Reload commands
(607,'Command: reload'),
(680,'Command: reload rbac'),
-- Server commands
(718,'Command: server'),
(725,'Command: server info'),
-- Tele commands
(737,'Command: tele'),
(738,'Command: tele add'),
(739,'Command: tele del'),
(740,'Command: tele name'),
(741,'Command: tele group');

-- Link roles to permissions
-- Administrator role gets Gamemaster role + admin commands
INSERT INTO `rbac_linked_permissions` VALUES
(192, 7),   -- Admin: Skip idle check
(192, 21),  -- Admin: Skip talent reset check
(192, 42),  -- Admin: World teleport
(192, 43),  -- Admin: Whois
(192, 193), -- Admin: links to GM role
(192, 196), -- Admin: Admin commands role
-- Gamemaster role gets Moderator role + GM commands
(193, 11),  -- GM: Log trades
(193, 32),  -- GM: Can be assigned tickets
(193, 34),  -- GM: Appear in GM list
(193, 35),  -- GM: See all sec levels
(193, 38),  -- GM: Resurrect full HP
(193, 39),  -- GM: Restore GM state
(193, 40),  -- GM: Allow GM friend
(193, 41),  -- GM: Start GM level
(193, 44),  -- GM: Receive global GM messages
(193, 45),  -- GM: Join channels without announce
(193, 46),  -- GM: Change channel settings
(193, 47),  -- GM: Ignore lower security
(193, 48),  -- GM: Pinfo personal data
(193, 194), -- GM: links to Moderator role
(193, 197), -- GM: GM commands role
-- Moderator role gets Player role + mod commands
(194, 1),   -- Mod: Instant logout
(194, 2),   -- Mod: Skip queue
(194, 36),  -- Mod: Filter whispers
(194, 37),  -- Mod: Staff badge
(194, 195), -- Mod: links to Player role
(194, 198), -- Mod: Mod commands role
-- Player role gets basic permissions + player commands
(195, 3),   -- Player: Join BG
(195, 4),   -- Player: Join Random BG
(195, 5),   -- Player: Join Arenas
(195, 6),   -- Player: Join Dungeon Finder
(195, 199), -- Player: Player commands role
-- Admin commands role
(196, 200), -- rbac
(196, 201), -- rbac account
(196, 202), -- rbac account list
(196, 203), -- rbac account grant
(196, 204), -- rbac account deny
(196, 205), -- rbac account revoke
(196, 206), -- rbac list
(196, 219), -- account create
(196, 220), -- account delete
(196, 228), -- account set gmlevel
(196, 229), -- account set password
-- GM commands role
(197, 231), -- achievement add
(197, 267), -- cast
(197, 268), -- cast back
(197, 269), -- cast dist
(197, 270), -- cast self
(197, 271), -- cast target
(197, 272), -- cast dest
(197, 283), -- character level
(197, 287), -- levelup
(197, 292), -- cheat casttime
(197, 293), -- cheat cooldown
(197, 294), -- cheat explore
(197, 295), -- cheat god
(197, 296), -- cheat power
(197, 297), -- cheat status
(197, 298), -- cheat taxi
(197, 299), -- cheat waterwalk
(197, 300), -- debug
(197, 371), -- gm
(197, 372), -- gm chat
(197, 373), -- gm fly
(197, 376), -- gm visible
(197, 377), -- go
(197, 388), -- gobject activate
(197, 389), -- gobject add
(197, 417), -- learn
(197, 419), -- learn all my
(197, 420), -- learn all my class
(197, 422), -- learn all my spells
(197, 423), -- learn all talents
(197, 424), -- learn all gm
(197, 429), -- unlearn
(197, 440), -- list auras
(197, 488), -- additem
(197, 489), -- additemset
(197, 490), -- appear
(197, 491), -- aura
(197, 492), -- bank
(197, 494), -- combatstop
(197, 495), -- cometome
(197, 497), -- cooldown
(197, 498), -- damage
(197, 499), -- dev
(197, 500), -- die
(197, 504), -- freeze
(197, 513), -- maxskill
(197, 519), -- possess
(197, 521), -- repairitems
(197, 522), -- respawn
(197, 523), -- revive
(197, 526), -- setskill
(197, 528), -- summon
(197, 529), -- unaura
(197, 531), -- unfreeze
(197, 533), -- unpossess
(197, 534), -- unstuck
(197, 542), -- morph
(197, 543), -- demorph
(197, 544), -- modify
(197, 545), -- modify arenapoints
(197, 552), -- modify hp
(197, 553), -- modify mana
(197, 554), -- modify money
(197, 558), -- modify reputation
(197, 561), -- modify speed
(197, 571), -- npc add
(197, 576), -- npc delete
(197, 602), -- quest
(197, 603), -- quest add
(197, 604), -- quest complete
(197, 605), -- quest remove
(197, 606), -- quest reward
(197, 737), -- tele
(197, 738), -- tele add
(197, 739), -- tele del
(197, 740), -- tele name
(197, 741), -- tele group
-- Moderator commands role
(198, 240), -- ban account
(198, 241), -- ban character
(198, 242), -- ban ip
(198, 245), -- baninfo account
(198, 246), -- baninfo character
(198, 247), -- baninfo ip
(198, 249), -- banlist account
(198, 250), -- banlist character
(198, 251), -- banlist ip
(198, 253), -- unban account
(198, 254), -- unban character
(198, 255), -- unban ip
(198, 462), -- announce
(198, 466), -- gmannounce
(198, 510), -- kick
(198, 515), -- mute
(198, 517), -- pinfo
(198, 532), -- unmute
-- Player commands role
(199, 217), -- account
(199, 218), -- account addon
(199, 221), -- account lock
(199, 222), -- account lock country
(199, 223), -- account lock ip
(199, 225), -- account password
(199, 374), -- gm ingame
(199, 375), -- gm list
(199, 442), -- lookup
(199, 443), -- lookup area
(199, 444), -- lookup creature
(199, 446), -- lookup faction
(199, 447), -- lookup item
(199, 450), -- lookup quest
(199, 455), -- lookup skill
(199, 456), -- lookup spell
(199, 459), -- lookup tele
(199, 496), -- commands
(199, 501), -- dismount
(199, 505), -- gps
(199, 507), -- help
(199, 525), -- save
(199, 725); -- server info

-- Default permissions by security level
-- SEC_PLAYER = 0 gets Player role (195)
-- SEC_MODERATOR = 1 gets Moderator role (194, which includes 195)
-- SEC_GAMEMASTER = 2 gets GM role (193, which includes 194)
-- SEC_ADMINISTRATOR = 3 gets Admin role (192, which includes 193)
INSERT INTO `rbac_default_permissions` VALUES
(3, 192, -1),  -- Admin gets Admin role
(2, 193, -1),  -- GM gets GM role
(1, 194, -1),  -- Moderator gets Mod role
(0, 195, -1);  -- Player gets Player role

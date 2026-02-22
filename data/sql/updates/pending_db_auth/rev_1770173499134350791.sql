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

-- ============================================================================
-- Insert permissions
-- ============================================================================
INSERT INTO `rbac_permissions` VALUES
-- Core permissions (1-53)
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
(52,'No battleground deserter debuff'),
(53,'Can be AFK on the battleground'),
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
-- Achievement commands (231-232)
(231,'Command: achievement add'),
(232,'Command: achievement checkall'),
-- Arena commands (233-238)
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
-- Battlefield commands (258-262)
(258,'Command: bf start'),
(259,'Command: bf stop'),
(260,'Command: bf switch'),
(261,'Command: bf timer'),
(262,'Command: bf enable'),
-- Account email commands (263-266)
(263,'Command: account email'),
(265,'Command: account set sec email'),
(266,'Command: account set sec regmail'),
-- Cast commands (267-272)
(267,'Command: cast'),
(268,'Command: cast back'),
(269,'Command: cast dist'),
(270,'Command: cast self'),
(271,'Command: cast target'),
(272,'Command: cast dest'),
-- Character commands (274-290)
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
(289,'Command: pdump load'),
(290,'Command: pdump write'),
-- Cheat commands (292-299)
(292,'Command: cheat casttime'),
(293,'Command: cheat cooldown'),
(294,'Command: cheat explore'),
(295,'Command: cheat god'),
(296,'Command: cheat power'),
(297,'Command: cheat status'),
(298,'Command: cheat taxi'),
(299,'Command: cheat waterwalk'),
-- Debug command (300)
(300,'Command: debug'),
-- Deserter commands (343-347)
(343,'Command: deserter bg add'),
(344,'Command: deserter bg remove'),
(346,'Command: deserter instance add'),
(347,'Command: deserter instance remove'),
-- Disable commands (350-366)
(350,'Command: disable add achievement_criteria'),
(351,'Command: disable add battleground'),
(352,'Command: disable add map'),
(353,'Command: disable add mmap'),
(354,'Command: disable add outdoorpvp'),
(355,'Command: disable add quest'),
(356,'Command: disable add spell'),
(357,'Command: disable add vmap'),
(359,'Command: disable remove achievement_criteria'),
(360,'Command: disable remove battleground'),
(361,'Command: disable remove map'),
(362,'Command: disable remove mmap'),
(363,'Command: disable remove outdoorpvp'),
(364,'Command: disable remove quest'),
(365,'Command: disable remove spell'),
(366,'Command: disable remove vmap'),
-- Event commands (367-370)
(367,'Command: event info'),
(368,'Command: event activelist'),
(369,'Command: event start'),
(370,'Command: event stop'),
-- GM commands (371-376)
(371,'Command: gm'),
(372,'Command: gm chat'),
(373,'Command: gm fly'),
(374,'Command: gm ingame'),
(375,'Command: gm list'),
(376,'Command: gm visible'),
-- Go command (377)
(377,'Command: go'),
-- Gobject commands (388-399)
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
-- Guild commands (401-407)
(401,'Command: guild'),
(402,'Command: guild create'),
(403,'Command: guild delete'),
(404,'Command: guild invite'),
(405,'Command: guild uninvite'),
(406,'Command: guild rank'),
(407,'Command: guild rename'),
-- Honor commands (409-411)
(409,'Command: honor add'),
(410,'Command: honor add kill'),
(411,'Command: honor update'),
-- Instance commands (413-416)
(413,'Command: instance listbinds'),
(414,'Command: instance unbind'),
(415,'Command: instance stats'),
(416,'Command: instance savedata'),
-- Learn commands (417-429)
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
-- LFG commands (431-435)
(431,'Command: lfg player'),
(432,'Command: lfg group'),
(433,'Command: lfg queue'),
(434,'Command: lfg clean'),
(435,'Command: lfg options'),
-- List commands (437-441)
(437,'Command: list creature'),
(438,'Command: list item'),
(439,'Command: list object'),
(440,'Command: list auras'),
(441,'Command: list mail'),
-- Lookup commands (442-461)
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
-- Announce/Channel commands (462-471)
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
-- Group commands (472-478)
(472,'Command: group'),
(473,'Command: group leader'),
(474,'Command: group disband'),
(475,'Command: group remove'),
(476,'Command: group join'),
(477,'Command: group list'),
(478,'Command: group summon'),
-- Pet commands (479-482)
(479,'Command: pet'),
(480,'Command: pet create'),
(481,'Command: pet learn'),
(482,'Command: pet unlearn'),
-- Send commands (483-487)
(483,'Command: send'),
(484,'Command: send items'),
(485,'Command: send mail'),
(486,'Command: send message'),
(487,'Command: send money'),
-- Misc commands (488-535)
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
-- MMap commands (536-541)
(536,'Command: mmap'),
(537,'Command: mmap loadedtiles'),
(538,'Command: mmap loc'),
(539,'Command: mmap path'),
(540,'Command: mmap stats'),
(541,'Command: mmap testarea'),
-- Morph commands (542-543)
(542,'Command: morph'),
(543,'Command: demorph'),
-- Modify commands (544-569)
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
-- NPC commands (571-601)
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
-- Quest commands (602-606)
(602,'Command: quest'),
(603,'Command: quest add'),
(604,'Command: quest complete'),
(605,'Command: quest remove'),
(606,'Command: quest reward'),
-- Reload commands (607-709)
(607,'Command: reload'),
(608,'Command: reload access_requirement'),
(609,'Command: reload achievement_criteria_data'),
(610,'Command: reload achievement_reward'),
(611,'Command: reload all'),
(612,'Command: reload all achievement'),
(613,'Command: reload all area'),
(614,'Command: reload broadcast_text'),
(615,'Command: reload all gossips'),
(616,'Command: reload all item'),
(617,'Command: reload all locales'),
(618,'Command: reload all loot'),
(619,'Command: reload all npc'),
(620,'Command: reload all quest'),
(621,'Command: reload all scripts'),
(622,'Command: reload all spell'),
(623,'Command: reload areatrigger_involvedrelation'),
(624,'Command: reload areatrigger_tavern'),
(625,'Command: reload areatrigger_teleport'),
(626,'Command: reload auctions'),
(627,'Command: reload autobroadcast'),
(629,'Command: reload conditions'),
(630,'Command: reload config'),
(631,'Command: reload battleground_template'),
(632,'Command: mutehistory'),
(633,'Command: reload creature_linked_respawn'),
(634,'Command: reload creature_loot_template'),
(635,'Command: reload creature_onkill_reputation'),
(636,'Command: reload creature_questender'),
(637,'Command: reload creature_queststarter'),
(638,'Command: reload creature_summon_groups'),
(639,'Command: reload creature_template'),
(640,'Command: reload creature_text'),
(641,'Command: reload disables'),
(642,'Command: reload disenchant_loot_template'),
(643,'Command: reload event_scripts'),
(644,'Command: reload fishing_loot_template'),
(645,'Command: reload graveyard_zone'),
(646,'Command: reload game_tele'),
(647,'Command: reload gameobject_questender'),
(648,'Command: reload gameobject_quest_loot_template'),
(649,'Command: reload gameobject_queststarter'),
(650,'Command: reload gm_tickets'),
(651,'Command: reload gossip_menu'),
(652,'Command: reload gossip_menu_option'),
(653,'Command: reload item_enchantment_template'),
(654,'Command: reload item_loot_template'),
(655,'Command: reload item_set_names'),
(656,'Command: reload lfg_dungeon_rewards'),
(657,'Command: reload achievement_reward_locale'),
(658,'Command: reload creature_template_locale'),
(659,'Command: reload creature_text_locale'),
(660,'Command: reload gameobject_template_locale'),
(661,'Command: reload gossip_menu_option_locale'),
(662,'Command: reload item_template_locale'),
(663,'Command: reload item_set_name_locale'),
(664,'Command: reload npc_text_locale'),
(665,'Command: reload page_text_locale'),
(666,'Command: reload points_of_interest_locale'),
(667,'Command: reload quest_template_locale'),
(668,'Command: reload mail_level_reward'),
(669,'Command: reload mail_loot_template'),
(670,'Command: reload milling_loot_template'),
(671,'Command: reload npc_spellclick_spells'),
(672,'Command: reload trainer'),
(673,'Command: reload npc_vendor'),
(674,'Command: reload page_text'),
(675,'Command: reload pickpocketing_loot_template'),
(676,'Command: reload points_of_interest'),
(677,'Command: reload prospecting_loot_template'),
(678,'Command: reload quest_poi'),
(679,'Command: reload quest_template'),
(680,'Command: reload rbac'),
(681,'Command: reload reference_loot_template'),
(682,'Command: reload reserved_name'),
(683,'Command: reload reputation_reward_rate'),
(684,'Command: reload reputation_spillover_template'),
(685,'Command: reload skill_discovery_template'),
(686,'Command: reload skill_extra_item_template'),
(687,'Command: reload skill_fishing_base_level'),
(688,'Command: reload skinning_loot_template'),
(689,'Command: reload smart_scripts'),
(690,'Command: reload spell_required'),
(691,'Command: reload spell_area'),
(692,'Command: reload spell_bonus_data'),
(693,'Command: reload spell_group'),
(694,'Command: reload spell_learn_spell'),
(695,'Command: reload spell_loot_template'),
(696,'Command: reload spell_linked_spell'),
(697,'Command: reload spell_pet_auras'),
(698,'Command: character changeaccount'),
(699,'Command: reload spell_proc'),
(701,'Command: reload spell_target_position'),
(702,'Command: reload spell_threats'),
(703,'Command: reload spell_group_stack_rules'),
(704,'Command: reload acore_string'),
(706,'Command: reload waypoint_scripts'),
(707,'Command: reload waypoint_data'),
(708,'Command: reload vehicle_accessory'),
(709,'Command: reload vehicle_template_accessory'),
-- Reset commands (710-717)
(710,'Command: reset'),
(711,'Command: reset achievements'),
(712,'Command: reset honor'),
(713,'Command: reset level'),
(714,'Command: reset spells'),
(715,'Command: reset stats'),
(716,'Command: reset talents'),
(717,'Command: reset all'),
-- Server commands (718-736)
(718,'Command: server'),
(719,'Command: server corpses'),
(720,'Command: server exit'),
(721,'Command: server idlerestart'),
(722,'Command: server idlerestart cancel'),
(723,'Command: server idleshutdown'),
(724,'Command: server idleshutdown cancel'),
(725,'Command: server info'),
(726,'Command: server plimit'),
(727,'Command: server restart'),
(728,'Command: server restart cancel'),
(729,'Command: server set'),
(730,'Command: server set closed'),
(731,'Command: server set difftime'),
(732,'Command: server set loglevel'),
(733,'Command: server set motd'),
(734,'Command: server shutdown'),
(735,'Command: server shutdown cancel'),
(736,'Command: server motd'),
-- Tele commands (737-741)
(737,'Command: tele'),
(738,'Command: tele add'),
(739,'Command: tele del'),
(740,'Command: tele name'),
(741,'Command: tele group'),
-- Ticket commands (742-760)
(742,'Command: ticket'),
(743,'Command: ticket assign'),
(744,'Command: ticket close'),
(745,'Command: ticket closedlist'),
(746,'Command: ticket comment'),
(747,'Command: ticket complete'),
(748,'Command: ticket delete'),
(749,'Command: ticket escalate'),
(750,'Command: ticket escalatedlist'),
(751,'Command: ticket list'),
(752,'Command: ticket onlinelist'),
(753,'Command: ticket reset'),
(754,'Command: ticket response'),
(755,'Command: ticket response append'),
(756,'Command: ticket response appendln'),
(757,'Command: ticket togglesystem'),
(758,'Command: ticket unassign'),
(759,'Command: ticket viewid'),
(760,'Command: ticket viewname'),
-- Titles commands (762-766)
(762,'Command: titles add'),
(763,'Command: titles current'),
(764,'Command: titles remove'),
(766,'Command: titles set mask'),
-- WP commands (767-774)
(767,'Command: wp'),
(768,'Command: wp add'),
(769,'Command: wp event'),
(770,'Command: wp load'),
(771,'Command: wp modify'),
(772,'Command: wp unload'),
(773,'Command: wp reload'),
(774,'Command: wp show'),
-- Mailbox command (777)
(777,'Command: mailbox'),
-- AHBot commands (779-793)
(779,'Command: ahbot items'),
(780,'Command: ahbot items gray'),
(781,'Command: ahbot items white'),
(782,'Command: ahbot items green'),
(783,'Command: ahbot items blue'),
(784,'Command: ahbot items purple'),
(785,'Command: ahbot items orange'),
(786,'Command: ahbot items yellow'),
(787,'Command: ahbot ratio'),
(788,'Command: ahbot ratio alliance'),
(789,'Command: ahbot ratio horde'),
(790,'Command: ahbot ratio neutral'),
(791,'Command: ahbot rebuild'),
(792,'Command: ahbot reload'),
(793,'Command: ahbot status'),
-- Guild info / Instance boss / PVPStats / Modify XP (794-798)
(794,'Command: guild info'),
(795,'Command: instance setbossstate'),
(796,'Command: instance getbossstate'),
(797,'Command: pvpstats'),
(798,'Command: modify xp'),
-- Additional commands (837-843)
(837,'Command: npc evade'),
(838,'Command: pet level'),
(839,'Command: server shutdown force'),
(840,'Command: server restart force'),
(841,'Command: neargraveyard'),
(843,'Command: reload quest_greeting'),
-- Spawngroup / Group / NPC / List commands (856-868)
(856,'Command: npc spawngroup'),
(857,'Command: npc despawngroup'),
(858,'Command: gobject spawngroup'),
(859,'Command: gobject despawngroup'),
(860,'Command: list respawns'),
(861,'Command: group set'),
(862,'Command: group set assistant'),
(863,'Command: group set maintank'),
(864,'Command: group set mainassist'),
(865,'Command: npc showloot'),
(866,'Command: list spawnpoints'),
(867,'Command: reload quest_greeting_locale'),
(868,'Command: group revive'),
-- Server debug / Reload / Settings / Lookup (872-877)
(872,'Command: server debug'),
(873,'Command: reload creature_movement_override'),
(874,'Command: settings announcer'),
(875,'Command: lookup map id'),
(876,'Command: lookup item id'),
(877,'Command: lookup quest id'),
-- PDump copy / Reload vehicle template (880-881)
(880,'Command: pdump copy'),
(881,'Command: reload vehicle_template'),
-- BG start/stop (884-885)
(884,'Command: bg start'),
(885,'Command: bg stop'),
-- AC-specific commands (886-896)
(886,'Command: item restore'),
(887,'Command: item restore list'),
(888,'Command: item refund'),
(889,'Command: commentator'),
(890,'Command: skirmish'),
(891,'Command: string'),
(892,'Command: opendoor'),
(893,'Command: beastmaster'),
(894,'Command: packetlog'),
(895,'Command: aura stack'),
(896,'Command: respawn all'),
-- Gear / Spectator commands (897-904)
(897,'Command: gear repair'),
(898,'Command: gear stats'),
(899,'Command: spect'),
(900,'Command: spect version'),
(901,'Command: spect reset'),
(902,'Command: spect spectate'),
(903,'Command: spect watch'),
(904,'Command: spect leave'),
-- Arena season commands (905-908)
(905,'Command: arena season state'),
(906,'Command: arena season reward'),
(907,'Command: arena season deleteteams'),
(908,'Command: arena season start'),
-- Character check commands (909-911)
(909,'Command: character check bank'),
(910,'Command: character check bag'),
(911,'Command: character check profession');

-- ============================================================================
-- Link roles to permissions
-- ============================================================================
INSERT INTO `rbac_linked_permissions` VALUES
-- ---------------------------------------------------------------------------
-- Role 192 (Administrator): Core admin permissions + links to GM role and Admin commands
-- ---------------------------------------------------------------------------
(192, 7),   -- Skip idle check
(192, 21),  -- Skip talent reset check
(192, 42),  -- World teleport opcode
(192, 43),  -- Whois opcode
(192, 193), -- Links to GM role
(192, 196), -- Admin commands role
-- ---------------------------------------------------------------------------
-- Role 193 (Gamemaster): GM-specific core permissions + links to Mod role and GM commands
-- ---------------------------------------------------------------------------
(193, 45),  -- Join channels without announce
(193, 48),  -- Pinfo personal data
(193, 52),  -- No BG deserter debuff
(193, 53),  -- Can AFK in BG
(193, 194), -- Links to Moderator role
(193, 197), -- GM commands role
-- ---------------------------------------------------------------------------
-- Role 194 (Moderator): Moderator core permissions + links to Player role and Mod commands
-- ---------------------------------------------------------------------------
(194, 1),   -- Instant logout
(194, 2),   -- Skip queue
(194, 9),   -- Cannot earn realm first achievements
(194, 11),  -- Log GM trades
(194, 13),  -- Skip instance required bosses check
(194, 14),  -- Skip character creation team mask check
(194, 15),  -- Skip character creation class mask check
(194, 16),  -- Skip character creation race mask check
(194, 17),  -- Skip character creation reserved name check
(194, 18),  -- Skip character creation death knight check
(194, 19),  -- Skip channel requirements check
(194, 20),  -- Skip disable map check
(194, 22),  -- Skip spam chat check
(194, 23),  -- Skip over-speed ping check
(194, 25),  -- Allow say chat between factions
(194, 26),  -- Allow channel chat between factions
(194, 27),  -- Two side mail interaction
(194, 28),  -- See two side who list
(194, 29),  -- Add friends of other faction
(194, 30),  -- Save without delay
(194, 31),  -- Unstuck with args
(194, 32),  -- Can be assigned tickets
(194, 33),  -- Notify command not found
(194, 34),  -- Appear in GM list
(194, 35),  -- See all sec levels
(194, 36),  -- Filter whispers
(194, 37),  -- Staff badge
(194, 38),  -- Resurrect full HP
(194, 39),  -- Restore GM state
(194, 40),  -- Allow GM friend
(194, 41),  -- Start GM level
(194, 44),  -- Receive global GM messages
(194, 46),  -- Change channel settings
(194, 47),  -- Ignore lower security
(194, 51),  -- Allow two side trade
(194, 195), -- Links to Player role
(194, 198), -- Mod commands role
(194, 632), -- Mutehistory
(194, 798), -- Modify XP
-- ---------------------------------------------------------------------------
-- Role 195 (Player): Basic player permissions + player commands
-- ---------------------------------------------------------------------------
(195, 3),   -- Join BG
(195, 4),   -- Join Random BG
(195, 5),   -- Join Arenas
(195, 6),   -- Join Dungeon Finder
(195, 24),  -- Two side character creation
(195, 49),  -- Email confirm for pass change
(195, 199), -- Player commands role
-- ---------------------------------------------------------------------------
-- Role 196 (Admin Commands): Server management, reload, reset, disable, etc.
-- ---------------------------------------------------------------------------
-- RBAC commands
(196, 200), (196, 201), (196, 202), (196, 203), (196, 204), (196, 205), (196, 206),
-- Account administration
(196, 219), (196, 220), (196, 224), (196, 226), (196, 227), (196, 228), (196, 229),
(196, 265), (196, 266),
-- Battlefield management
(196, 258), (196, 259), (196, 260), (196, 261), (196, 262),
-- Character admin (destructive operations)
(196, 278), (196, 281), (196, 282), (196, 698),
-- PDump
(196, 289), (196, 290), (196, 880),
-- Disable commands
(196, 350), (196, 351), (196, 352), (196, 353), (196, 354), (196, 355), (196, 356), (196, 357),
(196, 359), (196, 360), (196, 361), (196, 362), (196, 363), (196, 364), (196, 365), (196, 366),
-- Channel management
(196, 463), (196, 464), (196, 465),
-- Mass operations
(196, 503), (196, 511), (196, 524),
-- Reload commands
(196, 607), (196, 608), (196, 609), (196, 610), (196, 611), (196, 612), (196, 613), (196, 614),
(196, 615), (196, 616), (196, 617), (196, 618), (196, 619), (196, 620), (196, 621), (196, 622),
(196, 623), (196, 624), (196, 625), (196, 626), (196, 627), (196, 629), (196, 630), (196, 631),
(196, 633), (196, 634), (196, 635), (196, 636), (196, 637), (196, 638), (196, 639), (196, 640),
(196, 641), (196, 642), (196, 643), (196, 644), (196, 645), (196, 646), (196, 647), (196, 648),
(196, 649), (196, 650), (196, 651), (196, 652), (196, 653), (196, 654), (196, 655), (196, 656),
(196, 657), (196, 658), (196, 659), (196, 660), (196, 661), (196, 662), (196, 663), (196, 664),
(196, 665), (196, 666), (196, 667), (196, 668), (196, 669), (196, 670), (196, 671), (196, 672),
(196, 673), (196, 674), (196, 675), (196, 676), (196, 677), (196, 678), (196, 679), (196, 680),
(196, 681), (196, 682), (196, 683), (196, 684), (196, 685), (196, 686), (196, 687), (196, 688),
(196, 689), (196, 690), (196, 691), (196, 692), (196, 693), (196, 694), (196, 695), (196, 696),
(196, 697), (196, 699), (196, 701), (196, 702), (196, 703), (196, 704), (196, 706), (196, 707),
(196, 708), (196, 709),
(196, 843), (196, 867), (196, 873), (196, 881),
-- Reset commands
(196, 710), (196, 711), (196, 712), (196, 713), (196, 714), (196, 715), (196, 716), (196, 717),
-- Server commands
(196, 718), (196, 719), (196, 720), (196, 721), (196, 722), (196, 723), (196, 724),
(196, 726), (196, 727), (196, 728), (196, 729), (196, 730), (196, 731), (196, 732),
(196, 733), (196, 734), (196, 735), (196, 736),
(196, 839), (196, 840), (196, 872),
-- Ticket admin (destructive)
(196, 748), (196, 753), (196, 757),
-- WP reload
(196, 773),
-- Mailbox
(196, 777),
-- AHBot
(196, 779), (196, 780), (196, 781), (196, 782), (196, 783), (196, 784), (196, 785),
(196, 786), (196, 787), (196, 788), (196, 789), (196, 790), (196, 791), (196, 792), (196, 793),
-- List spawnpoints
(196, 866),
-- Arena season commands
(196, 905), (196, 906), (196, 907), (196, 908),
-- AC-specific admin commands
(196, 886), (196, 887), (196, 888), (196, 891), (196, 894), (196, 896),
-- ---------------------------------------------------------------------------
-- Role 197 (GM Commands): Game manipulation, character, NPC, gobject, quest, etc.
-- ---------------------------------------------------------------------------
-- Achievement
(197, 231), (197, 232),
-- Arena
(197, 233), (197, 234), (197, 235), (197, 236), (197, 237), (197, 238),
-- Cast
(197, 267), (197, 268), (197, 269), (197, 270), (197, 271), (197, 272),
-- Character
(197, 274), (197, 275), (197, 276), (197, 279), (197, 280),
(197, 283), (197, 284), (197, 285), (197, 286), (197, 287),
(197, 909), (197, 910), (197, 911),
-- Cheat
(197, 292), (197, 293), (197, 294), (197, 295), (197, 296), (197, 297), (197, 298), (197, 299),
-- Debug
(197, 300),
-- Deserter
(197, 343), (197, 344), (197, 346), (197, 347),
-- Event
(197, 367), (197, 368), (197, 369), (197, 370),
-- GM / Go
(197, 371), (197, 372), (197, 373), (197, 376), (197, 377),
-- Gobject
(197, 388), (197, 389), (197, 390), (197, 391), (197, 392), (197, 393), (197, 394),
(197, 396), (197, 397), (197, 398), (197, 399),
-- Guild
(197, 401), (197, 402), (197, 403), (197, 404), (197, 405), (197, 406), (197, 407),
-- Honor
(197, 409), (197, 410), (197, 411),
-- Instance
(197, 413), (197, 414), (197, 415), (197, 416),
-- Learn
(197, 417), (197, 419), (197, 420), (197, 421), (197, 422), (197, 423), (197, 424),
(197, 425), (197, 426), (197, 427), (197, 428), (197, 429),
-- LFG
(197, 431), (197, 432), (197, 433), (197, 434), (197, 435),
-- List
(197, 437), (197, 438), (197, 439), (197, 440), (197, 441),
-- Lookup (GM-level)
(197, 445), (197, 448), (197, 449), (197, 451), (197, 452), (197, 453), (197, 454),
(197, 457), (197, 458), (197, 460), (197, 461),
-- Group
(197, 472), (197, 473), (197, 474), (197, 475), (197, 476), (197, 477), (197, 478),
-- Pet
(197, 479), (197, 480), (197, 481), (197, 482),
-- Send
(197, 483), (197, 484), (197, 485), (197, 486), (197, 487),
-- Misc game commands
(197, 488), (197, 489), (197, 490), (197, 491), (197, 492), (197, 493), (197, 494), (197, 495),
(197, 497), (197, 498), (197, 499), (197, 500),
(197, 502), (197, 504), (197, 506), (197, 508), (197, 509),
(197, 512), (197, 513), (197, 514), (197, 516), (197, 518), (197, 519), (197, 520),
(197, 521), (197, 522), (197, 523), (197, 526), (197, 527), (197, 528), (197, 529), (197, 530), (197, 531),
(197, 533), (197, 535),
-- MMap
(197, 536), (197, 537), (197, 538), (197, 539), (197, 540), (197, 541),
-- Morph
(197, 542), (197, 543),
-- Modify
(197, 544), (197, 545), (197, 546), (197, 547), (197, 548), (197, 549), (197, 550), (197, 551),
(197, 552), (197, 553), (197, 554), (197, 555), (197, 556), (197, 557), (197, 558), (197, 559),
(197, 560), (197, 561), (197, 562), (197, 563), (197, 564), (197, 565), (197, 566), (197, 567),
(197, 568), (197, 569),
-- NPC
(197, 571), (197, 572), (197, 573), (197, 574), (197, 575), (197, 576), (197, 577), (197, 578),
(197, 579), (197, 580), (197, 581), (197, 582), (197, 583), (197, 584), (197, 585), (197, 586),
(197, 587), (197, 588), (197, 589), (197, 590), (197, 591), (197, 592), (197, 593), (197, 594),
(197, 595), (197, 596), (197, 597), (197, 598), (197, 599), (197, 600), (197, 601),
-- Quest
(197, 602), (197, 603), (197, 604), (197, 605), (197, 606),
-- Tele
(197, 737), (197, 738), (197, 739), (197, 740), (197, 741),
-- Titles
(197, 762), (197, 763), (197, 764), (197, 766),
-- WP (except reload which is in 196)
(197, 767), (197, 768), (197, 769), (197, 770), (197, 771), (197, 772), (197, 774),
-- Guild info / Instance boss state / Modify XP
(197, 794), (197, 795), (197, 796), (197, 798),
-- NPC evade / Pet level / Neargraveyard
(197, 837), (197, 838), (197, 841),
-- Spawngroup / List respawns
(197, 856), (197, 857), (197, 858), (197, 859), (197, 860),
-- Group set / NPC showloot
(197, 861), (197, 862), (197, 863), (197, 864), (197, 865),
-- Group revive / Settings announcer
(197, 868), (197, 874),
-- Lookup map/item/quest id
(197, 875), (197, 876), (197, 877),
-- BG start/stop
(197, 884), (197, 885),
-- AC-specific GM commands
(197, 889), (197, 890), (197, 892), (197, 893), (197, 895),
-- Gear repair
(197, 897),
-- ---------------------------------------------------------------------------
-- Role 198 (Mod Commands): Community management - ban, mute, kick, tickets, announce
-- ---------------------------------------------------------------------------
-- Ban/Unban
(198, 240), (198, 241), (198, 242), (198, 243),
(198, 245), (198, 246), (198, 247),
(198, 249), (198, 250), (198, 251),
(198, 253), (198, 254), (198, 255), (198, 256),
-- Announce/Notify
(198, 462), (198, 466), (198, 467), (198, 468), (198, 469), (198, 470), (198, 471),
-- Kick/Mute/Pinfo/Unmute
(198, 510), (198, 515), (198, 517), (198, 532),
-- Mutehistory
(198, 632),
-- Ticket commands (excluding admin-only 748 delete, 753 reset, 757 togglesystem)
(198, 742), (198, 743), (198, 744), (198, 745), (198, 746), (198, 747),
(198, 749), (198, 750), (198, 751), (198, 752),
(198, 754), (198, 755), (198, 756), (198, 758), (198, 759), (198, 760),
-- ---------------------------------------------------------------------------
-- Role 199 (Player Commands): Self-service account management, basic lookups
-- ---------------------------------------------------------------------------
-- Account self-management
(199, 217), (199, 218), (199, 221), (199, 222), (199, 223), (199, 225), (199, 263),
-- GM info
(199, 374), (199, 375),
-- Lookup (basic)
(199, 442), (199, 443), (199, 444), (199, 446), (199, 447), (199, 450), (199, 455), (199, 456), (199, 459),
-- Basic commands
(199, 496), (199, 501), (199, 505), (199, 507), (199, 525), (199, 534),
-- Server info / PVPStats
(199, 725), (199, 797),
-- Gear stats
(199, 898),
-- Spectator
(199, 899), (199, 900), (199, 901), (199, 902), (199, 903), (199, 904);

-- ============================================================================
-- Default permissions by security level
-- ============================================================================
-- SEC_PLAYER = 0 gets Player role (195)
-- SEC_MODERATOR = 1 gets Moderator role (194, which includes 195)
-- SEC_GAMEMASTER = 2 gets GM role (193, which includes 194)
-- SEC_ADMINISTRATOR = 3 gets Admin role (192, which includes 193)
INSERT INTO `rbac_default_permissions` VALUES
(3, 192, -1),  -- Admin gets Admin role
(2, 193, -1),  -- GM gets GM role
(1, 194, -1),  -- Moderator gets Mod role
(0, 195, -1);  -- Player gets Player role

-- DB update 2025_01_28_00 -> 2025_01_31_00
--
DELETE FROM `command` WHERE `name` IN ('worldstate sunsreach phase', 'worldstate sunsreach subphase', 'worldstate sunsreach gate');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('worldstate sunsreach phase', 3, 'Syntax: .worldstate sunsreach phase <value>.\nSets the phase of Sun''s Reach.\nValid values are:\n0: Staging Area\n1: Sanctum\n2: Armory\n3: Harbor.'),
('worldstate sunsreach subphase', 3, 'Syntax: .worldstate sunsreach subphase <mask>.\nSets the subphase mask of Sun''s Reach.\nValid values are:\n1: Portal\n2: Anvil\n4: Alchemy Lab\n8: Monument\n15: All.'),
('worldstate sunsreach gate', 3, 'Syntax: .worldstate sunsreach gate <gate>.\nSets the phase of Sunwell Plateau Gate.\nValid values are:\n0: All Gates Closed\n1: Gate 1 Agamath Open\n2: Gate 2 Rohendar Open\n3: Gate 3 Archonisus Open.');

-- Smith Hauthaa <Weapons & Armorsmith>
SET @cguidsmith = 93964;
-- Shaani <Jewelcrafting Supplies>
SET @cguidjc = 94386;
-- Mar'nah <Alchemist>
SET @cguidalch = 94378;
-- Demonic Crystals
SET @guidcrystals = 5300500;
-- Alchemy lab
SET @guidalch = 5300290;
-- Portal Subphase, Shattrath City, Shattered Sun Warrior and Shattered Sun Marksman
SET @cguidportalshat = 165102;
-- Portal Subphase, Isle of Quel'Danas
SET @cguidportalisle = 5300070;
-- Dawnblade Blood Knight
SET @cguidbloodknights = 5300293;
-- Dawnblade Summoner, Dawnblade Marksman
SET @cguidsummonermarksman = 5300355;
-- Irespeaker
SET @cguidirespeaker = 5300460;
-- Abyssal Flamewalker, Unleashed Hellion
SET @cguidflamewalkerhellion = 5300473;
-- Invisible Stalker Floating -> Fel Crystal Spell target
SET @cguidfelcrystalspelltarget = 5300031;

SET
@sunsreachpone       = 101,
@sunsreachptwoonly   = 102,
@sunsreachptwoperm   = 103,
@sunsreachnoportal   = 104,
@sunsreachportal     = 105,
@sunsreachpthreeonly = 106,
@sunsreachpthreeperm = 107,
@sunsreachnoanvil    = 108,
@sunsreachanvil      = 109,
@sunsreachpfour      = 110,
@sunsreachnomonument = 111,
@sunsreachmonument   = 112,
@sunsreachnolab      = 113,
@sunsreachlab        = 114,
@sunsreachkiru       = 115,
@sunwellnone         = 116,
@sunwellfirst        = 117,
@sunwellsecond       = 118,
@sunwellall          = 119;

DELETE FROM `game_event` WHERE `eventEntry` IN (@sunsreachpone, @sunsreachptwoonly, @sunsreachptwoperm, @sunsreachnoportal, @sunsreachportal, @sunsreachpthreeonly, @sunsreachpthreeperm, @sunsreachnoanvil, @sunsreachanvil, @sunsreachpfour, @sunsreachnomonument, @sunsreachmonument, @sunsreachnolab, @sunsreachlab, @sunsreachkiru, @sunwellnone, @sunwellfirst, @sunwellsecond, @sunwellall);
INSERT INTO `game_event` (`eventEntry`, `start_time`, `end_time`, `occurence`, `length`, `holiday`, `holidayStage`, `description`, `world_event`, `announce`) VALUES
(@sunsreachpone,       '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase 1',              5, 2),
(@sunsreachptwoonly,   '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase 2 Only',         5, 2),
(@sunsreachptwoperm,   '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase 2 Permanent',    5, 2),
(@sunsreachnoportal,   '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase No Portal',      5, 2),
(@sunsreachportal,     '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase Portal',         5, 2),
(@sunsreachpthreeonly, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase 3 Only',         5, 2),
(@sunsreachpthreeperm, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase 3 Permanent',    5, 2),
(@sunsreachnoanvil,    '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase No Anvil',       5, 2),
(@sunsreachanvil,      '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase Anvil',          5, 2),
(@sunsreachpfour,      '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase 4',              5, 2),
(@sunsreachnomonument, '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase No Monument',    5, 2),
(@sunsreachmonument,   '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase Monument',       5, 2),
(@sunsreachnolab,      '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase No Alchemy Lab', 5, 2),
(@sunsreachlab,        '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase Alchemy Lab',    5, 2),
(@sunsreachkiru,       '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase K''iru',         5, 2),
(@sunwellnone,         '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'SWP - All Gates Closed',                        5, 2), -- 1 1 1
(@sunwellfirst,        '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'SWP - First Gate Open',                         5, 2), -- 0 1 1
(@sunwellsecond,       '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'SWP - Second Gate Open',                        5, 2), -- 0 0 1
(@sunwellall,          '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'SWP - All Gates Open',                          5, 2); -- 0 0 0

UPDATE `creature_template` SET `ScriptName`='npc_suns_reach_reclamation' WHERE `entry` IN (24965,24967,25061,25057,24932,25108,25069,25046,24975,25112,25163);
UPDATE `creature_template` SET `ScriptName`='npc_sunwell_gate' WHERE `entry` = 25169;

DELETE FROM `game_event_creature` WHERE `eventEntry` IN (@sunsreachpone, @sunsreachptwoonly, @sunsreachptwoperm, @sunsreachnoportal, @sunsreachportal, @sunsreachpthreeonly, @sunsreachpthreeperm, @sunsreachnoanvil, @sunsreachanvil, @sunsreachpfour, @sunsreachnomonument, @sunsreachmonument, @sunsreachnolab, @sunsreachlab, @sunsreachkiru, @sunwellnone, @sunwellfirst, @sunwellsecond, @sunwellall, -@sunsreachpone, -@sunsreachptwoonly, -@sunsreachptwoperm, -@sunsreachnoportal, -@sunsreachportal, -@sunsreachpthreeonly, -@sunsreachpthreeperm, -@sunsreachnoanvil, -@sunsreachanvil, -@sunsreachpfour, -@sunsreachnomonument, -@sunsreachmonument, -@sunsreachnolab, -@sunsreachlab, -@sunsreachkiru, -@sunwellnone, -@sunwellfirst, -@sunwellsecond, -@sunwellall);
INSERT INTO `game_event_creature` (`guid`, `eventEntry`) VALUES
-- Phase 2
(93950, @sunsreachptwoperm), -- 25061 (Harbinger Inuuro)
(93951, @sunsreachptwoperm), -- 25057 (Battlemage Arynna)
(93952, @sunsreachptwoperm), -- 25034 (Tradesman Portanuus <Trade Supplies>)
(93953, @sunsreachptwoperm), -- 25133 (Astromancer Darnarian)
(96655, @sunsreachptwoperm), -- 24932 (Exarch Nasuun)
-- Phase 3
(@cguidsmith, @sunsreachpthreeperm), -- 25046 (Smith Hauthaa <Weapons & Armorsmith>)
(93955, @sunsreachpthreeperm), -- 25108 (Vindicator Kaalan)
(93954, @sunsreachpthreeperm), -- 25035 (Tyrael Flamekissed <General Goods>)
(93960, @sunsreachpthreeperm), -- 26089 (Kayri <Exotic Gear Purveyor>)
(93956, @sunsreachpthreeperm), -- 26090 (Karynna <Exotic Gear Purveyor>)
(93959, @sunsreachpthreeperm), -- 26091 (Olus <Exotic Gear Purveyor>)
(93958, @sunsreachpthreeperm), -- 26092 (Soryn <Exotic Gear Purveyor>)
(93957, @sunsreachpthreeperm), -- 25069 (Magister Ilastar)
-- Phase 4
(@cguidalch, @sunsreachpfour), -- 24975 (Mar'nah <Alchemist>)
(94379, @sunsreachpfour), -- 25036 (Caregiver Inaara <Innkeeper>)
(94384, @sunsreachpfour), -- 25112 (Anchorite Ayuri)
(94385, @sunsreachpfour), -- 25163 (Anchorite Kairthos)
(@cguidjc, @sunsreachpfour), -- 25950 (Shaani <Jewelcrafting Supplies>)
-- Kaalif?
(94381, @sunsreachpfour), -- 25043 (Sereth Duskbringer <Poison Supplies>)
(94383, @sunsreachpfour), -- 25088 (Captain Valindria)
(94380, @sunsreachpfour), -- 25037 (Seraphina Bloodheart <Stable Master>)
(94382, @sunsreachpfour), -- 25045 (Sentinel <Seraphina's Pet>)
-- Anvil
(40444,   @sunsreachanvil), -- 27667 (Anwehu <Weapons & Armorsmith>)
-- Alchemy Lab
(44253, @sunsreachlab), -- 27666 (Ontuvo <Jewelcrafting Supplies>)
(984, @sunsreachlab), -- 25039 (Kaalif <Reagent Vendor>)
-- K'iru
(62847, @sunsreachkiru), -- 25174 (K'iru)
-- Sanctum Allies
(76576, @sunsreachptwoperm), -- 24994 (Shattered Sun Sentry) 5300440
(78387, @sunsreachptwoperm), -- 24994 (Shattered Sun Sentry) 5300445
(76578, @sunsreachptwoperm), -- 24994 (Shattered Sun Sentry) 5300442
(54113, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300093
(54114, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300094
(54143, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300095
(65681, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300107
(54176, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300097
(54165, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300096
(54177, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300098
(54178, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300099
(54181, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300100
(54182, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300101
(54184, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300103
(54183, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300102
(54185, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300104
(56315, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300105
(65680, @sunsreachptwoperm), -- 24938 (Shattered Sun Marksman) 5300106
(71926, @sunsreachptwoperm), -- 25115 (Shattered Sun Warrior) 5301090
(71925, @sunsreachptwoperm), -- 25115 (Shattered Sun Warrior) 5301089
(76577, @sunsreachptwoperm), -- 24994 (Shattered Sun Sentry) 5300441
(76582, @sunsreachptwoperm), -- 24994 (Shattered Sun Sentry)
(76581, @sunsreachptwoperm), -- 24994 (Shattered Sun Sentry)
-- Armory Allies
(65693, @sunsreachpthreeperm), -- 24938 (Shattered Sun Marksman) 5300118
(65692, @sunsreachpthreeperm), -- 24938 (Shattered Sun Marksman) 5300117
(65691, @sunsreachpthreeperm), -- 24938 (Shattered Sun Marksman) 5300116
(65690, @sunsreachpthreeperm), -- 24938 (Shattered Sun Marksman) 5300115
(65689, @sunsreachpthreeperm), -- 24938 (Shattered Sun Marksman) 5300114
(65688, @sunsreachpthreeperm), -- 24938 (Shattered Sun Marksman) 5300113
(65685, @sunsreachpthreeperm), -- 24938 (Shattered Sun Marksman) 5300111
(65684, @sunsreachpthreeperm), -- 24938 (Shattered Sun Marksman) 5300110
(65683, @sunsreachpthreeperm), -- 24938 (Shattered Sun Marksman) 5300109
(65686, @sunsreachpthreeperm), -- 24938 (Shattered Sun Marksman) 5300112
(65682, @sunsreachpthreeperm), -- 24938 (Shattered Sun Marksman) 5300108
(65687, @sunsreachpthreeperm), -- 24938 (Shattered Sun Marksman) 5301587
-- (5300152, @sunsreachpthreeperm), -- 24938 (Shattered Sun Marksman) Missing?
(93961, @sunsreachpthreeperm), -- 26253 (Shattered Sun Peacekeeper) 5301179
(71927, @sunsreachpthreeperm), -- 25115 (Shattered Sun Warrior) 5301091
(71928, @sunsreachpthreeperm), -- 25115 (Shattered Sun Warrior) 5301092
(76579, @sunsreachpthreeperm), -- 24994 (Shattered Sun Sentry) 5300443
(78388, @sunsreachpthreeperm), -- 24994 (Shattered Sun Sentry) 5300446
(72677, @sunsreachpthreeperm), -- 25115 (Shattered Sun Warrior) 5301093
(72989, @sunsreachpthreeperm), -- 25115 (Shattered Sun Warrior) 5301094
(78386, @sunsreachpthreeperm), -- 24994 (Shattered Sun Sentry) 5300433
-- (5300436, @sunsreachpthreeperm), -- 24994 (Shattered Sun Sentry) Missing?
(77479, @sunsreachpthreeperm), -- 24994 (Shattered Sun Sentry) 5300444
(78385, @sunsreachpthreeperm), -- 24994 (Shattered Sun Sentry)
(78389, @sunsreachpthreeperm), -- 24994 (Shattered Sun Sentry) 5300447
(94387, @sunsreachpthreeperm), -- 25115 (Shattered Sun Warrior)
-- Dawning Square Allies (Unconfirmed)
(65702, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300126
(65700, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300125
(65696, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300121
(65695, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300120
(65694, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300119
(65697, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300122
(65699, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300124
(65698, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300123
(76580, @sunsreachpfour), -- 24994 (Shattered Sun Sentry) 5300430
-- Harbor Allies
(94433, @sunsreachpfour), -- 25115 (Shattered Sun Warrior) 5301210
(94432, @sunsreachpfour), -- 25115 (Shattered Sun Warrior) 5301211
(94401, @sunsreachpfour), -- 24994 (Shattered Sun Sentry) 5300448
(94406, @sunsreachpfour), -- 24994 (Shattered Sun Sentry) 5300451
(94413, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300134
(94414, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300135
(94415, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300136
(12719, @sunsreachpfour), -- 24994 (Shattered Sun Sentry) 5300429
(94416, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300137
(94417, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300138
(94418, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300139
(94419, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300140
(94420, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300141
(94422, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300142
(94423, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300143
(94424, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300144
(94425, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300145
(94426, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300146
(94427, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300147
(94428, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300148
(94429, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300149
(94430, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300150
(94431, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300151
(94409, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300130
(94402, @sunsreachpfour), -- 24994 (Shattered Sun Sentry) 5300449
(94377, @sunsreachpfour), -- 24994 (Shattered Sun Sentry)
(83998, @sunsreachpfour), -- 24994 (Shattered Sun Sentry)
(94435, @sunsreachpfour), -- 25115 (Shattered Sun Warrior) 5301097
(94434, @sunsreachpfour), -- 25115 (Shattered Sun Warrior) 5301096
(94436, @sunsreachpfour), -- 25115 (Shattered Sun Warrior) 5301098
(94437, @sunsreachpfour), -- 25115 (Shattered Sun Warrior) 5301099
(94438, @sunsreachpfour), -- 25115 (Shattered Sun Warrior) 5301100
(94408, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300129
(94407, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300128
(94410, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300131
(94411, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300132
(94412, @sunsreachpfour), -- 24938 (Shattered Sun Marksman) 5300133
(94403, @sunsreachpfour), -- 24994 (Shattered Sun Sentry) 5300450
-- Sanctum Enemies
(5300412, -@sunsreachptwoperm), -- 24979 (Dawnblade Marksman)
(5300411, -@sunsreachptwoperm), -- 24979 (Dawnblade Marksman)
(5300414, -@sunsreachptwoperm), -- 24979 (Dawnblade Marksman)
(5300313, -@sunsreachptwoperm), -- 24976 (Dawnblade Blood Knight)
(5300314, -@sunsreachptwoperm), -- 24976 (Dawnblade Blood Knight)
(5300368, -@sunsreachptwoperm), -- 24978 (Dawnblade Summoner)
-- Armory Enemies
(5300463, -@sunsreachpthreeperm), -- 24999 (Irespeaker)
(5300462, -@sunsreachpthreeperm), -- 24999 (Irespeaker)
(5300498, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(5300460, -@sunsreachpthreeperm), -- 24999 (Irespeaker)
(5300461, -@sunsreachpthreeperm), -- 24999 (Irespeaker)
(5300464, -@sunsreachpthreeperm), -- 24999 (Irespeaker)
(5300493, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(5300494, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(5300465, -@sunsreachpthreeperm), -- 24999 (Irespeaker)
(5300477, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(5300478, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(5300476, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(5300495, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(93965,   -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(5300480, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(5300365, -@sunsreachpthreeperm), -- 24978 (Dawnblade Summoner)
(5300499, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(5300479, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(5300475, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(5300481, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(5300500, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(5300496, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(5300497, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(5300501, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(93982, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(@cguidfelcrystalspelltarget+0, -@sunsreachpthreeperm), -- 25953 (Fel Crystal Spell Target)
(@cguidfelcrystalspelltarget+1, -@sunsreachpthreeperm), -- 25953 (Fel Crystal Spell Target)
(@cguidfelcrystalspelltarget+2, -@sunsreachpthreeperm), -- 25953 (Fel Crystal Spell Target)
(@cguidfelcrystalspelltarget+3, -@sunsreachpthreeperm), -- 25953 (Fel Crystal Spell Target)
(@cguidfelcrystalspelltarget+4, -@sunsreachpthreeperm), -- 25953 (Fel Crystal Spell Target)
-- Dawning Square Enemies
(5300406, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300403, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300408, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300407, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300404, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300405, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
-- Harbor Enemies
(5300410, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300302, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300303, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300409, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300397, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300399, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300356, -@sunsreachpfour), -- 24978 (Dawnblade Summoner)
(5300359, -@sunsreachpfour), -- 24978 (Dawnblade Summoner)
(5300301, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300358, -@sunsreachpfour), -- 24978 (Dawnblade Summoner)
(5300300, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300393, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300355, -@sunsreachpfour), -- 24978 (Dawnblade Summoner)
(5300357, -@sunsreachpfour), -- 24978 (Dawnblade Summoner)
(5300394, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300295, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300364, -@sunsreachpfour), -- 24978 (Dawnblade Summoner)
(5300312, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300367, -@sunsreachpfour), -- 24978 (Dawnblade Summoner)
(5300366, -@sunsreachpfour), -- 24978 (Dawnblade Summoner)
(5300360, -@sunsreachpfour), -- 24978 (Dawnblade Summoner)
(5300361, -@sunsreachpfour), -- 24978 (Dawnblade Summoner)
(5300307, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300298, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300395, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300297, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300396, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300415, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300398, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300305, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300306, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300304, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300308, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300363, -@sunsreachpfour), -- 24978 (Dawnblade Summoner)
(5300392, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300391, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300390, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300389, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300413, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300400, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300310, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300362, -@sunsreachpfour), -- 24978 (Dawnblade Summoner)
(5300388, -@sunsreachpfour), -- 24979 (Dawnblade Marksman)
(5300311, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300299, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
(5300296, -@sunsreachpfour), -- 24976 (Dawnblade Blood Knight)
-- Unmarked
(93969, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(5300473, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(5300474, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(93983, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(5300503, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(54030, -@sunsreachptwoperm), -- 24938 (Shattered Sun Marksman)
(54031, -@sunsreachptwoperm), -- 24938 (Shattered Sun Marksman)
(5300293, -@sunsreachptwoperm), -- 24976 (Dawnblade Blood Knight)
(5300294, -@sunsreachptwoperm), -- 24976 (Dawnblade Blood Knight)
(5300309, -@sunsreachptwoperm), -- 24976 (Dawnblade Blood Knight)
(5300315, -@sunsreachptwoperm), -- 24976 (Dawnblade Blood Knight)
(5300369, -@sunsreachptwoperm), -- 24978 (Dawnblade Summoner)
(5300370, -@sunsreachptwoperm), -- 24978 (Dawnblade Summoner)
(5300401, -@sunsreachptwoperm), -- 24979 (Dawnblade Marksman)
(5300402, -@sunsreachptwoperm), -- 24979 (Dawnblade Marksman)
(71916, -@sunsreachptwoperm), -- 25115 (Shattered Sun Warrior)
(71917, -@sunsreachptwoperm), -- 25115 (Shattered Sun Warrior)
(71919, -@sunsreachptwoperm), -- 25115 (Shattered Sun Warrior)
(54030, -@sunsreachptwoonly), -- 24938 (Shattered Sun Marksman)
(54031, -@sunsreachptwoonly), -- 24938 (Shattered Sun Marksman)
(5300293, -@sunsreachptwoonly), -- 24976 (Dawnblade Blood Knight)
(5300294, -@sunsreachptwoonly), -- 24976 (Dawnblade Blood Knight)
(5300309, -@sunsreachptwoonly), -- 24976 (Dawnblade Blood Knight)
(5300315, -@sunsreachptwoonly), -- 24976 (Dawnblade Blood Knight)
(5300369, -@sunsreachptwoonly), -- 24978 (Dawnblade Summoner)
(5300370, -@sunsreachptwoonly), -- 24978 (Dawnblade Summoner)
(5300401, -@sunsreachptwoonly), -- 24979 (Dawnblade Marksman)
(5300402, -@sunsreachptwoonly), -- 24979 (Dawnblade Marksman)
(@cguidportalshat+0,  @sunsreachportal), -- 25115 (Shattered Sun Warrior)
(@cguidportalshat+1,  @sunsreachportal), -- 25115 (Shattered Sun Warrior)
(@cguidportalshat+2,  @sunsreachportal), -- 25115 (Shattered Sun Warrior)
(@cguidportalshat+3,  @sunsreachportal), -- 25115 (Shattered Sun Warrior)
(@cguidportalshat+4,  @sunsreachportal), -- 24938 (Shattered Sun Marksman)
(@cguidportalshat+5,  @sunsreachportal), -- 24938 (Shattered Sun Marksman)
(@cguidportalshat+6,  @sunsreachportal), -- 24938 (Shattered Sun Marksman)
(@cguidportalshat+7,  @sunsreachportal), -- 24938 (Shattered Sun Marksman)
(@cguidportalisle+0, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(@cguidportalisle+1, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(@cguidportalisle+2, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(@cguidportalisle+3, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(@cguidportalisle+4, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(@cguidportalisle+5, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(@cguidportalisle+6, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(@cguidportalisle+7, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(@cguidportalisle+8, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(@cguidportalisle+9, @sunsreachportal); -- 24936 (Sunwell Daily Bunny x 0.01)

DELETE FROM `game_event_gameobject` WHERE `eventEntry` IN (@sunsreachpone, @sunsreachptwoonly, @sunsreachptwoperm, @sunsreachnoportal, @sunsreachportal, @sunsreachpthreeonly, @sunsreachpthreeperm, @sunsreachnoanvil, @sunsreachanvil, @sunsreachpfour, @sunsreachnomonument, @sunsreachmonument, @sunsreachnolab, @sunsreachlab, @sunsreachkiru, @sunwellnone, @sunwellfirst, @sunwellsecond, @sunwellall, -@sunsreachpone, -@sunsreachptwoonly, -@sunsreachptwoperm, -@sunsreachnoportal, -@sunsreachportal, -@sunsreachpthreeonly, -@sunsreachpthreeperm, -@sunsreachnoanvil, -@sunsreachanvil, -@sunsreachpfour, -@sunsreachnomonument, -@sunsreachmonument, -@sunsreachnolab, -@sunsreachlab, -@sunsreachkiru, -@sunwellnone, -@sunwellfirst, -@sunwellsecond, -@sunwellall);
INSERT INTO `game_event_gameobject` (`guid`, `eventEntry`) VALUES
-- Portal
(47196,   @sunsreachportal), -- 187056, Shattrath Portal to Isle of Quel'Danas
(27755,   @sunsreachportal), -- 187335, Portal from Shattrath City
-- Armory
(27811,   @sunsreachpthreeperm), -- 187112, Forge
-- Anvil
(27810,   @sunsreachanvil), -- 187111, Hauthaa's Anvil
-- Phase 4
(27845,   @sunsreachpfour), -- 187113, Mailbox
-- Monument
(50446,   @sunsreachmonument), -- 187116, Monument to the Fallen - Sunwell Plateau
(27862,   @sunsreachmonument), -- 187116, Monument to the Fallen - Isle of Quel'Danas
(@guidalch, @sunsreachlab), -- 187115, Alchemy Lab
-- Crystals
(@guidcrystals+0, -@sunsreachpthreeperm), -- 187120, Demonic Crystal
(@guidcrystals+1, -@sunsreachpthreeperm), -- 187120, Demonic Crystal
(@guidcrystals+2, -@sunsreachpthreeperm), -- 187120, Demonic Crystal
(@guidcrystals+3, -@sunsreachpthreeperm), -- 187120, Demonic Crystal
(@guidcrystals+4, -@sunsreachpthreeperm), -- 187120, Demonic Crystal
-- Banners
(27839, @sunsreachptwoperm), -- 187356, Shattered Sun Banner (Draenei - Pole)
(27833, @sunsreachptwoperm), -- 187357, Shattered Sun Banner (Blood Elf - Pole)
(27838, @sunsreachpthreeperm), -- 187357, Shattered Sun Banner (Blood Elf - Pole)
(27844, @sunsreachpthreeperm), -- 187356, Shattered Sun Banner (Draenei - Pole)
(27830, @sunsreachpfour), -- 187356, Shattered Sun Banner (Draenei - Pole)
(27831, @sunsreachpfour), -- 187356, Shattered Sun Banner (Draenei - Pole)
(27861, @sunsreachpfour), -- 187357, Shattered Sun Banner (Blood Elf - Pole)
(27836, @sunsreachpfour), -- 187357, Shattered Sun Banner (Blood Elf - Pole)
(27827, @sunsreachpfour), -- 187357, Shattered Sun Banner (Blood Elf - Pole)
(27828, @sunsreachpfour), -- 187356, Shattered Sun Banner (Draenei - Pole)
-- Gates
(50441, @sunwellnone), -- 187766, Agamath, The First Gate
(50439, @sunwellnone), -- 187764, Rohendor, The Second Gate
(50440, @sunwellnone), -- 187765, Archonisus, The Third Gate
(50439, @sunwellfirst), -- 187764, Rohendor, The Second Gate
(50440, @sunwellfirst), -- 187765, Archonisus, The Third Gate
(50440, @sunwellsecond); -- 187765, Archonisus, The Third Gate

DELETE FROM `creature_queststarter` WHERE `quest` IN (11514, 11520, 11521, 11523, 11525, 11532, 11533, 11535, 11536, 11537, 11538, 11539, 11540, 11541, 11542, 11543, 11544, 11545, 11546, 11547, 11548, 11549);
DELETE FROM `game_event_creature_quest` WHERE `eventEntry` IN (@sunsreachpone, @sunsreachptwoonly, @sunsreachptwoperm, @sunsreachnoportal, @sunsreachportal, @sunsreachpthreeonly, @sunsreachpthreeperm, @sunsreachnoanvil, @sunsreachanvil, @sunsreachpfour, @sunsreachnomonument, @sunsreachmonument, @sunsreachnolab, @sunsreachlab, @sunsreachkiru, @sunwellnone, @sunwellfirst, @sunwellsecond, @sunwellall);
INSERT INTO `game_event_creature_quest` (`eventEntry`, `id`, `quest`) VALUES
-- Phase 1
(@sunsreachpone,       24965, 11524), -- Erratic Behavior
(@sunsreachpone,       24967, 11496), -- The Sanctum Wards
-- Phase 2
(@sunsreachptwoonly,   25061, 11538), -- The Battle for the Sun's Reach Armory
(@sunsreachptwoonly,   25057, 11532), -- Distraction at the Dead Scar
-- No portal
(@sunsreachnoportal,   25034, 11517), -- Report to Nasuun
(@sunsreachnoportal,   24932, 11513), -- Intercepting the Mana Cells
-- Phase 3
(@sunsreachpthreeonly, 25108, 11542), -- Intercept the Reinforcements
(@sunsreachpthreeonly, 25069, 11539), -- Taking the Harbor
-- No anvil
(@sunsreachnoanvil,    25046, 11535), -- Making Ready
-- No alchemy lab
(@sunsreachnolab,      24975, 11520), -- Discovering Your Roots
-- No monument
(@sunsreachnomonument, 25112, 11545), -- A Charitable Donation
-- Phase 2 permanent
(@sunsreachptwoperm,   24967, 11523), -- Arm the Wards!
(@sunsreachptwoperm,   24965, 11525), -- Further Conversions
-- Portal
(@sunsreachportal,     24932, 11514), -- Maintaining the Sunwell Portal
(@sunsreachportal,     25133, 11547), -- Know Your Ley Lines
(@sunsreachportal,     25034, 11534), -- Report to Nasuun
-- Phase 3 permanent
(@sunsreachpthreeperm, 25057, 11533), -- The Air Strikes Must Continue
(@sunsreachpthreeperm, 25061, 11537), -- The Battle Must Go On
-- Anvil
(@sunsreachanvil,      25046, 11536), -- Don't Stop Now....
(@sunsreachanvil,      25046, 11544), -- Ata'mal Armaments
-- Phase 4
(@sunsreachpfour,      25069, 11540), -- Crush the Dawnblade
(@sunsreachpfour,      25088, 11541), -- Disrupt the Greengill Coast
(@sunsreachpfour,      25108, 11543), -- Keeping the Enemy at Bay
(@sunsreachpfour,      25163, 11549), -- A Magnanimous Benefactor
-- Monument
(@sunsreachmonument,   25112, 11548), -- Your Continued Support
-- Alchemy lab
(@sunsreachlab,        24975, 11521), -- Rediscovering Your Roots
(@sunsreachlab,        24975, 11546); -- Open for Business

DELETE FROM `gossip_menu` WHERE `MenuID` IN (51000, 51001, 51002, 51003, 51004, 51005, 51006, 51007, 51008, 51009, 51010, 51011, 51012, 51013); -- Custom IDs
DELETE FROM `gossip_menu` WHERE `MenuID` IN (9046, 9307) AND `TextID` IN (12226, 12304, 12305, 12306);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
-- Exarch Nasuun
(9046,  12226), -- Portal progress
(51000, 12300), -- Armory progress
(51001, 12301), -- Anvil progress
(51002, 12302), -- Harbor progress
(51003, 12303), -- Alchemy lab progress
(9307,  12304), -- Agamath gate progress
(9307,  12305), -- Rohendor gate progress
(9307,  12306), -- Archonisus gate progress
-- Vindicator Moorba
(51004, 12602), -- Agamath gate progress
(51004, 12603), -- Rohendor gate progress
(51004, 12605), -- Archonisus gate progress
-- Vindicator Xayann
(51005, 12240), -- Sanctum progress
-- Captain Theris Dawnheart
(51006, 12260), -- Sanctum progress
-- Harbinger Inuuro
(51007, 12255), -- Armory progress
-- Battlemage Arynna
(51008, 12257), -- Armory progress
-- Magister Ilastar
(51009, 12339), -- Harbor progress
-- Vindicator Kaalan
(51010, 12319), -- Harbor progress
-- Smith Hauthaa
(51011, 12285), -- Anvil progress
-- Mar'nah
(51012, 12238), -- Alchemy lab progress
-- Anchorite Ayuri
(51013, 12322); -- Monument progress

DELETE FROM `npc_text` WHERE `ID` IN (12306, 12602, 12603, 12605);
INSERT INTO `npc_text` (`ID`, `text0_0`, `text0_1`, `BroadcastTextID0`, `lang0`, `Probability0`, `em0_0`, `em0_1`, `em0_2`, `em0_3`, `em0_4`, `em0_5`, `text1_0`, `text1_1`, `BroadcastTextID1`, `lang1`, `Probability1`, `em1_0`, `em1_1`, `em1_2`, `em1_3`, `em1_4`, `em1_5`, `text2_0`, `text2_1`, `BroadcastTextID2`, `lang2`, `Probability2`, `em2_0`, `em2_1`, `em2_2`, `em2_3`, `em2_4`, `em2_5`, `text3_0`, `text3_1`, `BroadcastTextID3`, `lang3`, `Probability3`, `em3_0`, `em3_1`, `em3_2`, `em3_3`, `em3_4`, `em3_5`, `text4_0`, `text4_1`, `BroadcastTextID4`, `lang4`, `Probability4`, `em4_0`, `em4_1`, `em4_2`, `em4_3`, `em4_4`, `em4_5`, `text5_0`, `text5_1`, `BroadcastTextID5`, `lang5`, `Probability5`, `em5_0`, `em5_1`, `em5_2`, `em5_3`, `em5_4`, `em5_5`, `text6_0`, `text6_1`, `BroadcastTextID6`, `lang6`, `Probability6`, `em6_0`, `em6_1`, `em6_2`, `em6_3`, `em6_4`, `em6_5`, `text7_0`, `text7_1`, `BroadcastTextID7`, `lang7`, `Probability7`, `em7_0`, `em7_1`, `em7_2`, `em7_3`, `em7_4`, `em7_5`, `VerifiedBuild`) VALUES
(12602, 'All three barriers are fully operational. Consult with Archmage Ne''thul in Sun''s Reach Harbor to aid the effort in unlocking the gates.',                                                                        '', 25535, 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(12603, 'Agamath, the First Gate has been breached. Two of Kil''jaeden''s most powerful lieutenants, Lady Sacrolash and Grand Warlock Alythess, are now vulnerable to attack.',                                             '', 25534, 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(12605, 'Agamath, the First Gate and Rohendor, the Second Gate are now destroyed. Only Archonisus, the Third Gate remains.',                                                                                                '', 25536, 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(12306, 'Rohendor, the Second Gate has been brought down, but the last of the Sunwell Plateau''s magical barriers, Archonisus, resists us, $n.$B$BMaintain your efforts to assist at the Sunwell in any way that you can.', '', 24234, 0, 1, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, '', '', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

DELETE FROM `gossip_menu_option` WHERE `MenuID` IN (51000, 51001, 51002, 51003);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(51000, 0, 0, 'I have something else to ask you about.', 24226, 1, 1, 9046, 0, 0, 0, '', 0, 0),
(51001, 0, 0, 'I have something else to ask you about.', 24226, 1, 1, 9046, 0, 0, 0, '', 0, 0),
(51002, 0, 0, 'I have something else to ask you about.', 24226, 1, 1, 9046, 0, 0, 0, '', 0, 0),
(51003, 0, 0, 'I have something else to ask you about.', 24226, 1, 1, 9046, 0, 0, 0, '', 0, 0);

DELETE FROM `gossip_menu_option` WHERE `MenuID` = 9046 AND `OptionID` IN (0, 1, 2, 3);
INSERT INTO `gossip_menu_option` (`MenuID`, `OptionID`, `OptionIcon`, `OptionText`, `OptionBroadcastTextID`, `OptionType`, `OptionNpcFlag`, `ActionMenuID`, `ActionPoiID`, `BoxCoded`, `BoxMoney`, `BoxText`, `BoxBroadcastTextID`, `VerifiedBuild`) VALUES
(9046, 0, 0, 'What news of the fight to take the Sun''s Reach Armory?',                               24222, 1, 1, 51000, 0, 0, 0, '', 0, 0),
(9046, 1, 0, 'How close are we to the completion of the anvil and forge at the Sun''s Reach Armory?', 24224, 1, 1, 51002, 0, 0, 0, '', 0, 0),
(9046, 2, 0, 'Exarch, have we taken the Sun''s Reach Harbor yet?',                                    24227, 1, 1, 51001, 0, 0, 0, '', 0, 0),
(9046, 3, 0, 'Nasuun, do you know how long until we have an alchemy lab at the Sun''s Reach Harbor?', 24229, 1, 1, 51003, 0, 0, 0, '', 0, 0);

DELETE FROM `creature_questender` WHERE `quest` IN (11496, 11513, 11517, 11520, 11524, 11532, 11535, 11538, 11539, 11542, 11545);
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(24965, 11524), -- Erratic Behavior
(24967, 11496), -- The Sanctum Wards
(25061, 11538), -- The Battle for the Sun's Reach Armory
(25057, 11532), -- Distraction at the Dead Scar
-- No portal
(24932, 11517), -- Report to Nasuun
(24932, 11513), -- Intercepting the Mana Cells
(25108, 11542), -- Intercept the Reinforcements
(25069, 11539), -- Taking the Harbor
(25046, 11535), -- Making Ready
(24975, 11520), -- Discovering Your Roots
(25112, 11545); -- A Charitable Donation

DELETE FROM `conditions` WHERE `ConditionTypeOrReference` = 12 AND `ConditionValue1` IN (@sunsreachpone, @sunsreachptwoonly, @sunsreachptwoperm, @sunsreachnoportal, @sunsreachportal, @sunsreachpthreeonly, @sunsreachpthreeperm, @sunsreachnoanvil, @sunsreachanvil, @sunsreachpfour, @sunsreachnomonument, @sunsreachmonument, @sunsreachnolab, @sunsreachlab, @sunsreachkiru, @sunwellnone, @sunwellfirst, @sunwellsecond, @sunwellall);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Vindicator Xayann
(14, 9052, 12240, 0, 0, 12, 0, @sunsreachpone,       0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 1'' is active'),
(14, 9052, 12241, 0, 1, 12, 0, @sunsreachpone,       0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 1'' is not active'),
-- Captain Theris Dawnhearth
(14, 9065, 12260, 0, 0, 12, 0, @sunsreachpone,       0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 1'' is active'),
(14, 9065, 12259, 0, 1, 12, 0, @sunsreachpone,       0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 1'' is not active'),
-- Exarch Nasuun
(14, 9046,  12226, 0, 0, 12, 0, @sunsreachnoportal,   0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Portal'' is active'),
(14, 9046,  12227, 0, 1, 12, 0, @sunsreachnoportal,   0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Portal'' is not active'),
-- Battlemage Arynna
(14, 9064,  12257, 0, 0, 12, 0, @sunsreachptwoonly,   0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 2 Only'' is active'),
(14, 9064,  12258, 0, 1, 12, 0, @sunsreachptwoonly,   0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 2 Only'' is not active'),
-- Harbinger Inuuro
(14, 9063,  12255, 0, 0, 12, 0, @sunsreachptwoonly,   0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 2 Only'' is active'),
(14, 9063,  12256, 0, 1, 12, 0, @sunsreachptwoonly,   0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 2 Only'' is not active'),
--
(14, 51000, 12300, 0, 0, 12, 0, @sunsreachptwoonly,   0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 2 Only'' is active'),
(14, 51001, 12301, 0, 0, 12, 0, @sunsreachnoanvil,    0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Anvil'' is active'),
-- Smith Hauthaa
(14, 9087, 12285, 0, 0, 12, 0, @sunsreachnoanvil,    0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Anvil'' is active'),
(14, 9087, 12286, 0, 1, 12, 0, @sunsreachnoanvil,    0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Anvil'' is not active'),
--
(14, 51002, 12302, 0, 0, 12, 0, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 3 Only'' is active'),
-- Magister Ilastar
(14, 9127, 12339, 0, 0, 12, 0, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 3 Only'' is active'),
(14, 9127, 12340, 0, 1, 12, 0, @sunsreachpthreeonly, 0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 3 Only'' is not active'),
-- Vindicator Kaalan
(14, 9111, 12319, 0, 0, 12, 0, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 3 Only'' is active'),
(14, 9111, 12320, 0, 1, 12, 0, @sunsreachpthreeonly, 0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 3 Only'' is not active'),
--
(14, 51003, 12303, 0, 0, 12, 0, @sunsreachnolab,      0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is active'),
-- Mar'nah <Alchemist>
(14, 9050, 12238, 0, 0, 12, 0, @sunsreachnolab,      0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is active'),
(14, 9050, 12237, 0, 1, 12, 0, @sunsreachnolab,      0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is not active'),
-- Shaani Jewelcrafting Supplies>
(14, 9198, 12496, 0, 0, 12, 0, @sunsreachnolab,      0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is active'),
(14, 9198, 12497, 0, 1, 12, 0, @sunsreachnolab,      0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is not active'),
-- Anchorite Ayuri
(14, 9115, 12322, 0, 0, 12, 0, @sunsreachnomonument, 0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Monument'' is active'),
(14, 9115, 12323, 0, 1, 12, 0, @sunsreachnomonument, 0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Monument'' is not active'),
-- Exarch Nasuun
(15, 9046, 0, 0, 0, 12, 0, @sunsreachptwoonly,   0, 0, 0, 0, 0, '', 'Show gossip option if the event ''Sun''s Reach Reclamation Phase 2 Only'' is active'),
(15, 9046, 1, 0, 0, 12, 0, @sunsreachnoanvil,    0, 0, 0, 0, 0, '', 'Show gossip option if the event ''Sun''s Reach Reclamation Phase No Anvil'' is active'),
(15, 9046, 2, 0, 0, 12, 0, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'Show gossip option if the event ''Sun''s Reach Reclamation Phase 3 Only'' is active'),
(15, 9046, 3, 0, 0, 12, 0, @sunsreachnolab,      0, 0, 0, 0, 0, '', 'Show gossip option if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is active'),
-- Sunwell Gates
(14, 9307, 12304, 0, 0, 12, 0, @sunwellnone,         0, 0, 0, 0, 0, '', 'Show gossip text if the event ''SWP - All Gates Closed'' is active'),
(14, 9307, 12305, 0, 0, 12, 0, @sunwellfirst,        0, 0, 0, 0, 0, '', 'Show gossip text if the event ''SWP - First Gate Open'' is active'),
(14, 9307, 12306, 0, 0, 12, 0, @sunwellsecond,       0, 0, 0, 0, 0, '', 'Show gossip text if the event ''SWP - Second Gate Open'' is active'),
--
(14, 51004, 12602, 0, 0, 12, 0, @sunwellnone,   0, 0, 0, 0, 0, '', 'Show gossip text if the event ''SWP - All Gates Closed'' is active'),
(14, 51004, 12603, 0, 0, 12, 0, @sunwellfirst,  0, 0, 0, 0, 0, '', 'Show gossip text if the event ''SWP - First Gate Open'' is active'),
(14, 51004, 12605, 0, 0, 12, 0, @sunwellsecond, 0, 0, 0, 0, 0, '', 'Show gossip text if the event ''SWP - Second Gate Open'' is active');

-- Staging
-- Captain Theris Dawnhearth
DELETE FROM `gossip_menu` WHERE (`MenuID` = 9065) AND (`TextID` IN (12260));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9065, 12260);
-- Vindicator Xayann
DELETE FROM `gossip_menu` WHERE (`MenuID` = 9052) AND (`TextID` IN (12240));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9052, 12240);

-- Sanctum
-- Battlemage Arynna
DELETE FROM `gossip_menu` WHERE (`MenuID` = 9064) AND (`TextID` IN (12257));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9064, 12257);
-- Harbinger Inuuro
DELETE FROM `gossip_menu` WHERE (`MenuID` = 9063) AND (`TextID` IN (12255));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9063, 12255);

-- Armory
-- Magister Ilastar
DELETE FROM `gossip_menu` WHERE (`MenuID` = 9127) AND (`TextID` IN (12339));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9127, 12339);

-- Anvil subphase
-- Smith Hauthaa
DELETE FROM `gossip_menu` WHERE (`MenuID` = 9087) AND (`TextID` IN (12285));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9087, 12285);

-- Harbor
-- Shaani Jewelcrafting Supplies>
DELETE FROM `gossip_menu` WHERE (`MenuID` = 9198) AND (`TextID` IN (12496));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9198, 12496);
-- Mar'nah <Alchemist>
DELETE FROM `gossip_menu` WHERE (`MenuID` = 9050) AND (`TextID` IN (12238));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9050, 12238);

-- Monument
DELETE FROM `gossip_menu` WHERE (`MenuID` = 9115) AND (`TextID` IN (12322));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9115, 12322);

-- Portal Subphase Shattrath mobs walking to portal, entering and despawning
-- Remove Shattrath - Shattered Sun Marksman that should be spawned by Portal Subphase
DELETE FROM `creature` WHERE (`id1` = 24938) AND (`guid` IN (96656, 96657, 96658));
-- Remove Shattrath - Shattered Sun Warrior that should be spawned by Portal Subphase
DELETE FROM `creature` WHERE (`id1` = 25115) AND (`guid` IN (96593));

-- Anvil vendor
-- Smith Hauthaa
DELETE FROM `npc_vendor` WHERE (`entry` = 25046);
DELETE FROM `game_event_npc_vendor` WHERE (`eventEntry` = @sunsreachanvil) AND `guid` = @cguidsmith;
INSERT INTO `game_event_npc_vendor` (`eventEntry`, `guid`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES
(@sunsreachanvil, @cguidsmith, 0, 34887, 0, 0, 2059),
(@sunsreachanvil, @cguidsmith, 0, 34888, 0, 0, 2059),
(@sunsreachanvil, @cguidsmith, 0, 34889, 0, 0, 2059),
(@sunsreachanvil, @cguidsmith, 0, 34890, 0, 0, 2059),
(@sunsreachanvil, @cguidsmith, 0, 34891, 0, 0, 2329),
(@sunsreachanvil, @cguidsmith, 0, 34892, 0, 0, 2329),
(@sunsreachanvil, @cguidsmith, 0, 34893, 0, 0, 2331),
(@sunsreachanvil, @cguidsmith, 0, 34894, 0, 0, 2331),
(@sunsreachanvil, @cguidsmith, 0, 34895, 0, 0, 2329),
(@sunsreachanvil, @cguidsmith, 0, 34896, 0, 0, 2329),
(@sunsreachanvil, @cguidsmith, 0, 34898, 0, 0, 2329),
(@sunsreachanvil, @cguidsmith, 0, 34900, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34901, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34902, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34903, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34904, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34905, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34906, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34910, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34911, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34912, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34914, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34916, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34917, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34918, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34919, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34921, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34922, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34923, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34924, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34925, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34926, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34927, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34928, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34929, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34930, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34931, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34932, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34933, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34934, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34935, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34936, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34937, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34938, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34939, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34940, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34941, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34942, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34943, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34944, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34945, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34946, 0, 0, 2333),
(@sunsreachanvil, @cguidsmith, 0, 34947, 0, 0, 2049),
(@sunsreachanvil, @cguidsmith, 0, 34949, 0, 0, 2332),
(@sunsreachanvil, @cguidsmith, 0, 34950, 0, 0, 2332),
(@sunsreachanvil, @cguidsmith, 0, 34951, 0, 0, 2332),
(@sunsreachanvil, @cguidsmith, 0, 34952, 0, 0, 2332);

-- Mar'nah <Alchemist>
DELETE FROM `npc_vendor` WHERE (`entry` = 24975);
DELETE FROM `game_event_npc_vendor` WHERE (`eventEntry` = @sunsreachlab) AND `guid` = @cguidalch;
INSERT INTO `game_event_npc_vendor` (`eventEntry`, `guid`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES
(@sunsreachlab, @cguidalch, 0, 3371, 0, 0, 0),
(@sunsreachlab, @cguidalch, 0, 3372, 0, 0, 0),
(@sunsreachlab, @cguidalch, 0, 8925, 0, 0, 0),
(@sunsreachlab, @cguidalch, 0, 13467, 3, 9000, 0),
(@sunsreachlab, @cguidalch, 0, 18256, 0, 0, 0),
(@sunsreachlab, @cguidalch, 0, 22785, 3, 9000, 0),
(@sunsreachlab, @cguidalch, 0, 22786, 3, 9000, 0),
(@sunsreachlab, @cguidalch, 0, 22791, 3, 9000, 0),
(@sunsreachlab, @cguidalch, 0, 22793, 1, 9000, 0),
(@sunsreachlab, @cguidalch, 0, 40411, 0, 0, 0);

-- Shaani <Jewelcrafting Supplies>
DELETE FROM `npc_vendor` WHERE (`entry` = 25950);
DELETE FROM `game_event_npc_vendor` WHERE (`eventEntry` = @sunsreachlab) AND `guid` = @cguidjc;
INSERT INTO `game_event_npc_vendor` (`eventEntry`, `guid`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES
(@sunsreachlab, @cguidjc, 0, 32227, 0, 0, 1642),
(@sunsreachlab, @cguidjc, 0, 32228, 0, 0, 1642),
(@sunsreachlab, @cguidjc, 0, 32229, 0, 0, 1642),
(@sunsreachlab, @cguidjc, 0, 32230, 0, 0, 1642),
(@sunsreachlab, @cguidjc, 0, 32231, 0, 0, 1642),
(@sunsreachlab, @cguidjc, 0, 32249, 0, 0, 1642),
(@sunsreachlab, @cguidjc, 0, 35238, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35239, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35240, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35241, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35242, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35243, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35244, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35245, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35246, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35247, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35248, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35249, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35250, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35251, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35252, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35253, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35254, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35255, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35256, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35257, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35258, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35259, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35260, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35261, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35262, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35263, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35264, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35265, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35266, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35267, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35268, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35269, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35270, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35271, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35322, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35323, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35325, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35766, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35767, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35768, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 35769, 0, 0, 0),
(@sunsreachlab, @cguidjc, 0, 37504, 0, 0, 0);

-- Shattered Sun Marksman + Warrior Transform Auras
-- Marksman Transform Auras
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24938) AND (`source_type` = 0) AND (`id` IN (3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24938, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493810, 2493813, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Random Script'),
(24938, 0, 4, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493820, 2493823, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Random Script'),
(24938, 0, 5, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493830, 2493833, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Random Script'),
(24938, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493840, 2493843, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Random Script');
-- Bridge Marksman spawn in Harbor Phase, (hard-coded bunny target GUIDs...)
DELETE FROM `smart_scripts` WHERE (`entryorguid` IN (-65694, -65695, -65696, -65697, -65698, -65699, -65700, -65702)) AND (`source_type` = 0) AND (`id` IN (1, 2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(-65694, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493830, 2493833, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65694, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493840, 2493843, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65695, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493830, 2493833, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65695, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493840, 2493843, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65696, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493830, 2493833, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65696, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493840, 2493843, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65697, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493830, 2493833, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65697, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493840, 2493843, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65698, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493830, 2493833, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65698, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493840, 2493843, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65699, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493830, 2493833, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65699, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493840, 2493843, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65700, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493830, 2493833, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65700, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493840, 2493843, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65702, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493830, 2493833, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script'),
(-65702, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493840, 2493843, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 2493810 AND 2493813);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2493810, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44962, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - BE Male Transform Tier 1'''),
(2493811, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44921, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - BE Female Transform Tier 1'''),
(2493812, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44925, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - Draenei Male Transform Tier 1'''),
(2493813, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44929, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - Draenei Female Transform Tier 1''');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 2493820 AND 2493823);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2493820, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44918, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - BE Male Transform Tier 2'''),
(2493821, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44922, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - BE Female Transform Tier 2'''),
(2493822, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44926, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - Draenei Male Transform Tier 2'''),
(2493823, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44930, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - Draenei Female Transform Tier 2''');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 2493830 AND 2493833);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2493830, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44919, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - BE Male Transform Tier 3'''),
(2493831, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44923, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - BE Female Transform Tier 3'''),
(2493832, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44927, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - Draenei Male Transform Tier 3'''),
(2493833, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44931, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - Draenei Female Transform Tier 3''');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 2493840 AND 2493843);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2493840, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44920, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - BE Male Transform Tier 4'''),
(2493841, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44924, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - BE Female Transform Tier 4'''),
(2493842, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44928, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - Draenei Male Transform Tier 4'''),
(2493843, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 44932, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - Actionlist - Cast ''Serverside - Archer - Draenei Female Transform Tier 4''');

-- Shattered Sun Warrior Transform Auras
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 25115;
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 25115) AND (`source_type` = 0);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(25115, 0, 0, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2511510, 2511513, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - On Respawn - Run Random Script'),
(25115, 0, 1, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2511520, 2511523, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - On Respawn - Run Random Script'),
(25115, 0, 2, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2511530, 2511533, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - On Respawn - Run Random Script'),
(25115, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2511540, 2511543, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - On Respawn - Run Random Script');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 2511510 AND 2511513);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2511510, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45159, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - BE Male Transform Tier 1'''),
(2511511, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45155, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - BE Female Transform Tier 1'''),
(2511512, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45167, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - Draenei Male Transform Tier 1'''),
(2511513, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45163, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - Draenei Female Transform Tier 1''');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 2511520 AND 2511523);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2511520, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45160, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - BE Male Transform Tier 2'''),
(2511521, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45156, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - BE Female Transform Tier 2'''),
(2511522, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45168, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - Draenei Male Transform Tier 2'''),
(2511523, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45164, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - Draenei Female Transform Tier 2''');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 2511530 AND 2511533);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2511530, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45161, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - BE Male Transform Tier 3'''),
(2511531, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45157, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - BE Female Transform Tier 3'''),
(2511532, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45169, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - Draenei Male Transform Tier 3'''),
(2511533, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45165, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - Draenei Female Transform Tier 3''');

DELETE FROM `smart_scripts` WHERE (`source_type` = 9 AND `entryorguid` BETWEEN 2511540 AND 2511543);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(2511540, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45162, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - BE Male Transform Tier 4'''),
(2511541, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45158, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - BE Female Transform Tier 4'''),
(2511542, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45170, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - Draenei Male Transform Tier 4'''),
(2511543, 9, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0, 0, 0, 11, 45166, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Warrior - Actionlist - Cast ''Serverside - Warrior - Draenei Female Transform Tier 4''');

-- Marksman SAI conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` IN (4, 5, 6, 7)) AND (`SourceEntry` = 24938) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Tier 1: !anvil && !p4 (!@sunsreachanvil && !@sunsreachpfour)
(22, 4, 24938, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is not active'),
(22, 4, 24938, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is not active'),
-- Tier 2: p3 only && anvil (@sunsreachpthreeonly && @sunsreachanvil)
(22, 5, 24938, 0, 0, 12, 1, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Three Only'' is active'),
(22, 5, 24938, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is active'),
-- Tier 3: p4 && !anvil (@sunsreachpfour && !@sunsreachanvil)
(22, 6, 24938, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 6, 24938, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is not active'),
-- Tier 4: p4 && anvil (@sunsreachpfour && @sunsreachanvil)
(22, 7, 24938, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 7, 24938, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is active');
-- Bridge Marksman SAI conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` IN (2, 3)) AND (`SourceEntry` IN (-65694, -65695, -65696, -65697, -65698, -65699, -65700, -65702)) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Tier 3: p4 && !anvil (@sunsreachpfour && !@sunsreachanvil)
(22, 2, -65694, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 2, -65694, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is not active'),
-- Tier 4: p4 && anvil (@sunsreachpfour && @sunsreachanvil)
(22, 3, -65694, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 3, -65694, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is active'),
-- Tier 3: p4 && !anvil (@sunsreachpfour && !@sunsreachanvil)
(22, 2, -65695, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 2, -65695, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is not active'),
-- Tier 4: p4 && anvil (@sunsreachpfour && @sunsreachanvil)
(22, 3, -65695, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 3, -65695, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is active'),
-- Tier 3: p4 && !anvil (@sunsreachpfour && !@sunsreachanvil)
(22, 2, -65696, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 2, -65696, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is not active'),
-- Tier 4: p4 && anvil (@sunsreachpfour && @sunsreachanvil)
(22, 3, -65696, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 3, -65696, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is active'),
-- Tier 3: p4 && !anvil (@sunsreachpfour && !@sunsreachanvil)
(22, 2, -65697, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 2, -65697, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is not active'),
-- Tier 4: p4 && anvil (@sunsreachpfour && @sunsreachanvil)
(22, 3, -65697, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 3, -65697, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is active'),
-- Tier 3: p4 && !anvil (@sunsreachpfour && !@sunsreachanvil)
(22, 2, -65698, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 2, -65698, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is not active'),
-- Tier 4: p4 && anvil (@sunsreachpfour && @sunsreachanvil)
(22, 3, -65698, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 3, -65698, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is active'),
-- Tier 3: p4 && !anvil (@sunsreachpfour && !@sunsreachanvil)
(22, 2, -65699, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 2, -65699, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is not active'),
-- Tier 4: p4 && anvil (@sunsreachpfour && @sunsreachanvil)
(22, 3, -65699, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 3, -65699, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is active'),
-- Tier 3: p4 && !anvil (@sunsreachpfour && !@sunsreachanvil)
(22, 2, -65700, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 2, -65700, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is not active'),
-- Tier 4: p4 && anvil (@sunsreachpfour && @sunsreachanvil)
(22, 3, -65700, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 3, -65700, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is active'),
-- Tier 3: p4 && !anvil (@sunsreachpfour && !@sunsreachanvil)
(22, 2, -65702, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 2, -65702, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is not active'),
-- Tier 4: p4 && anvil (@sunsreachpfour && @sunsreachanvil)
(22, 3, -65702, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 3, -65702, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is active');

-- Warrior SAI conditions
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 22) AND (`SourceGroup` IN (1, 2, 3, 4)) AND (`SourceEntry` = 25115) AND (`SourceId` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
-- Tier 1: !anvil && !p4 (!@sunsreachanvil && !@sunsreachpfour)
(22, 1, 25115, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is not active'),
(22, 1, 25115, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is not active'),
-- Tier 2: p3 only && anvil (@sunsreachpthreeonly && @sunsreachanvil)
(22, 2, 25115, 0, 0, 12, 1, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Three Only'' is active'),
(22, 2, 25115, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is active'),
-- Tier 3: p4 && !anvil (@sunsreachpfour && !@sunsreachanvil)
(22, 3, 25115, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 3, 25115, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 1, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is not active'),
-- Tier 4: p4 && anvil (@sunsreachpfour && @sunsreachanvil)
(22, 4, 25115, 0, 0, 12, 1, @sunsreachpfour, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Harbor'' is active'),
(22, 4, 25115, 0, 0, 12, 1, @sunsreachanvil, 0, 0, 0, 0, 0, '', 'if the event ''Sun''s Reach Reclamation Phase Anvil'' is active');

-- Gameobjects
-- Alchemy Lab
DELETE FROM `gameobject` WHERE (`id` = 187115) AND (`guid` IN (@guidalch));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(@guidalch, 187115, 530, 4080, 4087, 1, 1, 12845.603516, -7011.98584, 18.592701, 5.543178, 0, 0, 0, 0, 0, 0, 0, '', 0);
-- Demonic Crystals
DELETE FROM `gameobject` WHERE `id` = 187120 AND `guid` BETWEEN @guidcrystals AND @guidcrystals+4;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `VerifiedBuild`, `Comment`) VALUES
(@guidcrystals+0, 187120, 530, 1, 1, 12685.7998046875, -6925.830078125, 39.61629867553711, 2.4260098934173584, 0.0, 0.0, 0.9366719722747804, 0.3502070009708404, 180, 0, ''),
(@guidcrystals+1, 187120, 530, 1, 1, 12707.7998046875, -6938.7900390625, 40.44039916992188, 1.815140008926392, 0.0, 0.0, 0.7880110144615173, 0.6156619787216187, 180, 0, ''),
(@guidcrystals+2, 187120, 530, 1, 1, 12665.0, -6935.72998046875, 29.555299758911133, -0.5934119820594788, 0.0, 0.0, 0.2923719882965088, -0.9563050270080566, 180, 0, ''),
(@guidcrystals+3, 187120, 530, 1, 1, 12655.7001953125, -6948.68994140625, 38.598098754882805, 2.687809944152832, 0.0, 0.0, 0.974370002746582, 0.2249509990215301, 180, 0, ''),
(@guidcrystals+4, 187120, 530, 1, 1, 12645.2001953125, -6980.97998046875, 40.50529861450195, -1.85004997253418, 0.0, 0.0, 0.0, 0.0, 180, 0, '');

-- Creatures
-- Portal Subphase, Shattrath City, Shattered Sun Warrior and Shattered Sun Marksman
DELETE FROM `creature` WHERE `id1` IN (25115, 24938) AND `guid` BETWEEN @cguidportalshat AND @cguidportalshat+7;
-- spawntimesecs 30-120s, 75s avg
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `MovementType`, `VerifiedBuild`, `Comment`) VALUES
(@cguidportalshat+0, 25115, 530, 1, 1, 1, -1983.31005859375, 5491.89013671875, -12.344799995422363, 0.1725849956274032, 75, 2, 0, ''),
(@cguidportalshat+1, 25115, 530, 1, 1, 1, -1866.1199951171875, 5519.31005859375, -12.344799995422363, 3.35932993888855, 75, 2, 0, ''),
(@cguidportalshat+2, 25115, 530, 1, 1, 1, -1955.0699462890625, 5432.39990234375, -12.344799995422363, 4.982600212097168, 75, 2, 0, ''),
(@cguidportalshat+3, 25115, 530, 1, 1, 1, -1753.5, 5495.75, -12.344799995422363, 3.782819986343384, 75, 2, 0, ''),
(@cguidportalshat+4, 24938, 530, 1, 1, 1, -1941.18994140625, 5486.89990234375, -12.344799995422363, 0.5934119820594788, 75, 2, 0, ''),
(@cguidportalshat+5, 24938, 530, 1, 1, 1, -1958.1099853515625, 5418.16015625, -12.344799995422363, 5.061450004577637, 75, 2, 0, ''),
(@cguidportalshat+6, 24938, 530, 1, 1, 1, -1771.47998046875, 5424.3798828125, -12.344799995422363, 1.7976900339126587, 75, 2, 0, ''),
(@cguidportalshat+7, 24938, 530, 1, 1, 1, -1799.050048828125, 5549.31982421875, -12.344799995422363, 5.026549816131592, 75, 2, 0, '');

DELETE FROM `waypoint_data` WHERE `id` = (@cguidportalshat+0)*10;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`) VALUES
((@cguidportalshat+0)*10, 1, -1983.33, 5492.03, -12.4281, 0.0, 250, 1, 0),
((@cguidportalshat+0)*10, 2, -1941.97, 5499.10, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+0)*10, 3, -1905.15, 5501.05, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+0)*10, 4, -1875.16, 5471.33, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+0)*10, 5, -1853.28, 5475.17, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+0)*10, 6, -1847.65, 5493.82, -12.4545, 0.0, 0, 1, 0),
((@cguidportalshat+0)*10, 7, -1841.89, 5499.54, -12.4281, 1.23, 5000, 1, @cguidportalshat*10);

DELETE FROM `waypoint_data` WHERE `id` = (@cguidportalshat+1)*10;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`) VALUES
((@cguidportalshat+1)*10, 1, -1866.18, 5519.39, -12.4281, 0.0, 250, 1, 0),
((@cguidportalshat+1)*10, 2, -1889.29, 5514.19, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+1)*10, 3, -1897.09, 5497.14, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+1)*10, 4, -1876.34, 5471.40, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+1)*10, 5, -1856.19, 5471.47, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+1)*10, 6, -1845.27, 5496.98, -12.4569, 0.0, 0, 1, 0),
((@cguidportalshat+1)*10, 7, -1840.91, 5499.92, -12.4280, 1.23, 5000, 1, @cguidportalshat*10);

DELETE FROM `waypoint_data` WHERE `id` = (@cguidportalshat+2)*10;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`) VALUES
((@cguidportalshat+2)*10, 1, -1954.96, 5432.12, -12.4281, 0.0, 250, 1, 0),
((@cguidportalshat+2)*10, 2, -1947.68, 5405.70, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+2)*10, 3, -1928.35, 5396.70, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+2)*10, 4, -1892.14, 5430.80, -12.4282, 0.0, 0, 1, 0),
((@cguidportalshat+2)*10, 5, -1865.26, 5463.53, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+2)*10, 6, -1841.39, 5493.11, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+2)*10, 7, -1840.05, 5499.26, -12.4280, 1.23, 5000, 1, @cguidportalshat*10);

DELETE FROM `waypoint_data` WHERE `id` = (@cguidportalshat+3)*10;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`) VALUES
((@cguidportalshat+3)*10, 1, -1753.56, 5495.54, -12.4281, 0.0, 250, 1, 0),
((@cguidportalshat+3)*10, 2, -1791.01, 5467.76, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+3)*10, 3, -1825.64, 5453.07, -12.4282, 0.0, 0, 1, 0),
((@cguidportalshat+3)*10, 4, -1844.89, 5473.19, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+3)*10, 5, -1840.24, 5498.82, -12.4281, 1.23, 5000, 1, @cguidportalshat*10);

DELETE FROM `waypoint_data` WHERE `id` = (@cguidportalshat+4)*10;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`) VALUES
((@cguidportalshat+4)*10, 1, -1941.15, 5487.12, -12.42811, 0.0, 250, 1, 0),
((@cguidportalshat+4)*10, 2, -1914.21, 5504.99, -12.42810, 0.0, 0, 1, 0),
((@cguidportalshat+4)*10, 3, -1896.75, 5495.92, -12.42810, 0.0, 0, 1, 0),
((@cguidportalshat+4)*10, 4, -1879.80, 5472.28, -12.42810, 0.0, 0, 1, 0),
((@cguidportalshat+4)*10, 5, -1853.05, 5469.34, -12.42811, 0.0, 0, 1, 0),
((@cguidportalshat+4)*10, 6, -1839.51, 5498.56, -12.42811, 0.0, 0, 1, 0),
((@cguidportalshat+4)*10, 7, -1839.51, 5498.56, -12.42810, 1.23, 5000, 1, @cguidportalshat*10);

DELETE FROM `waypoint_data` WHERE `id` = (@cguidportalshat+5)*10;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`) VALUES
((@cguidportalshat+5)*10, 1, -1958.15, 5418.13, -12.4281, 0.0, 250, 1, 0),
((@cguidportalshat+5)*10, 2, -1937.75, 5396.30, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+5)*10, 3, -1903.02, 5412.98, -12.4282, 0.0, 0, 1, 0),
((@cguidportalshat+5)*10, 4, -1885.32, 5439.74, -12.4281,0.0, 0, 1, 0),
((@cguidportalshat+5)*10, 5, -1856.43, 5471.17, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+5)*10, 6, -1848.19, 5493.08, -12.4475, 0.0, 0, 1, 0),
((@cguidportalshat+5)*10, 7, -1841.45, 5499.37, -12.4281, 1.23, 5000, 1, @cguidportalshat*10);

DELETE FROM `waypoint_data` WHERE `id` = (@cguidportalshat+6)*10;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`) VALUES
((@cguidportalshat+6)*10, 1, -1771.40, 5424.44, -12.4281, 0.0, 250, 1, 0),
((@cguidportalshat+6)*10, 2, -1780.13, 5458.50, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+6)*10, 3, -1802.26, 5461.31, -12.4281, 0.0, 0, 1, 0),
((@cguidportalshat+6)*10, 4, -1826.47, 5454.01, -12.4283, 0.0, 0, 1, 0),
((@cguidportalshat+6)*10, 5, -1844.75, 5471.00, -12.4282, 0.0, 0, 1, 0),
((@cguidportalshat+6)*10, 6, -1840.07, 5498.43, -12.4281, 1.23, 5000, 1, @cguidportalshat*10);

DELETE FROM `waypoint_data` WHERE `id` = (@cguidportalshat+7)*10;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`) VALUES
((@cguidportalshat+7)*10, 1, -1799.13, 5549.21,0 -12.42810, 0.0, 250, 1, 0),
((@cguidportalshat+7)*10, 2, -1786.30, 5503.25,0 -12.42810, 0.0, 0, 1, 0),
((@cguidportalshat+7)*10, 3, -1788.18, 5469.74,0 -12.42811, 0.0, 0, 1, 0),
((@cguidportalshat+7)*10, 4, -1822.23, 5450.82,0 -12.42813, 0.0, 0, 1, 0),
((@cguidportalshat+7)*10, 5, -1844.87, 5471.94,0 -12.42820, 0.0, 0, 1, 0),
((@cguidportalshat+7)*10, 6, -1840.02, 5499.12,0 -12.42810, 1.23, 5000, 1, @cguidportalshat*10);

DELETE FROM `waypoint_scripts` WHERE `id` = @cguidportalshat*10 AND `guid` BETWEEN (@cguidportalshat*10) AND (@cguidportalshat*10)+2;
INSERT INTO `waypoint_scripts` (`id`, `delay`, `command`, `datalong`, `datalong2`, `dataint`, `x`, `y`, `z`, `o`, `guid`) VALUES
(@cguidportalshat*10, 0, 15, 34427, 1, 0, 0.0, 0.0, 0.0, 0.0, (@cguidportalshat*10)+0),
(@cguidportalshat*10, 0, 1, 66, 0, 0, 0.0, 0.0, 0.0, 0.0, (@cguidportalshat*10)+1),
(@cguidportalshat*10, 0, 18, 1000, 0, 0, 0.0, 0.0, 0.0, 0.0, (@cguidportalshat*10)+2);

-- Set `path_id` for the above creatures
DELETE FROM `creature_addon` WHERE `guid` BETWEEN @cguidportalshat AND @cguidportalshat+7;
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(@cguidportalshat+0, (@cguidportalshat+0)*10, 0, 0, 0, 45, 0, NULL),
(@cguidportalshat+1, (@cguidportalshat+1)*10, 0, 0, 0, 45, 0, NULL),
(@cguidportalshat+2, (@cguidportalshat+2)*10, 0, 0, 0, 45, 0, NULL),
(@cguidportalshat+3, (@cguidportalshat+3)*10, 0, 0, 0, 45, 0, NULL),
(@cguidportalshat+4, (@cguidportalshat+4)*10, 0, 0, 0, 45, 0, NULL),
(@cguidportalshat+5, (@cguidportalshat+5)*10, 0, 0, 0, 45, 0, NULL),
(@cguidportalshat+6, (@cguidportalshat+6)*10, 0, 0, 0, 45, 0, NULL),
(@cguidportalshat+7, (@cguidportalshat+7)*10, 0, 0, 0, 45, 0, NULL);

-- Portal Subphase, Isle of Quel'Danas
DELETE FROM `creature` WHERE `id1` = 24936 AND `guid` BETWEEN @cguidportalisle AND @cguidportalisle+9;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `MovementType`, `VerifiedBuild`, `Comment`) VALUES
(@cguidportalisle+0, 24936, 530, 1, 1, -1842.9300537109373, 5509.740234375, -12.184900283813477, 5.039340019226073, 300, 0, 0, ''),
(@cguidportalisle+1, 24936, 530, 1, 1, -1841.0500488281248, 5510.43994140625, -10.386300086975098, 4.83420991897583, 300, 0, 0, ''),
(@cguidportalisle+2, 24936, 530, 1, 1, -1833.4599609375, 5507.990234375, -11.58769989013672, 3.994129896163941, 300, 0, 0, ''),
(@cguidportalisle+3, 24936, 530, 1, 1, -1833.1500244140625, 5507.06005859375, -12.136099815368652, 3.902909994125366, 300, 0, 0, ''),
(@cguidportalisle+4, 24936, 530, 1, 1, -1839.1700439453125, 5510.02978515625, -12.219599723815918, 4.6390299797058105, 300, 0, 0, ''),
(@cguidportalisle+5, 24936, 530, 1, 1, -1835.4100341796875, 5507.0400390625, -12.114999771118164, 4.103789806365967, 300, 0, 0, ''),
(@cguidportalisle+6, 24936, 530, 1, 1, -1841.6999511718752, 5510.3798828125, -11.60849952697754, 4.900139808654785, 300, 0, 0, ''),
(@cguidportalisle+7, 24936, 530, 1, 1, -1834.4000244140625, 5507.919921875, -10.934700012207031, 4.06702995300293, 300, 0, 0, ''),
(@cguidportalisle+8, 24936, 530, 1, 1, -1840.27001953125, 5509.81005859375, -11.740400314331056, 4.758059978485107, 300, 0, 0, ''),
(@cguidportalisle+9, 24936, 530, 1, 1, -1832.4599609375, 5506.02001953125, -12.198599815368652, 3.76786994934082, 300, 0, 0, '');

-- Dawnblade Blood Knight
DELETE FROM `creature` WHERE `id1` = 24976 AND `guid` BETWEEN @cguidbloodknights AND @cguidbloodknights+22;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`, `Comment`) VALUES
(@cguidbloodknights+00, 24976, 530, 1, 1, 1, 12873.400390625, -6957.669921875, 3.931679964065552, 1.5707999467849731, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+01, 24976, 530, 1, 1, 1, 12874.599609375, -6958.58984375, 3.9531400203704834, 0.5235990285873413, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+02, 24976, 530, 1, 1, 1, 12845.599609375, -7014.43017578125, 71.28970336914062, 0.6806780099868774, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+03, 24976, 530, 1, 1, 1, 12826.599609375, -7030.5498046875, 71.57510375976561, 1.9024100303649905, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+04, 24976, 530, 1, 1, 1, 12833.400390625, -6993.60986328125, 71.206298828125, 1.7278800010681152, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+05, 24976, 530, 1, 1, 1, 12817.7998046875, -6999.2900390625, 71.34230041503906, -2.7931900024414062, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+06, 24976, 530, 1, 1, 1, 12850.7998046875, -7035.56005859375, 47.862499237060554, 2.932149887084961, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+07, 24976, 530, 1, 1, 1, 12852.2998046875, -7051.7099609375, 19.04030036926269, 2.0726099014282227, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+08, 24976, 530, 1, 1, 1, 12846.599609375, -7008.5400390625, 18.5935001373291, 3.0896999835968018, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+09, 24976, 530, 1, 1, 1, 12811.5, -6989.0400390625, 18.721200942993164, 2.6005399227142334, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+10, 24976, 530, 1, 1, 1, 12801.7001953125, -6997.02978515625, 18.71999931335449, 2.007129907608032, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+11, 24976, 530, 1, 1, 1, 12869.5, -7019.9599609375, 3.2795801162719727, 5.4698500633239755, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+12, 24976, 530, 1, 1, 1, 12871.2998046875, -7022.18994140625, 3.2777199745178223, 5.5664801597595215, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+13, 24976, 530, 1, 1, 1, 12872.0, -7018.4599609375, 3.274280071258545, 6.139150142669679, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+14, 24976, 530, 1, 1, 1, 12837.900390625, -7049.5400390625, 3.3980100154876713, 5.550149917602539, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+15, 24976, 530, 1, 1, 1, 12748.5, -7066.2998046875, 7.478529930114745, 6.09119987487793, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+16, 24976, 530, 1, 1, 1, 12887.2998046875, -6924.3701171875, 3.8923499584198, 0.1548810005187988, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+17, 24976, 530, 1, 1, 1, 12869.5, -6986.85009765625, 3.2696700096130367, 1.5028200149536133, 300, 0.0, 0, 0, ''),
(@cguidbloodknights+18, 24976, 530, 1, 1, 1, 12756.2001953125, -7139.580078125, 3.462500095367432, 2.255970001220703, 300, 3.0, 1, 0, ''),
(@cguidbloodknights+19, 24976, 530, 1, 1, 1, 12787.099609375, -7032.419921875, 11.81439971923828, 0.1741870045661926, 300, 5.0, 1, 0, ''),
(@cguidbloodknights+20, 24976, 530, 1, 1, 1, 12736.7998046875, -6890.7998046875, 12.408699989318848, 5.4163498878479, 300, 5.0, 1, 0, ''),
(@cguidbloodknights+21, 24976, 530, 1, 1, 1, 12755.900390625, -6937.7099609375, 12.485600471496582, 3.4923501014709477, 300, 5.0, 1, 0, ''),
(@cguidbloodknights+22, 24976, 530, 1, 1, 1, 12821.900390625, -6919.1298828125, 11.729999542236328, 1.271530032157898, 300, 5.0, 1, 0, '');

-- Dawnblade Summoner, Dawnblade Marksman
DELETE FROM `creature` WHERE `id1` IN (24978, 24979) AND `guid` BETWEEN @cguidsummonermarksman AND @cguidsummonermarksman+60;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `equipment_id`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`, `Comment`) VALUES
(@cguidsummonermarksman+00, 24978, 530, 1, 1, 1, 12798.2998046875, -6996.10009765625, 47.56069946289063, 1.2217299938201904, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+01, 24978, 530, 1, 1, 1, 12820.2001953125, -7040.509765625, 18.676000595092773, 2.164210081100464, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+02, 24978, 530, 1, 1, 1, 12845.7998046875, -7007.8701171875, 47.51129913330078, 2.909019947052002, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+03, 24978, 530, 1, 1, 1, 12858.400390625, -7044.52978515625, 19.007099151611328, 1.9688700437545776, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+04, 24978, 530, 1, 1, 1, 12834.599609375, -6994.66015625, 18.762199401855472, 3.525520086288452, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+05, 24978, 530, 1, 1, 1, 12810.5, -7055.56005859375, 3.0357499122619633, 5.900400161743164, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+06, 24978, 530, 1, 1, 1, 12834.400390625, -7066.47021484375, 3.369379997253418, 1.3788100481033323, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+07, 24978, 530, 1, 1, 1, 12853.900390625, -6976.75, 5.031179904937744, 5.301620006561279, 300, 3.0, 1, 0, ''),
(@cguidsummonermarksman+08, 24978, 530, 1, 1, 1, 12754.2001953125, -7103.52978515625, 6.988080024719238, 1.578089952468872, 300, 3.0, 1, 0, ''),
(@cguidsummonermarksman+09, 24978, 530, 1, 1, 1, 12757.400390625, -7029.89990234375, 9.374119758605955, 5.8371901512146, 300, 5.0, 1, 0, ''),
(@cguidsummonermarksman+10, 24978, 530, 1, 1, 1, 12745.099609375, -6984.7001953125, 19.198400497436523, 2.3560900688171387, 300, 3.0, 1, 0, ''),
(@cguidsummonermarksman+11, 24978, 530, 1, 1, 1, 12778.2998046875, -7005.10986328125, 13.887200355529783, 1.0297399759292605, 300, 3.0, 1, 0, ''),
(@cguidsummonermarksman+12, 24978, 530, 1, 1, 1, 12760.099609375, -6993.27978515625, 11.464699745178224, 0.3670099973678589, 300, 3.0, 1, 0, ''),
(@cguidsummonermarksman+13, 24978, 530, 1, 1, 1, 12764.099609375, -6920.009765625, 12.275699615478516, -2.9297499656677246, 300, 3.0, 1, 0, ''),
(@cguidsummonermarksman+14, 24978, 530, 1, 1, 1, 12837.7998046875, -6943.52978515625, 7.168889999389648, 1.9164899587631223, 300, 3.0, 1, 0, ''),
(@cguidsummonermarksman+15, 24978, 530, 1, 1, 1, 12881.900390625, -6932.259765625, 3.9561200141906734, 1.015720009803772, 300, 3.0, 1, 0, ''),
(@cguidsummonermarksman+33, 24979, 530, 1, 1, 1, 12780.2001953125, -7133.77001953125, 9.23165035247803, 1.81046998500824, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+34, 24979, 530, 1, 1, 1, 12806.2998046875, -7089.10009765625, 8.221309661865234, -1.0778800249099731, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+35, 24979, 530, 1, 1, 1, 12848.7001953125, -7128.97998046875, 6.870110034942627, 2.702569961547852, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+36, 24979, 530, 1, 1, 1, 12828.2998046875, -7118.52001953125, 5.363649845123291, 4.1189799308776855, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+37, 24979, 530, 1, 1, 1, 12793.2998046875, -7121.31005859375, 5.416520118713379, 5.479209899902344, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+38, 24979, 530, 1, 1, 1, 12800.400390625, -6980.72021484375, 47.661598205566406, 5.375609874725343, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+39, 24979, 530, 1, 1, 1, 12843.5, -7041.06005859375, 47.91299819946289, 0.1919859945774078, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+40, 24979, 530, 1, 1, 1, 12809.2998046875, -7004.2998046875, 70.59559631347656, 4.712389945983888, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+41, 24979, 530, 1, 1, 1, 12841.7998046875, -7001.31982421875, 71.206298828125, 0.5759590268135071, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+42, 24979, 530, 1, 1, 1, 12879.900390625, -6997.669921875, 3.0978500843048096, 0.0349065996706485, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+43, 24979, 530, 1, 1, 1, 12877.7998046875, -7028.16015625, 3.275310039520264, 5.6374101638793945, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+44, 24979, 530, 1, 1, 1, 12807.2998046875, -7028.919921875, 18.69499969482422, 0.8552110195159912, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+45, 24979, 530, 1, 1, 1, 12787.099609375, -6955.93994140625, 13.763099670410156, 2.007129907608032, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+46, 24979, 530, 1, 1, 1, 12898.599609375, -6956.919921875, 3.3791999816894527, 0.7504919767379761, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+47, 24979, 530, 1, 1, 1, 12885.7001953125, -6938.580078125, 3.899499893188477, 0.2443459928035736, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+48, 24979, 530, 1, 1, 1, 12668.5, -6860.10009765625, 13.115699768066406, 2.932149887084961, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+49, 24979, 530, 1, 1, 1, 12657.400390625, -6820.08984375, 12.552800178527832, 0.4712390005588531, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+50, 24979, 530, 1, 1, 1, 12646.400390625, -6830.10986328125, 12.41569995880127, 5.113810062408447, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+51, 24979, 530, 1, 1, 1, 12689.7998046875, -6848.2001953125, 13.33329963684082, 0.2967059910297394, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+52, 24979, 530, 1, 1, 1, 12703.2001953125, -6868.35986328125, 12.553899765014648, 5.3581600189208975, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+53, 24979, 530, 1, 1, 1, 12692.7001953125, -6878.35009765625, 12.4197998046875, 5.550149917602539, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+54, 24979, 530, 1, 1, 1, 12794.900390625, -7012.02001953125, 18.750099182128903, 2.268929958343506, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+55, 24979, 530, 1, 1, 1, 12826.099609375, -6984.009765625, 18.64080047607422, 1.924110054969788, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+56, 24979, 530, 1, 1, 1, 12765.2998046875, -6897.490234375, 13.382100105285645, 3.7815499305725098, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+57, 24979, 530, 1, 1, 1, 12769.2001953125, -6902.72998046875, 13.392399787902832, -2.02396011352539, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+58, 24979, 530, 1, 1, 1, 12775.7998046875, -6970.490234375, 14.151200294494627, 2.1118500232696533, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+59, 24979, 530, 1, 1, 1, 12852.599609375, -6911.85009765625, 8.594349861145021, 0.2445050030946731, 300, 0.0, 0, 0, ''),
(@cguidsummonermarksman+60, 24979, 530, 1, 1, 1, 12865.099609375, -7039.6298828125, 3.2777299880981445, 3.875829935073853, 300, 0.0, 0, 0, '');

-- Irespeaker
DELETE FROM `creature` WHERE `id1` = 24999 AND `guid` BETWEEN @cguidirespeaker AND @cguidirespeaker+5;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`, `Comment`) VALUES
(@cguidirespeaker+0, 24999, 530, 1, 1, 12702.7001953125, -6942.97021484375, 36.3202018737793, 0.4014259874820709, 300, 0.0, 0, 0, ''),
(@cguidirespeaker+1, 24999, 530, 1, 1, 12684.599609375, -6933.43994140625, 36.32070159912109, 1.6231600046157837, 300, 0.0, 0, 0, ''),
(@cguidirespeaker+2, 24999, 530, 1, 1, 12655.400390625, -6976.35986328125, 36.316699981689446, 3.4033899307250977, 300, 0.0, 0, 0, ''),
(@cguidirespeaker+3, 24999, 530, 1, 1, 12660.0, -6950.81982421875, 36.32229995727539, 3.0543301105499268, 300, 0.0, 0, 0, ''),
(@cguidirespeaker+4, 24999, 530, 1, 1, 12670.7001953125, -6940.8798828125, 23.57360076904297, 1.745329976081848, 300, 0.0, 0, 0, ''),
(@cguidirespeaker+5, 24999, 530, 1, 1, 12684.0, -6957.1201171875, 15.554200172424316, 0.63127201795578, 300, 0.0, 0, 0, '');

-- Abyssal Flamewalker, Unleashed Hellion
DELETE FROM `creature` WHERE `id1` IN (25001, 25002) AND `guid` BETWEEN @cguidflamewalkerhellion AND @cguidflamewalkerhellion+30;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`, `Comment`) VALUES
(@cguidflamewalkerhellion+00, 25001, 530, 1, 1, 12692.0, -7107.39990234375, 19.421600341796875, 6.03203010559082, 300, 8.0, 1, 0, ''),
(@cguidflamewalkerhellion+01, 25001, 530, 1, 1, 12663.7001953125, -7082.509765625, 19.48740005493164, 4.04925012588501, 300, 8.0, 1, 0, ''),
(@cguidflamewalkerhellion+02, 25001, 530, 1, 1, 12641.0, -7043.39013671875, 19.326499938964844, 0.1822019964456558, 300, 8.0, 1, 0, ''),
(@cguidflamewalkerhellion+03, 25001, 530, 1, 1, 12728.2001953125, -6945.3798828125, 14.332799911499023, 1.623579978942871, 300, 0.0, 2, 0, ''),
(@cguidflamewalkerhellion+04, 25001, 530, 1, 1, 12657.0, -6979.91015625, 14.657400131225586, 4.1078500747680655, 300, 8.0, 1, 0, ''),
(@cguidflamewalkerhellion+05, 25001, 530, 1, 1, 12703.900390625, -6920.830078125, 13.740599632263184, 0.8711439967155457, 300, 8.0, 1, 0, ''),
(@cguidflamewalkerhellion+06, 25001, 530, 1, 1, 12696.0, -7010.14013671875, 21.250799179077152, 1.210919976234436, 300, 8.0, 1, 0, ''),
(@cguidflamewalkerhellion+07, 25001, 530, 1, 1, 12606.099609375, -6987.64990234375, 17.03179931640625, 5.598269939422607, 300, 8.0, 1, 0, ''),
(@cguidflamewalkerhellion+08, 25001, 530, 1, 1, 12636.7001953125, -7014.68017578125, 20.319900512695312, 2.3435299396514893, 300, 8.0, 1, 0, ''),
(@cguidflamewalkerhellion+20, 25002, 530, 1, 1, 12702.0, -6950.81005859375, 15.645500183105469, 0.663224995136261, 300, 0.0, 0, 0, ''),
(@cguidflamewalkerhellion+21, 25002, 530, 1, 1, 12696.2001953125, -6942.97998046875, 15.641799926757812, 0.5235990285873413, 300, 0.0, 0, 0, ''),
(@cguidflamewalkerhellion+22, 25002, 530, 1, 1, 12701.099609375, -6983.31005859375, 25.60110092163086, 6.117310047149657, 300, 0.0, 0, 0, ''),
(@cguidflamewalkerhellion+23, 25002, 530, 1, 1, 12683.2001953125, -6957.72021484375, 36.25310134887695, 3.7768199443817134, 300, 0.0, 0, 0, ''),
(@cguidflamewalkerhellion+24, 25002, 530, 1, 1, 12673.099609375, -6943.68994140625, 36.338600158691406, 5.46288013458252, 300, 0.0, 0, 0, ''),
(@cguidflamewalkerhellion+25, 25002, 530, 1, 1, 12704.0, -6972.18017578125, 36.23080062866211, 0.3528819978237152, 300, 0.0, 0, 0, ''),
(@cguidflamewalkerhellion+26, 25002, 530, 1, 1, 12689.7998046875, -6983.56005859375, 15.571100234985352, 5.247819900512695, 300, 3.0, 1, 0, ''),
(@cguidflamewalkerhellion+27, 25002, 530, 1, 1, 12657.7001953125, -7019.89990234375, 21.81920051574707, 2.5725700855255127, 300, 3.0, 1, 0, ''),
(@cguidflamewalkerhellion+28, 25002, 530, 1, 1, 12612.900390625, -7022.419921875, 18.695499420166016, 1.23540997505188, 300, 5.0, 1, 0, ''),
(@cguidflamewalkerhellion+30, 25002, 530, 1, 1, 12652.2998046875, -7074.39013671875, 18.13419914245605, 5.452239990234375, 300, 5.0, 1, 0, '');

-- Invisible Stalker Floating -> Fel Crystal Spell target
DELETE FROM `creature` WHERE `id1` = 25953 AND `guid` BETWEEN @cguidfelcrystalspelltarget AND @cguidfelcrystalspelltarget+4;
INSERT INTO `creature` (`guid`, `id1`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `spawntimesecs`, `wander_distance`, `MovementType`, `VerifiedBuild`, `Comment`) VALUES
(@cguidfelcrystalspelltarget+0, 25953, 530, 1, 1, 12707.900390625, -6938.85009765625, 39.885299682617195, 6.24828004837036, 300, 0.0, 0, 0, ''),
(@cguidfelcrystalspelltarget+1, 25953, 530, 1, 1, 12685.900390625, -6925.9501953125, 39.12950134277344, 3.4906599521636963, 300, 0.0, 0, 0, ''),
(@cguidfelcrystalspelltarget+2, 25953, 530, 1, 1, 12665.0, -6935.7099609375, 28.988800048828125, 5.5326900482177725, 300, 0.0, 0, 0, ''),
(@cguidfelcrystalspelltarget+3, 25953, 530, 1, 1, 12655.599609375, -6948.64990234375, 38.00170135498047, 1.518440008163452, 300, 0.0, 0, 0, ''),
(@cguidfelcrystalspelltarget+4, 25953, 530, 1, 1, 12645.099609375, -6981.1298828125, 39.86289978027344, 2.2863800525665283, 300, 0.0, 0, 0, '');

-- Abyssal Flamewalker
DELETE FROM `creature_addon` WHERE (`guid` = 5300476);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `visibilityDistanceType`, `auras`) VALUES
(5300476, 53004760, 0, 0, 1, 0, 0, '');
DELETE FROM `waypoint_data` WHERE `id` = 53004760;
INSERT INTO `waypoint_data` (`id`, `point`, `position_x`, `position_y`, `position_z`, `orientation`, `delay`, `move_type`, `action`, `action_chance`, `wpguid`) VALUES
(53004760, 1, 12728.2, -6945.38, 14.3328, NULL, 0, 0, 0, 100, 0),
(53004760, 2, 12728.0, -6963.33, 17.2544, NULL, 0, 0, 0, 100, 0),
(53004760, 3, 12723.1, -6977.58, 18.9559, NULL, 0, 0, 0, 100, 0),
(53004760, 4, 12728.0, -6963.33, 17.2544, NULL, 0, 0, 0, 100, 0);

-- Fix Dawnblade Marksman not showing bow
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24979) AND (`source_type` = 0) AND (`id` IN (2));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24979, 0, 2, 0, 25, 0, 100, 0, 0, 0, 0, 0, 0, 0, 40, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Dawnblade Marksman - On Reset - Set Sheath Ranged');

-- Do not remove transform auras on evade
-- SPELL_ATTR1_AURA_STAYS_AFTER_COMBAT = 0x02000000, // TITLE Aura stays after combat DESCRIPTION Aura will not be removed when the unit leaves combat
UPDATE `spell_dbc` SET `AttributesEx`=`AttributesEx`|(0x02000000) WHERE `ID` IN (44918, 44919, 44920, 44921, 44922, 44923, 44924, 44925, 44926, 44927, 44928, 44929, 44930, 44931, 44932, 44962, 45155, 45156, 45157, 45158, 45159, 45160, 45161, 45162, 45163, 45164, 45165, 45166, 45167, 45168, 45169, 45170);

-- Close First, Second, Third Gate
UPDATE `gameobject` SET `state` = 1 WHERE `id` IN (187766, 187765, 187764) AND `guid` IN (50441, 50440, 50439);

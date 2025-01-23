--
DELETE FROM `command` WHERE `name` IN ('worldstate sunsreach phase', 'worldstate sunsreach subphase');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('worldstate sunsreach phase', 3, 'Syntax: .worldstate sunsreach phase <value>.\nSets the phase of Sun''s Reach.\nValid values are:\n0: Staging Area\n1: Harbor\n2: Armory\n3: Sanctum.'),
('worldstate sunsreach subphase', 3, 'Syntax: .worldstate sunsreach subphase <mask>.\nSets the subphase mask of Sun''s Reach.\nValid values are:\n1: Portal\n2: Anvil\n4: Alchemy Lab\n8: Monument\n15: All.');

UPDATE `creature_template` SET `ScriptName`='npc_suns_reach_reclamation' WHERE `entry` IN (24965,24967,25061,25057,24932,25108,25069,25046,24975,25112,25163);

-- 20-1-2025
-- author: heyitsbench
-- original: https://gist.githubusercontent.com/heyitsbench/64e9741fdc5e06f48592b583a4712b4f/raw/43ef22898c5268973ab01051d9387ca1f5aeec9f/suns-reach-reclamation.sql
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
@sunsreachkiru       = 115;

-- Smith Hauthaa <Weapons & Armorsmith>
SET @guidsmith = 93964;
-- Shaani <Jewelcrafting Supplies>
SET @guidjc = 94386;
-- Mar'nah <Alchemist>
SET @guidalch = 94378;
-- Demonic Crystals
SET @guidcrystals:=5300500;

DELETE FROM `game_event` WHERE `eventEntry` IN (@sunsreachpone, @sunsreachptwoonly, @sunsreachptwoperm, @sunsreachnoportal, @sunsreachportal, @sunsreachpthreeonly, @sunsreachpthreeperm, @sunsreachnoanvil, @sunsreachanvil, @sunsreachpfour, @sunsreachnomonument, @sunsreachmonument, @sunsreachnolab, @sunsreachlab, @sunsreachkiru);
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
(@sunsreachkiru,       '2000-01-01 14:00:00', '2000-01-01 14:00:00', 5184000, 2592000, 0, 0, 'Sun''s Reach Reclamation Phase K''iru',         5, 2);

DELETE FROM `game_event_creature` WHERE `eventEntry` IN (@sunsreachpone, @sunsreachptwoonly, @sunsreachptwoperm, @sunsreachnoportal, @sunsreachportal, @sunsreachpthreeonly, @sunsreachpthreeperm, @sunsreachnoanvil, @sunsreachanvil, @sunsreachpfour, @sunsreachnomonument, @sunsreachmonument, @sunsreachnolab, @sunsreachlab, @sunsreachkiru, -@sunsreachpone, -@sunsreachptwoonly, -@sunsreachptwoperm, -@sunsreachnoportal, -@sunsreachportal, -@sunsreachpthreeonly, -@sunsreachpthreeperm, -@sunsreachnoanvil, -@sunsreachanvil, -@sunsreachpfour, -@sunsreachnomonument, -@sunsreachmonument, -@sunsreachnolab, -@sunsreachlab, -@sunsreachkiru);
INSERT INTO `game_event_creature` (`guid`, `eventEntry`) VALUES
-- Phase 2
(93950, @sunsreachptwoperm), -- 25061 (Harbinger Inuuro)
(93951, @sunsreachptwoperm), -- 25057 (Battlemage Arynna)
(93952, @sunsreachptwoperm), -- 25034 (Tradesman Portanuus <Trade Supplies>)
(93953, @sunsreachptwoperm), -- 25133 (Astromancer Darnarian)
(96655, @sunsreachptwoperm), -- 24932 (Exarch Nasuun)
-- Phase 3
(@guidsmith, @sunsreachpthreeperm), -- 25046 (Smith Hauthaa <Weapons & Armorsmith>)
(93955, @sunsreachpthreeperm), -- 25108 (Vindicator Kaalan)
(93954, @sunsreachpthreeperm), -- 25035 (Tyrael Flamekissed <General Goods>)
(93960, @sunsreachpthreeperm), -- 26089 (Kayri <Exotic Gear Purveyor>)
(93956, @sunsreachpthreeperm), -- 26090 (Karynna <Exotic Gear Purveyor>)
(93959, @sunsreachpthreeperm), -- 26091 (Olus <Exotic Gear Purveyor>)
(93958, @sunsreachpthreeperm), -- 26092 (Soryn <Exotic Gear Purveyor>)
(93957, @sunsreachpthreeperm), -- 25069 (Magister Ilastar)
-- Phase 4
(@guidalch, @sunsreachpfour), -- 24975 (Mar'nah <Alchemist>)
(94379, @sunsreachpfour), -- 25036 (Caregiver Inaara <Innkeeper>)
(94384, @sunsreachpfour), -- 25112 (Anchorite Ayuri)
(94385, @sunsreachpfour), -- 25163 (Anchorite Kairthos)
(@guidjc, @sunsreachpfour), -- 25950 (Shaani <Jewelcrafting Supplies>)
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
-- (5300434, @sunsreachptwoperm), -- 24994 (Shattered Sun Sentry) Probably 76582
-- (5300431, @sunsreachptwoperm), -- 24994 (Shattered Sun Sentry) Probably 76581
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
-- (5300432, @sunsreachpthreeperm), -- 24994 (Shattered Sun Sentry) Maybe 78385?
(78389, @sunsreachpthreeperm), -- 24994 (Shattered Sun Sentry) 5300447
-- (5301095, @sunsreachpthreeperm), -- 25115 (Shattered Sun Warrior) Maybe 94387?
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
-- (5301204, @sunsreachpfour), -- 24994 (Shattered Sun Sentry) Missing? Maybe 94377?
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
-- (5300435, @sunsreachpfour), -- 24994 (Shattered Sun Sentry) Maybe 83998 or 94377?
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
(5300471, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
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
(5300472, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(5300473, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(5300474, -@sunsreachpthreeperm), -- 25001 (Abyssal Flamewalker)
(5300502, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(5300503, -@sunsreachpthreeperm), -- 25002 (Unleashed Hellion)
(5300086, -@sunsreachptwoperm), -- 24938 (Shattered Sun Marksman)
(5300087, -@sunsreachptwoperm), -- 24938 (Shattered Sun Marksman)
(5300293, -@sunsreachptwoperm), -- 24976 (Dawnblade Blood Knight)
(5300294, -@sunsreachptwoperm), -- 24976 (Dawnblade Blood Knight)
(5300309, -@sunsreachptwoperm), -- 24976 (Dawnblade Blood Knight)
(5300315, -@sunsreachptwoperm), -- 24976 (Dawnblade Blood Knight)
(5300369, -@sunsreachptwoperm), -- 24978 (Dawnblade Summoner)
(5300370, -@sunsreachptwoperm), -- 24978 (Dawnblade Summoner)
(5300401, -@sunsreachptwoperm), -- 24979 (Dawnblade Marksman)
(5300402, -@sunsreachptwoperm), -- 24979 (Dawnblade Marksman)
(5301085, -@sunsreachptwoperm), -- 25115 (Shattered Sun Warrior)
(5301086, -@sunsreachptwoperm), -- 25115 (Shattered Sun Warrior)
(5301087, -@sunsreachptwoperm), -- 25115 (Shattered Sun Warrior)
(5300086, -@sunsreachptwoonly), -- 24938 (Shattered Sun Marksman)
(5300087, -@sunsreachptwoonly), -- 24938 (Shattered Sun Marksman)
(5300293, -@sunsreachptwoonly), -- 24976 (Dawnblade Blood Knight)
(5300294, -@sunsreachptwoonly), -- 24976 (Dawnblade Blood Knight)
(5300309, -@sunsreachptwoonly), -- 24976 (Dawnblade Blood Knight)
(5300315, -@sunsreachptwoonly), -- 24976 (Dawnblade Blood Knight)
(5300369, -@sunsreachptwoonly), -- 24978 (Dawnblade Summoner)
(5300370, -@sunsreachptwoonly), -- 24978 (Dawnblade Summoner)
(5300401, -@sunsreachptwoonly), -- 24979 (Dawnblade Marksman)
(5300402, -@sunsreachptwoonly), -- 24979 (Dawnblade Marksman)
(5301085, -@sunsreachptwoonly), -- 25115 (Shattered Sun Warrior)
(5301086, -@sunsreachptwoonly), -- 25115 (Shattered Sun Warrior)
(5301087, -@sunsreachptwoonly), -- 25115 (Shattered Sun Warrior)
(165102,  @sunsreachportal), -- 25115 (Shattered Sun Warrior)
(165103,  @sunsreachportal), -- 25115 (Shattered Sun Warrior)
(165104,  @sunsreachportal), -- 25115 (Shattered Sun Warrior)
(165105,  @sunsreachportal), -- 25115 (Shattered Sun Warrior)
(165106,  @sunsreachportal), -- 24938 (Shattered Sun Marksman)
(165107,  @sunsreachportal), -- 24938 (Shattered Sun Marksman)
(165108,  @sunsreachportal), -- 24938 (Shattered Sun Marksman)
(165109,  @sunsreachportal), -- 24938 (Shattered Sun Marksman)
(5300070, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(5300071, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(5300072, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(5300073, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(5300074, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(5300075, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(5300076, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(5300077, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(5300078, @sunsreachportal), -- 24936 (Sunwell Daily Bunny x 0.01)
(5300079, @sunsreachportal); -- 24936 (Sunwell Daily Bunny x 0.01)

DELETE FROM `game_event_gameobject` WHERE `eventEntry` IN (@sunsreachpone, @sunsreachptwoonly, @sunsreachptwoperm, @sunsreachnoportal, @sunsreachportal, @sunsreachpthreeonly, @sunsreachpthreeperm, @sunsreachnoanvil, @sunsreachanvil, @sunsreachpfour, @sunsreachnomonument, @sunsreachmonument, @sunsreachnolab, @sunsreachlab, @sunsreachkiru, -@sunsreachpone, -@sunsreachptwoonly, -@sunsreachptwoperm, -@sunsreachnoportal, -@sunsreachportal, -@sunsreachpthreeonly, -@sunsreachpthreeperm, -@sunsreachnoanvil, -@sunsreachanvil, -@sunsreachpfour, -@sunsreachnomonument, -@sunsreachmonument, -@sunsreachnolab, -@sunsreachlab, -@sunsreachkiru);
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
(5300290, @sunsreachlab), -- 187115, Alchemy Lab
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
(27828, @sunsreachpfour); -- 187356, Shattered Sun Banner (Draenei - Pole)

DELETE FROM `creature_queststarter` WHERE `quest` IN (11514, 11520, 11521, 11523, 11525, 11532, 11533, 11535, 11536, 11537, 11538, 11539, 11540, 11541, 11542, 11543, 11544, 11545, 11546, 11547, 11548, 11549);
DELETE FROM `game_event_creature_quest` WHERE `eventEntry` IN (@sunsreachpone, @sunsreachptwoonly, @sunsreachptwoperm, @sunsreachnoportal, @sunsreachportal, @sunsreachpthreeonly, @sunsreachpthreeperm, @sunsreachnoanvil, @sunsreachanvil, @sunsreachpfour, @sunsreachnomonument, @sunsreachmonument, @sunsreachnolab, @sunsreachlab, @sunsreachkiru);
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

DELETE FROM `gossip_menu` WHERE `MenuID` IN (51000, 51001, 51002, 51003, 51005, 51006, 51007, 51008, 51009, 51010, 51011, 51012, 51013); -- Custom IDs
DELETE FROM `gossip_menu` WHERE `MenuID` IN (9046) AND `TextID` IN (12226, 12304, 12305, 12306);
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
-- Exarch Nasuun
(9046,  12226), -- Portal progress
(51000, 12300), -- Armory progress
(51001, 12301), -- Anvil progress
(51002, 12302), -- Harbor progress
(51003, 12303), -- Alchemy lab progress
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

DELETE FROM `conditions` WHERE `ConditionTypeOrReference` = 12 AND `ConditionValue1` IN (@sunsreachpone, @sunsreachptwoonly, @sunsreachptwoperm, @sunsreachnoportal, @sunsreachportal, @sunsreachpthreeonly, @sunsreachpthreeperm, @sunsreachnoanvil, @sunsreachanvil, @sunsreachpfour, @sunsreachnomonument, @sunsreachmonument, @sunsreachnolab, @sunsreachlab, @sunsreachkiru);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(14, 9052, 12240, 0, 0, 12, 0, @sunsreachpone,       0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 1'' is active'),
(14, 9052, 12241, 0, 1, 12, 0, @sunsreachpone,       0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 1'' is not active'),
(14, 9065, 12260, 0, 0, 12, 0, @sunsreachpone,       0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 1'' is active'),
(14, 9065, 12259, 0, 1, 12, 0, @sunsreachpone,       0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 1'' is not active'),

(14, 9046,  12226, 0, 0, 12, 0, @sunsreachnoportal,   0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Portal'' is active'),
(14, 9046,  12227, 0, 1, 12, 0, @sunsreachnoportal,   0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Portal'' is not active'),

(14, 9064,  12257, 0, 0, 12, 0, @sunsreachptwoonly,   0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 2 Only'' is active'),
(14, 9064,  12258, 0, 1, 12, 0, @sunsreachptwoonly,   0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 2 Only'' is not active'),
(14, 9063,  12255, 0, 0, 12, 0, @sunsreachptwoonly,   0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 2 Only'' is active'),
(14, 9063,  12256, 0, 1, 12, 0, @sunsreachptwoonly,   0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 2 Only'' is not active'),
(14, 51000, 12300, 0, 0, 12, 0, @sunsreachptwoonly,   0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 2 Only'' is active'),

(14, 51001, 12301, 0, 0, 12, 0, @sunsreachnoanvil,    0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Anvil'' is active'),
(14, 9087, 12285, 0, 0, 12, 0, @sunsreachnoanvil,    0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Anvil'' is active'),
(14, 9087, 12286, 0, 1, 12, 0, @sunsreachnoanvil,    0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Anvil'' is not active'),

(14, 51002, 12302, 0, 0, 12, 0, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 3 Only'' is active'),

(14, 9127, 12339, 0, 0, 12, 0, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 3 Only'' is active'),
(14, 9127, 12340, 0, 1, 12, 0, @sunsreachpthreeonly, 0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 3 Only'' is not active'),
(14, 9111, 12319, 0, 0, 12, 0, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 3 Only'' is active'),
(14, 9111, 12320, 0, 1, 12, 0, @sunsreachpthreeonly, 0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 3 Only'' is not active'),

(14, 51003, 12303, 0, 0, 12, 0, @sunsreachnolab,      0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is active'),
(14, 9050, 12238, 0, 0, 12, 0, @sunsreachnolab,      0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is active'),
(14, 9050, 12237, 0, 1, 12, 0, @sunsreachnolab,      0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is not active'),
(14, 9198, 12496, 0, 0, 12, 0, @sunsreachnolab,      0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is active'),
(14, 9198, 12497, 0, 1, 12, 0, @sunsreachnolab,      0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is not active'),
(14, 9115, 12322, 0, 0, 12, 0, @sunsreachnomonument, 0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Monument'' is active'),
(14, 9115, 12323, 0, 1, 12, 0, @sunsreachnomonument, 0, 0, 1, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Monument'' is not active'),

(15, 9046,  0,     0, 0, 12, 0, @sunsreachptwoonly,   0, 0, 0, 0, 0, '', 'Show gossip option if the event ''Sun''s Reach Reclamation Phase 2 Only'' is active'),
(15, 9046,  1,     0, 0, 12, 0, @sunsreachnoanvil,    0, 0, 0, 0, 0, '', 'Show gossip option if the event ''Sun''s Reach Reclamation Phase No Anvil'' is active'),
(15, 9046,  2,     0, 0, 12, 0, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'Show gossip option if the event ''Sun''s Reach Reclamation Phase 3 Only'' is active'),
(15, 9046,  3,     0, 0, 12, 0, @sunsreachnolab,      0, 0, 0, 0, 0, '', 'Show gossip option if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is active');

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

-- Docks
-- JC
-- Shaani
DELETE FROM `gossip_menu` WHERE (`MenuID` = 9198) AND (`TextID` IN (12496));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9198, 12496);

-- Alchemist
-- Mar'nah
DELETE FROM `gossip_menu` WHERE (`MenuID` = 9050) AND (`TextID` IN (12238));
INSERT INTO `gossip_menu` (`MenuID`, `TextID`) VALUES
(9050, 12238);

-- Alchemy Lab
DELETE FROM `gameobject` WHERE (`id` = 187115) AND (`guid` IN (5300290));
INSERT INTO `gameobject` (`guid`, `id`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `animprogress`, `state`, `ScriptName`, `VerifiedBuild`) VALUES
(5300290, 187115, 530, 4080, 4087, 1, 1, 12845.603516, -7011.98584, 18.592701, 5.543178, 0, 0, 0, 0, 0, 0, 0, '', 0);

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
DELETE FROM `game_event_npc_vendor` WHERE (`eventEntry` = @sunsreachanvil) AND `guid` = @guidsmith;
INSERT INTO `game_event_npc_vendor` (`eventEntry`, `guid`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES
(@sunsreachanvil, @guidsmith, 0, 34887, 0, 0, 2059),
(@sunsreachanvil, @guidsmith, 0, 34888, 0, 0, 2059),
(@sunsreachanvil, @guidsmith, 0, 34889, 0, 0, 2059),
(@sunsreachanvil, @guidsmith, 0, 34890, 0, 0, 2059),
(@sunsreachanvil, @guidsmith, 0, 34891, 0, 0, 2329),
(@sunsreachanvil, @guidsmith, 0, 34892, 0, 0, 2329),
(@sunsreachanvil, @guidsmith, 0, 34893, 0, 0, 2331),
(@sunsreachanvil, @guidsmith, 0, 34894, 0, 0, 2331),
(@sunsreachanvil, @guidsmith, 0, 34895, 0, 0, 2329),
(@sunsreachanvil, @guidsmith, 0, 34896, 0, 0, 2329),
(@sunsreachanvil, @guidsmith, 0, 34898, 0, 0, 2329),
(@sunsreachanvil, @guidsmith, 0, 34900, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34901, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34902, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34903, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34904, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34905, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34906, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34910, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34911, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34912, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34914, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34916, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34917, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34918, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34919, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34921, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34922, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34923, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34924, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34925, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34926, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34927, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34928, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34929, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34930, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34931, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34932, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34933, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34934, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34935, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34936, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34937, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34938, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34939, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34940, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34941, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34942, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34943, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34944, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34945, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34946, 0, 0, 2333),
(@sunsreachanvil, @guidsmith, 0, 34947, 0, 0, 2049),
(@sunsreachanvil, @guidsmith, 0, 34949, 0, 0, 2332),
(@sunsreachanvil, @guidsmith, 0, 34950, 0, 0, 2332),
(@sunsreachanvil, @guidsmith, 0, 34951, 0, 0, 2332),
(@sunsreachanvil, @guidsmith, 0, 34952, 0, 0, 2332);

-- Alchemist vendor
-- Mar'nah
DELETE FROM `npc_vendor` WHERE (`entry` = 24975);
DELETE FROM `game_event_npc_vendor` WHERE (`eventEntry` = @sunsreachlab) AND `guid` = @guidalch;
INSERT INTO `game_event_npc_vendor` (`eventEntry`, `guid`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES
(@sunsreachlab, @guidalch, 0, 3371, 0, 0, 0),
(@sunsreachlab, @guidalch, 0, 3372, 0, 0, 0),
(@sunsreachlab, @guidalch, 0, 8925, 0, 0, 0),
(@sunsreachlab, @guidalch, 0, 13467, 3, 9000, 0),
(@sunsreachlab, @guidalch, 0, 18256, 0, 0, 0),
(@sunsreachlab, @guidalch, 0, 22785, 3, 9000, 0),
(@sunsreachlab, @guidalch, 0, 22786, 3, 9000, 0),
(@sunsreachlab, @guidalch, 0, 22791, 3, 9000, 0),
(@sunsreachlab, @guidalch, 0, 22793, 1, 9000, 0),
(@sunsreachlab, @guidalch, 0, 40411, 0, 0, 0);

-- JC vendor
-- Shaani
DELETE FROM `npc_vendor` WHERE (`entry` = 25950);
DELETE FROM `game_event_npc_vendor` WHERE (`eventEntry` = @sunsreachlab) AND `guid` = @guidjc;
INSERT INTO `game_event_npc_vendor` (`eventEntry`, `guid`, `slot`, `item`, `maxcount`, `incrtime`, `ExtendedCost`) VALUES
(@sunsreachlab, @guidjc, 0, 32227, 0, 0, 1642),
(@sunsreachlab, @guidjc, 0, 32228, 0, 0, 1642),
(@sunsreachlab, @guidjc, 0, 32229, 0, 0, 1642),
(@sunsreachlab, @guidjc, 0, 32230, 0, 0, 1642),
(@sunsreachlab, @guidjc, 0, 32231, 0, 0, 1642),
(@sunsreachlab, @guidjc, 0, 32249, 0, 0, 1642),
(@sunsreachlab, @guidjc, 0, 35238, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35239, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35240, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35241, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35242, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35243, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35244, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35245, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35246, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35247, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35248, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35249, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35250, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35251, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35252, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35253, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35254, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35255, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35256, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35257, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35258, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35259, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35260, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35261, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35262, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35263, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35264, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35265, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35266, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35267, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35268, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35269, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35270, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35271, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35322, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35323, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35325, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35766, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35767, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35768, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 35769, 0, 0, 0),
(@sunsreachlab, @guidjc, 0, 37504, 0, 0, 0);

-- Shattered Sun Marksman + Warrior Transform Auras
-- Marksman Transform Auras
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 24938) AND (`source_type` = 0) AND (`id` IN (3, 4, 5, 6));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(24938, 0, 3, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493810, 2493813, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Random Script'),
(24938, 0, 4, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493820, 2493823, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Random Script'),
(24938, 0, 5, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493830, 2493833, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Random Script'),
(24938, 0, 6, 0, 11, 0, 100, 0, 0, 0, 0, 0, 0, 0, 88, 2493840, 2493843, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Shattered Sun Marksman - On Respawn - Run Random Script');

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
-- Demonic Crystals
DELETE FROM `gameobject` WHERE `id` = 187120 AND `guid` BETWEEN @guidcrystals AND @guidcrystals+4;
INSERT INTO `gameobject` (`guid`, `id`, `map`, `spawnMask`, `phaseMask`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `spawntimesecs`, `VerifiedBuild`, `Comment`) VALUES
(@guidcrystals+0, 187120, 530, 1, 1, 12685.7998046875, -6925.830078125, 39.61629867553711, 2.4260098934173584, 0.0, 0.0, 0.9366719722747804, 0.3502070009708404, 180, 0, ''),
(@guidcrystals+1, 187120, 530, 1, 1, 12707.7998046875, -6938.7900390625, 40.44039916992188, 1.815140008926392, 0.0, 0.0, 0.7880110144615173, 0.6156619787216187, 180, 0, ''),
(@guidcrystals+2, 187120, 530, 1, 1, 12665.0, -6935.72998046875, 29.555299758911133, -0.5934119820594788, 0.0, 0.0, 0.2923719882965088, -0.9563050270080566, 180, 0, ''),
(@guidcrystals+3, 187120, 530, 1, 1, 12655.7001953125, -6948.68994140625, 38.598098754882805, 2.687809944152832, 0.0, 0.0, 0.974370002746582, 0.2249509990215301, 180, 0, ''),
(@guidcrystals+4, 187120, 530, 1, 1, 12645.2001953125, -6980.97998046875, 40.50529861450195, -1.85004997253418, 0.0, 0.0, 0.0, 0.0, 180, 0, '');

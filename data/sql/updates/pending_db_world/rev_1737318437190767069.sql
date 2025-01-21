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
(93964, @sunsreachpthreeperm), -- 25046 (Smith Hauthaa <Weapons & Armorsmith>)
(93955, @sunsreachpthreeperm), -- 25108 (Vindicator Kaalan)
(93954, @sunsreachpthreeperm), -- 25035 (Tyrael Flamekissed <General Goods>)
(93960, @sunsreachpthreeperm), -- 26089 (Kayri <Exotic Gear Purveyor>)
(93956, @sunsreachpthreeperm), -- 26090 (Karynna <Exotic Gear Purveyor>)
(93959, @sunsreachpthreeperm), -- 26091 (Olus <Exotic Gear Purveyor>)
(93958, @sunsreachpthreeperm), -- 26092 (Soryn <Exotic Gear Purveyor>)
(93957, @sunsreachpthreeperm), -- 25069 (Magister Ilastar)
-- Phase 4
(94378, @sunsreachpfour), -- 24975 (Mar'nah <Alchemist>)
(94379, @sunsreachpfour), -- 25036 (Caregiver Inaara <Innkeeper>)
(94384, @sunsreachpfour), -- 25112 (Anchorite Ayuri)
(94385, @sunsreachpfour), -- 25163 (Anchorite Kairthos)
(94386, @sunsreachpfour), -- 25950 (Shaani <Jewelcrafting Supplies>)
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
-- 5800005? Sunwell bench? Not included
(5300290, @sunsreachlab), -- 187115, Alchemy Lab
-- Crystals
(5300500, -@sunsreachpthreeperm), -- 187120, Demonic Crystal
(5300501, -@sunsreachpthreeperm), -- 187120, Demonic Crystal
(5300502, -@sunsreachpthreeperm), -- 187120, Demonic Crystal
(5300503, -@sunsreachpthreeperm), -- 187120, Demonic Crystal
(5300504, -@sunsreachpthreeperm); -- 187120, Demonic Crystal

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
(14, 9046,  12226, 0, 0, 12, 0, @sunsreachnoportal,   0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Portal'' is active'),
(14, 51000, 12300, 0, 0, 12, 0, @sunsreachptwoonly,   0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 2 Only'' is active'),
(14, 51001, 12301, 0, 0, 12, 0, @sunsreachnoanvil,    0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Anvil'' is active'),
(14, 51002, 12302, 0, 0, 12, 0, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 3 Only'' is active'),
(14, 51003, 12303, 0, 0, 12, 0, @sunsreachnolab,      0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is active'),
(14, 51005, 12240, 0, 0, 12, 0, @sunsreachpone,       0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 1'' is active'),
(14, 51006, 12260, 0, 0, 12, 0, @sunsreachpone,       0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 1'' is active'),
(14, 51007, 12255, 0, 0, 12, 0, @sunsreachptwoonly,   0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 2 Only'' is active'),
(14, 51008, 12257, 0, 0, 12, 0, @sunsreachptwoonly,   0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 2 Only'' is active'),
(14, 51009, 12339, 0, 0, 12, 0, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 3 Only'' is active'),
(14, 51010, 12319, 0, 0, 12, 0, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase 3 Only'' is active'),
(14, 51011, 12285, 0, 0, 12, 0, @sunsreachnoanvil,    0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Anvil'' is active'),
(14, 51012, 12238, 0, 0, 12, 0, @sunsreachnolab,      0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is active'),
(14, 51013, 12322, 0, 0, 12, 0, @sunsreachnomonument, 0, 0, 0, 0, 0, '', 'Show gossip text if the event ''Sun''s Reach Reclamation Phase No Monument'' is active'),
(15, 9046,  0,     0, 0, 12, 0, @sunsreachptwoonly,   0, 0, 0, 0, 0, '', 'Show gossip option if the event ''Sun''s Reach Reclamation Phase 2 Only'' is active'),
(15, 9046,  1,     0, 0, 12, 0, @sunsreachnoanvil,    0, 0, 0, 0, 0, '', 'Show gossip option if the event ''Sun''s Reach Reclamation Phase No Anvil'' is active'),
(15, 9046,  2,     0, 0, 12, 0, @sunsreachpthreeonly, 0, 0, 0, 0, 0, '', 'Show gossip option if the event ''Sun''s Reach Reclamation Phase 3 Only'' is active'),
(15, 9046,  3,     0, 0, 12, 0, @sunsreachnolab,      0, 0, 0, 0, 0, '', 'Show gossip option if the event ''Sun''s Reach Reclamation Phase No Alchemy Lab'' is active');

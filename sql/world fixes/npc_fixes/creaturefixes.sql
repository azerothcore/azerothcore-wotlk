
-- --------------------------------
-- GENERIC
-- --------------------------------
-- spirit healers should be visible in all phasemasks
UPDATE creature SET phasemask=4294967295 WHERE id=6491;

-- Vehicles shouldnt regenerate out of combat (player vehicles)
UPDATE creature_template SET RegenHealth=0 WHERE vehicleid<>0 AND IconName<>"" AND entry NOT IN(36838, 36839);

-- Deadwood Den Watcher, Deadwood Avenger, Deadwood Shaman now gives reputation to revered
UPDATE creature_onkill_reputation SET MaxStanding1=6 WHERE creature_id IN(7156, 7157, 7158);
-- Twilight Geolord (11881), reputaton amount
UPDATE creature_onkill_reputation SET RewOnKillRepValue1=10 WHERE creature_id=11881;
-- Twilight now gives reputation to exalted
UPDATE creature_onkill_reputation SET MaxStanding1=7 WHERE creature_id IN(15213, 14479, 15541, 15201, 11803, 15200, 11883, 11882, 11881, 15542, 11880, 15308);
-- Booty Bay Bruiser (4624)
REPLACE INTO creature_onkill_reputation VALUES (4624, 87, 21, 5, 0, 25, 7, 1, -125, 0);

-- 3.2.0 REP DISCOUNTS
UPDATE creature_template SET faction=2037 WHERE entry=35133;
UPDATE creature_template SET faction=1981 WHERE entry=35135;
UPDATE creature_template SET faction=12 WHERE entry=35100;
UPDATE creature_template SET faction=29 WHERE entry=35093;

-- Those npcs should have their loot removed, wrong wowhead data!
DELETE FROM creature_loot_template WHERE entry IN(31813, 31205, 28220, 32467, 31142);
UPDATE creature_template SET lootid=0 WHERE entry IN(31813, 31205, 28220, 32467, 31142);

-- Remove Diseases immunity from tbc bosses
UPDATE creature_template SET mechanic_immune_mask = mechanic_immune_mask & ~(1<<21) WHERE entry IN(2784 , 3057 , 3516 , 4949 , 4968 , 
7937 , 7999 , 10181 , 10540 , 11980 , 16472 , 16800 , 16802 , 16807 , 16808 , 16809 , 17257 , 17468 , 17536 , 17537 , 17711 , 
17723 , 17734 , 17770 , 17826 , 17882 , 17907 , 17940 , 17958 , 17978 , 17990 , 18105 , 18432 , 18434 , 18481 , 18680 , 18692 , 
18731 , 19218 , 19551 , 19710 , 19891 , 20032 , 20035 , 20036 , 20037 , 20039 , 20040 , 20041 , 20043 , 20044 , 20045 , 20046 , 
20049 , 20050 , 20060 , 20062 , 20063 , 20064 , 20164 , 20168 , 20169 , 20183 , 20184 , 20187 , 20189 , 20568 , 20596 , 20597 , 
20636 , 20864 , 20867 , 20868 , 20870 , 20873 , 20879 , 20880 , 20885 , 20886 , 20896 , 20901 , 20902 , 20905 , 20906 , 20908 , 
20909 , 20910 , 20911 , 20912 , 20992 , 21127 , 21174 , 21221 , 21224 , 21227 , 21298 , 21299 , 21301 , 21303 , 21304 , 21339 , 
21346 , 21362 , 21466 , 21467 , 21508 , 21525 , 21526 , 21581 , 21588 , 21589 , 21590 , 21591 , 21592 , 21593 , 21594 , 21595 , 
21596 , 21599 , 21600 , 21601 , 21605 , 21606 , 21608 , 21610 , 21611 , 21612 , 21616 , 21617 , 21618 , 21623 , 21624 , 21626 , 
21702 , 21838 , 21843 , 21958 , 21964 , 21965 , 21966 , 22055 , 22076 , 22119 , 22120 , 22128 , 22129 , 22330 , 22346 , 22844 , 
22847 , 22849 , 22855 , 22873 , 22877 , 22880 , 22884 , 22956 , 22960 , 22963 , 22964 , 23028 , 23030 , 23061 , 23196 , 23222 , 
23239 , 23261 , 23281 , 23282 , 23330 , 23337 , 23394 , 23397 , 23399 , 23400 , 23402 , 23403 , 23421 , 23597 , 24175 , 24374 , 
24560 , 24664 , 24723 , 24744 , 24857 , 24882 , 24892 , 25038 , 25165 , 25166 , 25315 , 25560 , 25562 , 25573 , 25741 , 25840 , 
28132 , 28171 , 28443 , 29611);

-- Some random NPCs (Raaar!!! Me smash $R text)
UPDATE smart_scripts SET target_type=7 WHERE entryorguid IN(212,889,891,892,1179,1180,1183,1251,2252,2253,2254,2255,2287,2416,2417,2420,2422,2562,2564,
2566,2567,2569,2570,2701,2715,2716,2717,2718,2720,2793,2906,7033,7034,7035,8977,9604,14267) AND action_type=1 AND action_param1=0 AND event_type=4;
UPDATE smart_scripts SET target_type=21, target_param1=30 WHERE entryorguid IN(212,889,891,892,1179,1180,1183,1251,2252,2253,2254,2255,2287,2416,2417,2420,2422,2562,2564,
2566,2567,2569,2570,2701,2715,2716,2717,2718,2720,2793,2906,7033,7034,7035,8977,9604,14267) AND action_type=1 AND action_param1=0 AND event_type<>4;

-- Some random levitating npcs
-- select ca.guid, ca.bytes1, cr.position_x, cr.position_y, cr.position_z, cr.map, ct.entry, ct.name from creature_addon AS ca left join (creature AS cr left join creature_template AS ct ON cr.id=ct.entry) ON ca.guid=cr.guid WHERE ca.bytes1&33554432 AND ct.inhabittype=3
UPDATE creature_template_addon SET bytes1=bytes1&~(33554432) WHERE entry IN(16170, 2522, 25484, 1713, 768);
UPDATE creature_addon SET bytes1=bytes1&~(33554432) WHERE guid IN(54767,54721,54675,54586,26291,26153,26151,26140,4216,11547,11550,11577,11608,11612,11654,11696,11812,11976,12904,12910,12912,13251,13303,13304,13310,
13311,13313,13315,16707,16709,16719,16733,16735,16737,16751,16754,16771,16796,16863,16880,16881,16882,16883,16901,16962,16963,16985,16987,17004,17005,17006,17010,17013,17017,17018,17021,17028,17031,17032,17044,17047,
17048,17051,17097,39613,40704,40743,40759,40763,40765,97753,97755,97757,97758,97763,97789,97833,97834,97835,97837,97838,97839,97840,97842,97843,97844,97845,97846,98405,121246,121254,121255,121268,121269);

-- No Skill Gain and Grip Immunity
UPDATE creature_template SET mechanic_immune_mask = mechanic_immune_mask|32, flags_extra = flags_extra | 262144 WHERE (name LIKE '%Training Dummy' OR name LIKE '%Target Dummy') AND entry IN (SELECT DISTINCT id FROM creature);
UPDATE creature_template SET mechanic_immune_mask = mechanic_immune_mask|32, flags_extra = flags_extra | 262144 WHERE ScriptName LIKE '%training_dummy%';
UPDATE creature_template SET mechanic_immune_mask = mechanic_immune_mask|32, flags_extra = flags_extra | 262144 WHERE entry IN(33229, 33243, 33272); -- AT: Melee Target, Ranged Target, Charge Target

-- Fix trainers missing gossip flag
UPDATE creature_template SET npcflag=209 WHERE npcflag=208;

-- Fix dummy npcs (vehicles without any AI serving no quest porposes)
UPDATE creature_template SET AIName='AgressorAI' WHERE entry IN(27241, 27605, 28246, 29351, 29358, 29460, 29857, 30320, 31137, 31702);

-- Missing Trigger Flag
UPDATE creature_template SET flags_extra=flags_extra|0x80 WHERE entry IN (16914, 16995, 17001, 17231, 17274, 17611, 17687, 17992, 17999, 18225, 18242, 18306, 18307, 18729, 18757, 18759, 19041, 19276, 19277, 19278, 19279, 19326, 19328, 19329, 19358, 19359, 19376, 19381, 19439, 19555, 19597, 19654, 19677, 19727, 20003, 20023, 20024, 20093, 20114, 20286, 20288, 20289, 20391, 20431, 20473, 20475, 20476, 20520, 20608, 20676, 20709, 20796, 20825, 20889, 20982, 21073, 21080, 21095, 21097, 21109, 21116, 21119, 21120, 21159, 21241, 21290, 21351, 21365, 21447, 21456, 21498, 21512, 21641, 21654, 21756, 21791, 21792, 21793, 21794, 21807, 21814, 21855, 21856, 21921, 21939, 21940, 21946, 21957, 22008, 22039, 22054, 22083, 22121, 22228, 22240, 22246, 22269, 22288, 22320, 22340, 22400, 22417, 22422, 22436, 22449, 22470, 22503, 22504, 22519, 22520, 22523, 22831, 22851, 22905, 23378, 23443, 22833, 22872, 22934, 23409, 23454, 22986, 15730, 17163, 17367, 17368, 17369, 18599, 18665, 19010, 19198, 19563, 19577, 20128, 20425, 20675, 20863, 20979, 21281, 21297, 21321, 21360, 21418, 21473, 21800, 21880, 21910, 21929, 22418, 22524, 22838, 23037, 23040, 23056, 23059, 23063, 23078, 23116, 23173, 23199, 23212, 23255, 23260, 23262, 23278, 23301, 23323, 23328, 23382, 23385, 23395, 23500, 23512, 23488, 24109, 23758, 19237, 22296, 22829, 22839, 22866, 22867, 22868, 22916, 22921, 22927, 23043, 23081, 23138, 23155, 23209, 23213, 23225, 23228, 23240, 23250, 23275, 23307, 23308, 23312, 23313, 23315, 23317, 23379, 23424, 23425, 23438, 23442, 23444, 23445, 23845, 23850, 23852, 23853, 23854, 23855, 24171, 24220, 23583, 23585, 23807, 23813, 23814, 23815, 23832, 23893, 23920, 24363, 24412, 24630, 24781, 24809, 24903, 24904, 24908, 24936, 25068, 25114, 25172, 25213, 25640, 25746, 25782, 25952, 25964, 25965, 25966, 26057, 26120, 26121, 26190, 26230, 26346, 26391, 27723, 27890, 26834, 26775, 26774, 29589, 29588, 28481, 24771, 23750, 23805, 23810, 23821, 23974, 24000, 24008, 24012, 24087, 24092, 24093, 24094, 24098, 24100, 24101, 24102, 24158, 24165, 24166, 24167, 24170, 24182, 24183, 24184, 24185, 24193, 24194, 24221, 24260, 24269, 24288, 24289, 24326, 24335, 24336, 24449, 24454, 24465, 24466, 24471, 24513, 24526, 24645, 24651, 24652, 24655, 24665, 24705, 24707, 24725, 24756, 24778, 24817, 24826, 24827, 24828, 24829, 24831, 24832, 24845, 24865, 24902, 24913, 24983, 25402, 25403, 25404, 25405, 25431, 25436, 25441, 25442, 25443, 25471, 25472, 25473, 25669, 25670, 25671, 25672, 25698, 25771, 25995, 26041, 26086, 26093, 26094, 26129, 26130, 26162, 26175, 26193, 26264, 26265, 26297, 26373, 26403, 26444, 26445, 26468, 26469, 26470, 26498, 26559, 26591, 26612, 26656, 26700, 26789, 26804, 26855, 26856, 26857, 26927, 26937, 27047, 27180, 27222, 27223, 27297, 27306, 27323, 27326, 27339, 27375, 27384, 27392, 27396, 27402, 27403, 27413, 27418, 27420, 27446, 27448, 27449, 27453, 27454, 27466, 27529, 27568, 27569, 27572, 27583, 27589, 27622, 27660, 27663, 27669, 27679, 27688, 27689, 27702, 27710, 27757, 27802, 27851, 27880, 27889, 27921, 27929, 27931, 27988, 27994, 28008, 28055, 28064, 28128, 28190, 28198, 28230, 28240, 28248, 28254, 28260, 28265, 28273, 28279, 28293, 28294, 28295, 28296, 28299, 28300, 28304, 28305, 28307, 28316, 28330, 28333, 28352, 28367, 28454, 28455, 28456, 28457, 28458, 28459, 28460, 28461, 28462, 28463, 28466, 28469, 28478, 28483, 28485, 28509, 28520, 28525, 28542, 28543, 28544, 28617, 28627, 28631, 28632, 28633, 28643, 28648, 28655, 28663, 28664, 28724, 28738, 28739, 28740, 28741, 28751, 28761, 28762, 28770, 28773, 28777, 28778, 28786, 28789, 28816, 28839, 28852, 28874, 28928, 28929, 28932, 28935, 29011, 29027, 29038, 29079, 29081, 29094, 29099, 29100, 29105, 29138, 29170, 29192, 29215, 29276, 29345, 29397, 29401, 29416, 29425, 29459, 29521, 29558, 29577, 29580, 29581, 29595, 29597, 29599, 29655, 29685, 29752, 29771, 29772, 29773, 29812, 29815, 29816, 29870, 29871, 29876, 29877, 29881, 29928, 29999, 30050, 30078, 30079, 30091, 30101, 30103, 30122, 30125, 30126, 30130, 30131, 30132, 30133, 30138, 30139, 30151, 30153, 30207, 30210, 30302, 30339, 30342, 30366, 30402, 30415, 30421, 30492, 30514, 30559, 30577, 30588, 30589, 30598, 30614, 30646, 30649, 30650, 30651, 30655, 30669, 30700, 30707, 30712, 30742, 30744, 30745, 30749, 30832, 30878, 30887, 30950, 30990, 31006, 31047, 31077, 31092, 31105, 31117, 31246, 31264, 31272, 31312, 31353, 31358, 31364, 31400, 31481, 31517, 31576, 31577, 31641, 31643, 31653, 31683, 31684, 31743, 31745, 31767, 31777, 31794, 31811, 31817, 31845, 31869, 31880, 31887, 31888, 31915, 32167, 32168, 32202, 32224, 32232, 32256, 32264, 32266, 32277, 32298, 32314, 32318, 32319, 32328, 32339, 32366, 32427, 32431, 32442, 32504, 32520, 32527, 32530, 32531, 32532, 32575, 32606, 32608, 32647, 32662, 32694, 32742, 32782, 32784, 32819, 32824, 32825, 32827, 32829, 32831, 33045, 33192, 33377, 33742, 33835, 33874, 33953, 33958, 34157, 34213, 34319, 26688, 35614, 34381, 35089, 35106, 34810, 36155, 35014, 34743, 34781, 35376, 35820, 35227, 35226, 35062, 35821, 34755, 36093, 35015, 34562, 34741, 34899, 34737, 34739, 34740, 36209, 34738, 35055, 35297, 36099, 34548, 34879, 36944, 36945, 36946, 36947, 36983, 37543, 37574, 38751, 37814, 35228, 36737, 35018, 36189, 38121, 38548, 37801, 37745, 38289, 38310, 38353, 38527, 38528, 38587, 38588, 38870, 38882, 38907, 39135, 39581, 39672, 39743, 39744, 39841, 39842, 40151, 40199, 40218, 40263, 40363, 40479, 40506, 40617)
AND lootid=0 AND skinloot=0 AND pickpocketloot=0 AND VehicleId=0 AND (IconName IS NULL OR IconName='') AND gossip_menu_id=0 AND npcflag=0 AND mingold=0 AND mechanic_immune_mask=0 AND ScriptName='';



-- --------------------------------
-- NPC SPECIFIC
-- --------------------------------
-- Sprok (8320)
UPDATE creature_template SET faction=120 WHERE entry=8320;

-- Vhel'kur (21801), should appear flying, not walking in air
UPDATE creature_template SET InhabitType=5 WHERE entry IN(21801);

-- Wintergrasp Detection Unit (27869), Invisible shit hitting players
UPDATE creature_template SET unit_flags=262144+33554432, flags_extra=130 WHERE entry=27869;

-- Adelene Sunlance (26977), add inscription
UPDATE creature_template SET npcflag=2257 WHERE entry=26977;

-- Number Two (15554) (had 120ms attack timer...)
UPDATE creature_template SET baseattacktime=2000 WHERE entry=15554;

-- npc Girana the Blooded (34771) should be friendly only for H
UPDATE creature_template SET faction=2121 WHERE entry=34771;

-- npc Highlord Tirion Fordring (30677)
UPDATE creature_template SET minlevel=83, maxlevel=83, mindmg=468, maxdmg=702, dmg_multiplier=13.9, attackpower=175, baseattacktime=2000, rangeattacktime=2000, minrangedmg=375, maxrangedmg=562,rangedattackpower=140 WHERE entry=30677;

-- npc Mage-Commander Evenstar (26873)
UPDATE creature_template SET dynamicflags=0 WHERE entry=26873;

-- npc Decomposing Ghoul (24177)
UPDATE creature_template SET unit_flags=0 WHERE entry=24177;

-- npc The Ebon Watcher (30596)
UPDATE creature_template SET minlevel=80, maxlevel=80 WHERE entry=30596;

-- npc model crashing client
UPDATE creature_template SET modelid2=0 WHERE modelid2=17116;

-- npc Windroc Matriarch (19055)
UPDATE creature_template SET unit_flags=0 WHERE entry=19055;

-- Surveyor Orlond <Explorers' League> (26514)
-- He should be dead
UPDATE creature_template SET dynamicflags=8+32 WHERE entry=26514;

-- "Scoodles" (24899)
UPDATE creature_template SET InhabitType=2 WHERE entry=24899;

-- Magisters Tarrace overpower buff

-- Invisible aura remove Crusader Bridenbrad (30562)
UPDATE creature_template_addon SET auras="57626" WHERE entry=30562;

-- Silver Covenant Agent (36774) - make him passive
UPDATE creature_template SET unit_flags = unit_flags | 0x200 WHERE entry=36774;

-- some mobs for achiev Frostbitten (achievement=2257)
UPDATE creature_template SET faction=14, mindmg=304, maxdmg=436, attackpower=296, dmg_multiplier=7.5, minrangedmg=268, maxrangedmg=399, rangedattackpower=40 WHERE entry=32361; -- Icehorn
UPDATE creature_template SET faction=14, mindmg=304, maxdmg=436, attackpower=296, dmg_multiplier=7.5, minrangedmg=268, maxrangedmg=399, rangedattackpower=40 WHERE entry=32357; -- Old Crystalbark
UPDATE creature_template SET faction=14, mindmg=304, maxdmg=436, attackpower=296, dmg_multiplier=7.5, minrangedmg=268, maxrangedmg=399, rangedattackpower=40 WHERE entry=32377; -- Perobas the Bloodthirster
UPDATE creature_template SET faction=14, mindmg=304, maxdmg=436, attackpower=296, dmg_multiplier=7.5, minrangedmg=268, maxrangedmg=399, rangedattackpower=40 WHERE entry=32398; -- King Ping
UPDATE creature_template SET faction=31, mindmg=304, maxdmg=436, attackpower=296, dmg_multiplier=7.5, minrangedmg=268, maxrangedmg=399, rangedattackpower=40 WHERE entry=32400; -- Tukemuth
UPDATE creature_template SET faction=14, mindmg=304, maxdmg=436, attackpower=296, dmg_multiplier=7.5, minrangedmg=268, maxrangedmg=399, rangedattackpower=40 WHERE entry=32438; -- Syreian the Bonecarver
UPDATE creature_template SET faction=14, mindmg=356, maxdmg=503, attackpower=432, dmg_multiplier=7.5, minrangedmg=305, maxrangedmg=452, rangedattackpower=74 WHERE entry=32475; -- Terror Spinner
UPDATE creature_template SET minlevel=75, maxlevel=75, faction=14, mindmg=356, maxdmg=503, attackpower=432, dmg_multiplier=7.5, minrangedmg=305, maxrangedmg=452, rangedattackpower=74 WHERE entry=32471; -- Griegen
UPDATE creature_template SET faction=14, mindmg=417, maxdmg=586, attackpower=608, dmg_multiplier=7.5, minrangedmg=341, maxrangedmg=506, rangedattackpower=80 WHERE entry=32501; -- High Thane Jorfus

-- mobs for some other achievement
UPDATE creature_template SET faction=14, mindmg=417, maxdmg=586, attackpower=608, dmg_multiplier=7.5, minrangedmg=341, maxrangedmg=506, rangedattackpower=80 WHERE entry=32495; -- Hildana Deathstealer
UPDATE creature_template SET faction=14, mindmg=304, maxdmg=436, attackpower=296, dmg_multiplier=7.5, minrangedmg=268, maxrangedmg=399, rangedattackpower=40 WHERE entry=32358; -- Fumblub Gearwind
UPDATE creature_template SET faction=14, mindmg=304, maxdmg=436, attackpower=296, dmg_multiplier=7.5, minrangedmg=268, maxrangedmg=399, rangedattackpower=40 WHERE entry=32386; -- Vigdis the War Maiden

-- Forgotten Depths Ambusher (30204)
UPDATE creature_template SET unit_flags=32768 WHERE entry=30204;
DELETE FROM spell_linked_spell WHERE spell_trigger=56418;
INSERT INTO spell_linked_spell VALUES (56418, -56422, 0, "remove submerge on cast");

-- Lesser Nether Drake (21004)
UPDATE creature_template SET unit_flags=unit_flags&~258 WHERE entry=21004;
UPDATE creature SET unit_flags=unit_flags&~258 WHERE id=21004;

-- Vacillating Voidcaller (19527)
UPDATE creature_template SET unit_flags=unit_flags&~2 WHERE entry=19527;

-- Dragonmaw Sky Stalker (23030)
UPDATE creature_template SET unit_flags=unit_flags&~33554432 WHERE entry=23030;

-- Some terokkar forest creatures with wrong faction
-- Time-Lost Skettis (x)
UPDATE creature_template SET faction=1862 WHERE entry IN(21651, 21763, 21787);

-- Thomas Yance (18672)
UPDATE creature_template SET faction=35 WHERE entry=18672;

-- Sargarosa (26231)
UPDATE creature_template SET dmg_multiplier=2 WHERE entry=26231;

-- Walter Soref <Locksmith> (29728)
UPDATE creature_template SET npcflag=1 WHERE entry=29728;

-- Enraged Air Spirit (21060)
UPDATE creature_template SET modelid1=14515, modelid2=0 WHERE entry=21060;

-- Felmist (17407)
UPDATE creature_template SET modelid1=17055, modelid2=0 WHERE entry=17407;

-- Tunneler (16968)
UPDATE creature_template SET unit_flags=0 WHERE entry=16968;

-- Relara Whitemoon (3892)
DELETE FROM smart_scripts WHERE entryorguid=3892 AND source_type=0;
INSERT INTO smart_scripts VALUES (3892, 0, 0, 0, 1, 0, 100, 1, 0, 0, 0, 0, 11, 46765, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Relara Whitemoon - Out Of Combat - Cast Self Visual - Sleep Until Cancelled  (DND)');

-- Laughing Sister (4054)
UPDATE creature SET equipment_id=0 WHERE id=4054;

-- Jarven Thunderbrew (1373)
UPDATE creature_text SET type=16 WHERE entry=1373 AND groupid=0;

-- Silvermoon City Guardian (16222)
UPDATE creature_template SET AIName='SmartAI' WHERE entry=16222;
DELETE FROM smart_scripts WHERE entryorguid=16222 AND source_type=0;
DELETE FROM smart_scripts WHERE entryorguid=16222*100 AND source_type=9;
INSERT INTO smart_scripts VALUES (16222, 0, 0, 0, 22, 0, 100, 0, 58, 0, 0, 0, 5, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silvermoon City Guardian - On Received Emote - Play Emote');
INSERT INTO smart_scripts VALUES (16222, 0, 1, 0, 22, 0, 100, 0, 101, 0, 0, 0, 5, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silvermoon City Guardian - On Received Emote - Play Emote');
INSERT INTO smart_scripts VALUES (16222, 0, 2, 0, 22, 0, 100, 0, 78, 0, 0, 0, 5, 66, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silvermoon City Guardian - On Received Emote - Play Emote');
INSERT INTO smart_scripts VALUES (16222, 0, 3, 0, 22, 0, 100, 0, 84, 0, 0, 0, 5, 23, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silvermoon City Guardian - On Received Emote - Play Emote');
INSERT INTO smart_scripts VALUES (16222, 0, 4, 0, 22, 0, 100, 0, 77, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silvermoon City Guardian - On Received Emote - Play Emote');
INSERT INTO smart_scripts VALUES (16222, 0, 5, 0, 22, 0, 100, 0, 22, 0, 0, 0, 5, 25, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silvermoon City Guardian - On Received Emote - Play Emote');
INSERT INTO smart_scripts VALUES (16222, 0, 6, 7, 22, 0, 100, 0, 38, 0, 0, 0, 64, 1, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 'Silvermoon City Guardian - On Received Emote - Store Target');
INSERT INTO smart_scripts VALUES (16222, 0, 7, 0, 61, 0, 100, 0, 0, 0, 0, 0, 80, 16222*100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silvermoon City Guardian - On Received Emote - Run Script');
INSERT INTO smart_scripts VALUES (16222*100, 9, 0, 0, 0, 0, 100, 0, 1000, 1000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 12, 1, 0, 0, 0, 0, 0, 0, 'Silvermoon City Guardian - Script9 - Set Orientation');
INSERT INTO smart_scripts VALUES (16222*100, 9, 1, 0, 0, 0, 100, 0, 1500, 1500, 0, 0, 5, 16, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silvermoon City Guardian - Script9 - Play Emote');
INSERT INTO smart_scripts VALUES (16222*100, 9, 2, 0, 0, 0, 100, 0, 4000, 4000, 0, 0, 66, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Silvermoon City Guardian - Script9 - Set Orientation');
DELETE FROM conditions WHERE SourceTypeOrReferenceId=22 AND SourceEntry=16222;
INSERT INTO conditions VALUES (22, 7, 16222, 0, 0, 15, 0, 2, 0, 0, 0, 0, 0, '', 'Run action if player is paladin');
INSERT INTO conditions VALUES (22, 7, 16222, 0, 0, 16, 0, 512, 0, 0, 0, 0, 0, '', 'Run action if player is blood elf');
INSERT INTO conditions VALUES (22, 7, 16222, 0, 0, 27, 0, 60, 3, 0, 0, 0, 0, '', 'Run action if player level >= 60');

-- Val'kyr Overseer (24258)
UPDATE creature_template SET InhabitType=4 WHERE entry=24258;

-- Stormcrest Eagle (30013)
-- Frostborn Stormrider (29730) - Passenger
DELETE FROM creature_addon WHERE guid IN(SELECT guid FROM creature WHERE id=29730);
DELETE FROM creature WHERE id=29730;
UPDATE creature SET spawndist=15 WHERE id=30013;
UPDATE creature_template SET InhabitType=4 WHERE entry=30013;
UPDATE creature_template SET unit_flags=33600 WHERE entry=29730;
DELETE FROM vehicle_template_accessory WHERE entry=30013;
INSERT INTO vehicle_template_accessory VALUES (30013, 29730, 0, 0, 'Frostborn Stormrider', 6, 30000);

-- DB update 2026_03_25_03 -> 2026_03_25_04
-- Enable smooth waypoint transitions for flying creatures
-- Paths with actions or delays are excluded

-- Buzzard (2830)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (71370, 72510, 72520, 72530, 76140);

-- Antilus the Soarer (5347)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (518400);

-- Soaring Razorbeak (8276)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (928800, 928810);

-- Bloodseeker Bat (11368)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (491230, 491460, 491580, 521360, 522670, 915550);

-- Bat Rider Guard (15242)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (548400, 548410, 548420, 548430);

-- OLDWorld Trigger (DO NOT DELETE) (15384)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (876470);

-- Eye of Thrallmar (16598)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (575850, 575860, 575870, 575880);

-- Eye of Honor Hold (16887)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (584380);

-- Skeletal Gryphon (17660)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (125540, 125550);

-- Large AOI Underbat (18409)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1383120, 1383140, 1383160, 1383210, 1383270, 1383410, 1383480, 1383520);

-- Night Elf Wisp (18502)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1396910, 1396920, 1396930, 1396940, 1396950, 1396960, 1396970, 1396990);

-- Torgos (18707)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (2469160);

-- Flying Raging Soul (18726)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1324010, 1324030, 1324100, 1324150, 1324320);

-- Wildhammer Gryphon Rider (19382)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (11580, 1259220, 1259270, 1259300, 1259310, 1259320, 1260520);

-- Al'ar (19514)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1580410);

-- Nuramoc (20932)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (249410, 249420, 249430);

-- Bladewing Bloodletter (21033)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (738490, 738500, 738520, 738530, 738580, 738600);

-- Kor'kron Wyvern Rider (21153)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (742190);

-- Mature Netherwing Drake (21648)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (755410, 755420, 755430, 755440, 755450, 755460, 755470, 755480, 755490, 755500, 755510, 755520, 755530, 755540, 755550, 755560, 755570, 755580, 861030);

-- Vhel'kur (21801)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (218010);

-- Vilewing Chimaera (21879)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (844880, 845940, 845970, 846130, 846320);

-- Avian Flyer (21931)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1387630, 1387660, 1387690);

-- [PH] Cave Bat JZB (22040)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (771910, 771920, 771930, 771940, 771950, 771960);

-- Dragonmaw Skybreaker (22274)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (782910, 782920, 782930, 782940, 782950, 782960, 782970, 782980, 782990, 783000);

-- Corvax (22842)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (697120);

-- Rook (22843)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (697110);

-- Dragonmaw Sky Stalker (23030)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1481220, 1481230, 1481270, 1481280, 1481290, 1481380, 1481390);

-- Invisible Stalker (Floating) (23033)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1312500, 1312520, 1338940, 1338990, 1339000);

-- Monstrous Kaliri (23051)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (790170, 832370, 832380, 860990, 861150, 861160, 861170, 861310, 861330, 1325530, 1325540, 1325550, 1325560, 1325570, 1325580, 1325600, 1325620, 1325640, 1325650, 1325660, 1325670);

-- Dragonmaw Transporter (23188)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1328140, 1328180);

-- Lady Sinestra (23283)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (287960);

-- Dragonflayer Raider (23557)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (971330, 971340, 971350, 971390, 971400);

-- Plagued Proto-Dragon (23680)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1076260);

-- Proto-Drake (23689)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1081500, 1081510, 1081520, 1081550, 1081560, 1081580);

-- Spotted Hippogryph (23772)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (938020, 938030, 938040, 938050, 938060, 938070, 938080, 938090, 938100, 938110, 938120, 938130, 938140, 938150, 938160, 938170, 938180, 938190, 938200, 938210, 938220, 938230, 938240, 938250, 938260, 938270, 938280, 938290, 938300, 938310, 938320, 938330, 938340, 938350, 938360, 938370, 938380, 938390, 938400, 938410, 938420, 938430, 938440);

-- Val'kyr Watcher (23935)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (482340, 482350, 482360, 482370, 482380, 482390, 482400, 482410, 482420, 482430, 482440);

-- Windy Cloud (24222)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1410000, 1410010, 1410020, 1410030, 1410040, 1410060, 1410070, 1410080);

-- Steelfeather (24514)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1142380);

-- Talonshrike (24518)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1147130);

-- Buoy (24707)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1078110);

-- Fjord Hawk (24747)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (938510, 938530, 938560, 938590, 938600, 938640, 938660, 938680, 938730, 938750, 938790, 938810, 938880, 938900);

-- Nexus Watcher (24770)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1241160, 1241170, 1241180, 1241190, 1241200, 1241210, 1241220, 1241230, 1241240, 1241250, 1241260);

-- Fjord Hawk Matriarch (24787)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1158350, 1158370, 1158430, 1158440, 1158450);

-- Proto-Drake Rider (24849)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1259340, 1259360, 1259370, 1259400);

-- Dawnblade Hawkrider (25063)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (839990, 840020, 840030, 840040, 840050, 840060);

-- Shattered Sun Bombardier (25144)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (853700, 853720, 853730, 853740);

-- Bloodspore Moth (25464)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1327080);

-- Spirit of the North (25711)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1210760, 1225710);

-- Fizzcrank Bomber (25765)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1113600);

-- D.E.H.T.A. Enforcer (25819)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1329840);

-- Shaman Beam Bunny 000 (25964)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (125390);

-- Shaman Beam Bunny 001 (25965)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (125400);

-- Shaman Beam Bunny 002 (25966)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (125410);

-- Nexus Drake Hatchling (26127)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1210410, 1210420, 1210430, 1210440, 1210450, 1210460, 1210470);

-- Carrion Condor (26174)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1018170, 1018400, 1018550, 1018860, 1018870, 1019250, 1019290);

-- Nexus Guardian (26276)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1113040, 1113590);

-- Emberwyrm (26286)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1123860, 1123870);

-- Dreadtalon (26838)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1161740);

-- Reanimated Frost Wyrm (26841)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (404970, 404980, 404990, 405000, 405010, 405020, 405030, 405040, 405050);

-- Sarathstra (26858)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1124010);

-- Wyrmrest Temple Drake (26925)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1001700, 1002060, 1002070, 1002080, 1002090, 1002100, 1002130, 1002150, 1002160, 1002260, 1309990);

-- Wyrmrest Guardian (26933)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1008230, 1008240, 1008250, 1008260, 1310350, 1310360, 1310370, 1310380);

-- Forgotten Captain (27220)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1033880, 1033910, 1033940, 1033960, 1033980, 1034000, 1034030, 1034110);

-- Risen Gryphon (27241)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1311770, 1311780);

-- Emerald Skytalon (27244)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1057430, 1057510, 1057710, 1057730, 1057760, 1057900, 1057920, 1057930);

-- Reconstructed Frost Wyrm (27285)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1099150, 1099160, 1099270);

-- Cosmetic Drakkari Bat [PH] (27490)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1275080, 1275090, 1275100, 1275110, 1275120, 1275130);

-- Azure Dragon (27608)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (991050, 991060, 991070, 991080, 991090, 991100, 991110, 991120, 991130, 991140, 991150, 991160, 991170, 991180);

-- Azure Drake (27682)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (990780, 990790, 990830, 990840, 990850, 990860, 990870, 990880, 990890, 990920, 990930, 990940, 990950, 990960, 990970, 990980, 990990, 991030, 991040);

-- Heb'Drakkar Striker (28465)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1005360, 1005400);

-- Scarlet Gryphon (28614)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1293080, 1293090);

-- Olrun the Battlecaller (29047)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1287390);

-- Gundrak Bat Rider (29332)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1097750, 1097780, 1097820, 1097840, 1097860, 1097870, 1097930, 1097950, 1098560);

-- Onslaught Gryphon Rider (29333)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1231100, 1231120, 1231290, 1231300, 1231320, 1231330, 1231420, 1231430, 1231460, 1231470, 1231560, 1231570);

-- Vargul Plaguetalon (29453)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (976340);

-- Frigid Proto-Drake (29460)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (979910, 979920, 979950, 980250, 980260, 980270, 980280);

-- Nascent Val'kyr (29570)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1077080, 1077240, 1077780, 1077820, 1077870, 1077890, 1077910, 1077930, 1077950, 1077960, 1077970, 1077980, 1077990);

-- Hyldsmeet Proto-Drake (29625)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1134270, 1134280, 1134290, 1134300, 1134460, 1134470, 1134480, 1134490, 1134500, 1134510, 1134520, 1134570, 1134580, 1134590, 1134610, 1134620, 1134630, 1134640, 1134650, 1134660, 1134670);

-- Stormpeak Wyrm (29753)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1010000, 1011070, 1011080, 1011090, 1011100, 1011110, 1011120, 1011130, 1011140, 1011150, 1011170, 1011180, 1011190, 1011200, 1011210, 1011220);

-- Sirana Iceshriek (29794)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (2025870);

-- Stormcrest Eagle (30013)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1017130, 1017140, 1017150, 1018010);

-- Wild Wyrm (30275)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (2029720, 2029730, 2029740, 2029750, 2029760, 2029770);

-- Jotunheim Proto-Drake (30330)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1227590, 1227600, 1227610, 1227620, 1227630, 1227640, 1227650, 1227660, 1227670, 1227680, 1227690, 1227700, 1227710, 1227720, 1227730, 1227740, 1227750, 1227760, 1241110, 1241120);

-- Wrathstrike Gargoyle (30482)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1348070, 1348080, 1348090, 1348100, 1348110, 1348120, 1348130, 1348140);

-- Scourgebeak Fleshripper (30988)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1210070, 1210110, 1210140, 1210170, 1210190, 1210230, 1210250);

-- Wrathstrike Gargoyle (31040)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1217480, 1217490, 1217500, 1217510, 1217520, 1217530, 1217540, 1217550);

-- Frostbrood Skytalon (31137)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1234960, 1234970, 1234980, 1234990, 1235020, 1235030, 1235040, 1235070, 1235090);

-- Kor'kron Battle Wyvern (31269)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (992270, 992280, 992300);

-- Crystal Wyrm (31393)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1111560, 1111620);

-- Frostbrood Spawn (31702)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1244190, 1244200, 1244210, 1244220, 1244230, 1244240, 1244250);

-- Stabled Hunter Pet (31768)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (2087870);

-- Stabled Hunter Pet (31769)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (2087880);

-- Tempus Wyrm (32180)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1129570);

-- Infinite Eradicator (32185)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1134360, 1134380);

-- Skybreaker Recon Fighter (32189)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1240870, 1240880, 1240890, 1240900);

-- Orgrim's Hammer Scout (32201)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1241600, 1241870, 1241880, 1241890, 1241900, 1241910, 1241920, 1241930, 1241940, 1241950, 1241960, 1242070, 1242080, 1242090, 1242120, 1242130, 1242140, 1242150, 1242160, 1242180, 1242190, 1242200, 1242210, 1242220);

-- Northrend Daily Dungeon Image Bunny (32265)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (973340);

-- Fumblub Gearwind (32358)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1519380);

-- Ebon Blade Gargoyle (32472)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1244280, 1244290);

-- Time-Lost Proto Drake (32491)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (392030, 392040, 392050, 392060);

-- Frostbrood Matriarch (32492)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1181850, 1181860, 1181880, 1181890, 1181900);

-- Vyragosa (32630)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (392030, 392040, 392050, 392060);

-- Frostbrood Sentry (32767)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1251080, 1251090, 1251100, 1251550, 1251620);

-- Mechanolift 304-A (33214)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (13681700, 13681801, 13681802, 13681803, 13681804, 13681805, 13681806, 13681807, 13681808, 13681809, 13681810, 13681811, 13681812, 13681813, 13681814, 13681815, 13681816, 13681817, 13681818, 13682000, 13682101, 13682102, 13682103, 13682104, 13682105, 13682106, 13682107, 13682108, 13682109, 13682110, 13682300, 13682700, 13683000, 13683100, 13685300, 13686200, 13686800, 13687000, 13688500);

-- Guardian of Life (33528)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1375280, 1375290, 1375300, 1375310);

-- Chillmaw (33687)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (2008510);

-- Tournament Hippogryph (33778)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (1231520);

-- Stonespine Gargoyle (36896)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (2018220, 2018240, 2018340, 2018380, 2018460);

-- Val'kyr Herald (37098)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (2012450, 2013220);

-- Spire Frostwyrm (Ambient) (37528)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (2008870, 2009600, 2009750);

-- Argent Hippogryph (37968)
UPDATE `waypoint_data` SET `smoothTransition` = 1 WHERE `id` IN (887940, 887960, 887980, 887990);

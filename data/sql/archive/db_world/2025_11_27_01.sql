-- DB update 2025_11_27_00 -> 2025_11_27_01
--
-- Setthek Talon Lord wields a sword, but shares id1 with War Hawk (no equipment)
-- workaround for error: Table `creature` have creature (Entries: 18321, 21904, 0) one or more with equipment_id 1 not found in table `creature_equip_template`, set to no equipment.
DELETE FROM `smart_scripts` WHERE (`entryorguid` = 18321) AND (`source_type` = 0) AND (`id` IN (1));
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(18321, 0, 1, 0, 37, 0, 100, 0, 0, 0, 0, 0, 0, 0, 124, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Sethekk Talon Lord - On Initialize - Load Equipment Id 1');

-- CreatureID 2603 (Kovork)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 2603 AND `guid` IN (300753);

-- CreatureID 2604 (Molok the Crusher)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 2604 AND `guid` IN (300754);

-- CreatureID 2605 (Zalas Witherbark)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 2605 AND `guid` IN (300757, 301300, 301301, 301302);

-- CreatureID 2606 (Nimar the Slayer)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 2606 AND `guid` IN (300755, 301290, 301291, 301292);

-- CreatureID 4842 (Earthcaller Halmgar)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 4842 AND `guid` IN (1975863);

-- CreatureID 5569 (Fizzlebang Booms)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 5569 AND `guid` IN (12523);

-- CreatureID 6490 (Azshir the Sleepless)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 6490 AND `guid` IN (1975841);

-- CreatureID 7157 (Deadwood Avenger)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 7157 AND `guid` IN (40303, 40304, 40386, 40388);

-- CreatureID 7158 (Deadwood Shaman)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 7158 AND `guid` IN (40305);

-- CreatureID 7354 (Ragglesnout)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 7354 AND `guid` IN (247108);

-- CreatureID 8116 (Ziggle Sparks)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 8116 AND `guid` IN (12524);

-- CreatureID 8117 (Wizbang Booms)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 8117 AND `guid` IN (12525);

-- CreatureID 8121 (Jaxxil Sparks)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 8121 AND `guid` IN (12527);

-- CreatureID 8122 (Kizzak Sparks)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 8122 AND `guid` IN (12528);

-- CreatureID 8387 (Horizon Scout First Mate)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 8387 AND `guid` IN (160359);

-- CreatureID 8388 (Horizon Scout Cook)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 8388 AND `guid` IN (160360);

-- CreatureID 8389 (Horizon Scout Engineer)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 8389 AND `guid` IN (160361);

-- CreatureID 8478 (Second Mate Shandril)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 8478 AND `guid` IN (160363);

-- CreatureID 9216 (Spirestone Warlord)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 9216 AND `guid` IN (24187, 24188, 248595, 248596, 248597, 248598, 248599, 248600);

-- CreatureID 9462 (Chieftain Bloodmaw)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 9462 AND `guid` IN (40427);

-- CreatureID 9693 (Bloodaxe Evoker)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 9693 AND `guid` IN (52124, 52125, 52126, 52127, 52128, 52129, 52130, 52131, 52132, 52133, 52134);

-- CreatureID 11277 (Caer Darrow Citizen)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 11277 AND `guid` IN (131325, 131326, 131327, 131328, 131338, 131343, 131344, 131346, 131347);

-- CreatureID 11279 (Caer Darrow Guardsman)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 11279 AND `guid` IN (131329, 131330, 131331, 131342);

-- CreatureID 11280 (Caer Darrow Cannoneer)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 11280 AND `guid` IN (131332, 131333, 131334);

-- CreatureID 11287 (Baker Masterson)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 11287 AND `guid` IN (131345);

-- CreatureID 11316 (Joseph Dirte)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 11316 AND `guid` IN (131337);

-- CreatureID 14684 (Balzaphon)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 14684 AND `guid` IN (248654);

-- CreatureID 14695 (Lord Blackwood)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 14695 AND `guid` IN (153321);

-- CreatureID 14724 (Bubulo Acerbus)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 14724 AND `guid` IN (1741);

-- CreatureID 15197 (Darkcaller Yanka)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15197 AND `guid` IN (240193);

-- CreatureID 15199 (Sergeant Hartman)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15199 AND `guid` IN (240192);

-- CreatureID 15264 (Anubisath Sentinel)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15264 AND `guid` IN (87564, 87565, 87566, 87567, 87568, 87569, 87570, 87571);

-- CreatureID 15275 (Emperor Vek'nilash)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15275 AND `guid` IN (88076);

-- CreatureID 15276 (Emperor Vek'lor)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15276 AND `guid` IN (88077);

-- CreatureID 15383 (Sergeant Stonebrow)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15383 AND `guid` IN (83120);

-- CreatureID 15431 (Corporal Carnes)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15431 AND `guid` IN (83121);

-- CreatureID 15434 (Private Draxlegauge)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15434 AND `guid` IN (83123);

-- CreatureID 15437 (Master Nightsong)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15437 AND `guid` IN (83124);

-- CreatureID 15445 (Sergeant Major Germaine)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15445 AND `guid` IN (83125);

-- CreatureID 15446 (Bonnie Stoneflayer)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15446 AND `guid` IN (83126);

-- CreatureID 15448 (Private Porter)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15448 AND `guid` IN (83127);

-- CreatureID 15450 (Marta Finespindle)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15450 AND `guid` IN (83128);

-- CreatureID 15451 (Sentinel Silversky)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15451 AND `guid` IN (83129);

-- CreatureID 15453 (Keeper Moonshade)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15453 AND `guid` IN (83131);

-- CreatureID 15455 (Slicky Gastronome)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15455 AND `guid` IN (83132);

-- CreatureID 15457 (Huntress Swiftriver)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15457 AND `guid` IN (83134);

-- CreatureID 15458 (Commander Stronghammer)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15458 AND `guid` IN (83146);

-- CreatureID 15459 (Miner Cromwell)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15459 AND `guid` IN (83152);

-- CreatureID 15460 (Grunt Maug)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15460 AND `guid` IN (83153);

-- CreatureID 15469 (Senior Sergeant T'kelah)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15469 AND `guid` IN (83154);

-- CreatureID 15477 (Herbalist Proudfeather)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15477 AND `guid` IN (83155);

-- CreatureID 15502 (Andorgos)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15502 AND `guid` IN (87527);

-- CreatureID 15503 (Kandrostrasz)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15503 AND `guid` IN (87529);

-- CreatureID 15504 (Vethsera)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15504 AND `guid` IN (87528);

-- CreatureID 15508 (Batrider Pele'keiki)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15508 AND `guid` IN (83156);

-- CreatureID 15512 (Apothecary Jezel)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15512 AND `guid` IN (83157);

-- CreatureID 15515 (Skinner Jamani)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15515 AND `guid` IN (83158);

-- CreatureID 15522 (Sergeant Umala)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15522 AND `guid` IN (83148);

-- CreatureID 15525 (Doctor Serratus)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15525 AND `guid` IN (83159);

-- CreatureID 15528 (Healer Longrunner)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15528 AND `guid` IN (83160);

-- CreatureID 15532 (Stoneguard Clayhoof)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15532 AND `guid` IN (83162);

-- CreatureID 15533 (Bloodguard Rawtar)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15533 AND `guid` IN (83149);

-- CreatureID 15534 (Fisherman Lin'do)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15534 AND `guid` IN (83150);

-- CreatureID 15535 (Chief Sharpclaw)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15535 AND `guid` IN (83151);

-- CreatureID 15539 (General Zog)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15539 AND `guid` IN (83118);

-- CreatureID 15700 (Warlord Gorchuk)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15700 AND `guid` IN (83168);

-- CreatureID 15701 (Field Marshal Snowfall)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15701 AND `guid` IN (83140);

-- CreatureID 15702 (Senior Sergeant Taiga)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15702 AND `guid` IN (83169);

-- CreatureID 15703 (Senior Sergeant Grimsford)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15703 AND `guid` IN (83170);

-- CreatureID 15704 (Senior Sergeant Kai'jin)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15704 AND `guid` IN (83171);

-- CreatureID 15707 (Master Sergeant Fizzlebolt)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15707 AND `guid` IN (83172);

-- CreatureID 15709 (Master Sergeant Moonshadow)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15709 AND `guid` IN (83174);

-- CreatureID 15723 (Booty Bay Reveler)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15723 AND `guid` IN (420041, 420042, 420043, 420044, 420045, 420046, 420047, 420048, 420049, 420050, 420051, 420052, 420053, 420054, 420055, 420056, 420057, 420058, 420059);

-- CreatureID 15724 (Drunken Bruiser)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15724 AND `guid` IN (420060, 420061, 420062, 420063, 420064, 420065, 420066, 420067, 420068, 420069, 420070, 420071, 420072, 420073, 420074, 420075, 420076, 420077, 420078, 420079, 420080, 420081, 420082, 420083, 420084, 420085, 420086, 420087, 420088, 420089, 420090, 420091, 420092, 420093, 420094, 420095, 420096, 420097, 420098, 420099, 420100, 420101, 420102, 420103, 420104, 420105, 420106, 420107, 420108, 420109, 420110, 420111, 420112, 420113, 420114, 420115, 420116, 420117, 420118, 420119, 420120, 420121);

-- CreatureID 15765 (Officer Redblade)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 15765 AND `guid` IN (83179);

-- CreatureID 16241 (Argent Recruiter)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 16241 AND `guid` IN (12863, 12867, 12870, 12871);

-- CreatureID 16255 (Argent Scout)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 16255 AND `guid` IN (12876, 12880, 12884, 12887);

-- CreatureID 16281 (Keeper of the Rolls)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 16281 AND `guid` IN (12860);

-- CreatureID 16285 (Argent Emissary)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 16285 AND `guid` IN (12861, 12864, 12868, 12872);

-- CreatureID 16359 (Argent Messenger)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 16359 AND `guid` IN (12877, 12881, 12885, 12888);

-- CreatureID 16361 (Commander Thomas Helleran)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 16361 AND `guid` IN (12862);

-- CreatureID 16384 (Argent Dawn Initiate)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 16384 AND `guid` IN (153326, 153327, 153328);

-- CreatureID 16395 (Argent Dawn Paladin)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 16395 AND `guid` IN (153322, 153323, 153324, 153325);

-- CreatureID 16433 (Argent Dawn Crusader)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 16433 AND `guid` IN (153329, 153330, 153331, 153332);

-- CreatureID 16434 (Argent Dawn Champion)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 16434 AND `guid` IN (153336, 153337, 153338, 153339);

-- CreatureID 16435 (Argent Dawn Cleric)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 16435 AND `guid` IN (153333, 153334, 153335);

-- CreatureID 16436 (Argent Dawn Priest)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 16436 AND `guid` IN (153340, 153341, 153342);

-- CreatureID 17190 (Siltfin Murloc)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 17190 AND `guid` IN (60815, 60818, 60820, 60821, 60822, 60825, 60827, 60830, 60831, 60834, 60836, 60837, 60839, 60842, 60845, 60847, 60853, 60854, 60858, 60859, 60863, 60864, 60870, 60871, 60872, 60875, 60877, 60879, 60884, 60887, 60889, 60892, 60895, 60899, 60901, 60903, 60904, 60906, 60907, 60908, 60911, 60913, 60916);

-- CreatureID 17191 (Siltfin Oracle)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 17191 AND `guid` IN (60816, 60819, 60823, 60824, 60826, 60828, 60833, 60835, 60838, 60841, 60843, 60846, 60850, 60851, 60852, 60856, 60861, 60862, 60865, 60866, 60868, 60869, 60873, 60876, 60880, 60881, 60882, 60883, 60885, 60888, 60891, 60898, 60900, 60902, 60910, 60912, 60914, 60915);

-- CreatureID 17192 (Siltfin Hunter)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 17192 AND `guid` IN (60817, 60829, 60832, 60840, 60844, 60848, 60849, 60860, 60867, 60874, 60878, 60886, 60894, 60905, 60909, 60917, 60918);

-- CreatureID 17211 (Human Footman)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 17211 AND `guid` IN (76021, 76022, 76023, 76025, 76026, 76027, 76029, 76031);

-- CreatureID 17469 (Orc Grunt)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 17469 AND `guid` IN (76020, 76028, 76030, 76032, 76033, 76035, 76036, 76040);

-- CreatureID 17701 (Lord Xiz)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 17701 AND `guid` IN (63448);

-- CreatureID 17885 (Earthbinder Rayge)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 17885 AND `guid` IN (138478);

-- CreatureID 18192 (Horde Halaani Guard)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 18192 AND `guid` IN (12416, 12417, 12418, 12419, 12420, 12421, 12422, 12423, 12424, 12425, 12426, 12427, 12428, 12429, 12430);

-- CreatureID 18206 (Wastewalker Captive)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 18206 AND `guid` IN (79461, 79463, 79469, 79471, 79472, 79475, 79482, 79488, 79490, 135044, 135045, 135047, 135048, 135049, 135050, 135051, 135052, 135054, 135055, 135057, 135058, 135060, 135061, 135062, 135063, 135064, 135065, 135066, 135067, 135072, 135073, 135074, 135075, 135076, 135077, 135078, 135079, 135080, 135081, 135082, 135083, 135084, 135085, 135086, 135087, 135089);

-- CreatureID 18256 (Alliance Halaani Guard)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 18256 AND `guid` IN (12436, 12437, 12438, 12439, 12440, 12441, 12442, 12443, 12444, 12445, 12446, 12447, 12448, 12449, 12450);

-- CreatureID 18556 (Phasing Soldier)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 18556 AND `guid` IN (132411, 132422, 132436);

-- CreatureID 18557 (Phasing Cleric)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 18557 AND `guid` IN (132409, 132413, 132414, 132425, 132429, 132430);

-- CreatureID 18558 (Phasing Sorcerer)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 18558 AND `guid` IN (132404, 132417, 132431, 132437);

-- CreatureID 18559 (Phasing Stalker)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 18559 AND `guid` IN (132406, 132408, 132416, 132420, 132421, 132428);

-- CreatureID 18684 (Bro'Gaz the Clanless)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 18684 AND `guid` IN (100866, 100867, 100868);

-- CreatureID 20885 (Dalliah the Doomsayer)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 20885 AND `guid` IN (138950);

-- CreatureID 21474 (Coreiel)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21474 AND `guid` IN (12413);

-- CreatureID 21485 (Aldraan)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21485 AND `guid` IN (12433);

-- CreatureID 21682 (Human Cleric)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21682 AND `guid` IN (76046, 76048);

-- CreatureID 21683 (Human Conjurer)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21683 AND `guid` IN (76047);

-- CreatureID 21684 (King Llane)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21684 AND `guid` IN (76049);

-- CreatureID 21726 (Summoned Daemon)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21726 AND `guid` IN (76034, 76039);

-- CreatureID 21736 (Wildhammer Defender)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21736 AND `guid` IN (213465, 213466, 213467, 213468, 213469, 213470, 213471, 213472, 213473, 213474, 213475, 213476, 213477, 213478, 213479, 213480, 213481, 213482, 213483, 213484, 213485, 213486, 213487, 213488, 213489, 213490, 213491, 213492, 213493, 213494, 213495, 213496, 213497, 213498, 213499, 213500, 213501, 213502, 213503, 213504, 213505, 213506, 213507, 213508, 213509, 213510, 213511, 213512, 213513, 213514, 213515, 213516, 213517, 213518, 213519, 213520, 213521, 213522, 213523, 213524, 213525, 213526, 213527, 213528, 213529, 213530, 213531, 213532, 213533, 213534, 213535, 213536, 213537, 213538, 213539, 213540, 213541, 213542, 213543, 213544, 213545, 213546, 213547, 213548, 213549, 213550, 213551, 213552, 213553, 213554, 213555, 213556, 213557, 213558, 213559, 213560, 213561, 213562, 213563, 213564, 213565, 213566, 213567, 213568, 213569, 213570, 213571, 213572, 213573, 213574, 213575, 213576, 213577, 213578, 213579, 213580, 213581, 213582, 213583, 213584, 213585, 213586, 213587, 213588, 213589, 213590);

-- CreatureID 21747 (Orc Necrolyte)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21747 AND `guid` IN (76037, 76041);

-- CreatureID 21748 (Orc Wolf)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21748 AND `guid` IN (76038, 76042);

-- CreatureID 21749 (Shadowmoon Scout)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21749 AND `guid` IN (213591, 213592, 213593, 213594, 213595, 213596, 213597, 213598, 213599, 213600, 213601, 213602, 213603, 213604, 213605, 213606, 213607, 213608, 213609, 213610, 213611, 213612, 213613, 213614, 213615, 213616, 213617, 213618, 213619, 213620, 213621, 213622, 213623, 213624, 213625, 213626, 213627, 213628, 213629, 213630, 213631, 213632, 213633, 213634, 213635, 213636, 213637, 213638, 213639, 213640, 213641, 213642, 213643, 213644, 213645, 213646, 213647, 213648, 213649, 213650, 213651, 213652, 213653, 213654, 213655, 213656, 213657, 213658, 213659, 213660, 213661, 213662, 213663, 213664, 213665, 213666, 213667, 213668, 213669, 213670, 213671, 213672, 213673, 213674, 213675, 213676, 213677, 213678, 213679, 213680, 213681, 213682, 213683, 213684, 213685, 213686, 213687, 213688, 213689, 213690, 213691, 213692, 213693, 213694, 213695, 213696, 213697, 213698, 213699, 213700, 213701, 213702, 213703, 213704, 213705, 213706, 213707, 213708, 213709, 213710, 213711, 213712, 213713, 213714, 213715, 213716, 213717, 213718, 213719);

-- CreatureID 21750 (Orc Warlock)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21750 AND `guid` IN (76043);

-- CreatureID 21752 (Warchief Blackhand)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21752 AND `guid` IN (76044);

-- CreatureID 21797 (Ancient Shadowmoon Spirit)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21797 AND `guid` IN (100050);

-- CreatureID 21846 (Slain Auchenai Warrior)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21846 AND `guid` IN (1977353, 1977354, 1977355, 1977356, 1977357, 1977358, 1977359, 1977360, 1977361, 1977362, 1977363, 1977364, 1977365, 1977366, 1977367, 1977368, 1977369, 1977370, 1977371, 1977372, 1977373, 1977374, 1977375, 1977376, 1977377, 1977378, 1977379, 1977380, 1977381, 1977382, 1977383, 1977384, 1977385, 1977386, 1977387, 1977388);

-- CreatureID 21961 (Cataclysm Overseer)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 21961 AND `guid` IN (213306, 213307, 213308, 213309, 213310, 213311, 213312, 213313);

-- CreatureID 22954 (Illidari Fearbringer)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 22954 AND `guid` IN (148140, 148141, 148142, 148143);

-- CreatureID 22955 (Charming Courtesan)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 22955 AND `guid` IN (148543, 148544, 148547, 148548, 148549, 148551, 148554, 148556, 148558, 148559, 148560, 148562, 148563, 148565, 148568, 148571, 148572, 148576, 148577, 148578, 148581, 148584, 148586, 148588, 148589, 148593, 148594, 148597, 148598, 148600, 148603, 148609, 148610, 148612, 148613, 148614, 148616, 148619, 148621, 148622, 148624, 148626, 148627, 148628, 148629, 148632, 148634, 148636, 148638, 148639, 148640, 148643, 148645, 148648, 148649, 148650, 148653, 148656, 148658, 148661, 148662, 148664, 148666, 148668, 148670, 148671, 148674, 148675);

-- CreatureID 23008 (Ethereum Jailor)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23008 AND `guid` IN (1975937, 1975938, 1975939, 1975940, 1975941, 1975942, 1975943, 1975944, 1975945, 1975946, 1975947, 1975948, 1975949, 1975950, 1975951, 1975952, 1975953, 1975954, 1975955, 1975956, 1975957);

-- CreatureID 23023 (Scryer Reveler)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23023 AND `guid` IN (420203, 420204, 420205, 420206, 420207, 420208, 420209, 420210, 420211, 420212);

-- CreatureID 23024 (Aldor Reveler)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23024 AND `guid` IN (420213, 420214, 420215, 420216, 420217, 420218, 420219, 420220);

-- CreatureID 23039 (Draenei Reveler)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23039 AND `guid` IN (420221, 420222, 420223, 420224, 420225, 420226, 420227, 420228, 420229, 420230, 420231, 420232, 420233, 420234, 420235, 420236, 420237, 420238, 420239);

-- CreatureID 23045 (Blood Elf Reveler)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23045 AND `guid` IN (420240, 420241, 420242, 420243, 420244, 420245, 420246, 420247, 420248, 420249, 420250, 420251, 420252, 420253, 420254, 420255, 420256);

-- CreatureID 23146 (Dragonmaw Enforcer)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23146 AND `guid` IN (52106, 52107, 52108, 52109, 52110, 52111, 52112, 52113, 52114, 52115, 52121, 52230, 52231, 143596, 143597, 143598);

-- CreatureID 23196 (Bonechewer Behemoth)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23196 AND `guid` IN (148360, 148361, 148362, 148363, 148364);

-- CreatureID 23305 (Crazed Murkblood Foreman)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23305 AND `guid` IN (143892, 143893);

-- CreatureID 23311 (Disobedient Dragonmaw Peon)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23311 AND `guid` IN (136178, 136179, 136180, 136181, 136182, 136183, 136184, 136185, 136186, 136187, 136188, 136189, 136190, 136191, 136192, 136193, 136194, 136195, 136196, 136197, 136198, 136199, 136200, 136201, 136202, 136203, 136204, 136205, 136206, 136207, 136208, 136209, 136210, 136211, 136212, 136213, 136214, 136215, 136216, 136217, 136218, 136219, 136220, 136221, 136222);

-- CreatureID 23324 (Crazed Murkblood Miner)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23324 AND `guid` IN (143882, 143883, 143884, 143885, 143886, 143887, 143888, 143889, 143890, 143891);

-- CreatureID 23381 (Tydormu)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23381 AND `guid` IN (139700);

-- CreatureID 23437 (Indormi)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23437 AND `guid` IN (139701);

-- CreatureID 23718 (Mack)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23718 AND `guid` IN (139273);

-- CreatureID 23748 (Kurzel)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23748 AND `guid` IN (139328);

-- CreatureID 23872 (Coren Direbrew)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23872 AND `guid` IN (240000);

-- CreatureID 23982 (Forsaken Deckhand)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 23982 AND `guid` IN (88486, 88487, 88488, 88489, 88490, 88491, 88492, 88493, 88494, 88495, 88496, 88497, 88498, 88499, 88500, 88501, 88502, 88503, 88504, 88505, 88506, 88507, 88508, 88509, 88510, 88511, 88512, 88513, 88514, 88515, 88516, 88517, 88518, 88519, 88520, 88521, 88522, 88523, 88524, 88525, 88526, 88527, 88528, 88529, 88530, 88531, 88532, 88533, 88534, 88535, 88536, 88537, 88538);

-- CreatureID 24239 (Hex Lord Malacrass)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 24239 AND `guid` IN (89357);

-- CreatureID 24364 (Flynn Firebrew)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 24364 AND `guid` IN (240002);

-- CreatureID 24527 (Bok Dropcertain)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 24527 AND `guid` IN (134677, 240001);

-- CreatureID 24833 (Captain "Stash" Torgoley)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 24833 AND `guid` IN (52011);

-- CreatureID 24834 (Galley Chief Grace)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 24834 AND `guid` IN (52012);

-- CreatureID 24835 (First Mate Kowalski)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 24835 AND `guid` IN (52013);

-- CreatureID 24838 (Sailor Henders)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 24838 AND `guid` IN (52016);

-- CreatureID 24839 (Sailor Wicks)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 24839 AND `guid` IN (52017);

-- CreatureID 24840 (Sailor Vines)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 24840 AND `guid` IN (52018);

-- CreatureID 24841 (Marine Halters)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 24841 AND `guid` IN (52019);

-- CreatureID 24842 (Marine Anderson)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 24842 AND `guid` IN (52020);

-- CreatureID 24843 (Engineer Combs)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 24843 AND `guid` IN (52021);

-- CreatureID 25239 (Thulrin)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 25239 AND `guid` IN (110115);

-- CreatureID 25258 (Footman Rob)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 25258 AND `guid` IN (85221);

-- CreatureID 25259 (Footman George)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 25259 AND `guid` IN (85222);

-- CreatureID 25261 (Footman Chuck)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 25261 AND `guid` IN (85226);

-- CreatureID 25338 (Warsong Caravan Guard)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 25338 AND `guid` IN (74539, 74540, 74541);

-- CreatureID 26335 (Fallen Earthen Warrior)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 26335 AND `guid` IN (117222);

-- CreatureID 26772 (Icemist Warrior)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 26772 AND `guid` IN (75010, 75011, 75012, 75013, 75014, 75015, 75016, 75017, 75018, 75019, 75020, 75021);

-- CreatureID 28106 (Shaman Jakjek)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 28106 AND `guid` IN (1975898);

-- CreatureID 28209 (Mizli Crankwheel)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 28209 AND `guid` IN (12564);

-- CreatureID 28210 (Ognip Blastbolt)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 28210 AND `guid` IN (12565);

-- CreatureID 28344 (Blazzle)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 28344 AND `guid` IN (116);

-- CreatureID 28347 (Miles Sidney)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 28347 AND `guid` IN (45216);

-- CreatureID 28355 (Wright Williams)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 28355 AND `guid` IN (45215);

-- CreatureID 28495 (Gawanil)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 28495 AND `guid` IN (110277);

-- CreatureID 28496 (Chulo the Mad)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 28496 AND `guid` IN (110278);

-- CreatureID 28668 (Zepik the Gorloc Hunter)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 28668 AND `guid` IN (202970);

-- CreatureID 29503 (Fjorn)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 29503 AND `guid` IN (88308);

-- CreatureID 29519 (Unworthy Initiate)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 29519 AND `guid` IN (128557, 128558, 128559);

-- CreatureID 29520 (Unworthy Initiate)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 29520 AND `guid` IN (128561, 128563);

-- CreatureID 29565 (Unworthy Initiate)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 29565 AND `guid` IN (128740);

-- CreatureID 29566 (Unworthy Initiate)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 29566 AND `guid` IN (128742, 128743, 128744);

-- CreatureID 29567 (Unworthy Initiate)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 29567 AND `guid` IN (128747, 128748, 128749);

-- CreatureID 29862 (Stormforged Monitor)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 29862 AND `guid` IN (1975936);

-- CreatureID 30060 (Stormforged Warmonger)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 30060 AND `guid` IN (1976443, 1976444, 1976445, 1976446, 1976447, 1976448, 1976449, 1976450, 1976451, 1976452, 1976453, 1976454);

-- CreatureID 30065 (Frostborn Axemaster)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 30065 AND `guid` IN (1976470, 1976471, 1976472, 1976473, 1976474, 1976475, 1976476, 1976477, 1976478, 1976479, 1976480, 1976481, 1976482, 1976483, 1976484, 1976485, 1976486, 1976487, 1976488, 1976489, 1976490, 1976491, 1976492);

-- CreatureID 30099 (Njormeld)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 30099 AND `guid` IN (1975964);

-- CreatureID 30121 (Frost Giant Stormherald)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 30121 AND `guid` IN (1975993, 1975994, 1975995);

-- CreatureID 30182 (Yorg Stormheart)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 30182 AND `guid` IN (1976494);

-- CreatureID 30188 (Argent Champion)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 30188 AND `guid` IN (1977144, 1977145, 1977146, 1977147, 1977148, 1977149, 1977150, 1977151, 1977152, 1977153, 1977154, 1977155, 1977156, 1977157, 1977158, 1977159, 1977160, 1977161, 1977162, 1977163, 1977164, 1977165, 1977166, 1977167, 1977168);

-- CreatureID 30295 (Thorim)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 30295 AND `guid` IN (1955077);

-- CreatureID 30382 (Brann Bronzebeard)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 30382 AND `guid` IN (1976495);

-- CreatureID 30399 (Thorim)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 30399 AND `guid` IN (49141);

-- CreatureID 30571 (Michael Belfast)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 30571 AND `guid` IN (1970932);

-- CreatureID 31283 (Orbaz Bloodbane)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31283 AND `guid` IN (129851);

-- CreatureID 31306 (Margrave Dhakar)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31306 AND `guid` IN (74957);

-- CreatureID 31314 (Ebon Blade Veteran)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31314 AND `guid` IN (74952, 74953, 74954, 74955);

-- CreatureID 31316 (Ebon Blade Reaper)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31316 AND `guid` IN (129852, 129853, 129859, 129860, 129862, 129863, 129865, 129866, 129867, 129868, 129869, 129870, 129871, 129872, 129873, 129874);

-- CreatureID 31412 (Thrall)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31412 AND `guid` IN (3108763);

-- CreatureID 31420 (Karus)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31420 AND `guid` IN (1976083);

-- CreatureID 31421 (Koma)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31421 AND `guid` IN (1976084);

-- CreatureID 31422 (Soran)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31422 AND `guid` IN (1976085);

-- CreatureID 31423 (Kaja)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31423 AND `guid` IN (1976086);

-- CreatureID 31425 (Olvia)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31425 AND `guid` IN (1976088);

-- CreatureID 31426 (Doras)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31426 AND `guid` IN (1976089);

-- CreatureID 31427 (Felika)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31427 AND `guid` IN (1976090);

-- CreatureID 31428 (Crusader Olakin Sainrith)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31428 AND `guid` IN (74958);

-- CreatureID 31431 (Overlord Runthak)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31431 AND `guid` IN (1976093);

-- CreatureID 31440 (Sergeant Kregga)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31440 AND `guid` IN (1975899);

-- CreatureID 31649 (Vol'jin)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31649 AND `guid` IN (3109787);

-- CreatureID 31739 (Warsong Battleguard)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 31739 AND `guid` IN (3109792, 3109793, 3109794, 3109795);

-- CreatureID 32239 (Highlord Tirion Fordring)
UPDATE `creature` SET `equipment_id` = 2 WHERE `id1` = 32239 AND `guid` IN (74512);

-- CreatureID 32241 (Disguised Crusader)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 32241 AND `guid` IN (74513, 74514, 74515);

-- CreatureID 32365 (Lady Sylvanas Windrunner)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 32365 AND `guid` IN (3109786);

-- CreatureID 32376 (Broll Bearmantle)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 32376 AND `guid` IN (3109766);

-- CreatureID 32378 (Valeera Sanguinar)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 32378 AND `guid` IN (3109767);

-- CreatureID 32387 (Stormwind Elite)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 32387 AND `guid` IN (3109768, 3109769, 3109770, 3109771, 3109772, 3109773);

-- CreatureID 32401 (King Varian Wrynn)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 32401 AND `guid` IN (3109764);

-- CreatureID 32402 (Lady Jaina Proudmoore)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 32402 AND `guid` IN (3109765);

-- CreatureID 32518 (Thrall)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 32518 AND `guid` IN (3109785);

-- CreatureID 34382 (Chapman)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 34382 AND `guid` IN (240228, 240229, 240251, 240252, 240253, 240254, 240255, 240256, 240257, 240258);

-- CreatureID 34383 (Catrina)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 34383 AND `guid` IN (240226, 240227, 240259, 240260, 240261, 240262, 240263, 240264, 240265, 240266);

-- CreatureID 34478 (Cheerful Dwarf Spirit)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 34478 AND `guid` IN (240293);

-- CreatureID 34528 (Tahu Sagewind)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 34528 AND `guid` IN (37);

-- CreatureID 34712 (Roberta Carter)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 34712 AND `guid` IN (240609);

-- CreatureID 34713 (Ondani Greatmill)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 34713 AND `guid` IN (240534);

-- CreatureID 34714 (Mahara Goldwheat)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 34714 AND `guid` IN (240577);

-- CreatureID 34744 (Jasper Moore)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 34744 AND `guid` IN (240458);

-- CreatureID 34768 (William Mullins)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 34768 AND `guid` IN (240610);

-- CreatureID 34785 (Alnar Whitebough)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 34785 AND `guid` IN (240519);

-- CreatureID 34786 (Alice Rigsdale)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 34786 AND `guid` IN (240642);

-- CreatureID 36162 (Goblin Engineering Crew)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 36162 AND `guid` IN (74976, 74977);

-- CreatureID 36164 (Kor'kron Reaver)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 36164 AND `guid` IN (74978, 74979, 74980, 74981, 74982, 74983, 74984, 74985, 74986, 74987);

-- CreatureID 36165 (7th Legion Deckhand)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 36165 AND `guid` IN (74998, 74999);

-- CreatureID 36166 (7th Legion Marine)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 36166 AND `guid` IN (74988, 74989, 74990, 74991, 74992, 74993, 74994, 74995, 74996, 74997);

-- CreatureID 36217 (Overseer Kraggosh)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 36217 AND `guid` IN (79263);

-- CreatureID 36296 (Apothecary Hummel)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 36296 AND `guid` IN (146623);

-- CreatureID 36888 (Rescued Alliance Slave)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 36888 AND `guid` IN (202285, 202286, 202287, 202288);

-- CreatureID 36889 (Rescued Horde Slave)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 36889 AND `guid` IN (202279, 202280, 202283, 202284);

-- CreatureID 36970 (Skybreaker Deckhand)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 36970 AND `guid` IN (133978, 133979, 133980, 133981, 133982, 133983, 133984, 133985);

-- CreatureID 36971 (Orgrim's Hammer Crew)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 36971 AND `guid` IN (133964, 133965, 133966, 133967, 133968, 133969, 133970, 133971, 133975);

-- CreatureID 37182 (High Captain Justin Bartlett)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 37182 AND `guid` IN (133977);

-- CreatureID 37184 (Zafod Boombox)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 37184 AND `guid` IN (133957, 133976);

-- CreatureID 37214 (Crown Lackey)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 37214 AND `guid` IN (12461, 12462, 12463, 12464, 12465, 12466, 244581, 244582, 244583, 244584, 244585, 244586, 244587, 244588, 244589, 244590);

-- CreatureID 37226 (The Lich King)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 37226 AND `guid` IN (1971982);

-- CreatureID 37523 (Warden of the Sunwell)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 37523 AND `guid` IN (1976590, 1976591);

-- CreatureID 37527 (Halduron Brightwing)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 37527 AND `guid` IN (43498);

-- CreatureID 37715 (Snivel Rustrocket)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 37715 AND `guid` IN (244629, 244630);

-- CreatureID 37763 (Grand Magister Rommath)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 37763 AND `guid` IN (1976652);

-- CreatureID 37765 (Captain Auric Sunchaser)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 37765 AND `guid` IN (1976655);

-- CreatureID 37833 (Sky-Reaver Korm Blackscar)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 37833 AND `guid` IN (133958);

-- CreatureID 37917 (Crown Thug)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 37917 AND `guid` IN (12483, 12484, 12485, 12486, 12487, 12488, 12489, 12490, 12491, 12492, 12493, 12494, 244567, 244568, 244569, 244570, 244591, 244592, 244593, 244594, 244595);

-- CreatureID 37984 (Crown Duster)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 37984 AND `guid` IN (12468, 12469, 12470, 12471, 12472, 244621, 244622, 244623, 244624, 244625);

-- CreatureID 38006 (Crown Hoodlum)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 38006 AND `guid` IN (12473, 12474, 12475, 12476, 12477, 244616, 244617, 244618, 244619, 244620);

-- CreatureID 38023 (Crown Sprinkler)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 38023 AND `guid` IN (12500, 12501, 12502, 12503, 12504, 244596, 244597, 244598, 244599, 244600);

-- CreatureID 38030 (Crown Underling)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 38030 AND `guid` IN (12505, 12506, 12507, 12508, 12509, 12510, 12511, 244601, 244602, 244603, 244604, 244605);

-- CreatureID 38032 (Crown Sprayer)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 38032 AND `guid` IN (12512, 12513, 12514, 12515, 12516, 12517, 12518, 12519, 12520, 12521, 12522, 244532, 244533, 244534, 244535, 244536, 244537, 244538, 244539, 244540, 244541, 244542, 244543, 244544);

-- CreatureID 38065 (Crown Supply Sentry)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 38065 AND `guid` IN (244631, 244632, 244633);

-- CreatureID 40446 (Skar'this the Summoner)
UPDATE `creature` SET `equipment_id` = 1 WHERE `id1` = 40446 AND `guid` IN (12549);

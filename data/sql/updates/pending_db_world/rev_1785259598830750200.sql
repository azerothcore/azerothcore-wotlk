--
-- Issue #26694: pickpocket does not work on heroic difficulty entries
-- Difficulty (heroic) creature_template entries inherit `lootid` but were left with
-- `pickpocketloot` = 0, so SpellInfo::CheckTarget() returns SPELL_FAILED_TARGET_NO_POCKETS.
-- Mirror the normal-mode pickpocket loot template onto their difficulty entries.
--
-- Grimtooth
UPDATE `creature_template` SET `pickpocketloot` = 603 WHERE `entry` IN (22555, 32000, 37319);
-- Wildpaw Gnoll
UPDATE `creature_template` SET `pickpocketloot` = 10991 WHERE `entry` IN (22785, 32146, 37476);
-- Wildpaw Shaman
UPDATE `creature_template` SET `pickpocketloot` = 11837 WHERE `entry` IN (22787, 32148, 37478);
-- Wildpaw Mystic
UPDATE `creature_template` SET `pickpocketloot` = 11838 WHERE `entry` IN (22786, 32147, 37477);
-- Wildpaw Alpha
UPDATE `creature_template` SET `pickpocketloot` = 11840 WHERE `entry` IN (22783, 32144, 37474);
-- Vanndar Stormpike
UPDATE `creature_template` SET `pickpocketloot` = 11948 WHERE `entry` IN (22644, 31818, 37444);
-- Umi Thorson
UPDATE `creature_template` SET `pickpocketloot` = 13078 WHERE `entry` IN (22696, 32119, 37442);
-- Keetar
UPDATE `creature_template` SET `pickpocketloot` = 13079 WHERE `entry` IN (22683, 32026, 37346);
-- Irondeep Guard
UPDATE `creature_template` SET `pickpocketloot` = 13080 WHERE `entry` IN (22743, 32014, 37333);
-- Irondeep Surveyor
UPDATE `creature_template` SET `pickpocketloot` = 13098 WHERE `entry` IN (22749, 32020, 37339);
-- Lieutenant Rugba
UPDATE `creature_template` SET `pickpocketloot` = 13137 WHERE `entry` IN (22707, 32038, 37358);
-- Lieutenant Spencer
UPDATE `creature_template` SET `pickpocketloot` = 13138 WHERE `entry` IN (22708, 32039, 37359);
-- Commander Dardosh <old>
UPDATE `creature_template` SET `pickpocketloot` = 13140 WHERE `entry` IN (22613, 31952, 37270);
-- Lieutenant Stronghoof
UPDATE `creature_template` SET `pickpocketloot` = 13143 WHERE `entry` IN (22710, 32041, 37361);
-- Lieutenant Vol\'talar
UPDATE `creature_template` SET `pickpocketloot` = 13144 WHERE `entry` IN (22711, 32042, 37362);
-- Lieutenant Grummus
UPDATE `creature_template` SET `pickpocketloot` = 13145 WHERE `entry` IN (22701, 32031, 37351);
-- Lieutenant Murp <old>
UPDATE `creature_template` SET `pickpocketloot` = 13146 WHERE `entry` IN (22706, 32037, 37357);
-- Lieutenant Lewis
UPDATE `creature_template` SET `pickpocketloot` = 13147 WHERE `entry` IN (22703, 32034, 37354);
-- Commander Malgor
UPDATE `creature_template` SET `pickpocketloot` = 13152 WHERE `entry` IN (22617, 31956, 37274);
-- Commander Mulfort
UPDATE `creature_template` SET `pickpocketloot` = 13153 WHERE `entry` IN (22619, 31958, 37276);
-- Commander Louis Philips
UPDATE `creature_template` SET `pickpocketloot` = 13154 WHERE `entry` IN (22616, 31955, 37273);
-- Wing Commander Jeztor
UPDATE `creature_template` SET `pickpocketloot` = 13180 WHERE `entry` IN (22697, 31826, 37481);
-- Wing Commander Mulverick
UPDATE `creature_template` SET `pickpocketloot` = 13181 WHERE `entry` IN (22598, 31825, 37482);
-- Grunnda Wolfheart
UPDATE `creature_template` SET `pickpocketloot` = 13218 WHERE `entry` IN (22681, 32001, 37320);
-- Frostwolf Shaman
UPDATE `creature_template` SET `pickpocketloot` = 13284 WHERE `entry` IN (22678, 31989, 37308);
-- Lieutenant Largent
UPDATE `creature_template` SET `pickpocketloot` = 13296 WHERE `entry` IN (22702, 32033, 37353);
-- Lieutenant Stouthandle
UPDATE `creature_template` SET `pickpocketloot` = 13297 WHERE `entry` IN (22709, 32040, 37360);
-- Lieutenant Greywand
UPDATE `creature_template` SET `pickpocketloot` = 13298 WHERE `entry` IN (22700, 32030, 37350);
-- Lieutenant Lonadin
UPDATE `creature_template` SET `pickpocketloot` = 13299 WHERE `entry` IN (22704, 32035, 37355);
-- Commander Karl Philips
UPDATE `creature_template` SET `pickpocketloot` = 13320 WHERE `entry` IN (22615, 31954, 37272);
-- Seasoned Defender
UPDATE `creature_template` SET `pickpocketloot` = 13326 WHERE `entry` IN (22714, 32062, 37383);
-- Seasoned Guardian
UPDATE `creature_template` SET `pickpocketloot` = 13328 WHERE `entry` IN (22715, 32063, 37384);
-- Veteran Guardian
UPDATE `creature_template` SET `pickpocketloot` = 13332 WHERE `entry` IN (22589, 32126, 37451);
-- Sergeant Yazra Bloodsnarl
UPDATE `creature_template` SET `pickpocketloot` = 13448 WHERE `entry` IN (22760, 32077, 37398);
-- Veteran Coldmine Guard
UPDATE `creature_template` SET `pickpocketloot` = 13535 WHERE `entry` IN (22771, 32122, 37446);
-- Seasoned Coldmine Surveyor
UPDATE `creature_template` SET `pickpocketloot` = 13537 WHERE `entry` IN (22754, 32060, 37381);
-- Veteran Coldmine Surveyor
UPDATE `creature_template` SET `pickpocketloot` = 13538 WHERE `entry` IN (22773, 32124, 37448);
-- Seasoned Irondeep Explorer
UPDATE `creature_template` SET `pickpocketloot` = 13540 WHERE `entry` IN (22755, 32065, 37386);
-- Veteran Irondeep Explorer
UPDATE `creature_template` SET `pickpocketloot` = 13541 WHERE `entry` IN (22774, 32128, 37453);
-- Veteran Irondeep Raider
UPDATE `creature_template` SET `pickpocketloot` = 13544 WHERE `entry` IN (22776, 32130, 37455);
-- Seasoned Coldmine Explorer
UPDATE `creature_template` SET `pickpocketloot` = 13546 WHERE `entry` IN (22751, 32057, 37378);
-- Seasoned Irondeep Guard
UPDATE `creature_template` SET `pickpocketloot` = 13552 WHERE `entry` IN (22756, 32066, 37387);
-- Seasoned Irondeep Surveyor
UPDATE `creature_template` SET `pickpocketloot` = 13555 WHERE `entry` IN (22758, 32068, 37389);
-- Fel Orc Convert
UPDATE `creature_template` SET `pickpocketloot` = 17083 WHERE `entry` IN (20567);
-- Broggok
UPDATE `creature_template` SET `pickpocketloot` = 17380 WHERE `entry` IN (18601);
-- Orc Captive
UPDATE `creature_template` SET `pickpocketloot` = 17416 WHERE `entry` IN (18613);
-- Fel Orc Neophyte
UPDATE `creature_template` SET `pickpocketloot` = 17429 WHERE `entry` IN (18603);
-- Laughing Skull Warden
UPDATE `creature_template` SET `pickpocketloot` = 17624 WHERE `entry` IN (18611);
-- Murkblood Healer
UPDATE `creature_template` SET `pickpocketloot` = 17730 WHERE `entry` IN (20177);
-- Lordaeron Watchman
UPDATE `creature_template` SET `pickpocketloot` = 17814 WHERE `entry` IN (20538);
-- Pit Spectator
UPDATE `creature_template` SET `pickpocketloot` = 17846 WHERE `entry` IN (20543);
-- Rokmar the Crackler
UPDATE `creature_template` SET `pickpocketloot` = 17991 WHERE `entry` IN (19895);
-- Infinite Saboteur
UPDATE `creature_template` SET `pickpocketloot` = 18172 WHERE `entry` IN (20533);
-- Mechano-Lord Capacitus
UPDATE `creature_template` SET `pickpocketloot` = 19219 WHERE `entry` IN (21533);
-- Durnholde Lookout
UPDATE `creature_template` SET `pickpocketloot` = 22128 WHERE `entry` IN (22129);
-- Bladespire Guardian
UPDATE `creature_template` SET `pickpocketloot` = 22261 WHERE `entry` IN (30760);
-- Bladespire Elder
UPDATE `creature_template` SET `pickpocketloot` = 22262 WHERE `entry` IN (30759);
-- Bladespire Keg King
UPDATE `creature_template` SET `pickpocketloot` = 22263 WHERE `entry` IN (30761);
-- Tarren Mill Guardsman
UPDATE `creature_template` SET `pickpocketloot` = 23175 WHERE `entry` IN (23182);
-- Tarren Mill Lookout
UPDATE `creature_template` SET `pickpocketloot` = 23177 WHERE `entry` IN (23184);
-- Tarren Mill Lookout
UPDATE `creature_template` SET `pickpocketloot` = 23178 WHERE `entry` IN (23183);
-- Tarren Mill Protector
UPDATE `creature_template` SET `pickpocketloot` = 23179 WHERE `entry` IN (23186);
-- Tarren Mill Protector
UPDATE `creature_template` SET `pickpocketloot` = 23180 WHERE `entry` IN (23185);
-- Gan\'arg Analyzer
UPDATE `creature_template` SET `pickpocketloot` = 23386 WHERE `entry` IN (30773);
-- Dragonflayer Strategist
UPDATE `creature_template` SET `pickpocketloot` = 23956 WHERE `entry` IN (31666);
-- Dragonflayer Runecaster
UPDATE `creature_template` SET `pickpocketloot` = 23960 WHERE `entry` IN (31663);
-- Dragonflayer Ironhelm
UPDATE `creature_template` SET `pickpocketloot` = 23961 WHERE `entry` IN (30747);
-- Dragonflayer Bonecrusher
UPDATE `creature_template` SET `pickpocketloot` = 24069 WHERE `entry` IN (31658);
-- Dragonflayer Heartsplitter
UPDATE `creature_template` SET `pickpocketloot` = 24071 WHERE `entry` IN (31660);
-- Dragonflayer Metalworker
UPDATE `creature_template` SET `pickpocketloot` = 24078 WHERE `entry` IN (31661);
-- Dragonflayer Forge Master
UPDATE `creature_template` SET `pickpocketloot` = 24079 WHERE `entry` IN (31659);
-- Dragonflayer Weaponsmith
UPDATE `creature_template` SET `pickpocketloot` = 24080 WHERE `entry` IN (31667);
-- Proto-Drake Handler
UPDATE `creature_template` SET `pickpocketloot` = 24082 WHERE `entry` IN (31675);
-- Tunneling Ghoul
UPDATE `creature_template` SET `pickpocketloot` = 24084 WHERE `entry` IN (31681);
-- Dragonflayer Overseer
UPDATE `creature_template` SET `pickpocketloot` = 24085 WHERE `entry` IN (31662);
-- Coilskar Witch
UPDATE `creature_template` SET `pickpocketloot` = 24696 WHERE `entry` IN (25547);
-- Sister of Torment
UPDATE `creature_template` SET `pickpocketloot` = 24697 WHERE `entry` IN (25563);
-- Dawnblade Summoner
UPDATE `creature_template` SET `pickpocketloot` = 24978 WHERE `entry` IN (25548);
-- Dragonflayer Deathseeker
UPDATE `creature_template` SET `pickpocketloot` = 26550 WHERE `entry` IN (30764);
-- Dragonflayer Fanatic
UPDATE `creature_template` SET `pickpocketloot` = 26553 WHERE `entry` IN (30765);
-- Dragonflayer Seer
UPDATE `creature_template` SET `pickpocketloot` = 26554 WHERE `entry` IN (30766);
-- Ymirjar Berserker
UPDATE `creature_template` SET `pickpocketloot` = 26696 WHERE `entry` IN (30816);
-- Horde Berserker
UPDATE `creature_template` SET `pickpocketloot` = 26799 WHERE `entry` IN (30495);
-- Alliance Berserker
UPDATE `creature_template` SET `pickpocketloot` = 26800 WHERE `entry` IN (30496);
-- Horde Ranger
UPDATE `creature_template` SET `pickpocketloot` = 26801 WHERE `entry` IN (30508);
-- Alliance Ranger
UPDATE `creature_template` SET `pickpocketloot` = 26802 WHERE `entry` IN (30509);
-- Horde Cleric
UPDATE `creature_template` SET `pickpocketloot` = 26803 WHERE `entry` IN (30497);
-- Frenzied Geist, Scourge Hulk, Ymirjar Dusk Shaman, Ymirjar Flesh Hunter, Ymirjar Savage
UPDATE `creature_template` SET `pickpocketloot` = 27533 WHERE `entry` IN (30806, 30817, 30818, 30821, 31671);
-- Dark Rune Warrior
UPDATE `creature_template` SET `pickpocketloot` = 27960 WHERE `entry` IN (31377);
-- Dark Rune Worker
UPDATE `creature_template` SET `pickpocketloot` = 27961 WHERE `entry` IN (31378);
-- Dark Rune Elementalist
UPDATE `creature_template` SET `pickpocketloot` = 27962 WHERE `entry` IN (31372);
-- Dark Rune Theurgist
UPDATE `creature_template` SET `pickpocketloot` = 27963 WHERE `entry` IN (31376);
-- Dark Rune Scholar
UPDATE `creature_template` SET `pickpocketloot` = 27964 WHERE `entry` IN (31374);
-- Dark Rune Shaper
UPDATE `creature_template` SET `pickpocketloot` = 27965 WHERE `entry` IN (31375);
-- Ymirjar Necromancer
UPDATE `creature_template` SET `pickpocketloot` = 28368 WHERE `entry` IN (30820);
-- Hardened Steel Reaver
UPDATE `creature_template` SET `pickpocketloot` = 28578 WHERE `entry` IN (30967);
-- Hardened Steel Berserker
UPDATE `creature_template` SET `pickpocketloot` = 28579 WHERE `entry` IN (30966);
-- Hardened Steel Skycaller
UPDATE `creature_template` SET `pickpocketloot` = 28580 WHERE `entry` IN (30968);
-- Stormforged Tactician
UPDATE `creature_template` SET `pickpocketloot` = 28581 WHERE `entry` IN (30977);
-- Stormforged Mender
UPDATE `creature_template` SET `pickpocketloot` = 28582 WHERE `entry` IN (30974);
-- Stormforged Runeshaper
UPDATE `creature_template` SET `pickpocketloot` = 28836 WHERE `entry` IN (30975);
-- Drakkari Earthshaker
UPDATE `creature_template` SET `pickpocketloot` = 29829 WHERE `entry` IN (30926);
-- Ruins Dweller
UPDATE `creature_template` SET `pickpocketloot` = 29920 WHERE `entry` IN (30939);
-- Plague Walker
UPDATE `creature_template` SET `pickpocketloot` = 30283 WHERE `entry` IN (31466);
-- Twilight Apostle, Twilight Darkcaster, Twilight Worshipper
UPDATE `creature_template` SET `pickpocketloot` = 30319 WHERE `entry` IN (31471, 31472, 31475);

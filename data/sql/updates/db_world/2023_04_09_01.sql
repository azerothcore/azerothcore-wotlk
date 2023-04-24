-- DB update 2023_04_09_00 -> 2023_04_09_01
--
SET @REP_MEDIUM_N := 12;
SET @REP_MEDIUM_H := 15;
SET @REP_SMALL_N := 2;
SET @REP_SMALL_H := 3;
SET @REP_BOSS_N := 120;
SET @REP_BOSS_H := 250;
SET @REP_LARGE_N := 24;
SET @REP_LARGE_H := 30;

DELETE FROM `creature_onkill_reputation` WHERE (`creature_id` IN (16507,16523,16593,16594,16699,16700,16704,16807,16808,16809,17083,17356,17357,17420,17427,17461,17462,17464,17465,17471,17552,17578,17611,17621,17622,17623,17669,17670,17671,17687,17693,17694,17695,18370,19523,19524,20709,20593,20591,20582,20576,20590,20589,20594,20568,20597,20596,20567,20565,20566,20587,20579,20581,20595,20586,20583,20570,20569,20578,20575,20574,20588,20584,20592,20577,20580,20598,20572,20573));
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(16507, 946, 947, 7, 0, @REP_MEDIUM_N, 7, 0, @REP_MEDIUM_N, 1), -- Shattered Hand Sentry
(16523, 946, 947, 7, 0, @REP_MEDIUM_N, 7, 0, @REP_MEDIUM_N, 1), -- Shattered Hand Savage
(16593, 946, 947, 7, 0, @REP_MEDIUM_N, 7, 0, @REP_MEDIUM_N, 1), -- Shattered Hand Brawler
(16594, 946, 947, 7, 0, @REP_MEDIUM_N, 7, 0, @REP_MEDIUM_N, 1), -- Shadowmoon Acolyte
(16699, 946, 947, 7, 0, @REP_MEDIUM_N, 7, 0, @REP_MEDIUM_N, 1), -- Shattered Hand Reaver
(16700, 946, 947, 7, 0, @REP_MEDIUM_N, 7, 0, @REP_MEDIUM_N, 1), -- Shattered Hand Legionnaire
(16704, 946, 947, 7, 0, @REP_MEDIUM_N, 7, 0, @REP_MEDIUM_N, 1), -- Shattered Hand Sharpshooter
(16807, 946, 947, 7, 0, @REP_BOSS_N, 7, 0, @REP_BOSS_N, 1), -- Grand Warlock Nethekurse
(16808, 946, 947, 7, 0, @REP_BOSS_N, 7, 0, @REP_BOSS_N, 1), -- Warchief Kargath Bladefist
(16809, 946, 947, 7, 0, @REP_BOSS_N, 7, 0, @REP_BOSS_N, 1), -- Warbringer O'mrogg
(17083, 946, 947, 7, 0, @REP_SMALL_N, 7, 0, @REP_SMALL_N, 1), -- Fel Orc Convert
(17420, 946, 947, 7, 0, @REP_MEDIUM_N, 7, 0, @REP_MEDIUM_N, 1), -- Shattered Hand Heathen
(17427, 946, 947, 7, 0, @REP_MEDIUM_N, 7, 0, @REP_MEDIUM_N, 1), -- Shattered Hand Archer
(17461, 946, 947, 7, 0, @REP_LARGE_N, 7, 0, @REP_LARGE_N, 1), -- Shattered Hand Blood Guard
(17462, 946, 947, 7, 0, @REP_SMALL_N, 7, 0, @REP_SMALL_N, 1), -- Shattered Hand Zealot
(17464, 946, 947, 7, 0, @REP_MEDIUM_N, 7, 0, @REP_MEDIUM_N, 1), -- Shattered Hand Gladiator
(17465, 946, 947, 7, 0, @REP_LARGE_N, 7, 0, @REP_LARGE_N, 1), -- Shattered Hand Centurion
(17621, 946, 947, 7, 0, @REP_SMALL_N, 7, 0, @REP_SMALL_N, 1), -- Heathen Guard
(17622, 946, 947, 7, 0, @REP_SMALL_N, 7, 0, @REP_SMALL_N, 1), -- Sharpshooter Guard
(17623, 946, 947, 7, 0, @REP_SMALL_N, 7, 0, @REP_SMALL_N, 1), -- Reaver Guard
(17669, 946, 947, 7, 0, @REP_SMALL_N, 7, 0, @REP_SMALL_N, 1), -- Rabid Warhound
(17670, 946, 947, 7, 0, @REP_MEDIUM_N, 7, 0, @REP_MEDIUM_N, 1), -- Shattered Hand Houndmaster
(17671, 946, 947, 7, 0, @REP_MEDIUM_N, 7, 0, @REP_MEDIUM_N, 1), -- Shattered Hand Champion
(17694, 946, 947, 7, 0, @REP_MEDIUM_N, 7, 0, @REP_MEDIUM_N, 1), -- Shadowmoon Darkcaster
(17695, 946, 947, 7, 0, @REP_SMALL_N, 7, 0, @REP_SMALL_N, 1), -- Shattered Hand Assassin

(20593, 946, 947, 7, 0, @REP_MEDIUM_H, 7, 0, @REP_MEDIUM_H, 1), -- Shattered Hand Sentry (1)
(20591, 946, 947, 7, 0, @REP_MEDIUM_H, 7, 0, @REP_MEDIUM_H, 1), -- Shattered Hand Savage (1)
(20582, 946, 947, 7, 0, @REP_MEDIUM_H, 7, 0, @REP_MEDIUM_H, 1), -- Shattered Hand Brawler (1)
(20576, 946, 947, 7, 0, @REP_MEDIUM_H, 7, 0, @REP_MEDIUM_H, 1), -- Shadowmoon Acolyte (1)
(20590, 946, 947, 7, 0, @REP_MEDIUM_H, 7, 0, @REP_MEDIUM_H, 1), -- Shattered Hand Reaver (1)
(20589, 946, 947, 7, 0, @REP_MEDIUM_H, 7, 0, @REP_MEDIUM_H, 1), -- Shattered Hand Legionnaire (1)
(20594, 946, 947, 7, 0, @REP_MEDIUM_H, 7, 0, @REP_MEDIUM_H, 1), -- Shattered Hand Sharpshooter (1)
(20568, 946, 947, 7, 0, @REP_BOSS_H, 7, 0, @REP_BOSS_H, 1), -- Grand Warlock Nethekurse (1)
(20597, 946, 947, 7, 0, @REP_BOSS_H, 7, 0, @REP_BOSS_H, 1), -- Warchief Kargath Bladefist (1)
(20596, 946, 947, 7, 0, @REP_BOSS_H, 7, 0, @REP_BOSS_H, 1), -- Warbringer O'mrogg (1)
(20567, 946, 947, 7, 0, @REP_SMALL_H, 7, 0, @REP_SMALL_H, 1), -- Fel Orc Convert (1)
(20587, 946, 947, 7, 0, @REP_MEDIUM_H, 7, 0, @REP_MEDIUM_H, 1), -- Shattered Hand Heathen (1)
(20579, 946, 947, 7, 0, @REP_MEDIUM_H, 7, 0, @REP_MEDIUM_H, 1), -- Shattered Hand Archer (1)
(20581, 946, 947, 7, 0, @REP_BOSS_H, 7, 0, @REP_BOSS_H, 1), -- Blood Guard Porung
(20595, 946, 947, 7, 0, @REP_SMALL_H, 7, 0, @REP_SMALL_H, 1), -- Shattered Hand Zealot (1)
(20586, 946, 947, 7, 0, @REP_MEDIUM_H, 7, 0, @REP_MEDIUM_H, 1), -- Shattered Hand Gladiator (1)
(20583, 946, 947, 7, 0, @REP_LARGE_H, 7, 0, @REP_LARGE_H, 1), -- Shattered Hand Centurion (1)
(20569, 946, 947, 7, 0, @REP_SMALL_H, 7, 0, @REP_SMALL_H, 1), -- Heathen Guard (1)
(20578, 946, 947, 7, 0, @REP_SMALL_H, 7, 0, @REP_SMALL_H, 1), -- Sharpshooter Guard (1)
(20575, 946, 947, 7, 0, @REP_SMALL_H, 7, 0, @REP_SMALL_H, 1), -- Reaver Guard (1)
(20574, 946, 947, 7, 0, @REP_SMALL_H, 7, 0, @REP_SMALL_H, 1), -- Rabid Warhound (1)
(20588, 946, 947, 7, 0, @REP_MEDIUM_H, 7, 0, @REP_MEDIUM_H, 1), -- Shattered Hand Houndmaster (1)
(20584, 946, 947, 7, 0, @REP_MEDIUM_H, 7, 0, @REP_MEDIUM_H, 1), -- Shattered Hand Champion (1)
(20577, 946, 947, 7, 0, @REP_MEDIUM_H, 7, 0, @REP_MEDIUM_H, 1), -- Shadowmoon Darkcaster (1)
(20580, 946, 947, 7, 0, @REP_SMALL_H, 7, 0, @REP_SMALL_H, 1); -- Shattered Hand Assassin (1)

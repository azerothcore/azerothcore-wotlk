-- DB update 2023_04_04_06 -> 2023_04_04_07
-- Steamvault
DELETE FROM `creature_onkill_reputation` WHERE (`creature_id` IN (17721,17722,17796,17797,17798,17799,17800,17801,17802,17803,17805,17917,17951,17954,20926,21338,21694,21695,21696,20620,20621,20622,20623,20624,20625,20626,20627,20628,20629,20630,20631,20632,20633,21914,21915,21916,21917));
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(17721, 942, 0, 7, 0, 12, 0, 0, 0, 0), -- Coilfang Engineer
(17722, 942, 0, 7, 0, 12, 0, 0, 0, 0), -- Coilfang Sorceress
(17796, 942, 0, 7, 0, 120, 0, 0, 0, 0), -- Mekgineer Steamrigger
(17797, 942, 0, 7, 0, 120, 0, 0, 0, 0), -- Hydromancer Thespia
(17798, 942, 0, 7, 0, 120, 0, 0, 0, 0), -- Warlord Kalithresh
(17799, 942, 0, 7, 0, 12, 0, 0, 0, 0), -- Dreghood Slave
(17800, 942, 0, 7, 0, 12, 0, 0, 0, 0), -- Coilfang Myrmidon
(17801, 942, 0, 7, 0, 12, 0, 0, 0, 0), -- Coilfang Siren
(17802, 942, 0, 7, 0, 12, 0, 0, 0, 0), -- Coilfang Warrior
(17803, 942, 0, 7, 0, 12, 0, 0, 0, 0), -- Coilfang Oracle
(17805, 942, 0, 7, 0, 12, 0, 0, 0, 0), -- Coilfang Slavemaster
(17917, 942, 0, 7, 0, 12, 0, 0, 0, 0), -- Coilfang Water Elemental
(21338, 942, 0, 7, 0, 2, 0, 0, 0, 0), -- Coilfang Leper
(21694, 942, 0, 7, 0, 24, 0, 0, 0, 0), -- Bog Overlord
(21695, 942, 0, 7, 0, 12, 0, 0, 0, 0), -- Tidal Surger
(21696, 942, 0, 7, 0, 2, 0, 0, 0, 0), -- Steam Surger
-- Heroic
(20620, 942, 0, 7, 0, 15, 0, 0, 0, 0), -- Coilfang Engineer
(20621, 942, 0, 7, 0, 15, 0, 0, 0, 0), -- Coilfang Myrmidon
(20622, 942, 0, 7, 0, 15, 0, 0, 0, 0), -- Coilfang Oracle
(20623, 942, 0, 7, 0, 15, 0, 0, 0, 0), -- Coilfang Siren
(20624, 942, 0, 7, 0, 15, 0, 0, 0, 0), -- Coilfang Slavemaster
(20625, 942, 0, 7, 0, 15, 0, 0, 0, 0), -- Coilfang Sorceress
(20626, 942, 0, 7, 0, 15, 0, 0, 0, 0), -- Coilfang Warrior
(20627, 942, 0, 7, 0, 15, 0, 0, 0, 0), -- Coilfang Water Elemental
(20628, 942, 0, 7, 0, 15, 0, 0, 0, 0), -- Dreghood Slave
(20629, 942, 0, 7, 0, 250, 0, 0, 0, 0), -- Hydromancer Thespia
(20630, 942, 0, 7, 0, 250, 0, 0, 0, 0), -- Mekgineer Steamrigger
(20633, 942, 0, 7, 0, 250, 0, 0, 0, 0), -- Warlord Kalithresh
(21914, 942, 0, 7, 0, 30, 0, 0, 0, 0), -- Bog Overlord
(21915, 942, 0, 7, 0, 3, 0, 0, 0, 0), -- Coilfang Leper
(21916, 942, 0, 7, 0, 3, 0, 0, 0, 0), -- Steam Surger
(21917, 942, 0, 7, 0, 15, 0, 0, 0, 0); -- Tidal Surger

-- Shadow Labyrinth
DELETE FROM `creature_onkill_reputation` WHERE (`creature_id` IN (19208,19209,20660,20661,18631,18632,18633,18634,18635,18636,18637,18638,18639,18640,18641,18642,18667,18708,18731,18732,18794,18796,18797,18830,18848,18891,20636,20637,20638,20639,20640,20641,20642,20643,20644,20645,20646,20647,20648,20649,20650,20651,20652,20653,20656,20657,20659,20662,18663,20655));
INSERT INTO `creature_onkill_reputation` (`creature_id`, `RewOnKillRepFaction1`, `RewOnKillRepFaction2`, `MaxStanding1`, `IsTeamAward1`, `RewOnKillRepValue1`, `MaxStanding2`, `IsTeamAward2`, `RewOnKillRepValue2`, `TeamDependent`) VALUES
(18631, 1011, 0, 7, 0, 12, 0, 0, 0, 0), -- Cabal Cultist
(18632, 1011, 0, 7, 0, 12, 0, 0, 0, 0), -- Cabal Executioner
(18633, 1011, 0, 7, 0, 12, 0, 0, 0, 0), -- Cabal Acolyte
(18634, 1011, 0, 7, 0, 12, 0, 0, 0, 0), -- Cabal Summoner
(18635, 1011, 0, 7, 0, 12, 0, 0, 0, 0), -- Cabal Deathsworn
(18636, 1011, 0, 7, 0, 12, 0, 0, 0, 0), -- Cabal Assassin
(18637, 1011, 0, 7, 0, 12, 0, 0, 0, 0), -- Cabal Shadow Priest
(18638, 1011, 0, 7, 0, 12, 0, 0, 0, 0), -- Cabal Zealot
(18639, 1011, 0, 7, 0, 12, 0, 0, 0, 0), -- Cabal Spellbinder
(18640, 1011, 0, 7, 0, 12, 0, 0, 0, 0), -- Cabal Warlock
(18641, 1011, 0, 7, 0, 2, 0, 0, 0, 0), -- Cabal Familiar
(18642, 1011, 0, 7, 0, 2, 0, 0, 0, 0), -- Fel Guardhound
(18663, 1011, 0, 7, 0, 2, 0, 0, 0, 0), -- Maiden of Discipline
(18667, 1011, 0, 7, 0, 120, 0, 0, 0, 0), -- Blackheart the Inciter
(18708, 1011, 0, 7, 0, 120, 0, 0, 0, 0), -- Murmur
(18731, 1011, 0, 7, 0, 120, 0, 0, 0, 0), -- Ambassador Hellmaw
(18732, 1011, 0, 7, 0, 120, 0, 0, 0, 0), -- Grandmaster Vorpil
(18794, 1011, 0, 7, 0, 12, 0, 0, 0, 0), -- Cabal Ritualist
(18796, 1011, 0, 7, 0, 24, 0, 0, 0, 0), -- Fel Overseer
(18830, 1011, 0, 7, 0, 12, 0, 0, 0, 0), -- Cabal Fanatic
(18848, 1011, 0, 7, 0, 24, 0, 0, 0, 0), -- Malicious Instructor
-- Heroic
(20636, 1011, 0, 7, 0, 250, 0, 0, 0, 0), -- Ambassador Hellmaw
(20637, 1011, 0, 7, 0, 250, 0, 0, 0, 0), -- Blackheart the Inciter
(20638, 1011, 0, 7, 0, 15, 0, 0, 0, 0), -- Cabal Acolyte
(20639, 1011, 0, 7, 0, 15, 0, 0, 0, 0), -- Cabal Assassin
(20640, 1011, 0, 7, 0, 15, 0, 0, 0, 0), -- Cabal Cultist
(20641, 1011, 0, 7, 0, 15, 0, 0, 0, 0), -- Cabal Deathsworn
(20642, 1011, 0, 7, 0, 15, 0, 0, 0, 0), -- Cabal Executioner
(20643, 1011, 0, 7, 0, 3, 0, 0, 0, 0), -- Cabal Familiar
(20644, 1011, 0, 7, 0, 15, 0, 0, 0, 0), -- Cabal Fanatic
(20645, 1011, 0, 7, 0, 15, 0, 0, 0, 0), -- Cabal Ritualist
(20646, 1011, 0, 7, 0, 15, 0, 0, 0, 0), -- Cabal Shadow Priest
(20647, 1011, 0, 7, 0, 15, 0, 0, 0, 0), -- Cabal Spellbinder
(20648, 1011, 0, 7, 0, 15, 0, 0, 0, 0), -- Cabal Summoner
(20649, 1011, 0, 7, 0, 15, 0, 0, 0, 0), -- Cabal Warlock
(20650, 1011, 0, 7, 0, 15, 0, 0, 0, 0), -- Cabal Zealot
(20651, 1011, 0, 7, 0, 3, 0, 0, 0, 0), -- Fel Guardhound
(20652, 1011, 0, 7, 0, 30, 0, 0, 0, 0), -- Fel Overseer
(20653, 1011, 0, 7, 0, 250, 0, 0, 0, 0), -- Grandmaster Vorpil
(20655, 1011, 0, 7, 0, 3, 0, 0, 0, 0), -- Maiden of Discipline
(20656, 1011, 0, 7, 0, 30, 0, 0, 0, 0), -- Malicious Instructor
(20657, 1011, 0, 7, 0, 250, 0, 0, 0, 0); -- Murmur

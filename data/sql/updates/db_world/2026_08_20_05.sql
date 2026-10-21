-- DB update 2026_08_20_04 -> 2026_08_20_05
-- Thelsamar Blood Sausages (Quest 418)
DELETE FROM `creature_questitem` WHERE `CreatureEntry` IN (1184, 1185, 1186, 1188, 1189, 1190, 1191, 1192, 1195, 1225) AND `ItemId` IN (3172, 3173, 3174);
INSERT INTO `creature_questitem` (`CreatureEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES
(1184, 1, 3174, 0), -- Cliff Lurker - Spider Ichor
(1185, 1, 3174, 0), -- Wood Lurker - Spider Ichor
(1186, 0, 3173, 0), -- Elder Black Bear - Bear Meat
(1188, 0, 3173, 0), -- Grizzled Black Bear - Bear Meat
(1189, 0, 3173, 0), -- Black Bear Patriarch - Bear Meat
(1190, 0, 3172, 0), -- Mountain Boar - Boar Intestines
(1191, 0, 3172, 0), -- Mangy Mountain Boar - Boar Intestines
(1192, 0, 3172, 0), -- Elder Mountain Boar - Boar Intestines
(1195, 1, 3174, 0), -- Forest Lurker - Spider Ichor
(1225, 1, 3173, 0); -- Ol' Sooty - Bear Meat

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1644601221468992700');

/* Culinary Crunch  - Quest 9171 */
DELETE FROM `creature_questitem` WHERE `CreatureEntry` IN (16350, 16351, 16352) AND `ItemId` = 22644;
INSERT INTO `creature_questitem` (`CreatureEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES
(16350, 2, 22644, 0),
(16351, 2, 22644, 0),
(16352, 2, 22644, 0);

/* Spinal Dust - Quest 9218 */
DELETE FROM `creature_questitem` WHERE `CreatureEntry` IN (16303, 16305, 16307, 16308);
INSERT INTO `creature_questitem` (`CreatureEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES
(16303, 0, 22642, 0),
(16305, 0, 22642, 0),
(16307, 0, 22642, 0),
(16308, 0, 22642, 0);

/* Rotting Hearts - Quest 9216 */
DELETE FROM `creature_questitem` WHERE `CreatureEntry` IN (16301, 16302);
INSERT INTO `creature_questitem` (`CreatureEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES
(16301, 0, 22641, 0),
(16302, 0, 22641, 0);

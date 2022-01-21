INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1642724246151292535');

-- adds missing quest item objective marker for CC ticket 2838
DELETE FROM `creature_questitem` WHERE `CreatureEntry` IN (17200, 17201);
INSERT INTO `creature_questitem` (`CreatureEntry`, `Idx`, `ItemId`, `VerifiedBuild`) VALUES 
(17200, 0, 23676, 0),
(17201, 0, 23676, 0),
(17201, 1, 23677, 0);

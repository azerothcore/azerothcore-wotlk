INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633365891402740400');

-- Alliance only(5401)
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`|1|4|8|64|1024 WHERE (`ID` = 5401);

-- Horde only(5405)
UPDATE `quest_template` SET `AllowableRaces` = `AllowableRaces`|2|16|32|128|512 WHERE (`ID` = 5405);

-- Changed from Argent Officer Pureheart to Argent Officer Garush.
DELETE FROM `creature_queststarter` WHERE (`quest` = 5405) AND (`id` IN (10857, 10839));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(10839, 5405);

DELETE FROM `creature_questender` WHERE (`quest` = 5405) AND (`id` IN (10857, 10839));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(10839, 5405);

-- Changed from Argent Officer Garush to Duke Nicholas Zverenhoff  For the neutral quest(5503)
DELETE FROM `creature_queststarter` WHERE (`quest` = 5503) AND (`id` IN (10839, 11039));
INSERT INTO `creature_queststarter` (`id`, `quest`) VALUES
(11039, 5503);

DELETE FROM `creature_questender` WHERE (`quest` = 5503) AND (`id` IN (10839, 11039));
INSERT INTO `creature_questender` (`id`, `quest`) VALUES
(11039, 5503);

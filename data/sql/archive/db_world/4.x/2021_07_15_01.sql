-- DB update 2021_07_15_00 -> 2021_07_15_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_07_15_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_07_15_00 2021_07_15_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1626104814208190800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1626104814208190800');

-- Make Emerald Ooze wander 
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3 WHERE `id` = 4469 AND `guid` = 93735;

-- Make Vilebranch Wolf Pup wander
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3 WHERE `id` = 2680 AND `guid` = 93627;

-- Make Vilebranch Witch Doctors wander
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 2640 AND `guid` IN (93105, 93201, 93400);
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3 WHERE `id` = 2640 AND `guid` IN (93601, 93746);

-- Make Vilebranch Shadowcasters wander
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 2642 AND `guid` IN (93554, 93640, 93659);
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3 WHERE `id` = 2642 AND `guid` IN (93638, 93648, 93656);

-- Make Vilebranch Berserkers wander
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3 WHERE `id` = 2643 AND `guid` IN (93553, 93651);
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 2643 AND `guid` IN (93555, 93649, 93650, 93761);

-- Make Vilebranch Hideskinners wander
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 2644 AND `guid` IN (93666, 93678);
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3 WHERE `id` = 2644 AND `guid` IN (93211, 93731);

-- Make Vilebranch Shadow Hunters wander
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 2645 AND `guid` IN (93208, 93672, 93675, 93726, 93732);
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3 WHERE `id` = 2645 AND `guid` IN (93207, 93679, 93727, 93733);

-- Make Vilebranch Blood Drinkers wander
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 2646 AND `guid` IN (93038, 93039, 93042, 93044, 93216, 93218, 93221, 93232, 93242, 93577, 93703, 93719, 93722);
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3 WHERE `id` = 2646 AND `guid` IN (93032, 93033, 93041, 93217, 93219, 93572, 93693, 93704);

-- Make Vilebranch Soul Eaters wander
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 2647 AND `guid` IN (93215, 93694, 93689);
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 7 WHERE `id` = 2647 AND `guid` IN (93215, 93700, 93721);
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 2647 AND `guid` IN (93040, 93184, 93231, 93573, 93714);
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3 WHERE `id` = 2647 AND `guid` IN (93045, 93213, 93220, 93716, 93718);

-- Make Vilebranch Aman'zasi Guards
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 2648 AND `guid` IN (92963, 93586, 93588, 93708);
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3 WHERE `id` = 2648 AND `guid` = 93571;
-- 93701, 93702 Guarding entrance, so no wandering?

-- Make Vilebranch Scalpers wander
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 5 WHERE `id` = 4466 AND `guid` IN (93102, 93715);

-- Make Vilebranch Soothsayer wander
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 10 WHERE `id` = 4467 AND `guid` = 93408;
UPDATE `creature` SET `MovementType` = 1, `wander_distance` = 3 WHERE `id` = 4467 AND `guid` IN (93633, 93637, 93660, 93661, 93668, 93671);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_07_15_01' WHERE sql_rev = '1626104814208190800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

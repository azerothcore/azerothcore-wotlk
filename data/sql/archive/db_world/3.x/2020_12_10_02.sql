-- DB update 2020_12_10_01 -> 2020_12_10_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_10_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_10_01 2020_12_10_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1602336256005673600'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1602336256005673600');
/*
 * General: Dungeons update
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* BOSS */
UPDATE `creature_template` SET `DamageModifier` = 1.84 WHERE `entry` = 7079;
UPDATE `creature_template` SET `DamageModifier` = 1.60 WHERE `entry` = 5775;
UPDATE `creature_template` SET `DamageModifier` = 1.38 WHERE `entry` = 644;
UPDATE `creature_template` SET `DamageModifier` = 1.13 WHERE `entry` = 642;
UPDATE `creature_template` SET `DamageModifier` = 1.12 WHERE `entry` = 643;
UPDATE `creature_template` SET `DamageModifier` = 1.17 WHERE `entry` = 3886;
UPDATE `creature_template` SET `DamageModifier` = 1.29 WHERE `entry` = 4275;
UPDATE `creature_template` SET `DamageModifier` = 1.20 WHERE `entry` = 4829;
UPDATE `creature_template` SET `DamageModifier` = 1.30 WHERE `entry` = 7228;
UPDATE `creature_template` SET `DamageModifier` = 1.49 WHERE `entry` = 7797;
UPDATE `creature_template` SET `DamageModifier` = 1.61 WHERE `entry` = 7274;
UPDATE `creature_template` SET `DamageModifier` = 1.77 WHERE `entry` = 8127;
UPDATE `creature_template` SET `DamageModifier` = 1.44 WHERE `entry` = 13282;
UPDATE `creature_template` SET `DamageModifier` = 1.16 WHERE `entry` = 12225;
UPDATE `creature_template` SET `DamageModifier` = 1.10 WHERE `entry` = 12236;
UPDATE `creature_template` SET `DamageModifier` = 1.20 WHERE `entry` = 12201;
UPDATE `creature_template` SET `DamageModifier` = 1.41 WHERE `entry` = 12203;
UPDATE `creature_template` SET `DamageModifier` = 1.90 WHERE `entry` = 13596;
UPDATE `creature_template` SET `DamageModifier` = 1.27 WHERE `entry` = 13601;
UPDATE `creature_template` SET `DamageModifier` = 1.97 WHERE `entry` = 8580;
UPDATE `creature_template` SET `DamageModifier` = 1.63 WHERE `entry` = 9196;
UPDATE `creature_template` SET `DamageModifier` = 1.54 WHERE `entry` = 9237;
UPDATE `creature_template` SET `DamageModifier` = 1.63 WHERE `entry` = 9568;
UPDATE `creature_template` SET `DamageModifier` = 1.58 WHERE `entry` = 10584;
UPDATE `creature_template` SET `DamageModifier` = 1.19 WHERE `entry` = 9816;
UPDATE `creature_template` SET `DamageModifier` = 1.26 WHERE `entry` = 10264;
UPDATE `creature_template` SET `DamageModifier` = 1.19 WHERE `entry` = 10339;
UPDATE `creature_template` SET `DamageModifier` = 2.05 WHERE `entry` = 10363;
UPDATE `creature_template` SET `DamageModifier` = 1.64 WHERE `entry` = 10429;
UPDATE `creature_template` SET `DamageModifier` = 2.09 WHERE `entry` = 10430;
UPDATE `creature_template` SET `DamageModifier` = 1.65 WHERE `entry` = 10509;
UPDATE `creature_template` SET `DamageModifier` = 1.31 WHERE `entry` = 10899;
UPDATE `creature_template` SET `DamageModifier` = 1.89 WHERE `entry` = 10506;
UPDATE `creature_template` SET `DamageModifier` = 1.50 WHERE `entry` = 11261;
UPDATE `creature_template` SET `DamageModifier` = 1.10 WHERE `entry` = 11622;
UPDATE `creature_template` SET `DamageModifier` = 2.14 WHERE `entry` = 10435;
UPDATE `creature_template` SET `DamageModifier` = 1.92 WHERE `entry` = 10436;
UPDATE `creature_template` SET `DamageModifier` = 2.12 WHERE `entry` = 10437;
UPDATE `creature_template` SET `DamageModifier` = 1.34 WHERE `entry` = 10438;
UPDATE `creature_template` SET `DamageModifier` = 1.20 WHERE `entry` = 10439;
UPDATE `creature_template` SET `DamageModifier` = 1.95 WHERE `entry` = 10440;
UPDATE `creature_template` SET `DamageModifier` = 1.14 WHERE `entry` = 10558;
UPDATE `creature_template` SET `DamageModifier` = 1.73 WHERE `entry` = 10808;
UPDATE `creature_template` SET `DamageModifier` = 1.43 WHERE `entry` = 10809;
UPDATE `creature_template` SET `DamageModifier` = 1.78 WHERE `entry` = 10811;
UPDATE `creature_template` SET `DamageModifier` = 1.77 WHERE `entry` = 10813;
UPDATE `creature_template` SET `DamageModifier` = 1.86 WHERE `entry` = 10997;
UPDATE `creature_template` SET `DamageModifier` = 1.65 WHERE `entry` = 11032;
UPDATE `creature_template` SET `DamageModifier` = 1.15 WHERE `entry` = 11490;
UPDATE `creature_template` SET `DamageModifier` = 1.28 WHERE `entry` = 11467;
UPDATE `creature_template` SET `DamageModifier` = 1.40 WHERE `entry` = 11486;
UPDATE `creature_template` SET `DamageModifier` = 1.21 WHERE `entry` = 11487;
UPDATE `creature_template` SET `DamageModifier` = 1.43 WHERE `entry` = 11489;
UPDATE `creature_template` SET `DamageModifier` = 1.57 WHERE `entry` = 11496;
UPDATE `creature_template` SET `DamageModifier` = 1.64 WHERE `entry` = 14506;
UPDATE `creature_template` SET `DamageModifier` = 1.26 WHERE `entry` = 14321;
UPDATE `creature_template` SET `DamageModifier` = 1.35 WHERE `entry` = 14322;
UPDATE `creature_template` SET `DamageModifier` = 1.19 WHERE `entry` = 14323;
UPDATE `creature_template` SET `DamageModifier` = 1.40 WHERE `entry` = 14325;
UPDATE `creature_template` SET `DamageModifier` = 1.24 WHERE `entry` = 14326;
UPDATE `creature_template` SET `mindmg` = 755, `maxdmg` = 996, `DamageModifier` = 1.02 WHERE `entry` = 16097;
UPDATE `creature_template` SET `mindmg` = 878, `maxdmg` = 1163, `DamageModifier` = 1.01 WHERE `entry` = 11143;
UPDATE `creature_template` SET `mindmg` = 503, `maxdmg` = 666, `DamageModifier` = 1.01 WHERE `entry` = 16101;
UPDATE `creature_template` SET `mindmg` = 503, `maxdmg` = 666, `DamageModifier` = 1.01 WHERE `entry` = 16102;
UPDATE `creature_template` SET `mindmg` = 4572, `maxdmg` = 5646, `DamageModifier` = 1.04 WHERE `entry` = 16387;
UPDATE `creature_template` SET `mindmg` = 448, `maxdmg` = 603, `DamageModifier` = 1.01 WHERE `entry` = 11121;
UPDATE `creature_template` SET `mindmg` = 624, `maxdmg` = 827, `DamageModifier` = 1.01 WHERE `entry` = 11120;
UPDATE `creature_template` SET `mindmg` = 899, `maxdmg` = 1193, `DamageModifier` = 1.01 WHERE `entry` = 11058;
UPDATE `creature_template` SET `mindmg` = 387, `maxdmg` = 511, `DamageModifier` = 1.01 WHERE `entry` = 10393;
UPDATE `creature_template` SET `mindmg` = 903, `maxdmg` = 1075, `DamageModifier` = 1.03 WHERE `entry` = 14516;
UPDATE `creature_template` SET `mindmg` = 813, `maxdmg` = 987, `DamageModifier` = 1.03 WHERE `entry` = 16118;
UPDATE `creature_template` SET `mindmg` = 1329, `maxdmg` = 1759, `DamageModifier` = 1.01 WHERE `entry` = 16042;
UPDATE `creature_template` SET `mindmg` = 575, `maxdmg` = 763, `DamageModifier` = 1.01 WHERE `entry` = 8923;
UPDATE `creature_template` SET `mindmg` = 394, `maxdmg` = 522, `DamageModifier` = 1.01 WHERE `entry` = 8929;
UPDATE `creature_template` SET `mindmg` = 547, `maxdmg` = 725, `DamageModifier` = 1.01 WHERE `entry` = 8983;
UPDATE `creature_template` SET `mindmg` = 636, `maxdmg` = 844, `DamageModifier` = 1.01 WHERE `entry` = 9016;
UPDATE `creature_template` SET `mindmg` = 450, `maxdmg` = 597, `DamageModifier` = 1.01 WHERE `entry` = 9017;
UPDATE `creature_template` SET `mindmg` = 271, `maxdmg` = 359, `DamageModifier` = 1.01 WHERE `entry` = 9018;
UPDATE `creature_template` SET `mindmg` = 695, `maxdmg` = 922, `DamageModifier` = 1.01 WHERE `entry` = 9019;
UPDATE `creature_template` SET `mindmg` = 266, `maxdmg` = 352, `DamageModifier` = 1.03 WHERE `entry` = 9024;
UPDATE `creature_template` SET `mindmg` = 311, `maxdmg` = 412, `DamageModifier` = 1.03 WHERE `entry` = 9025;
UPDATE `creature_template` SET `mindmg` = 257, `maxdmg` = 340, `DamageModifier` = 1.01 WHERE `entry` = 9026;
UPDATE `creature_template` SET `mindmg` = 477, `maxdmg` = 633, `DamageModifier` = 1.01 WHERE `entry` = 9027;
UPDATE `creature_template` SET `mindmg` = 530, `maxdmg` = 703, `DamageModifier` = 1.01 WHERE `entry` = 9028;
UPDATE `creature_template` SET `mindmg` = 401, `maxdmg` = 531, `DamageModifier` = 1.01 WHERE `entry` = 9029;
UPDATE `creature_template` SET `mindmg` = 349, `maxdmg` = 463, `DamageModifier` = 1.01 WHERE `entry` = 9030;
UPDATE `creature_template` SET `mindmg` = 444, `maxdmg` = 588, `DamageModifier` = 1.01 WHERE `entry` = 9031;
UPDATE `creature_template` SET `mindmg` = 583, `maxdmg` = 774, `DamageModifier` = 1.01 WHERE `entry` = 9032;
UPDATE `creature_template` SET `mindmg` = 550, `maxdmg` = 730, `DamageModifier` = 1.01 WHERE `entry` = 9033;
UPDATE `creature_template` SET `mindmg` = 350, `maxdmg` = 464, `DamageModifier` = 1.01 WHERE `entry` = 9034;
UPDATE `creature_template` SET `mindmg` = 376, `maxdmg` = 499, `DamageModifier` = 1.01 WHERE `entry` = 9035;
UPDATE `creature_template` SET `mindmg` = 321, `maxdmg` = 425, `DamageModifier` = 1.01 WHERE `entry` = 9036;
UPDATE `creature_template` SET `mindmg` = 537, `maxdmg` = 712, `DamageModifier` = 1.01 WHERE `entry` = 9037;
UPDATE `creature_template` SET `mindmg` = 321, `maxdmg` = 425, `DamageModifier` = 1.01 WHERE `entry` = 9038;
UPDATE `creature_template` SET `mindmg` = 330, `maxdmg` = 437, `DamageModifier` = 1.01 WHERE `entry` = 9039;
UPDATE `creature_template` SET `mindmg` = 384, `maxdmg` = 509, `DamageModifier` = 1.01 WHERE `entry` = 9040;
UPDATE `creature_template` SET `mindmg` = 300, `maxdmg` = 397, `DamageModifier` = 1.03 WHERE `entry` = 9041;
UPDATE `creature_template` SET `mindmg` = 405, `maxdmg` = 538, `DamageModifier` = 1.03 WHERE `entry` = 9042;
UPDATE `creature_template` SET `mindmg` = 638, `maxdmg` = 788, `DamageModifier` = 1.01 WHERE `entry` = 9056;
UPDATE `creature_template` SET `mindmg` = 470, `maxdmg` = 624, `DamageModifier` = 1.01 WHERE `entry` = 9156;
UPDATE `creature_template` SET `mindmg` = 327, `maxdmg` = 434, `DamageModifier` = 1.01 WHERE `entry` = 9319;
UPDATE `creature_template` SET `mindmg` = 331, `maxdmg` = 381, `DamageModifier` = 1.01 WHERE `entry` = 9499;
UPDATE `creature_template` SET `mindmg` = 658, `maxdmg` = 873, `DamageModifier` = 1.01 WHERE `entry` = 9502;
UPDATE `creature_template` SET `mindmg` = 705, `maxdmg` = 935, `DamageModifier` = 1.01 WHERE `entry` = 9537; 
UPDATE `creature_template` SET `mindmg` = 297, `maxdmg` = 394, `DamageModifier` = 1.01 WHERE `entry` = 9543; 
UPDATE `creature_template` SET `mindmg` = 806, `maxdmg` = 1068, `DamageModifier` = 1.01 WHERE `entry` = 9938; 
UPDATE `creature_template` SET `mindmg` = 403, `maxdmg` = 514, `DamageModifier` = 1.01 WHERE `entry` = 16059; 
UPDATE `creature_template` SET `mindmg` = 482, `maxdmg` = 657, `DamageModifier` = 1.63 WHERE `entry` = 16080;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

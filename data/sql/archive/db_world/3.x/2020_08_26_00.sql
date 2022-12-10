-- DB update 2020_08_25_00 -> 2020_08_26_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_08_25_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_08_25_00 2020_08_26_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1595681757220544700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1595681757220544700');
/*
 * Dungeon: Stratholme
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 336, `maxdmg` = 454, `DamageModifier` = 1.03 WHERE `entry` = 10381;
UPDATE `creature_template` SET `mindmg` = 107, `maxdmg` = 127, `DamageModifier` = 1.03 WHERE `entry` = 10383;
UPDATE `creature_template` SET `mindmg` = 356, `maxdmg` = 484, `DamageModifier` = 1.03 WHERE `entry` = 10391;
UPDATE `creature_template` SET `mindmg` = 329, `maxdmg` = 446, `DamageModifier` = 1.03 WHERE `entry` = 10382;
UPDATE `creature_template` SET `mindmg` = 306, `maxdmg` = 414, `DamageModifier` = 1.03 WHERE `entry` = 10390;
UPDATE `creature_template` SET `mindmg` = 318, `maxdmg` = 426, `DamageModifier` = 1.03 WHERE `entry` = 10405;
UPDATE `creature_template` SET `mindmg` = 108, `maxdmg` = 130, `DamageModifier` = 1.03 WHERE `entry` = 10411;
UPDATE `creature_template` SET `mindmg` = 263, `maxdmg` = 370, `DamageModifier` = 1.03 WHERE `entry` = 10408;
UPDATE `creature_template` SET `mindmg` = 315, `maxdmg` = 412, `DamageModifier` = 1.03 WHERE `entry` = 10384;
UPDATE `creature_template` SET `mindmg` = 344, `maxdmg` = 458, `DamageModifier` = 1.03 WHERE `entry` = 11082;
UPDATE `creature_template` SET `mindmg` = 479, `maxdmg` = 647, `DamageModifier` = 1.03 WHERE `entry` = 10414;
UPDATE `creature_template` SET `mindmg` = 733, `maxdmg` = 973, `DamageModifier` = 1.03 WHERE `entry` = 10516;
UPDATE `creature_template` SET `mindmg` = 342, `maxdmg` = 462, `DamageModifier` = 1.03 WHERE `entry` = 10418;
UPDATE `creature_template` SET `mindmg` = 319, `maxdmg` = 431, `DamageModifier` = 1.03 WHERE `entry` = 10420;
UPDATE `creature_template` SET `mindmg` = 332, `maxdmg` = 449, `DamageModifier` = 1.03 WHERE `entry` = 10424;
UPDATE `creature_template` SET `mindmg` = 242, `maxdmg` = 343, `DamageModifier` = 1.03 WHERE `entry` = 10419;
UPDATE `creature_template` SET `mindmg` = 325, `maxdmg` = 440, `DamageModifier` = 1.03 WHERE `entry` = 10421;
UPDATE `creature_template` SET `mindmg` = 247, `maxdmg` = 351, `DamageModifier` = 1.03 WHERE `entry` = 10423;
UPDATE `creature_template` SET `mindmg` = 332, `maxdmg` = 449, `DamageModifier` = 1.03 WHERE `entry` = 10424;
UPDATE `creature_template` SET `mindmg` = 261, `maxdmg` = 362, `DamageModifier` = 1.03 WHERE `entry` = 10422;
UPDATE `creature_template` SET `mindmg` = 107, `maxdmg` = 212, `DamageModifier` = 1.03 WHERE `entry` = 11054;
UPDATE `creature_template` SET `mindmg` = 332, `maxdmg` = 419, `DamageModifier` = 1.03 WHERE `entry` = 10426;
UPDATE `creature_template` SET `mindmg` = 314, `maxdmg` = 431, `DamageModifier` = 1.03 WHERE `entry` = 11043;
UPDATE `creature_template` SET `mindmg` = 252, `maxdmg` = 358, `DamageModifier` = 1.03 WHERE `entry` = 10425;
UPDATE `creature_template` SET `mindmg` = 348, `maxdmg` = 452, `DamageModifier` = 1.03 WHERE `entry` = 10464;
UPDATE `creature_template` SET `mindmg` = 355, `maxdmg` = 479, `DamageModifier` = 1.03 WHERE `entry` = 10413;
UPDATE `creature_template` SET `mindmg` = 349, `maxdmg` = 438, `DamageModifier` = 1.03 WHERE `entry` = 10407;
UPDATE `creature_template` SET `mindmg` = 263, `maxdmg` = 372, `DamageModifier` = 1.03 WHERE `entry` = 10408;
UPDATE `creature_template` SET `mindmg` = 342, `maxdmg` = 457, `DamageModifier` = 1.03 WHERE `entry` = 10463;
UPDATE `creature_template` SET `mindmg` = 248, `maxdmg` = 321, `DamageModifier` = 1.03 WHERE `entry` = 10406;
UPDATE `creature_template` SET `mindmg` = 218, `maxdmg` = 312, `DamageModifier` = 1.03 WHERE `entry` = 10400;
UPDATE `creature_template` SET `mindmg` = 157, `maxdmg` = 204, `DamageModifier` = 1.03 WHERE `entry` = 8477;
UPDATE `creature_template` SET `mindmg` = 257, `maxdmg` = 321, `DamageModifier` = 1.03 WHERE `entry` = 10399;
UPDATE `creature_template` SET `mindmg` = 268, `maxdmg` = 332, `DamageModifier` = 1.03 WHERE `entry` = 10398;
UPDATE `creature_template` SET `mindmg` = 102, `maxdmg` = 114, `DamageModifier` = 1.03 WHERE `entry` = 10876;
UPDATE `creature_template` SET `mindmg` = 111, `maxdmg` = 134, `DamageModifier` = 1.03 WHERE `entry` = 10697;
UPDATE `creature_template` SET `mindmg` = 362, `maxdmg` = 489, `DamageModifier` = 1.03 WHERE `entry` = 10417;
UPDATE `creature_template` SET `mindmg` = 355, `maxdmg` = 479, `DamageModifier` = 1.03 WHERE `entry` = 10416;
UPDATE `creature_template` SET `mindmg` = 78, `maxdmg` = 101, `DamageModifier` = 1.03 WHERE `entry` = 11030;
UPDATE `creature_template` SET `mindmg` = 351, `maxdmg` = 489, `DamageModifier` = 1.03 WHERE `entry` = 10394;
UPDATE `creature_template` SET `mindmg` = 82, `maxdmg` = 107, `DamageModifier` = 1.03 WHERE `entry` = 11197;

/* RARE */ 
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 342, `maxdmg` = 454, `DamageModifier` = 1.02 WHERE `entry` = 10558;
UPDATE `creature_template` SET `rank` = 2, `mindmg` = 311, `maxdmg` = 479, `DamageModifier` = 1.02 WHERE `entry` = 10809;

/* BOSS */
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 418, `maxdmg` = 554, `DamageModifier` = 1.01 WHERE `entry` = 10435;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 523, `maxdmg` = 693, `DamageModifier` = 1.01 WHERE `entry` = 10808;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 449, `maxdmg` = 523, `DamageModifier` = 1.01 WHERE `entry` = 11032;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 479, `maxdmg` = 518, `DamageModifier` = 1.01 WHERE `entry` = 10997;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 394, `maxdmg` = 467, `DamageModifier` = 1.01 WHERE `entry` = 10811;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 398, `maxdmg` = 478, `DamageModifier` = 1.01 WHERE `entry` = 10812;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 462, `maxdmg` = 675, `DamageModifier` = 1.01 WHERE `entry` = 10813;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 392, `maxdmg` = 472, `DamageModifier` = 1.01 WHERE `entry` = 10436;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 387, `maxdmg` = 486, `DamageModifier` = 1.01 WHERE `entry` = 10437;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 363, `maxdmg` = 465, `DamageModifier` = 1.01 WHERE `entry` = 10438;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 988, `maxdmg` = 1309, `speed_walk` = 0.7, `speed_run` = 0.7, `DamageModifier` = 1.01 WHERE `entry` = 10439;
UPDATE `creature_template` SET `type_flags`=`type_flags`|4, `mindmg` = 461, `maxdmg` = 565, `DamageModifier` = 1.01 WHERE `entry` = 10440;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

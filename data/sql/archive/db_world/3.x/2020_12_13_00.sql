-- DB update 2020_12_11_03 -> 2020_12_13_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2020_12_11_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2020_12_11_03 2020_12_13_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1601826865098802700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1601826865098802700');
/*
 * Dungeon: The Nexus
 * Update by Knindza | <www.azerothcore.org>
 * Copyright (C) <www.shadowburn.net> & <www.lichbane.com>
*/

/* REGULAR */ 
UPDATE `creature_template` SET `mindmg` = 2221, `maxdmg` = 3177, `DamageModifier` = 1.03 WHERE `entry` = 26716;
UPDATE `creature_template` SET `mindmg` = 5641, `maxdmg` = 7839, `DamageModifier` = 1.03 WHERE `entry` = 30459;
UPDATE `creature_template` SET `mindmg` = 2214, `maxdmg` = 3182, `DamageModifier` = 1.03 WHERE `entry` = 26730;
UPDATE `creature_template` SET `mindmg` = 5417, `maxdmg` = 7561, `DamageModifier` = 1.03 WHERE `entry` = 30473;
UPDATE `creature_template` SET `mindmg` = 2214, `maxdmg` = 3162, `DamageModifier` = 1.03 WHERE `entry` = 26727;
UPDATE `creature_template` SET `mindmg` = 5412, `maxdmg` = 7552, `DamageModifier` = 1.03 WHERE `entry` = 30460;
UPDATE `creature_template` SET `mindmg` = 2228, `maxdmg` = 3181, `DamageModifier` = 1.03 WHERE `entry` = 26801;
UPDATE `creature_template` SET `mindmg` = 5421, `maxdmg` = 7559, `DamageModifier` = 1.03 WHERE `entry` = 30580;
UPDATE `creature_template` SET `mindmg` = 2243, `maxdmg` = 3212, `DamageModifier` = 1.03 WHERE `entry` = 26799;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7624, `DamageModifier` = 1.03 WHERE `entry` = 30495;
UPDATE `creature_template` SET `mindmg` = 2119, `maxdmg` = 3182, `DamageModifier` = 1.03 WHERE `entry` = 26803;
UPDATE `creature_template` SET `mindmg` = 5415, `maxdmg` = 7558, `DamageModifier` = 1.03 WHERE `entry` = 30497;
UPDATE `creature_template` SET `mindmg` = 2215, `maxdmg` = 3182, `DamageModifier` = 1.03 WHERE `entry` = 26728;
UPDATE `creature_template` SET `mindmg` = 5416, `maxdmg` = 7559, `DamageModifier` = 1.03 WHERE `entry` = 30478;
UPDATE `creature_template` SET `mindmg` = 2241, `maxdmg` = 3196, `DamageModifier` = 1.03 WHERE `entry` = 26729;
UPDATE `creature_template` SET `mindmg` = 5482, `maxdmg` = 7624, `DamageModifier` = 1.03 WHERE `entry` = 30485;
UPDATE `creature_template` SET `mindmg` = 2215, `maxdmg` = 3180, `DamageModifier` = 1.03 WHERE `entry` = 26735;
UPDATE `creature_template` SET `mindmg` = 5482, `maxdmg` = 7563, `DamageModifier` = 1.03 WHERE `entry` = 30517;
UPDATE `creature_template` SET `mindmg` = 2689, `maxdmg` = 3835, `DamageModifier` = 1.03 WHERE `entry` = 26734;
UPDATE `creature_template` SET `mindmg` = 6576, `maxdmg` = 9149, `DamageModifier` = 1.03 WHERE `entry` = 30516;
UPDATE `creature_template` SET `mindmg` = 2241, `maxdmg` = 3196, `DamageModifier` = 1.03 WHERE `entry` = 26761;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7624, `DamageModifier` = 1.03 WHERE `entry` = 30521;
UPDATE `creature_template` SET `mindmg` = 2250, `maxdmg` = 3215, `DamageModifier` = 1.03 WHERE `entry` = 26737;
UPDATE `creature_template` SET `mindmg` = 5482, `maxdmg` = 7623, `DamageModifier` = 1.03 WHERE `entry` = 30519;
UPDATE `creature_template` SET `mindmg` = 575, `maxdmg` = 773, `DamageModifier` = 1.03 WHERE `entry` = 30746;
UPDATE `creature_template` SET `mindmg` = 890, `maxdmg` = 1115, `DamageModifier` = 1.03 WHERE `entry` = 30520;
UPDATE `creature_template` SET `mindmg` = 2689, `maxdmg` = 3835, `DamageModifier` = 1.03 WHERE `entry` = 26792;
UPDATE `creature_template` SET `mindmg` = 6976, `maxdmg` = 9142, `DamageModifier` = 1.03 WHERE `entry` = 30524;
UPDATE `creature_template` SET `mindmg` = 528, `maxdmg` = 716, `DamageModifier` = 1.03 WHERE `entry` = 26793;
UPDATE `creature_template` SET `mindmg` = 851, `maxdmg` = 980, `DamageModifier` = 1.03 WHERE `entry` = 30528;
UPDATE `creature_template` SET `mindmg` = 2241, `maxdmg` = 3196, `DamageModifier` = 1.03 WHERE `entry` = 26782;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7624, `DamageModifier` = 1.03 WHERE `entry` = 30526;
UPDATE `creature_template` SET `mindmg` = 2235, `maxdmg` = 3185, `DamageModifier` = 1.03 WHERE `entry` = 28231;
UPDATE `creature_template` SET `mindmg` = 5480, `maxdmg` = 7562, `DamageModifier` = 1.03 WHERE `entry` = 30525;
UPDATE `creature_template` SET `mindmg` = 2231, `maxdmg` = 3177, `DamageModifier` = 1.03 WHERE `entry` = 26722;
UPDATE `creature_template` SET `mindmg` = 5641, `maxdmg` = 7939, `DamageModifier` = 1.03 WHERE `entry` = 30457;
UPDATE `creature_template` SET `mindmg` = 2224, `maxdmg` = 3177, `DamageModifier` = 1.03 WHERE `entry` = 26802;
UPDATE `creature_template` SET `mindmg` = 5417, `maxdmg` = 7561, `DamageModifier` = 1.03 WHERE `entry` = 30509;
UPDATE `creature_template` SET `mindmg` = 2241, `maxdmg` = 3196, `DamageModifier` = 1.03 WHERE `entry` = 26800;
UPDATE `creature_template` SET `mindmg` = 5482, `maxdmg` = 7632, `DamageModifier` = 1.03 WHERE `entry` = 30496;
UPDATE `creature_template` SET `mindmg` = 2219, `maxdmg` = 3181, `DamageModifier` = 1.03 WHERE `entry` = 26805;
UPDATE `creature_template` SET `mindmg` = 5419, `maxdmg` = 7563, `DamageModifier` = 1.03 WHERE `entry` = 30498;

/* BOSS - First 4 are Heroic mode only.*/
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 26798;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 30397;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 26796;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 30398;
UPDATE `creature_template` SET `mindmg` = 3703, `maxdmg` = 4368, `DamageModifier` = 1.01 WHERE `entry` = 26731;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 30510;
UPDATE `creature_template` SET `mindmg` = 3780, `maxdmg` = 4564, `DamageModifier` = 1.01 WHERE `entry` = 26763;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 30529;
UPDATE `creature_template` SET `mindmg` = 3801, `maxdmg` = 4585, `DamageModifier` = 1.01 WHERE `entry` = 26794;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 30532;
UPDATE `creature_template` SET `mindmg` = 3843, `maxdmg` = 4879, `DamageModifier` = 1.01 WHERE `entry` = 26723;
UPDATE `creature_template` SET `mindmg` = 8907, `maxdmg` = 11952, `DamageModifier` = 1.01 WHERE `entry` = 30540;

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

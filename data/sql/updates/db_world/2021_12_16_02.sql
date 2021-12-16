-- DB update 2021_12_16_01 -> 2021_12_16_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_16_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_16_01 2021_12_16_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1638617008671223200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1638617008671223200');

-- Gnomish Engineering
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=12897;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=30575;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=30574;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=12907;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=56473;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=12905;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=30570;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=12903;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=23096;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=30568;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=15633;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=23129;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=11454;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=12906;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=12759;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=12902;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=30569;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=12899;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=23489;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=36955;
UPDATE `npc_trainer` SET `ReqSpell`=20219 WHERE `SpellID`=11454;

-- Goblin Engineering
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=23486;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=36954;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=30565;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=30566;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=12755;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=12718;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=12908;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=9273;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=23078;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=12717;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=12716;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=8895;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=12758;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=30563;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=12760;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=15628;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=30560;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=12754;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=30558;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=12715;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=13240;
UPDATE `npc_trainer` SET `ReqSpell`=20222 WHERE `SpellID`=56514;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_16_02' WHERE sql_rev = '1638617008671223200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

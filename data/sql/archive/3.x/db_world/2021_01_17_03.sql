-- DB update 2021_01_17_02 -> 2021_01_17_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_01_17_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_01_17_02 2021_01_17_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1599925076493872561'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1599925076493872561');
ALTER TABLE `warden_checks` MODIFY `str` VARCHAR(170);
DELETE FROM `warden_checks` WHERE `id` IN (788,789,790,791,792);
INSERT INTO `warden_checks` (`id`,`type`,`str`,`address`,`length`,`result`, `comment`) VALUES
(788, 139, 'forceinsecure() return issecure()', NULL, NULL, NULL, 'Detects naive Lua unlockers'),
(789, 139, 'return not not PQR_IsMoving', NULL, NULL, NULL, 'Detects PQR'),
(790, 139, 'local f=DEFAULT_CHAT_FRAME for i=1,f:GetNumMessages() do if (f:GetMessageInfo(i)):find("|cffffd200PQR|r") then return true end end', NULL, NULL, NULL, 'Detects PQR'),
(791, 139, 'local f=DEFAULT_CHAT_FRAME for i=1,f:GetNumMessages() do if (f:GetMessageInfo(i)):find("|cFF32CD32EWT|r") then return true end end',NULL,NULL,NULL,'Detects EWT'),
(792, 139, 'local f=DEFAULT_CHAT_FRAME for i=1,f:GetNumMessages() do if (f:GetMessageInfo(i)):find("|cFFFF4400WoWPlus|r") then return true end end',NULL,NULL,NULL,'Detects WoWPlus');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

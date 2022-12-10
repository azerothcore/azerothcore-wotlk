-- DB update 2022_04_01_09 -> 2022_04_01_10
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_01_09';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_01_09 2022_04_01_10 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1648460525676769171'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1648460525676769171');

REPLACE INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES 
(8673, 'deDE', 'Auktionator Thathung', '', 0),
(8673, 'esES', 'Subastador Thathung', '', 0),
(8673, 'esMX', 'Subastador Thathung', '', 0),
(8673, 'frFR', 'Commissaire-priseur Thathung', '', 0),
(8673, 'koKR', '경매인 타퉁', '', 0),
(8673, 'ruRU', 'Аукционер Скаботун', '', 0),
(8673, 'zhCN', '拍卖师萨苏恩', '', 0),
(8673, 'zhTW', '拍賣師薩蘇恩', '', 0),
(8724, 'deDE', 'Auktionator Wabang', '', 0),
(8724, 'esES', 'Subastador Wabang', '', 0),
(8724, 'esMX', 'Subastador Wabang', '', 0),
(8724, 'frFR', 'Commissaire-priseur Wabang', '', 0),
(8724, 'koKR', '경매인 와방', '', 0),
(8724, 'ruRU', 'Аукционер Вабанг', '', 0),
(8724, 'zhCN', '拍卖师瓦巴恩', '', 0),
(8724, 'zhTW', '拍賣師瓦巴恩', '', 0),
(9856, 'deDE', 'Auktionator Ingrimm', '', 0),
(9856, 'esES', 'Subastador Grimful', '', 0),
(9856, 'esMX', 'Subastador Grimful', '', 0),
(9856, 'frFR', 'Commissaire-priseur Grimful', '', 0),
(9856, 'koKR', '경매인 그림풀', '', 0),
(9856, 'ruRU', 'Аукционер Мрачнус', '', 0),
(9856, 'zhCN', '拍卖师格里夫', '', 0),
(9856, 'zhTW', '拍賣師格里夫', '', 0),
(3309, 'deDE', 'Karus', 'Bankier', 0),
(3309, 'esES', 'Karus', 'Banquero', 0),
(3309, 'esMX', 'Karus', 'Banquero', 0),
(3309, 'frFR', 'Karus', 'Banquier', 0),
(3309, 'koKR', '카루스', '은행원', 0),
(3309, 'ruRU', 'Карус', 'Банкир', 0),
(3309, 'zhCN', '卡鲁斯', '银行职员', 0),
(3309, 'zhTW', '卡魯斯', '銀行職員', 0),
(3318, 'deDE', 'Koma', 'Bankier', 0),
(3318, 'esES', 'Koma', 'Banquero', 0),
(3318, 'esMX', 'Koma', 'Banquero', 0),
(3318, 'frFR', 'Koma', 'Banquier', 0),
(3318, 'koKR', '코마', '은행원', 0),
(3318, 'ruRU', 'Кома', 'Банкир', 0),
(3318, 'zhCN', '库玛', '银行职员', 0),
(3318, 'zhTW', '寇瑪', '銀行職員', 0),
(3320, 'deDE', 'Soran', 'Bankier', 0),
(3320, 'esES', 'Soran', 'Banquero', 0),
(3320, 'esMX', 'Soran', 'Banquero', 0),
(3320, 'frFR', 'Soran', 'Banquier', 0),
(3320, 'koKR', '소란', '은행원', 0),
(3320, 'ruRU', 'Соран', 'Банкир', 0),
(3320, 'zhCN', '索兰', '银行职员', 0),
(3320, 'zhTW', '索蘭', '銀行職員', 0);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_01_10' WHERE sql_rev = '1648460525676769171';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

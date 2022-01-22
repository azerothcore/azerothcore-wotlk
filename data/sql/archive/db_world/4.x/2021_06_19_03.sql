-- DB update 2021_06_19_02 -> 2021_06_19_03
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_19_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_19_02 2021_06_19_03 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1623600456041056800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1623600456041056800');

DELETE FROM `creature_template_locale` WHERE `entry` IN (37942,37941,35495,35494,33964,33963,31582,31581,31580,31579);
INSERT INTO `creature_template_locale` (`entry`, `locale`, `Name`, `Title`, `VerifiedBuild`) VALUES
(37942, 'deDE', 'Arkanist Uovril', 'Emblem des Frost Rüstmeister', 18019),
(37942, 'esES', 'Arcanista Uovril', 'Emblema del intendente de escarcha', 18019),
(37942, 'esMX', 'Arcanista Uovril', 'Emblema del intendente de escarcha', 18019),
(37942, 'frFR', 'Arcaniste Uovril', 'Emblème du quartier-maître de givre', 18019),
(37942, 'koKR', '신비술사 우브릴', '서리 병참 장교의 문장', 18019),
(37942, 'ruRU', 'Чародей Уоврил', 'Эмблема интенданта Мороза', 18019),
(37942, 'zhCN', '奥术师尤维尔', '冰霜军需官徽记', 18019),
(37942, 'zhTW', '秘法師烏弗瑞', '冰霜軍需官徽記', 18019),
(37941, 'deDE', 'Magister Arlan', 'Emblem des Frost Rüstmeister', 18019),
(37941, 'esES', 'Magister Arlan', 'Emblema del intendente de escarcha', 18019),
(37941, 'esMX', 'Magister Arlan', 'Emblema del intendente de escarcha', 18019),
(37941, 'frFR', 'Magistère Arlan', 'Emblème du quartier-maître de givre', 18019),
(37941, 'koKR', '마법학자 알란', '서리 병참 장교의 문장', 18019),
(37941, 'ruRU', 'Магистр Арлан', 'Эмблема интенданта Мороза', 18019),
(37941, 'zhCN', '魔导师奥尔兰', '冰霜军需官徽记', 18019),
(37941, 'zhTW', '博學者亞蘭', '冰霜軍需官徽記', 18019),
(35495, 'deDE', 'Magistrix Vesara', 'Emblem des Triumph Rüstmeister', 18019),
(35495, 'esES', 'Magistrix Vesara', 'Emblema del intendente de triunfo', 18019),
(35495, 'esMX', 'Magistrix Vesara', 'Emblema del intendente de triunfo', 18019),
(35495, 'frFR', 'Magistrice Vesara', 'Emblème du quartier-maître du triomphe', 18019),
(35495, 'koKR', '마법학자 베사라', '승리 병참 장교의 문장', 18019),
(35495, 'ruRU', 'Магистр Весара', 'Эмблема триумфального интенданта', 18019),
(35495, 'zhCN', '魔导师维莎拉', '凯旋军需官的徽章', 18019),
(35495, 'zhTW', '博學者凡薩菈', '凱旋軍需官的徽記', 18019),
(35494, 'deDE', 'Arkanistin Miluria', 'Emblem des Triumph Rüstmeister', 18019),
(35494, 'esES', 'Arcanista Miluria', 'Emblema del intendente de triunfo', 18019),
(35494, 'esMX', 'Arcanista Miluria', 'Emblema del intendente de triunfo', 18019),
(35494, 'frFR', 'Arcaniste Miluria', 'Emblème du quartier-maître du triomphe', 18019),
(35494, 'koKR', '신비술사 밀루리아', '승리 병참 장교의 문장', 18019),
(35494, 'ruRU', 'Чародейка Милурия', 'Эмблема триумфального интенданта', 18019),
(35494, 'zhCN', '奥术师米露蕊娅', '凯旋军需官的徽章', 18019),
(35494, 'zhTW', '秘法師米露芮雅', '凱旋軍需官的徽記', 18019),
(33964, 'deDE', 'Arkanist Firael', 'Emblem der Eroberung Rüstmeister', 18019),
(33964, 'esES', 'Arcanista Firael', 'Emblema de intendencia de conquista', 18019),
(33964, 'esMX', 'Arcanista Firael', 'Emblema de intendencia de conquista', 18019),
(33964, 'frFR', 'Arcaniste Firael', 'Quartier-maître de l\'emblème de la conquête', 18019),
(33964, 'koKR', '신비술사 파이랠', '정복 병참 장교의 문장', 18019),
(33964, 'ruRU', 'Чародей Фираэль', 'Эмблема завоевания Интендант', 18019),
(33964, 'zhCN', '奥术师菲莱尔', '征服徽章军需官', 18019),
(33964, 'zhTW', '秘法師菲瑞爾', '征服徽章軍需官', 18019),
(33963, 'deDE', 'Magister Sarien', 'Emblem der Eroberung Rüstmeister', 18019),
(33963, 'esES', 'Magister Sarien', 'Emblema de intendencia de conquista', 18019),
(33963, 'esMX', 'Magister Sarien', 'Emblema de intendencia de conquista', 18019),
(33963, 'frFR', 'Magistère Sarien', 'Quartier-maître de l\'emblème de la conquête', 18019),
(33963, 'koKR', '마법학자 사리엔', '정복 병참 장교의 문장', 18019),
(33963, 'ruRU', 'Магистр Сариен', 'Эмблема завоевания Интендант', 18019),
(33963, 'zhCN', '魔导师萨雷恩', '征服徽章军需官', 18019),
(33963, 'zhTW', '博學者薩瑞安', '征服徽章軍需官', 18019),
(31582, 'deDE', 'Magistrix Lambriesse', 'Emblem des Heldentums Rüstmeister', 18019),
(31582, 'esES', 'Magistrix Lambriesse', 'Emblema del heroísmo intendente', 18019),
(31582, 'esMX', 'Magistrix Lambriesse', 'Emblema del heroísmo intendente', 18019),
(31582, 'frFR', 'Magistrice Lambriesse', 'Emblème de l\'héroïsme quartier-maître', 18019),
(31582, 'koKR', '마법학자 램브리스', '영웅주의 병참 장교의 상징', 18019),
(31582, 'ruRU', 'Магистр Ламбрисса', 'Эмблема героизма квартирмейстера', 18019),
(31582, 'zhCN', '魔导师拉姆布莉丝', '传承正义军需官', 18019),
(31582, 'zhTW', '博學者蘭布莉斯', '傳承正義點數軍需官', 18019),
(31581, 'deDE', 'Magister Brasael', 'Emblem der Ehre Rüstmeister', 18019),
(31581, 'esES', 'Magister Brasael', 'Emblema de intendente de honor', 18019),
(31581, 'esMX', 'Magister Brasael', 'Emblema de intendente de honor', 18019),
(31581, 'frFR', 'Magistère Brasael', 'Emblème d\'honneur quartier-maître', 18019),
(31581, 'koKR', '마법학자 브라샤엘', '명예 병참 장교의 상징', 18019),
(31581, 'ruRU', 'Магистр Бразайл', 'Эмблема почетного квартирмейстера', 18019),
(31581, 'zhCN', '魔导师布拉塞尔', '英雄主义军需官的象征', 18019),
(31581, 'zhTW', '博學者巴塞爾', '英雄主義軍需官的象徵', 18019),
(31580, 'deDE', 'Arkanistin Ivrenne', 'Emblem des Heldentums Rüstmeister', 18019),
(31580, 'esES', 'Arcanista Ivrenne', 'Emblema del heroísmo intendente', 18019),
(31580, 'esMX', 'Arcanista Ivrenne', 'Emblema del heroísmo intendente', 18019),
(31580, 'frFR', 'Arcaniste Ivrenne', 'Emblème de l\'héroïsme quartier-maître', 18019),
(31580, 'koKR', '신비술사 이브렌느', '영웅주의 병참 장교의 상징', 18019),
(31580, 'ruRU', 'Чародейка Ивренна', 'Эмблема героизма квартирмейстера', 18019),
(31580, 'zhCN', '奥术师艾弗蕾妮', '英雄主义军需官的象征', 18019),
(31580, 'zhTW', '秘法師伊芙瑞琳', '英雄主義軍需官的象徵', 18019),
(31579, 'deDE', 'Arkanist Adurin', 'Emblem der Ehre Rüstmeister', 18019),
(31579, 'esES', 'Arcanista Adurin', 'Emblema de intendente de honor', 18019),
(31579, 'esMX', 'Arcanista Adurin', 'Emblema de intendente de honor', 18019),
(31579, 'frFR', 'Arcaniste Adurin', 'Emblème d\'honneur quartier-maître', 18019),
(31579, 'koKR', '신비술사 아두린', '명예 병참 장교의 상징', 18019),
(31579, 'ruRU', 'Чародей Адурин', 'Эмблема почетного квартирмейстера', 18019),
(31579, 'zhCN', '奥术师埃杜林', '荣誉军需官徽章', 18019),
(31579, 'zhTW', '秘法師阿度靈', '榮譽軍需官徽章', 18019);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_19_03' WHERE sql_rev = '1623600456041056800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

-- DB update 2023_01_16_09 -> 2023_01_16_10
--
-- PR from TrinityCore @Jildor
UPDATE `item_template_locale` SET `Name`='Invernalia' WHERE `ID`=3819 AND `locale`='esES';
UPDATE `item_template_locale` SET `Name`='Invernalia' WHERE `ID`=3819 AND `locale`='esMX';
UPDATE `item_template_locale` SET `Name`='겨울서리풀' WHERE `ID`=3819 AND `locale`='koKR';
UPDATE `item_template_locale` SET `Name`='冬刺草' WHERE `ID`=3819 AND `locale`='zhCN';
UPDATE `item_template_locale` SET `Name`='冬刺草' WHERE `ID`=3819 AND `locale`='zhTW';

UPDATE `gameobject_template_locale` SET `Name`='Invernalia' WHERE `entry`=2044 AND `locale`='esES';
UPDATE `gameobject_template_locale` SET `Name`='Invernalia' WHERE `entry`=2044 AND `locale`='esMX';
UPDATE `gameobject_template_locale` SET `Name`='겨울서리풀' WHERE `entry`=2044 AND `locale`='koKR';
UPDATE `gameobject_template_locale` SET `Name`='冬刺草' WHERE `entry`=2044 AND `locale`='zhCN';
UPDATE `gameobject_template_locale` SET `Name`='冬刺草' WHERE `entry`=2044 AND `locale`='zhTW';

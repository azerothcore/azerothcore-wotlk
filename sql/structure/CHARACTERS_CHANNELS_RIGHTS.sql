CREATE TABLE `channels_rights` (
  `name` varchar(128) NOT NULL,
  `flags` int(10) unsigned NOT NULL,
  `speakdelay` int(10) unsigned NOT NULL,
  `joinmessage` varchar(255) NOT NULL DEFAULT '',
  `delaymessage` varchar(255) NOT NULL DEFAULT '',
  `moderators` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO `channels_rights` VALUES ('2v2', 509, 0, '', '', NULL);
INSERT INTO `channels_rights` VALUES ('3v3', 509, 0, '', '', NULL);
INSERT INTO `channels_rights` VALUES ('5v5', 509, 0, '', '', NULL);
INSERT INTO `channels_rights` VALUES ('bg', 509, 0, '', '', NULL);
INSERT INTO `channels_rights` VALUES ('guar', 209, 60, 'Kanal |cFFFF0000GUAR|r sluzy wylacznie do szukania/reklamowania gildii i szukania/reklamowania teamow arenowych. Rozmowy na inny temat, wulgaryzmy, trollowanie, chamstwo i lamanie regulaminu w jakikolwiek inny sposob beda skutkowaly blokada kanalu.', '', '');
INSERT INTO `channels_rights` VALUES ('handel', 209, 60, 'Kanal |cFFFF0000HANDEL|r sluzy wylacznie do handlu. Rozmowy na inny temat, wulgaryzmy, trollowanie, chamstwo i lamanie regulaminu w jakikolwiek inny sposob beda skutkowaly blokada kanalu.', '', '');
INSERT INTO `channels_rights` VALUES ('lfg', 209, 60, 'Kanal |cFFFF0000LFG|r sluzy wylacznie do szukania grupy (nie gildii, nie teamu arenowego!). Rozmowy na inny temat, wulgaryzmy, trollowanie, chamstwo i lamanie regulaminu w jakikolwiek inny sposob beda skutkowaly blokada kanalu.', 'Consider using Raid Browser: /rb (AddOn on forums)', '');
INSERT INTO `channels_rights` VALUES ('pl', 217, 5, 'Kanal |cFFFF0000PL|r zostal zablokowany. Informacje na temat nowych kanalow globalnych znajdziesz w regulaminie serwera.', '', NULL);
INSERT INTO `channels_rights` VALUES ('world', 209, 5, 'Kanal |cFFFF0000WORLD|r sluzy wylacznie do luznych rozmow. Handel, szukanie grupy, szukanie partnerow, reklamowanie gildii i inne podobne = blokada kanalu. Wulgaryzmy, trollowanie, chamstwo i lamanie regulaminu takze beda skutkowaly blokada kanalu.', '', '');

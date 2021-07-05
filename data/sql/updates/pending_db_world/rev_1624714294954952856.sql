INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624714294954952856');

DELETE FROM `creature_queststarter` WHERE `quest` IN (8154, 8155, 8156, 8080, 8297, 8162, 8161, 8160, 8123, 8299);
DELETE FROM `creature_questender` WHERE `quest` IN (8154, 8155, 8156, 8080, 8297, 8162, 8161, 8160, 8123, 8299);

DELETE FROM `disables` WHERE `entry` IN (8154, 8155, 8156, 8080, 8297, 8162, 8161, 8160, 8123, 8299);
INSERT INTO `disables` (sourceType, entry, flags, comment) VALUES 
(1, 8154, 0, 'Deprecated quest: Arathi Basin Resources!'),
(1, 8155, 0, 'Deprecated quest: Arathi Basin Resources!'),
(1, 8156, 0, 'Deprecated quest: Arathi Basin Resources!'),
(1, 8080, 0, 'Deprecated quest: Arathi Basin Resources!'),
(1, 8297, 0, 'Deprecated quest: Arathi Basin Resources!'),
(1, 8160, 0, 'Deprecated quest: Cut Arathor Supply Lines'),
(1, 8161, 0, 'Deprecated quest: Cut Arathor Supply Lines'),
(1, 8162, 0, 'Deprecated quest: Cut Arathor Supply Lines'),
(1, 8123, 0, 'Deprecated quest: Cut Arathor Supply Lines'),
(1, 8299, 0, 'Deprecated quest: Cut Arathor Supply Lines');

-- Add acore_strings for arena queue announcer with less detail about the teams

DELETE FROM `acore_string` WHERE `entry` IN (753, 754, 755, 756, 757, 758);

INSERT INTO `acore_string` (`entry`, `content_default`, `locale_frFR`, `locale_deDE`, `locale_zhCN`) VALUES
(753, '|cffff0000[Arena Queue Announcer]:|r %s -- Joined : %ux%u|r', '|cffff0000[Annonce File d''Attente Arène]:|r %s -- Rejoint : %ux%u|r', '|cffff0000[BG Ansager für Warteschlange]:|r %s -- beigetreten : %ux%u|r', '|cffff0000[竞技场列队公告]:|r %s -- 加入 : %ux%u|r'),
(754, '|cffff0000[Arena Queue Announcer]:|r %s -- Exited : %ux%u|r', '|cffff0000[Annonce File d''Attente Arène]:|r %s -- Quitté : %ux%u|r', '|cffff0000[BG Ansager für Warteschlange]:|r %s -- verlassen : %ux%u|r', '|cffff0000[竞技场列队公告]:|r %s -- 退出 : %ux%u|r'),
(755, '|cffff0000[Arena Queue Announcer]:|r Joined : %ux%u : %u|r', '|cffff0000[Annonce File d''Attente Arène]:|r Rejoint : %ux%u : %u|r', '|cffff0000[BG Ansager für Warteschlange]:|r beigetreten : %ux%u : %u|r', '|cffff0000[竞技场列队公告]:|r 加入 : %ux%u : %u|r'),
(756, '|cffff0000[Arena Queue Announcer]:|r Exited : %ux%u : %u|r', '|cffff0000[Annonce File d''Attente Arène]:|r Quitté : %ux%u : %u|r', '|cffff0000[BG Ansager für Warteschlange]:|r verlassen : %ux%u : %u|r', '|cffff0000[竞技场列队公告]:|r 退出 : %ux%u : %u|r'),
(757, '|cffff0000[Arena Queue Announcer]:|r Joined : %ux%u|r', '|cffff0000[Annonce File d''Attente Arène]:|r Rejoint : %ux%u|r', '|cffff0000[BG Ansager für Warteschlange]:|r beigetreten : %ux%u|r', '|cffff0000[竞技场列队公告]:|r 加入 : %ux%u|r'),
(758, '|cffff0000[Arena Queue Announcer]:|r Exited : %ux%u|r', '|cffff0000[Annonce File d''Attente Arène]:|r Quitté : %ux%u|r', '|cffff0000[BG Ansager für Warteschlange]:|r verlassen : %ux%u|r', '|cffff0000[竞技场列队公告]:|r 退出 : %ux%u|r');

UPDATE `acore_string` SET `locale_frFR` = '|cffff0000[Annonce File d''Attente Arène]:|r %s -- Rejoint : %ux%u : %u|r' WHERE `entry` = 718;
UPDATE `acore_string` SET `locale_frFR` = '|cffff0000[Annonce File d''Attente Arène]:|r %s -- Quitté : %ux%u : %u|r' WHERE `entry` = 719;

--
DELETE FROM `module_string` WHERE `module` = 'anticheat' AND `id` IN (1,2,3,4,5,6);
INSERT INTO `module_string` (`module`, `id`, `string`) VALUES
('anticheat', 1, '|cffffff00[|cffff0000ANTICHEAT ALERT|r|cffffff00]:|r |cFFFF8C00|r |cFFFF8C00[|Hplayer:{}|h{}|h|r|cFFFF8C00] - Latency: {} ms - Report: {}'),
('anticheat', 2, '|cffffff00[|cffff0000ANTICHEAT ALERT|r|cffffff00]:|r POSSIBLE TELEPORT HACK DETECTED|cFFFF8C00 [|Hplayer:{}|h{}|h|r|cFFFF8C00]|r - Latency: {} ms - GPS Diff x: {}, y: {}, z: {}'),
('anticheat', 3, '|cffffff00[|cffff0000ANTICHEAT ALERT|r|cffffff00]:|r POSSIBLE IGNORE CONTROL HACK DETECTED|cFFFF8C00 {}|r - Latency: {} ms'),
('anticheat', 4, '|cffffff00[|cffff0000ANTICHEAT ALERT|r|cffffff00]:|r TELEPORT HACK USED WHILE DUELING|cFFFF8C00 {}|r - Latency: {} ms vs |cFFFF8C00 {}|r - Latency: {} ms.'),
('anticheat', 5, '|cffffff00[|cffff0000ANTICHEAT ALERT|r|cffffff00]:|r BG Start Teleport\\Exploit Hack DETECTED|cFFFF8C00[|Hplayer:{}|h{}|h|r|cFFFF8C00] - Latency: {} ms'),
('anticheat', 6, '|cffffff00[|cffff0000COUNTER MEASURE ALERT|r|cffffff00]:|r |cFFFF8C00|r {} |cFFFF8C00[|Hplayer:{}|h{}|h|r|cFFFF8C00]');

DELETE FROM `module_string_locale` WHERE `module` = 'anticheat' AND `id` IN (1,2,3,4,5,6) AND `locale` IN ('frFR', 'esES', 'esMX');
INSERT INTO `module_string_locale` (`module`, `id`, `locale`, `string`) VALUES
('anticheat', 1, 'frFR', '|cffffff00[|cffff0000ALERTE ANTICHEAT|r|cffffff00]:|r |cFFFF8C00|r |cFFFF8C00[|Hplayer:{}|h{}|h|r|cFFFF8C00] - Latence : {} ms - Rapport : {}'),
('anticheat', 1, 'esES', '|cffffff00[|cffff0000ALERTA ANTITRAMPAS|r|cffffff00]:|r |cFFFF8C00|r |cFFFF8C00[|Hplayer:{}|h{}|h|r|cFFFF8C00] - Latencia: {} ms - Reporte: {}'),
('anticheat', 1, 'esMX', '|cffffff00[|cffff0000ALERTA ANTITRAMPAS|r|cffffff00]:|r |cFFFF8C00|r |cFFFF8C00[|Hplayer:{}|h{}|h|r|cFFFF8C00] - Latencia: {} ms - Reporte: {}'),
('anticheat', 2, 'frFR', '|cffffff00[|cffff0000ALERTE ANTICHEAT|r|cffffff00]:|r POSSIBLE TÉLÉPORT HACK DÉTECTÉ|cFFFF8C00 [|Hplayer:{}|h{}|h|r|cFFFF8C00]|r - Latence : {} ms - Diff GPS x: {}, y: {}, z: {}'),
('anticheat', 2, 'esES', '|cffffff00[|cffff0000ALERTA ANTITRAMPAS|r|cffffff00]:|r POSIBLE HACK DE TELEPORTE DETECTADO|cFFFF8C00 [|Hplayer:{}|h{}|h|r|cFFFF8C00]|r - Latencia: {} ms - GPS Diff x: {}, y: {}, z: {}'),
('anticheat', 2, 'esMX', '|cffffff00[|cffff0000ALERTA ANTITRAMPAS|r|cffffff00]:|r POSIBLE HACK DE TELEPORTE DETECTADO|cFFFF8C00 [|Hplayer:{}|h{}|h|r|cFFFF8C00]|r - Latencia: {} ms - GPS Diff x: {}, y: {}, z: {}'),
('anticheat', 3, 'frFR', '|cffffff00[|cffff0000ALERTE ANTICHEAT|r|cffffff00]:|r POSSIBLE IGNORE CONTROL HACK DÉTECTÉ|cFFFF8C00 {}|r - Latence : {} ms'),
('anticheat', 3, 'esES', '|cffffff00[|cffff0000ALERTA ANTITRAMPAS|r|cffffff00]:|r POSIBLE CONTROL DE HACK DETECTADO IGNORARADO|cFFFF8C00 {}|r - Latencia: {} ms'),
('anticheat', 3, 'esMX', '|cffffff00[|cffff0000ALERTA ANTITRAMPAS|r|cffffff00]:|r POSIBLE CONTROL DE HACK DETECTADO IGNORARADO|cFFFF8C00 {}|r - Latencia: {} ms'),
('anticheat', 4, 'frFR', '|cffffff00[|cffff0000ALERTE ANTICHEAT|r|cffffff00]:|r TÉLÉPORT HACK UTILISÉ PENDANT UN DUEL|cFFFF8C00 {}|r - Latence : {} ms vs |cFFFF8C00 {}|r - Latence : {} ms.'),
('anticheat', 5, 'frFR', '|cffffff00[|cffff0000ALERTE ANTICHEAT|r|cffffff00]:|r Téléport Début BG\\Exploit Hack DÉTECTÉ|cFFFF8C00[|Hplayer:{}|h{}|h|r|cFFFF8C00] - Latence : {} ms'),
('anticheat', 6, 'frFR', '|cffffff00[|cffff0000ALERTE CONTRE MESURE|r|cffffff00]:|r |cFFFF8C00|r {} |cFFFF8C00[|Hplayer:{}|h{}|h|r|cFFFF8C00]');

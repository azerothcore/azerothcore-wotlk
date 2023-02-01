-- DB update 2023_01_28_07 -> 2023_01_28_08
DELETE FROM `npc_text_locale` WHERE `ID` = 50022 AND `Locale` IN ('esES', 'esMX');
INSERT INTO `npc_text_locale` (`ID`, `Locale`, `Text0_0`) VALUES
(50022, 'esES', '¡Saludos, $c! Un día perfecto para ir a cazar, ¿no te parece? He estado teniendo bastante suerte con los jabalíes. ¿Te gustaría intentarlo?'),
(50022, 'esMX', '¡Saludos, $c! Un día perfecto para ir a cazar, ¿no te parece? He estado teniendo bastante suerte con los jabalíes. ¿Te gustaría intentarlo?');

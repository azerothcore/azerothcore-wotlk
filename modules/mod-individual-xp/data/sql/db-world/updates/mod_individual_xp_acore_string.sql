SET @ENTRY:=35411;
DELETE FROM `acore_string` WHERE `entry` BETWEEN @ENTRY+0 AND @ENTRY+9;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(@ENTRY+0, 'This server is running the |cff4CFF00IndividualXpRate |rmodule.', '', '', '', '', '', 'Este servidor está ejecutando el módulo |cff4CFF00 mod-individual-xp.', 'Este servidor está ejecutando el módulo |cff4CFF00 mod-individual-xp.', ''),
(@ENTRY+1, '[XP] The Individual XP module is deactivated.', '', '', '', '', '', '[XP] El módulo XP individual está desactivado.', '[XP] El módulo XP individual está desactivado.', ''),
(@ENTRY+2, '[XP] Your Individual XP is currently disabled. Use .xp enable to re-enable it.', '', '', '', '', '', '[XP] Su XP individual está actualmente desactivado. Utilice .xp enable para volver a activarlo.', '[XP] Su XP individual está actualmente desactivado. Utilice .xp enable para volver a activarlo.', ''),
(@ENTRY+3, '[XP] Your current XP rate is %u.', '', '', '', '', '', '[XP] Su experiencia actual es %u.', '[XP] su experiencia actual es %u.', ''),
(@ENTRY+4, '[XP] The maximum rate limit is %u.', '', '', '', '', '', '[XP] El límite máximo de XP es %u.', '[XP] El límite máximo de XP es %u.', ''),
(@ENTRY+5, '[XP] The minimum rate limit is 1.', '', '', '', '', '', '[XP] El límite mínimo de XP es 1.', '[XP] El límite mínimo de XP es 1.', ''),
(@ENTRY+6, '[XP] You have updated your XP rate to %u.', '', '', '', '', '', '[XP] Has actualizado tu XP a %u', '[XP] Has actualizado tu XP a %u', ''),
(@ENTRY+7, '[XP] You have disabled your XP gain.', '', '', '', '', '', '[XP] Has desactivado tu ganancia de XP.', '[XP] Has desactivado tu ganancia de XP.', ''),
(@ENTRY+8, '[XP] You have enabled your XP gain.', '', '', '', '', '', '[XP] Has activado tu ganancia de XP.', '[XP] Has activado tu ganancia de XP.', ''),
(@ENTRY+9, '[XP] You have restored your XP rate to the default value of %u.', '', '', '', '', '', '[XP] Has restaurado tu tasa de XP al valor por defecto de %u.', '[XP] Has restaurado tu tasa de XP al valor por defecto de %u.', '');

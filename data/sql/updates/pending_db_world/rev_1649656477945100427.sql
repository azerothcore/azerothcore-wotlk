INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1649656477945100427');

DELETE FROM `npc_text_locale` WHERE `ID`=13321 AND `locale` IN ('esES','esMX','frFR','zhCN','deDE'); 
INSERT INTO `npc_text_locale` (`ID`, `Locale`, `Text0_0`, `Text0_1`) VALUES
(13321,"frFR","","Depuis ce quai, la Bravoure fait l\'aller-retour entre Hurlevent et Auberdine."),
(13321,"esES","","Desde este muelle, El Valentía hace el viaje de ida y vuelta entre Ventormenta y Auberdine."),
(13321,"esMX","","Desde este muelle, El Valentía hace el viaje de ida y vuelta entre Ventormenta y Auberdine."),
(13321,"zhCN","","从这个码头，勇敢者号在暴风城和奥伯丁之间往返"),
(13321,"deDE","","Von diesem Dock aus fährt die Bravado zwischen Sturmwind und Auberdine hin und her.");

DELETE FROM `broadcast_text_locale` WHERE `ID`=28636 AND `locale` IN ('esES','esMX','frFR','zhCN','deDE'); 
INSERT INTO `broadcast_text_locale` (`ID`, `Locale`,`MaleText`,`FemaleText`,VerifiedBuild) VALUES
(28636,"frFR","","Depuis ce quai, la Bravoure fait l\'aller-retour entre Hurlevent et Auberdine.",18019),
(28636,"esES","","Desde este muelle, El Valentía hace el viaje de ida y vuelta entre Ventormenta y Auberdine.",18019),
(28636,"esMX","","Desde este muelle, El Valentía hace el viaje de ida y vuelta entre Ventormenta y Auberdine.",18019),
(28636,"zhCN","","从这个码头，勇敢者号在暴风城和奥伯丁之间往返",18019),
(28636,"deDE","","Von diesem Dock aus fährt die Bravado zwischen Sturmwind und Auberdine hin und her.",18019);

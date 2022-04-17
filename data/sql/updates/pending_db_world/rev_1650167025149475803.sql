INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650167025149475803');

UPDATE `quest_template_locale` SET `Objectives` = 'Encuentra y mata al Coleccionista y vuelve junto al alguacil Dughan con la sortija del coleccionista.' WHERE `ID` = 147 AND `locale` IN ('esES','esMX'); 
UPDATE `quest_template_locale` SET `CompletedText` = 'Vuelve con: Alguacil Dughan. Zona: Aserradero de la Vega del Este, Bosque de Elwynn.' WHERE `ID` = 147 AND `locale` IN ('esES','esMX');
UPDATE `quest_template_locale` SET `Objectives` = 'Mata a 4 sables de la noche y 4 jabalies cardo jovenes.' WHERE `ID` = 456 AND `locale` IN ('esES','esMX');
UPDATE `quest_template_locale` SET `Objectives` = 'Mata a 5 sables de la noche sarnosos y a 5 jabalies Cardo.' WHERE `ID` = 457 AND `locale` = 'esMX';
UPDATE `quest_template_locale` SET `Title` = 'El veneno de la Tejemadera' WHERE `ID` = 916 AND `locale` = 'esMX';
UPDATE `quest_template_locale` SET `Objectives` = 'Lleva 10 glándulas de veneno de Tejemadera a Gilshalan Caminaviento a Aldrassil.' WHERE `ID` = 916 AND `locale` = 'esMX';
UPDATE `quest_template_locale` SET `Details` = 'He venido a Cañada Umbría para observar a las arañas tejemadera de la Gruta Narácnida. Son parientes de unas arañas mucho más pequeñas; creo que el Árbol del Mundo ha tenido un profundo efecto en ellas y quiero estudiar unos especímenes para confirmarlo.$B$BPara empezar, necesito su veneno. Ve a la Gruta Narácnida, que está al norte de aquí, y tráeme glándulas de veneno; así podré compararlo con el veneno de sus parientes más pequeñas.' WHERE `ID` = 916 AND `locale` = 'esMX';
UPDATE `quest_template_locale` SET `CompletedText` = 'Vuelve con el vigilante Bel\'dugur al Apothecarium en Entrañas.' WHERE `ID` = 1013 AND `locale` IN ('esES','esMX');


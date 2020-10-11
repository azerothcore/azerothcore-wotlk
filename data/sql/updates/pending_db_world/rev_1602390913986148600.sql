INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1602390913986148600');

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12678 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12678, 'esES', '¿Lo sientes, $n? Esta sensación es puro poder recorriendo tu cuerpo. Tal cosa no puede existir para los mortales.$B$BYa se han desmantelado las primeras filas. Los geists acabarán el trabajo y prepararán el terreno para Razuvious. Ahora debemos centrarnos en objetivos más tácticos.', 18019),
(12678, 'esMX', '¿Lo sientes, $n? Esta sensación es puro poder recorriendo tu cuerpo. Tal cosa no puede existir para los mortales.$B$BYa se han desmantelado las primeras filas. Los geists acabarán el trabajo y prepararán el terreno para Razuvious. Ahora debemos centrarnos en objetivos más tácticos.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Caballo robado con éxito' WHERE `ID`=12680 AND `locale` IN ('esEs', 'esMX');

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12680 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12680, 'esES', 'Ahora la verdadera prueba. ¿Puedes dominar a un destrero suelto y coger brutalmente la cosa que más deseas?', 18019),
(12680, 'esMX', 'Ahora la verdadera prueba. ¿Puedes dominar a un destrero suelto y coger brutalmente la cosa que más deseas?', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12687 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12687, 'esES', 'Has conseguido lo que la mayoría de principiantes no ha podido conseguir, $n. Por ello recibirás un buen premio.', 18019),
(12687, 'esMX', 'Has conseguido lo que la mayoría de principiantes no ha podido conseguir, $n. Por ello recibirás un buen premio.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Caballeros de la Muerte derrotados en duelo' WHERE `ID`=12733 AND `locale` IN ('esEs', 'esMX');

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12733 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12733, 'esES', '¡Después de la victoria viene la gloria, caballero de la Muerte! ¡Bien hecho! Hoy el Rey Exánime te mira con buenos ojos.', 18019),
(12733, 'esMX', '¡Después de la victoria viene la gloria, caballero de la Muerte! ¡Bien hecho! Hoy el Rey Exánime te mira con buenos ojos.', 18019);

UPDATE `creature_text` SET `BroadcastTextId`=29258 WHERE `CreatureID`=28406 AND `GroupID`=1 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=29259 WHERE `CreatureID`=28406 AND `GroupID`=2 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=29260 WHERE `CreatureID`=28406 AND `GroupID`=3 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=29261 WHERE `CreatureID`=28406 AND `GroupID`=4 AND `ID`=0;

UPDATE `creature_text` SET `BroadcastTextId`=28790 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=0 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=28789 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=0 AND `ID`=1;
UPDATE `creature_text` SET `BroadcastTextId`=28793 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=0 AND `ID`=2;
UPDATE `creature_text` SET `BroadcastTextId`=28788 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=0 AND `ID`=3;
UPDATE `creature_text` SET `BroadcastTextId`=28787 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=0 AND `ID`=4;

UPDATE `creature_text` SET `BroadcastTextId`=28767 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=1 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=28764 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=1 AND `ID`=1;
UPDATE `creature_text` SET `BroadcastTextId`=28763 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=1 AND `ID`=2;
UPDATE `creature_text` SET `BroadcastTextId`=28765 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=1 AND `ID`=3;

UPDATE `creature_text` SET `BroadcastTextId`=28768 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=2 AND `ID`=0;
UPDATE `creature_text` SET `BroadcastTextId`=28766 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=2 AND `ID`=1;
UPDATE `creature_text` SET `BroadcastTextId`=28770 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=2 AND `ID`=2;
UPDATE `creature_text` SET `BroadcastTextId`=28769 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=2 AND `ID`=3;
UPDATE `creature_text` SET `BroadcastTextId`=28792 WHERE `CreatureID` IN (28576, 28577) AND `GroupID`=2 AND `ID`=4;

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12679 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12679, 'esES', '¡Bien hecho, caballero de la Muerte! ¡Alimentas la máquina de guerra de la Plaga con tus actos!$B$BAh sí, tu premio, como te prometí.', 18019),
(12679, 'esMX', '¡Bien hecho, caballero de la Muerte! ¡Alimentas la máquina de guerra de la Plaga con tus actos!$B$BAh sí, tu premio, como te prometí.', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12679 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12679, 'esES', 'La mayoría de flechas han acabado en la trayectoria donde apuntan o cerca de la Granja de Villa Refugio, en el sur.', 18019),
(12679, 'esMX', 'La mayoría de flechas han acabado en la trayectoria donde apuntan o cerca de la Granja de Villa Refugio, en el sur.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12697 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12697, 'esES', 'Has luchado mucho para invadir el reino del Cosechador… Espera.$B$B<Gothik consulta sus notas.>$B$BDiscúlpame, $c. Cuesta cambiar las antiguas costumbres.$B$B¿Valanar te envió, entonces? Creo que eres bastante competente.$B$BTengo un regalo para los perros Escarlata. Uno que, estoy seguro, acelerará sus trabajos en las minas.', 18019),
(12697, 'esMX', 'Has luchado mucho para invadir el reino del Cosechador… Espera.$B$B<Gothik consulta sus notas.>$B$BDiscúlpame, $c. Cuesta cambiar las antiguas costumbres.$B$B¿Valanar te envió, entonces? Creo que eres bastante competente.$B$BTengo un regalo para los perros Escarlata. Uno que, estoy seguro, acelerará sus trabajos en las minas.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Necrófago escarlata convertido' WHERE `ID`=12698 AND `locale` IN ('esEs', 'esMX');

UPDATE `creature_text` SET `BroadcastTextId`=28941 WHERE `CreatureID`=28658 AND `GroupID`=0 AND `ID`=0;

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12698 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12698, 'esES', 'Ahora saben que las minas ya no son seguras. Doblarán sus esfuerzos en retirarse y ¡nos las dejarán libres para nosotros!', 18019),
(12698, 'esMX', 'Ahora saben que las minas ya no son seguras. Doblarán sus esfuerzos en retirarse y ¡nos las dejarán libres para nosotros!', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=12698 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12698, 'esES', 'Una pequeña nota: los mineros no siempre se convierten en necrófago. A veces se convierten en espíritus enfurecidos, empeñados en matarte.', 18019),
(12698, 'esMX', 'Una pequeña nota: los mineros no siempre se convierten en necrófago. A veces se convierten en espíritus enfurecidos, empeñados en matarte.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12700 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12700, 'esES', 'Nos has hecho un buen servicio, caballero de la Muerte. Pocos de tus hermanos han sobrevivido nuestro ataque a los intrusos Escarlata. Eres uno de los más fuertes.$B$B<El príncipe Valanar asiente con la cabeza.>$B$BHacia el este, pasada la Mina Villa Refugio, está la costa llamada la Punta de la Luz por la Cruzada Escarlata. Un millar de soldados nos separa de sus barcos. ¿Insuperable? No lo creo...', 18019),
(12700, 'esMX', 'Nos has hecho un buen servicio, caballero de la Muerte. Pocos de tus hermanos han sobrevivido nuestro ataque a los intrusos Escarlata. Eres uno de los más fuertes.$B$B<El príncipe Valanar asiente con la cabeza.>$B$BHacia el este, pasada la Mina Villa Refugio, está la costa llamada la Punta de la Luz por la Cruzada Escarlata. Un millar de soldados nos separa de sus barcos. ¿Insuperable? No lo creo...', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Defensor escarlata asesinado' WHERE `ID`=12701 AND `locale` IN ('esEs', 'esMX');

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12701 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12701, 'esES', '¡La flota Escarlata al completo ha sido exterminada en cuestión de minutos! ¡Recibiré una mención de honor del Rey Exánime por esto! Todo lo que queda de la Cruzada Escarlata ahora son los ciudadanos de Nuevo Avalon.$B$BColocaré los ignitores y nigromantes en Villa Refugio inmediatamente. ¡Tú llevarás mi informe al Alto Señor!', 18019),
(12701, 'esMX', '¡La flota Escarlata al completo ha sido exterminada en cuestión de minutos! ¡Recibiré una mención de honor del Rey Exánime por esto! Todo lo que queda de la Cruzada Escarlata ahora son los ciudadanos de Nuevo Avalon.$B$BColocaré los ignitores y nigromantes en Villa Refugio inmediatamente. ¡Tú llevarás mi informe al Alto Señor!', 18019);

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1602691501352176800');

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12778 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12778, 'esES', 'Me has servido bien, $n. La marca de la Plaga se ha quemado en estas tierras Escarlatas. Has cosechado muerte y destrucción hasta donde puede alcanzar la vista y me has ofrecido el último ejército escarlata.$B$BAhora es hora de que acabes lo que empezaste.', 18019),
(12778, 'esMX', 'Me has servido bien, $n. La marca de la Plaga se ha quemado en estas tierras Escarlatas. Has cosechado muerte y destrucción hasta donde puede alcanzar la vista y me has ofrecido el último ejército escarlata.$B$BAhora es hora de que acabes lo que empezaste.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Soldados escarlata matados', `ObjectiveText2`='Balista escarlata aniquilado'  WHERE `ID`=12779 AND `locale` IN ('esEs', 'esMX');

DELETE FROM `quest_request_items_locale` WHERE `ID`=12779 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12779, 'esES', 'Mátalos a todos...', 18019),
(12779, 'esMX', 'Mátalos a todos...', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12779 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12779, 'esES', 'Arrodíllate, campeón. Te pongo este casco para completar tu cara de terror. Cualquiera que se atreva a mirar tu rostro oscuro sabrá que la muerte se acerca. No dejes que nadie se atreva a acercarse tanto a tu rey de manera que pueda hacer frente a tu ira despiadada, $n.$B$BSolo queda una tarea final pendiente…$B$BLa Capilla de la Esperanza de la Luz.', 18019),
(12779, 'esMX', 'Arrodíllate, campeón. Te pongo este casco para completar tu cara de terror. Cualquiera que se atreva a mirar tu rostro oscuro sabrá que la muerte se acerca. No dejes que nadie se atreva a acercarse tanto a tu rey de manera que pueda hacer frente a tu ira despiadada, $n.$B$BSolo queda una tarea final pendiente…$B$BLa Capilla de la Esperanza de la Luz.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12800 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12800, 'esES', '¡El Alto Señor y los otros caballeros de la Muerte están preparando el ataque! Aplastaremos todo lo que queda de vida en este lugar.', 18019),
(12800, 'esMX', '¡El Alto Señor y los otros caballeros de la Muerte están preparando el ataque! Aplastaremos todo lo que queda de vida en este lugar.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='La luz del alba descubierta' WHERE `ID`=12801 AND `locale` IN ('esEs', 'esMX');

DELETE FROM `quest_request_items_locale` WHERE `ID`=12801 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(12801, 'esES', '<Darion Mograine asiente con la cabeza.>', 18019),
(12801, 'esMX', '<Darion Mograine asiente con la cabeza.>', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=12801 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(12801, 'esES', 'No habrá compensación para nosotros, $n. Estamos condenados a vagar por la tierra como monstruos. El Rey Exánime nos ha liberado de su control, pero los espectros del pasado permanecerán en nuestros recuerdos para siempre.$B$BTenemos que enmendar de la única manera que sabemos: con la muerte…$B$BAhora te ordeno que te unas a mí y a Acherus como caballero de la Espada de Ébano. Juntos acabaremos con el Rey Exánime y pondremos fin a la Plaga.', 18019),
(12801, 'esMX', 'No habrá compensación para nosotros, $n. Estamos condenados a vagar por la tierra como monstruos. El Rey Exánime nos ha liberado de su control, pero los espectros del pasado permanecerán en nuestros recuerdos para siempre.$B$BTenemos que enmendar de la única manera que sabemos: con la muerte…$B$BAhora te ordeno que te unas a mí y a Acherus como caballero de la Espada de Ébano. Juntos acabaremos con el Rey Exánime y pondremos fin a la Plaga.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=13165 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(13165, 'esES', 'El Rey Exánime, herido por la Crematoria, ha vuelto a Rasganorte, pero los últimos soldados aún resisten en el segundo piso.', 18019),
(13165, 'esMX', 'El Rey Exánime, herido por la Crematoria, ha vuelto a Rasganorte, pero los últimos soldados aún resisten en el segundo piso.', 18019);

UPDATE `quest_template_locale` SET `ObjectiveText1`='Remendejo', `ObjectiveText2`='Miembro de la Plaga asesinado'  WHERE `ID`=13166 AND `locale` IN ('esEs', 'esMX');

DELETE FROM `quest_request_items_locale` WHERE `ID`=13166 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(13166, 'esES', '¡Acherus será nuestro!', 18019),
(13166, 'esMX', '¡Acherus será nuestro!', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=13166 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(13166, 'esES', 'Bien hecho, caballero de la Muerte. Se ocuparán de los quedan de la Plaga pronto y el proceso de reconstrucción comenzará de nuevo.$B$BPero tengo una última tarea para ti.', 18019),
(13166, 'esMX', 'Bien hecho, caballero de la Muerte. Se ocuparán de los quedan de la Plaga pronto y el proceso de reconstrucción comenzará de nuevo.$B$BPero tengo una última tarea para ti.', 18019);

DELETE FROM `quest_request_items_locale` WHERE `ID`=13188 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(13188, 'esES', 'Te quedan pocos momentos de vida.', 18019),
(13188, 'esMX', 'Te quedan pocos momentos de vida.', 18019);

DELETE FROM `quest_offer_reward_locale` WHERE `ID`=13188 AND `locale` IN ('esES', 'esMX');

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(13188, 'esES', '<Varian Wrynn mira a la distancia.>$B$BClaro, viejo amigo... Sangre y honor.$B$B<Varian Wrynn fija su mirada en ti.>$B$BSi no fuera por esta carta de Tirion, llevarías grilletes. Solo la protección de uno de los más grandes paladines que han existido podría asegurar tu supervivencia.$B$BNosotros... lucharemos juntos contra la Plaga. ¡Contra el Rey Exánime!$B$B¡GLORIA A LA ALIANZA!', 18019),
(13188, 'esMX', '<Varian Wrynn mira a la distancia.>$B$BClaro, viejo amigo... Sangre y honor.$B$B<Varian Wrynn fija su mirada en ti.>$B$BSi no fuera por esta carta de Tirion, llevarías grilletes. Solo la protección de uno de los más grandes paladines que han existido podría asegurar tu supervivencia.$B$BNosotros... lucharemos juntos contra la Plaga. ¡Contra el Rey Exánime!$B$B¡GLORIA A LA ALIANZA!', 18019);

--
-- https://www.wowhead.com/quest=24743/shadows-edge
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24743  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24743, 'esMX', 'Escucha bien, $c. Al aceptar esta arma, tu destino está sellado.$B$BVencer o sucumbir.$B$BHe puesto tus pies en este camino. Por lo tanto, eres mi responsabilidad personal. Si fallas, tengo el deber de liberarte de esta vida.$B$BRecuerda mis palabras, $r, y no falles.', 12340),
(24743, 'esES', 'Escucha bien, $c. Al aceptar esta arma, tu destino está sellado.$B$BVencer o sucumbir.$B$BHe puesto tus pies en este camino. Por lo tanto, eres mi responsabilidad personal. Si fallas, tengo el deber de liberarte de esta vida.$B$BRecuerda mis palabras, $r, y no falles.', 12340);

-- https://www.wowhead.com/quest=24547/a-feast-of-souls
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24547  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24547, 'esMX', '<El Alto Señor Mograine te observa en silencio por un momento.>$b$bParece que has soportado esta etapa de tu prueba admirablemente, $r.$b$bReza para que el destino siga sonriéndote en tu esfuerzo...', 12340),
(24547, 'esES', '<El Alto Señor Mograine te observa en silencio por un momento.>$b$bParece que has soportado esta etapa de tu prueba admirablemente, $r.$b$bReza para que el destino siga sonriéndote en tu esfuerzo...', 12340);

-- https://www.wowhead.com/quest=24749/unholy-infusion
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24749  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24749, 'esMX', 'Bien hecho, $c.$b$bLa finalización de nuestro trabajo se acerca.', 12340),
(24749, 'esES', 'Bien hecho, $c.$b$bLa finalización de nuestro trabajo se acerca.', 12340);

-- https://www.wowhead.com/quest=24756/blood-infusion
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24756  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24756, 'esMX', 'Bien hecho, $c.$b$bAgonía de Sombras está casi a nuestro alcance.', 12340),
(24756, 'esES', 'Bien hecho, $c.$b$bAgonía de Sombras está casi a nuestro alcance.', 12340);

-- https://www.wowhead.com/quest=24757/frost-infusion
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24757  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24757, 'esMX', 'El hacha ha bebido hasta saciarse, $r, y la forja está casi lista para la creación de Agonía de Sombras...', 12340),
(24757, 'esES', 'El hacha ha bebido hasta saciarse, $r, y la forja está casi lista para la creación de Agonía de Sombras...', 12340);

-- https://www.wowhead.com/quest=24548/the-splintered-throne
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24548  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24548, 'esMX', 'Esto debería ser suficiente, $c.$b$bHáblame cuando Filo de la Sombra esté completamente potenciado e intentaré completarlo.', 12340),
(24548, 'esES', 'Esto debería ser suficiente, $c.$b$bHáblame cuando Filo de la Sombra esté completamente potenciado e intentaré completarlo.', 12340);

DELETE FROM `quest_request_items_locale` WHERE `ID` = 24548  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(24548, 'esMX', '¿Has conseguido los fragmentos del trono helado, $C?', 12340),
(24548, 'esES', '¿Has conseguido los fragmentos del trono helado, $C?', 12340);

-- https://www.wowhead.com/quest=24912/empowerment
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24912  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24912, 'esMX', 'Manténgase alejado, $c, y manténgase estable.', 12340),
(24912, 'esES', 'Manténgase alejado, $c, y manténgase estable.', 12340);

-- https://www.wowhead.com/quest=24549/shadowmourne
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24549  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24549, 'esMX', 'Enhorabuena, $c.$b$bA pesar de todo lo contrario, has superado la tormenta.$b$bConfío en que encontrarás una recompensa proporcional a tu convicción...', 12340),
(24549, 'esES', 'Enhorabuena, $c.$b$bA pesar de todo lo contrario, has superado la tormenta.$b$bConfío en que encontrarás una recompensa proporcional a tu convicción...', 12340);

-- https://www.wowhead.com/quest=24748/the-lich-kings-last-stand
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24748  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24748, 'esMX', 'Así que, por fin, está hecho.$b$bQue la gente de Azeroth recuerde nuestras hazañas aquí para siempre. Que los sacrificios de tantos ardan en sus corazones eternamente. Que nunca dejen de arriesgarse al peligro mortal ante un gran mal.', 12340),
(24748, 'esES', 'Así que, por fin, está hecho.$b$bQue la gente de Azeroth recuerde nuestras hazañas aquí para siempre. Que los sacrificios de tantos ardan en sus corazones eternamente. Que nunca dejen de arriesgarse al peligro mortal ante un gran mal.', 12340);

-- https://www.wowhead.com/quest=24914/personal-property
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24914  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24914, 'esMX', '<Después de trazar un patrón complejo de runas en cada una de las superficies de la caja, aparece el contorno de una tapa y un clic resuena en la cámara.>$B$BAquí tienes, $R.', 12340),
(24914, 'esES', '<Después de trazar un patrón complejo de runas en cada una de las superficies de la caja, aparece el contorno de una tapa y un clic resuena en la cámara.>$B$BAquí tienes, $R.', 12340);

-- https://www.wowhead.com/quest=24915/mograines-reunion
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24915  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24915, 'esMX', 'Imposible...$B$B¡Padre, ¿eres tú?!$B$BMe has hecho un gran favor, héroe. Te ofrezco las riendas de mi fiel corcel. Haz lo que quieras con él, pero no olvides a quienes te ayudaron en esta hazaña monumental.', 12340),
(24915, 'esES', 'Imposible...$B$B¡Padre, ¿eres tú?!$B$BMe has hecho un gran favor, héroe. Te ofrezco las riendas de mi fiel corcel. Haz lo que quieras con él, pero no olvides a quienes te ayudaron en esta hazaña monumental.', 12340);

DELETE FROM `quest_request_items_locale` WHERE `ID` = 24915  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(24915, 'esMX', '¿Qué es eso que tienes, $c?$B$BMe llama, despertando sentimientos que creía muertos hace mucho tiempo.', 12340),
(24915, 'esES', '¿Qué es eso que tienes, $c?$B$BMe llama, despertando sentimientos que creía muertos hace mucho tiempo.', 12340);

-- https://www.wowhead.com/quest=24916/jainas-locket
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24916  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24916, 'esMX', '¿Cómo... cómo conseguiste esto?$B$BMe has hecho un gran favor, héroe. No podría soportar conservar este relicario, pero le pondré un encantamiento que te será útil. Haz lo que quieras con él, pero no olvides a quienes te ayudaron en esta hazaña monumental.', 12340),
(24916, 'esES', '¿Cómo... cómo conseguiste esto?$B$BMe has hecho un gran favor, héroe. No podría soportar conservar este relicario, pero le pondré un encantamiento que te será útil. Haz lo que quieras con él, pero no olvides a quienes te ayudaron en esta hazaña monumental.', 12340);

DELETE FROM `quest_request_items_locale` WHERE `ID` = 24916  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(24916, 'esMX', 'Sí, $c. ¿Cómo puedo ayudarte?', 12340),
(24916, 'esES', 'Sí, $c. ¿Cómo puedo ayudarte?', 12340);

-- https://www.wowhead.com/quest=24917/muradins-lament
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24917  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24917, 'esMX', 'Sí. Conozco esta espada... y siempre la atesoraré: un instante que se perderá para siempre.$B$BMe has hecho un gran favor, héroe. Te ofrezco un regalo de los enanos nacidos en la escarcha. Haz lo que quieras con él, pero no olvides a quienes te ayudaron en esta hazaña monumental.', 12340),
(24917, 'esES', 'Sí. Conozco esta espada... y siempre la atesoraré: un instante que se perderá para siempre.$B$BMe has hecho un gran favor, héroe. Te ofrezco un regalo de los enanos nacidos en la escarcha. Haz lo que quieras con él, pero no olvides a quienes te ayudaron en esta hazaña monumental.', 12340);

DELETE FROM `quest_request_items_locale` WHERE `ID` = 24917  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(24917, 'esMX', '¿Qué tienes ahí, $r?', 12340),
(24917, 'esES', '¿Qué tienes ahí, $r?', 12340);

-- https://www.wowhead.com/quest=24919/the-lightbringers-redemption
DELETE FROM `quest_offer_reward_locale` WHERE `ID` = 24919  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24919, 'esMX', '<Uther mira la medalla, sin palabras por un momento.>$B$BAl medalla de Arthas.$B$B Recuerdo bien el día que se la entregué...$B$BMe has hecho un gran favor, héroe. Mi alma puede descansar en paz. Te ofrezco un recuerdo perdido en el tiempo. Haz lo que quieras con él, pero no olvides a quienes te ayudaron en esta hazaña monumental.', 12340),
(24919, 'esES', '<Uther mira la medalla, sin palabras por un momento.>$B$BAl medalla de Arthas.$B$B Recuerdo bien el día que se la entregué...$B$BMe has hecho un gran favor, héroe. Mi alma puede descansar en paz. Te ofrezco un recuerdo perdido en el tiempo. Haz lo que quieras con él, pero no olvides a quienes te ayudaron en esta hazaña monumental.', 12340);

DELETE FROM `quest_request_items_locale` WHERE `ID` = 24919  AND `locale` IN ('esMX', 'esES');
INSERT INTO `quest_request_items_locale` (`ID`, `locale`, `CompletionText`, `VerifiedBuild`) VALUES
(24919, 'esMX', '¿En qué puedo serle útil, $r?', 12340),
(24919, 'esES', '¿En qué puedo serle útil, $r?', 12340);

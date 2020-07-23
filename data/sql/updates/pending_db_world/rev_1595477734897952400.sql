INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1595477734897952400');

DELETE FROM `quest_offer_reward_locale` WHERE `locale` IN ('esES', 'esMX') AND `ID` IN (24499, 24511, 24506, 24510);

INSERT INTO `quest_offer_reward_locale` (`ID`, `locale`, `RewardText`, `VerifiedBuild`) VALUES
(24499, 'esES', 'El Foso de Saron está más adelante y, si nuestros exploradores están en lo cierto, al otro lado están las Cámaras de Reflexión.$B$BEs ahí donde Arthas baja la guardia, y es ahí donde esperamos encontrar pistas sobre su debilidad... o tal vez, solo tal vez, su redención.', 18019),
(24499, 'esMX', 'El Foso de Saron está más adelante y, si nuestros exploradores están en lo cierto, al otro lado están las Cámaras de Reflexión.$B$BEs ahí donde Arthas baja la guardia, y es ahí donde esperamos encontrar pistas sobre su debilidad... o tal vez, solo tal vez, su redención.', 18019),
(24511, 'esES', 'El Foso de Saron está más adelante y, si nuestros exploradores están en lo cierto, al otro lado están las Cámaras de Reflexión.$B$BEs ahí donde Arthas baja la guardia, y es ahí donde esperamos encontrar pistas sobre su debilidad... o tal vez, solo tal vez, su redención.', 18019),
(24511, 'esMX', 'El Foso de Saron está más adelante y, si nuestros exploradores están en lo cierto, al otro lado están las Cámaras de Reflexión.$B$BEs ahí donde Arthas baja la guardia, y es ahí donde esperamos encontrar pistas sobre su debilidad... o tal vez, solo tal vez, su redención.', 18019),
(24506, 'esES', 'Bien. $n, he oído hablar de ti. Eres perfecto para estas tareas.$B$BNos han brindado una rara oportunidad para entrar en la Ciudadela de la Corona de Hielo, pero debemos apresurarnos para evitar la atención de Arthas.', 18019),
(24506, 'esMX', 'Bien. $n, he oído hablar de ti. Eres perfecto para estas tareas.$B$BNos han brindado una rara oportunidad para entrar en la Ciudadela de la Corona de Hielo, pero debemos apresurarnos para evitar la atención de Arthas.', 18019),
(24510, 'esES', '¡%n! Cuánto me alegro de que hayas venido.$B$BSe nos ha concedido la insólita oportunidad de adentrarnos en la Ciudadela de la Corona de Hielo, pero debemos darnos prisa si queremos evitar la atención de Arthas.', 18019),
(24510, 'esMX', '¡%n! Cuánto me alegro de que hayas venido.$B$BSe nos ha concedido la insólita oportunidad de adentrarnos en la Ciudadela de la Corona de Hielo, pero debemos darnos prisa si queremos evitar la atención de Arthas.', 18019);

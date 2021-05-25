-- DB update 2021_05_25_07 -> 2021_05_25_08
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_05_25_07';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_05_25_07 2021_05_25_08 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1621427242858236100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1621427242858236100');

UPDATE `item_template_locale` SET `Name` = 'Boceto: ámbar del rey luminoso' WHERE (`ID` = 46930) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: ojo de dragón rápido' WHERE (`ID` = 42307) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Amatista Cantosombrío equilibrada' WHERE (`ID` = 32213) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Amatista Cantosombrío imbuida' WHERE (`ID` = 32214) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Amatista Cantosombrío real' WHERE (`ID` = 32216) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Amatista Cantosombrío resplandeciente' WHERE (`ID` = 32215) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Brillo de otoño luminoso' WHERE (`ID` = 40012) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Brillo de otoño rígido' WHERE (`ID` = 40014) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Draenita dorada rígida' WHERE (`ID` = 23116) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Glifo de Maestría en Agua' WHERE (`ID` = 41541) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Glifo de Sello de sabiduría' WHERE (`ID` = 41109) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Gran ojo de león' WHERE (`ID` = 32210) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Granate de sangre rúnico' WHERE (`ID` = 23096) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Ojo de dragón brillante' WHERE (`ID` = 36766) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Ojo de dragón fracturado' WHERE (`ID` = 42153) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Ojo de dragón grueso' WHERE (`ID` = 42157) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Ojo de dragón lustroso' WHERE (`ID` = 42146) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Ojo de dragón rúnino' WHERE (`ID` = 42144) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Ojo de león grueso' WHERE (`ID` = 32208) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Ojo de león luminoso' WHERE (`ID` = 32204) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Ojo de león reluciente' WHERE (`ID` = 32207) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Ojo de león rígido' WHERE (`ID` = 32206) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Piedra del alba rígida' WHERE (`ID` = 24051) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Rubí vivo brillante' WHERE (`ID` = 24031) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Rubí vivo rúnico' WHERE (`ID` = 24030) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Rubí vivo sutil' WHERE (`ID` = 24032) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Zafiro empíreo luciente' WHERE (`ID` = 32202) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Zafiro empíreo sólido' WHERE (`ID` = 32200) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Ámbar del rey luminoso' WHERE (`ID` = 40123) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ojo de dragón llamativo.' WHERE (`ID` = 42298) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ojo de dragón ostentoso.' WHERE (`ID` = 42302) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ametrino durable.' WHERE (`ID` = 46952) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ametrino iluminado.' WHERE (`ID` = 47021) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ametrino luminoso.' WHERE (`ID` = 46947) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ametrino maligno.' WHERE (`ID` = 47011) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ametrino potenciado.' WHERE (`ID` = 47016) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ametrino resplandeciente.' WHERE (`ID` = 47018) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ametrino velado.' WHERE (`ID` = 46951) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un diamante de llama celeste refulgente.' WHERE (`ID` = 41705) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ojo de Zul brillante.' WHERE (`ID` = 46907) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ojo de Zul deslumbrante.' WHERE (`ID` = 46900) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ojo de Zul hendido.' WHERE (`ID` = 46906) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ojo de Zul irregular.' WHERE (`ID` = 46901) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ojo de Zul intemporal.' WHERE (`ID` = 46902) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ojo de Zul luminiscente.' WHERE (`ID` = 46909) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ojo de Zul opaco.' WHERE (`ID` = 46914) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ojo de Zul tenso.' WHERE (`ID` = 46908) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un topacio monarca completo.' WHERE (`ID` = 41687) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un topacio monarca destellante.' WHERE (`ID` = 41582) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un topacio monarca luminoso.' WHERE (`ID` = 41689) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un topacio monarca velado.' WHERE (`ID` = 41688) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un zafiro celestial luciente.' WHERE (`ID` = 41581) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar una esmeralda del bosque de vidente.' WHERE (`ID` = 41699) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar una esmeralda del bosque duradera.' WHERE (`ID` = 41697) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar una esmeralda del bosque intrincada.' WHERE (`ID` = 41694) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar una esmeralda del bosque luminiscente.' WHERE (`ID` = 41696) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar una piedra de terror de tenuidad.' WHERE (`ID` = 46946) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar una piedra de terror enjundiosa.' WHERE (`ID` = 46944) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar una piedra de terror equilibrada.' WHERE (`ID` = 46934) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar una piedra de terror imbuida.' WHERE (`ID` = 46945) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar una piedra de terror real.' WHERE (`ID` = 46939) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar una piedra de terror regia.' WHERE (`ID` = 46940) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Te enseña a tallar un ametrino destellante.' WHERE (`ID` = 47008) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo o amarillo.' WHERE (`ID` = 41482) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo o amarillo.' WHERE (`ID` = 41491) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo o amarillo.' WHERE (`ID` = 41488) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo o amarillo.' WHERE (`ID` = 41494) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo o amarillo.' WHERE (`ID` = 41502) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo o azul.' WHERE (`ID` = 30575) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo.' WHERE (`ID` = 41444) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo.' WHERE (`ID` = 41447) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo o azul.' WHERE (`ID` = 41456) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo o azul.' WHERE (`ID` = 41458) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo o azul.' WHERE (`ID` = 32224) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo.' WHERE (`ID` = 45882) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo.' WHERE (`ID` = 45987) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo.' WHERE (`ID` = 42148) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo.' WHERE (`ID` = 42156) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo o azul.' WHERE (`ID` = 40140) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo.' WHERE (`ID` = 40000) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo.' WHERE (`ID` = 41436) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color rojo.' WHERE (`ID` = 41439) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Description` = 'Encaja en una ranura de color amarillo o azul.' WHERE (`ID` = 24066) AND `locale` IN ('esES','esMX');
UPDATE `item_template_locale` SET `Name` = 'Boceto: ametrino de precisión', `Description` = 'Te enseña a tallar un ametrino de precisión.' WHERE (`ID` = 47010) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Diseño: Balas destrozadoras', `Description` = 'Te enseña a hacer balas destrozadoras.' WHERE (`ID` = 52022) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Diseño: Flecha de hoja de hielo', `Description` = 'Te enseña a hacer flechas de hoja de hielo.' WHERE (`ID` = 52023) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Técnica: Glifo de Agua eterna', `Description` = 'Te enseña a inscribir un Glifo de Agua eterna.' WHERE (`ID` = 50166) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Técnica: Glifo de descomposición presurosa', `Description` = 'Te enseña a inscribir un Glifo de descomposición presurosa.' WHERE (`ID` = 50168) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Técnica: Glifo de Rejuvenecimiento rápido', `Description` = 'Te enseña a inscribir un Glifo de Rejuvenecimiento rápido.' WHERE (`ID` = 50167) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: ametrino de luz trémula', `Description` = 'Te enseña a tallar un ametrino de luz trémula.' WHERE (`ID` = 47012) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: brillo del otoño rígido', `Description` = 'Te enseña a tallar un brillo del otoño rígido.' WHERE (`ID` = 41580) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: ojo de dragón brillante', `Description` = 'Te enseña a tallar un ojo de dragón brillante.' WHERE (`ID` = 42299) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: ojo de dragón fracturado', `Description` = 'Te enseña a tallar un ojo de dragón fracturado.' WHERE (`ID` = 42303) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: ojo de dragón grueso', `Description` = 'Te enseña a tallar un ojo de dragón grueso.' WHERE (`ID` = 42315) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: ojo de dragón lustroso', `Description` = 'Te enseña a tallar un ojo de dragón lustroso.' WHERE (`ID` = 42304) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: ojo de dragón rúnico', `Description` = 'Te enseña a tallar un ojo de dragón rúnico.' WHERE (`ID` = 42309) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: ojo de Zul vívido', `Description` = 'Te enseña a tallar un ojo de Zul vívido.' WHERE (`ID` = 46899) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: rubí cárdeno fracturado', `Description` = 'Te enseña a tallar un rubí cárdeno fracturado.' WHERE (`ID` = 46921) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: rubí cárdeno rúnico', `Description` = 'Te enseña a tallar un rubí cárdeno rúnico.' WHERE (`ID` = 46916) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: rubí cárdeno sutil', `Description` = 'Te enseña a tallar un rubí cárdeno sutil.' WHERE (`ID` = 46922) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: ópalo crepuscular enjundioso', `Description` = 'Te enseña a tallar un ópalo crepuscular enjundioso.' WHERE (`ID` = 41702) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: ópalo crepuscular real', `Description` = 'Te enseña a tallar un ópalo crepuscular real.' WHERE (`ID` = 41701) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: ópalo crepuscular regio', `Description` = 'Te enseña a tallar un ópalo crepuscular regio.' WHERE (`ID` = 41703) AND `locale` IN ('esMX','esES');
UPDATE `item_template_locale` SET `Name` = 'Boceto: lágrima de pesadilla', `Description` = 'Te enseña a tallar una lágrima de pesadilla.' WHERE (`ID` = 49112) AND `locale` IN ('esMX','esES');
--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

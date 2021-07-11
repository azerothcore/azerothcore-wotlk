-- DB update 2021_06_30_01 -> 2021_06_30_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_30_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_30_01 2021_06_30_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624507362164083800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624507362164083800');

SET @LOCALE:="Criatura (GUID: %u) No se han encontrado waypoints - Se trata de un problema de AzerothCore (flotador único).";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=223;

SET @LOCALE:="La criatura seleccionada se ignora - siempre que se utilice el GUID";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=224;

SET @LOCALE:="Criatura (GUID: %u) no encontrada";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=225;

SET @LOCALE:="Debe seleccionar un waypoint visual.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=226;

SET @LOCALE:="No se han encontrado waypoints visuales";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=227;

SET @LOCALE:="No se ha podido crear un waypoint visual con creatureID: %d";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=228;

SET @LOCALE:="Se han eliminado todos los waypoints visuales";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=229;

SET @LOCALE:="No se ha podido crear un waypoint-criatura con ID: %d";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=230;

SET @LOCALE:="No se ha proporcionado ningún GUID.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=231;

SET @LOCALE:="No se ha proporcionado el número de waypoint.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=232;

SET @LOCALE:="Se requiere un argumento para '%s'.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=233;

SET @LOCALE:="Waypoint %i añadido a GUID: %d";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=234;

SET @LOCALE:="Waypoint %d añadido.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=235;

SET @LOCALE:="Waypoint modificado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=236;

SET @LOCALE:="Waypoint %s modificado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=237;

SET @LOCALE:="La exportación de WP se ha realizado con éxito.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=238;

SET @LOCALE:="No se han encontrado waypoints en la base de datos.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=239;

SET @LOCALE:="Archivo importado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=240;

SET @LOCALE:="Waypoint eliminado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=241;

SET @LOCALE:="Advertencia: No se ha podido eliminar el WP del mundo con ID: %d";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=242;

SET @LOCALE:="Esto ocurre si el waypoint está demasiado lejos de tu char.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=243;

SET @LOCALE:="El WP se elimina de la base de datos, pero no del mundo aquí.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=244;

SET @LOCALE:="Desaparecerán después de un reinicio del servidor.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=245;

SET @LOCALE:="Waypoint %d: Información de la criatura: %s, GUID: %d";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=246;

SET @LOCALE:="Tiempo de espera: %d";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=247;

SET @LOCALE:="Modelo %d: %d";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=248;

SET @LOCALE:="Emote: %d";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=249;

SET @LOCALE:="Hechizo: %d";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=250;

SET @LOCALE:="Texto %d (ID: %i): %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=251;

SET @LOCALE:="AIScript: %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=252;

SET @LOCALE:="Se solicitará un cambio de nombre forzado para el jugador %s en el próximo inicio de sesión.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=253;

SET @LOCALE:="Se solicitará un cambio de nombre forzado para el jugador %s (GUID #%u) en el próximo inicio de sesión.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=254;

SET @LOCALE:="Criatura de la ruta (GUID: %u) no encontrada";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=255;

SET @LOCALE:="No se ha podido encontrar el NPC...";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=256;

SET @LOCALE:="El tipo de movimiento de la criatura se ha establecido en '%s', los waypoints se han eliminado (si los hay).";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=257;

SET @LOCALE:="El tipo de movimiento de la criatura es '%s', los puntos de ruta no se han eliminado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=258;

SET @LOCALE:="Valor incorrecto, usa on o off";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=259;

SET @LOCALE:="Valor guardado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=260;

SET @LOCALE:="Valor guardado, puede que necesites volver a unirte o limpiar la caché de tu cliente.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=261;

SET @LOCALE:="No se ha encontrado el identificador del activador %u.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=262;

SET @LOCALE:="El mapa o las coordenadas del objetivo no son válidos (X: %f Y: %f MapId: %u)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=263;

SET @LOCALE:="Las coordenadas de la zona no son válidas (X: %f Y: %f AreaId: %u)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=264;

SET @LOCALE:="La zona %u (%s) forma parte del mapa instanciable %u (%s)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=265;

SET @LOCALE:="¡No se ha encontrado nada!";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=266;

SET @LOCALE:="No se ha encontrado ningún objeto.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=267;

SET @LOCALE:="¡Criatura no encontrada!";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=268;

SET @LOCALE:="Advertencia: Mob encontrado más de una vez - serás teletransportado a la primera encontrada en la DB.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=269;

SET @LOCALE:="Criatura removida";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=270;

SET @LOCALE:="Criatura movida.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=271;

SET @LOCALE:="¡Criatura (GUID:%u) debe estar en el mismo mapa que el jugador!";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=272;

SET @LOCALE:="Objeto de juego (GUID: %u) no encontrado";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=273;

SET @LOCALE:="El objeto de juego (GUID: %u) tiene referencias en la lista de criaturas %u GO no encontradas, no puede ser eliminado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=274;

SET @LOCALE:="Objeto de juego (GUID: %u) eliminado";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=275;

SET @LOCALE:="Objeto de juego |cffffffff|Hgameobject:%d|h[%s]|h|r (GUID: %u) convertido";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=276;

SET @LOCALE:="Objeto de juego |cffffffff|Hgameobject:%d|h[%s]|h|r (GUID: %u) movido";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=277;

SET @LOCALE:="Debe seleccionar un vendedor";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=278;

SET @LOCALE:="Debe enviar el ID del objeto";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=279;

SET @LOCALE:="El vendedor tiene demasiados artículos (máximo 128)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=280;

SET @LOCALE:="No puedes expulsarte a ti mismo, cierra la sesión en su lugar";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=281;

SET @LOCALE:="Jugador %s expulsado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=282;

SET @LOCALE:="%s ha deshabilitado el chat de %s por %u minutos, efectivo en el próximo ingreso del jugador. Razón: %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=283;

SET @LOCALE:="Aceptando Susurro: %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=284;

SET @LOCALE:="Aceptando Susurro: ON";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=285;

SET @LOCALE:="Aceptando Susurro: OFF";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=286;

SET @LOCALE:="Criatura (GUID: %u) no encontrada";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=287;

SET @LOCALE:="Recuento de tickets: %i mostrar nuevos tickets: %s\n";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=288;

SET @LOCALE:="Nuevo ticket de %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=289;

SET @LOCALE:="Ticket de %s (Última actualización: %s):\n%s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=290;

SET @LOCALE:="Mostrar nuevo ticket: ON";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=291;

SET @LOCALE:="Mostrar nuevo ticket: OFF";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=292;

SET @LOCALE:="El ticket %i no existe";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=293;

SET @LOCALE:="Todos los tickets borrados.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=294;

SET @LOCALE:="Ticket del personaje %s borrado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=295;

SET @LOCALE:="Ticket borrado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=296;

SET @LOCALE:="La distancia de recorrido ha sido cambiada a: %f";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=297;

SET @LOCALE:="Tiempo de desove cambiado a: %i";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=298;

SET @LOCALE:="¡El honor de %s se ha fijado en %u!";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=299;

SET @LOCALE:="Tu chat ha sido desactivado durante %u minutos. Por: %s ,Razón: %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=300;

SET @LOCALE:="%s ha desactivado el chat de %s durante %u minutos. Razón: %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=301;

SET @LOCALE:="El chat del jugador ya está habilitado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=302;

SET @LOCALE:="Tu chat ha sido habilitado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=303;

SET @LOCALE:="Has habilitado el chat de %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=304;

SET @LOCALE:="¡La reputación de la Facción %s (%u) de %s se ha establecido en %5d!";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=305;

SET @LOCALE:="¡Los puntos de arena de %s se han establecido en %u!";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=306;

SET @LOCALE:="¡No se ha encontrado ninguna facción!";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=307;

SET @LOCALE:="¡Facción %i desconocida!";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=308;

SET @LOCALE:="Parámetro inválido %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=309;

SET @LOCALE:="delta debe estar entre 0 y %d (inclusive)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=310;

SET @LOCALE:="%d - |cffffffff|Hfacción:%d|h[%s]|h|r";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=311;

SET @LOCALE:=" [visible]";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=312;

SET @LOCALE:=" [en guerra]";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=313;

SET @LOCALE:=" [paz forzada]";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=314;

SET @LOCALE:=" [oculto]";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=315;

SET @LOCALE:=" [invisible forzado]";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=316;

SET @LOCALE:=" [inactivo]";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=317;

SET @LOCALE:="Odiado";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=318;

SET @LOCALE:="Hostil";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=319;

SET @LOCALE:="Poco amistoso";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=320;

SET @LOCALE:="Neutral";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=321;

SET @LOCALE:="Amistoso";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=322;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_30_02' WHERE sql_rev = '1624507362164083800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

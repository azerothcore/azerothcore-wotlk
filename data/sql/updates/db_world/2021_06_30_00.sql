-- DB update 2021_06_29_01 -> 2021_06_30_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_29_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_29_01 2021_06_30_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624499430461950800'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624499430461950800');

SET @LOCALE:="Debes seleccionar un personaje o una criatura.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=1;

SET @LOCALE:="Debes seleccionar una criatura.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=2;

SET @LOCALE:="[SERVIDOR] %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=3;

SET @LOCALE:="|cffff0000[Mensaje de evento]: %s|r";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=4;

SET @LOCALE:="No hay ayuda para ese comando";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=5;

SET @LOCALE:="No existe tal comando";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=6;

SET @LOCALE:="No existe este subcomando";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=7;

SET @LOCALE:="El comando %s tiene subcomandos: %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=8;

SET @LOCALE:="Comandos disponibles:";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=9;

SET @LOCALE:="Incorrect syntax.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=10;

SET @LOCALE:="Su nivel de cuenta es: %i";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=11;

SET @LOCALE:="Conexiones activas: %u (máx.: %u) Conexiones en cola: %u (máx.: %u)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=12;

SET @LOCALE:="Tiempo de actividad del servidor: %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=13;

SET @LOCALE:="Jugador guardado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=14;

SET @LOCALE:="Todos los jugadores han sido guardados.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=15;

SET @LOCALE:="Hay los siguientes GMs activos en este servidor:";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=16;

SET @LOCALE:="Actualmente no hay GMs conectados en este servidor.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=17;

SET @LOCALE:="No se puede hacer eso mientras se vuela.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=18;

SET @LOCALE:="Diferencia de tiempo de actualización: %u.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=19;

SET @LOCALE:="Tiempo restante hasta el apagado/reinicio: %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=20;

SET @LOCALE:="%s es el comando de vuelo falló.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=21;

SET @LOCALE:="No estás montado, así que no puedes desmontar.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=22;

SET @LOCALE:="No se puede hacer eso mientras se está peleando.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=23;

SET @LOCALE:="Lo has usado recientemente.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=24;

SET @LOCALE:="Contraseña no modificada (error desconocido)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=25;

SET @LOCALE:="La contraseña fue cambiada";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=26;

SET @LOCALE:="La antigua contraseña es incorrecta";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=27;

SET @LOCALE:="Su cuenta está bloqueada.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=28;

SET @LOCALE:="Su cuenta está ahora desbloqueada.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=29;

SET @LOCALE:=", rango";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=30;

SET @LOCALE:=" [conocido]";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=31;

SET @LOCALE:=" [aprender]";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=32;

SET @LOCALE:=" [pasivo]";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=33;

SET @LOCALE:=" [talento]";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=34;

SET @LOCALE:=" [activo]";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=35;

SET @LOCALE:=" [completo]";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=36;

SET @LOCALE:=" (sin conexión)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=37;

SET @LOCALE:="en";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=38;

SET @LOCALE:="fuera de";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=39;

SET @LOCALE:="Usted es: %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=40;

SET @LOCALE:="visible";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=41;

SET @LOCALE:="invisible";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=42;

SET @LOCALE:="hecho";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=43;

SET @LOCALE:="Usted";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=44;

SET @LOCALE:=" <desconocido>";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=45;

SET @LOCALE:="<error>";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=46;

SET @LOCALE:="<carácter no existente>";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=47;

SET @LOCALE:="DESCONOCIDO";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=48;

SET @LOCALE:="Debes ser al menos de nivel %u para entrar.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=49;

SET @LOCALE:="Debes ser al menos de nivel %u y tener el objeto %s para entrar.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=50;

SET @LOCALE:="¡Hola! ¿Preparado para entrenar?";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=51;

SET @LOCALE:="Recuento de elementos no válido (%u) para el elemento %u";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=52;

SET @LOCALE:="El correo no puede tener más pilas de artículos %u";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=53;

SET @LOCALE:="Las nuevas contraseñas no coinciden";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=54;

SET @LOCALE:="Su contraseña no puede tener más de 16 caracteres (límite del cliente), ¡la contraseña no se cambia!";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=55;

SET @LOCALE:="Mensaje actual del día: \r\n%s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=56;

SET @LOCALE:="Uso de la base de datos mundial: %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=57;

SET @LOCALE:="Utilizando la biblioteca de scripts: %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=58;

SET @LOCALE:="Usando la criatura EventAI: %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=59;

SET @LOCALE:="Jugadores en línea: %u (máximo: %u)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=60;

SET @LOCALE:="Ahora se permite una expansión de hasta %u.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=61;

SET @LOCALE:="Uno o más parámetros tienen valores incorrectos";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=62;

SET @LOCALE:="ID de parámetro erróneo: %u, no existe";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=63;

SET @LOCALE:="Parámetro incorrecto realmId: %d";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=64;

SET @LOCALE:="Cuenta %u (%s) con permisos concedidos:";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=65;

SET @LOCALE:="La cuenta %u (%s) tiene los permisos denegados:";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=66;

SET @LOCALE:="La cuenta %u (%s) ha heredado los permisos del nivel de seguridad %u:";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=67;

SET @LOCALE:="Permisos:";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=68;

SET @LOCALE:="Permisos vinculados:";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=69;

SET @LOCALE:="Lista vacía";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=70;

SET @LOCALE:="- %u (%s)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=71;

SET @LOCALE:="No se ha podido conceder el permiso %u (%s) realmId %d. La cuenta %u (%s) ya tiene ese permiso";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=72;

SET @LOCALE:="No se ha podido conceder el permiso %u (%s) realmId %d. La cuenta %u (%s) tiene ese permiso en la lista de denegación";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=73;

SET @LOCALE:="Permiso concedido %u (%s) realmId %d a la cuenta %u (%s)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=74;

SET @LOCALE:="No se ha podido denegar el permiso %u (%s) realmId %d. La cuenta %u (%s) ya tiene ese permiso";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=75;

SET @LOCALE:="No se ha podido denegar el permiso %u (%s) realmId %d. La cuenta %u (%s) tiene ese permiso en la lista de denegación";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=76;

SET @LOCALE:="Permiso denegado %u (%s) realmId %d a la cuenta %u (%s)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=77;

SET @LOCALE:="Permiso revocado %u (%s) realmId %d a la cuenta %u (%s)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=78;

SET @LOCALE:="No se ha podido revocar el permiso %u (%s) realmId %d. La cuenta %u (%s) no tiene ese permiso";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=79;

SET @LOCALE:="Victorias en el campo de batalla en los últimos 7 días\nAlianza: %d\nHorda: %d";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=80;

SET @LOCALE:="El registro de puntuaciones de campos de batalla está desactivado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=81;

SET @LOCALE:="ERROR DESCONOCIDO";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=87;

SET @LOCALE:="Los comandos de autenticación de doble factor no están configurados correctamente.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=88;

SET @LOCALE:="La autenticación de dos factores ya está activada para esta cuenta.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=89;

SET @LOCALE:="Se ha especificado un token de autenticación de dos factores no válido.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=90;

SET @LOCALE:="Para completar la configuración, tendrás que configurar el dispositivo que utilizarás como segundo factor.\nSu clave 2FA: %s\nUna vez que hayas configurado tu dispositivo, confirma ejecutando .account 2fa setup <token> con el token generado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=91;

SET @LOCALE:="La autenticación de dos factores se ha configurado correctamente.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=92;

SET @LOCALE:="La autenticación de dos factores no está activada para esta cuenta.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=93;

SET @LOCALE:="Para eliminar la autenticación de dos factores, especifique un nuevo token de dos factores de su dispositivo de autenticación.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=94;

SET @LOCALE:="La autenticación de dos factores se ha desactivado correctamente.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=95;

SET @LOCALE:="El nombre del gremio '%s' ya está ocupado";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=96;

SET @LOCALE:="Se ha cambiado el nombre del gremio '%s' por '%s'";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=97;

SET @LOCALE:="'%s' ya existe como nombre de personaje, elige otro";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=98;

SET @LOCALE:="Jugador '%s' forzado a cambiar de nombre a '%s'";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=99;

SET @LOCALE:="Notificación global: ";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=100;

SET @LOCALE:="Mapa: %u (%s) Zona: %u (%s) Área: %u (%s) Fase: %u\nX: %f Y: %f Z: %f Orientación: %f\nCuadrícula[%u,%u] Celda[%u,%u] InstanceID: %u\n Zona X: %f Zona Y: %f\nSuelo Z: %f Suelo Z: %f Tiene datos de altura (Mapa: %u VMap: %u MMap: %u)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=101;

SET @LOCALE:="%s ya está siendo teletransportado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=102;

SET @LOCALE:="Puedes convocar a un jugador a tu instancia sólo si está en tu grupo contigo como líder.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=103;

SET @LOCALE:="No puedes ir a la instancia del jugador porque ahora estás en un grupo.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=104;

SET @LOCALE:="Puedes ir a la instancia del jugador sin estar en su grupo sólo si tu modo GM está activado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=105;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_30_00' WHERE sql_rev = '1624499430461950800';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

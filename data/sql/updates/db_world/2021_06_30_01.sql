-- DB update 2021_06_30_00 -> 2021_06_30_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_06_30_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_06_30_00 2021_06_30_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1624500548840160900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1624500548840160900');

SET @LOCALE:="No se puede pasar al jugador %s de instancia a instancia.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=106;

SET @LOCALE:="No se puede convocar al jugador %s de una instancia a otra.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=107;

SET @LOCALE:="Estás invocando a %s%s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=108;

SET @LOCALE:="Estás siendo convocado por %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=109;

SET @LOCALE:="Te estás teletransportando %s%s a %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=110;

SET @LOCALE:="Estás siendo teletransportado por %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=111;

SET @LOCALE:="El jugador (%s) no existe.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=112;

SET @LOCALE:="Aparece en la ubicación de %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=113;

SET @LOCALE:="%s está apareciendo en su ubicación.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=114;

SET @LOCALE:="Valores incorrectos.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=115;

SET @LOCALE:="No se ha seleccionado ningún personaje.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=116;

SET @LOCALE:="%s no está en un grupo.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=117;

SET @LOCALE:="Has cambiado la VIDA de %s a %i/%i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=118;

SET @LOCALE:="%s cambió su VIDA a %i/%i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=119;

SET @LOCALE:="Has cambiado el MANA de %s a %i/%i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=120;

SET @LOCALE:="%s ha cambiado su MANA a %i/%i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=121;

SET @LOCALE:="Has cambiado la energía de %s a %i/%i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=122;

SET @LOCALE:="%s ha cambiado su energía a %i/%i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=123;

SET @LOCALE:="Energía actual: %u";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=124;

SET @LOCALE:="Has cambiado la ira de %s a %i/%i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=125;

SET @LOCALE:="%s cambió su ira a %i/%i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=126;

SET @LOCALE:="Has cambiado el nivel de %s a %i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=127;

SET @LOCALE:="GUID %i, facción es %i, flags: %i, npcflag es %i, bandera DY es %i";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=128;

SET @LOCALE:="Facción incorrecta: %u (no se encuentra en factiontemplate.dbc).";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=129;

SET @LOCALE:="Has cambiado GUID=%i. Facción a %i, flags a %i, npcflag a %i, dyflag a %i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=130;

SET @LOCALE:="Has cambiado el spellflatid=%i, val= %i, mark =%i a %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=131;

SET @LOCALE:="%s ha cambiado su spellflatid=%i, val= %i, mark =%i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=132;

SET @LOCALE:="%s tiene acceso a todos los puntos de taxi ahora (hasta el cierre de la sesión).";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=133;

SET @LOCALE:="%s ya no tiene acceso a todos los puntos de taxi (sólo se puede acceder a los visitados).";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=134;

SET @LOCALE:="%s te ha dado acceso a todos los puntos de taxi (hasta el cierre de la sesión).";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=135;

SET @LOCALE:="%s ha eliminado el acceso a todos los puntos de taxi (sólo los visitados siguen siendo accesibles).";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=136;

SET @LOCALE:="Has puesto todas las velocidades a %2.2f de lo normal de %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=137;

SET @LOCALE:="%s establece todas sus velocidades a %2.2f de lo normal.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=138;

SET @LOCALE:="Has puesto la velocidad a %2.2f de la normal de %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=139;

SET @LOCALE:="%s establece su velocidad a %2.2f de lo normal.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=140;

SET @LOCALE:="Has ajustado la velocidad de nado a %2.2f de la normal de %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=141;

SET @LOCALE:="%s establece tu velocidad de nado a %2.2f de lo normal.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=142;

SET @LOCALE:="Has ajustado la velocidad de carrera hacia atrás a %2.2f de lo normal de %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=143;

SET @LOCALE:="%s establece su velocidad de carrera hacia atrás a %2.2f de lo normal.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=144;

SET @LOCALE:="Has ajustado la velocidad de vuelo a %2.2f de lo normal de %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=145;

SET @LOCALE:="%s establece su velocidad de vuelo a %2.2f de lo normal.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=146;

SET @LOCALE:="Has establecido el tamaño %2.2f de %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=147;

SET @LOCALE:="%s establece su tamaño a %2.2f.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=148;

SET @LOCALE:="No existe tal montura.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=149;

SET @LOCALE:="Le das una montura a %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=150;

SET @LOCALE:="%s te dio una montura.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=151;

SET @LOCALE:="USUARIO1: %i, ADD: %i, DIF: %i\n";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=152;

SET @LOCALE:="Se lleva todo el cobre de los %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=153;

SET @LOCALE:="%s se llevó todo su cobre.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=154;

SET @LOCALE:="Se lleva %i cobre de %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=155;

SET @LOCALE:="%s te quitó %i cobre.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=156;

SET @LOCALE:="Das %i cobre a %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=157;

SET @LOCALE:="%s te dio %i cobre.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=158;

SET @LOCALE:="Se oye el sonido %u.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=159;

SET @LOCALE:="USER2: %i, ADD: %i, RESULTADO: %i\n";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=160;

SET @LOCALE:="Eliminado el bit %i en el campo %i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=161;

SET @LOCALE:="Establece el bit %i en el campo %i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=162;

SET @LOCALE:="La tabla de localización de teletransporte está vacía.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=163;

SET @LOCALE:="Ubicación del teletransporte no encontrada.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=164;

SET @LOCALE:="Requiere un parámetro de búsqueda.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=165;

SET @LOCALE:="No hay lugares de teletransporte que coincidan con su solicitud.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=166;

SET @LOCALE:="Este nombre está reservado, elige otro";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=167;

SET @LOCALE:="Los lugares encontrados son:\n%s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=168;

SET @LOCALE:="Correo enviado a %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=169;

SET @LOCALE:="Intentas escuchar el sonido %u pero no existe.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=170;

SET @LOCALE:="¡No puedes teletransportarte a ti mismo!";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=171;

SET @LOCALE:="comando de la consola del servidor";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=172;

SET @LOCALE:="Has cambiado el poder rúnico de %s a %i/%i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=173;

SET @LOCALE:="%s ha cambiado tu poder rúnico a %i/%i.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=174;

SET @LOCALE:="Nivel de líquido: %f, suelo: %f, tipo: %u, flags %u, estado: %d.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=175;

SET @LOCALE:="Tipo de objeto de juego no inválido, debe ser un edificio destructible.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=176;

SET @LOCALE:="Objeto de juego %s (GUID: %u) dañado %u (salud real: %u).";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=177;

SET @LOCALE:="grid[%u,%u]cell[%u,%u] ID de la instancia: %u\n ZonaX: %f ZonaY: %f\nGroundZ: %f FloorZ: %f Tiene datos de altura (Map: %u VMap: %u MMap: %u)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=178;

SET @LOCALE:="TransMapID: %u TransOffsetX: %f TransOffsetY: %f TransOffsetZ: %f TransOffsetO: %f (ID de transporte: %u %s)";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=186;

SET @LOCALE:="El secreto de autenticación de dos factores proporcionado es demasiado largo.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=188;

SET @LOCALE:="El secreto de autenticación de dos factores proporcionado no es válido.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=189;

SET @LOCALE:="Se ha activado con éxito la autenticación de dos factores para '%s' con el secreto especificado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=190;

SET @LOCALE:="No hay selección.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=200;

SET @LOCALE:="El GUID del objeto es: %s";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=201;

SET @LOCALE:="El nombre era demasiado largo en %i caracteres.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=202;

SET @LOCALE:="Error, el nombre sólo puede contener caracteres A-Z y a-z.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=203;

SET @LOCALE:="El subnombre era demasiado largo en %i caracteres.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=204;

SET @LOCALE:="Todavía no se ha aplicado";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=205;

SET @LOCALE:="Artículo '%i' '%s' añadido a la lista con maxcount '%i' y incrtime '%i' y coste ampliado '%i'";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=206;

SET @LOCALE:="El artículo '%i' no se encuentra en la base de datos.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=207;

SET @LOCALE:="Artículo '%i' '%s' borrado de la lista de vendedores";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=208;

SET @LOCALE:="El artículo '%i' no se encuentra en la lista de vendedores.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=209;

SET @LOCALE:="El artículo '%u' (con coste ampliado %u) ya está en la lista de vendedores.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=210;

SET @LOCALE:="Los hechizos de %s se reinician.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=211;

SET @LOCALE:="Los hechizos de %s se restablecerán en el próximo inicio de sesión.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=212;

SET @LOCALE:="Se restablecen los talentos de %s.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=213;

SET @LOCALE:="Los talentos de %s se restablecerán en el próximo inicio de sesión.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=214;

SET @LOCALE:="Tus hechizos se han restablecido.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=215;

SET @LOCALE:="Tus talentos se han restablecido.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=216;

SET @LOCALE:="Caso desconocido '%s' para el comando .resetall. Escriba el nombre completo del caso correcto.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=217;

SET @LOCALE:="Los hechizos se reiniciarán para todos los jugadores al iniciar la sesión. Se recomienda encarecidamente volver a iniciar sesión.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=218;

SET @LOCALE:="Los talentos se reiniciarán para todos los jugadores al iniciar la sesión. Se recomienda encarecidamente volver a iniciar sesión.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=219;

SET @LOCALE:="Criatura (GUID: %u) No se ha encontrado ningún waypoint.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=220;

SET @LOCALE:="Criatura (GUID: %u) Último waypoint no encontrado.";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=221;

SET @LOCALE:="Criatura (GUID: %u) No se ha encontrado ningún waypoint - se ha utilizado 'wpguid'. Ahora intento encontrarlo por su posición...";
UPDATE `acore_string` SET `locale_esES`=@LOCALE, `locale_esMX`=@LOCALE WHERE `entry`=222;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_06_30_01' WHERE sql_rev = '1624500548840160900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

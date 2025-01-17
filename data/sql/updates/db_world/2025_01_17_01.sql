-- DB update 2025_01_17_00 -> 2025_01_17_01
--
UPDATE `acore_string` SET
`content_default` = "No waypoint information was found for Creature (GUID: {}). Make sure 'wp show on' command was properly executed.",
`locale_deDE` = "Keine Wegpunktinformationen wurden für das Wesen (GUID: {}) gefunden. Stellen Sie sicher, dass der Befehl 'wp show on' korrekt ausgeführt wurde.",
`locale_zhCN` = "未找到生物（GUID: {}）的路径点信息。请确保正确执行了“wp show on”命令。",
`locale_esES` = "No se encontraron información de punto de ruta para la criatura (GUID: {}). Asegúrese de que el comando 'wp show on' se haya ejecutado correctamente.",
`locale_esMX` = "No se encontraron información de punto de ruta para la criatura (GUID: {}). Asegúrese de que el comando 'wp show on' se haya ejecutado correctamente."
WHERE `entry` = 223;

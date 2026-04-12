-- DB update 2026_04_12_04 -> 2026_04_12_05
--
DROP TABLE IF EXISTS `spawn_group_template`;
CREATE TABLE `spawn_group_template` (
  `groupId` int(10) unsigned NOT NULL,
  `groupName` varchar(100) NOT NULL,
  `groupFlags` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`groupId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `spawn_group`;
CREATE TABLE `spawn_group` (
  `groupId` int(10) unsigned NOT NULL,
  `spawnType` tinyint(3) unsigned NOT NULL,
  `spawnId` int(10) unsigned NOT NULL,
  PRIMARY KEY (`groupId`,`spawnType`,`spawnId`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert default spawn groups
DELETE FROM `spawn_group_template` WHERE `groupId` IN (0, 1);
INSERT INTO `spawn_group_template` (`groupId`, `groupName`, `groupFlags`) VALUES
(0, 'Default Group', 0x01),    -- SYSTEM (dynamic respawn by default)
(1, 'Legacy Group', 0x03);     -- SYSTEM | COMPATIBILITY_MODE

-- Register spawn group commands
DELETE FROM `command` WHERE `name` IN ('list respawns', 'npc spawngroup', 'npc despawngroup', 'gobject spawngroup', 'gobject despawngroup', 'reload spawn_group');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('list respawns', 2, 'Syntax: .list respawns\r\nShows all pending creature and gameobject respawns on the current map.'),
('npc spawngroup', 3, 'Syntax: .npc spawngroup #groupId\r\nSpawns all creatures in the given spawn group.'),
('npc despawngroup', 3, 'Syntax: .npc despawngroup #groupId\r\nDespawns all creatures in the given spawn group.'),
('gobject spawngroup', 3, 'Syntax: .gobject spawngroup #groupId\r\nSpawns all gameobjects in the given spawn group.'),
('gobject despawngroup', 3, 'Syntax: .gobject despawngroup #groupId\r\nDespawns all gameobjects in the given spawn group.'),
('reload spawn_group', 3, 'Syntax: .reload spawn_group\r\nReloads the spawn_group_template and spawn_group tables.');

-- Spawn group localized strings
DELETE FROM `acore_string` WHERE `entry` BETWEEN 35411 AND 35424;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(35411, 'Cannot manually spawn system group {} ({}).', '시스템 그룹 {} ({})을(를) 수동으로 생성할 수 없습니다.', 'Impossible de faire apparaître manuellement le groupe système {} ({}).', 'Systemgruppe {} ({}) kann nicht manuell gespawnt werden.', '无法手动生成系统组 {} ({})。', '無法手動生成系統組 {} ({})。', 'No se puede generar manualmente el grupo del sistema {} ({}).', 'No se puede generar manualmente el grupo del sistema {} ({}).', 'Невозможно вручную создать системную группу {} ({}).'),
(35412, 'Spawn group {} ({}) spawned successfully.', '스폰 그룹 {} ({})이(가) 성공적으로 생성되었습니다.', 'Le groupe d''apparition {} ({}) a été créé avec succès.', 'Spawngruppe {} ({}) erfolgreich erstellt.', '刷新组 {} ({}) 已成功生成。', '重生組 {} ({}) 已成功生成。', 'Grupo de aparición {} ({}) generado correctamente.', 'Grupo de aparición {} ({}) generado correctamente.', 'Группа спавна {} ({}) успешно создана.'),
(35413, 'Failed to spawn group {} ({}).', '스폰 그룹 {} ({}) 생성에 실패했습니다.', 'Échec de l''apparition du groupe {} ({}).', 'Spawngruppe {} ({}) konnte nicht erstellt werden.', '生成组 {} ({}) 失败。', '生成組 {} ({}) 失敗。', 'Error al generar el grupo {} ({}).', 'Error al generar el grupo {} ({}).', 'Не удалось создать группу спавна {} ({}).'),
(35414, 'Cannot manually despawn system group {} ({}).', '시스템 그룹 {} ({})을(를) 수동으로 제거할 수 없습니다.', 'Impossible de retirer manuellement le groupe système {} ({}).', 'Systemgruppe {} ({}) kann nicht manuell entfernt werden.', '无法手动移除系统组 {} ({})。', '無法手動移除系統組 {} ({})。', 'No se puede eliminar manualmente el grupo del sistema {} ({}).', 'No se puede eliminar manualmente el grupo del sistema {} ({}).', 'Невозможно вручную удалить системную группу {} ({}).'),
(35415, 'Spawn group {} ({}) despawned successfully.', '스폰 그룹 {} ({})이(가) 성공적으로 제거되었습니다.', 'Le groupe d''apparition {} ({}) a été retiré avec succès.', 'Spawngruppe {} ({}) erfolgreich entfernt.', '刷新组 {} ({}) 已成功移除。', '重生組 {} ({}) 已成功移除。', 'Grupo de aparición {} ({}) eliminado correctamente.', 'Grupo de aparición {} ({}) eliminado correctamente.', 'Группа спавна {} ({}) успешно удалена.'),
(35416, 'Failed to despawn group {} ({}).', '스폰 그룹 {} ({}) 제거에 실패했습니다.', 'Échec du retrait du groupe {} ({}).', 'Spawngruppe {} ({}) konnte nicht entfernt werden.', '移除组 {} ({}) 失败。', '移除組 {} ({}) 失敗。', 'Error al eliminar el grupo {} ({}).', 'Error al eliminar el grupo {} ({}).', 'Не удалось удалить группу спавна {} ({}).'),
(35419, 'Pending creature respawns on map {} (instance {}):', '맵 {} (인스턴스 {})의 대기 중인 생물 리스폰:', 'Réapparitions de créatures en attente sur la carte {} (instance {}) :', 'Ausstehende Kreatur-Respawns auf Karte {} (Instanz {}):', '地图 {} (副本 {}) 上待处理的生物重生:', '地圖 {} (副本 {}) 上待處理的生物重生:', 'Reapariciones de criaturas pendientes en mapa {} (instancia {}):', 'Reapariciones de criaturas pendientes en mapa {} (instancia {}):', 'Ожидающие респауны существ на карте {} (инстанс {}):'),
(35420, '  DB GUID: {} - {} ({}) - {}s', '  DB GUID: {} - {} ({}) - {}초', '  DB GUID : {} - {} ({}) - {}s', '  DB GUID: {} - {} ({}) - {}s', '  DB GUID: {} - {} ({}) - {}秒', '  DB GUID: {} - {} ({}) - {}秒', '  DB GUID: {} - {} ({}) - {}s', '  DB GUID: {} - {} ({}) - {}s', '  DB GUID: {} - {} ({}) - {}с'),
(35421, 'Pending gameobject respawns:', '대기 중인 게임오브젝트 리스폰:', 'Réapparitions de game objects en attente :', 'Ausstehende Spielobjekt-Respawns:', '待处理的游戏对象重生:', '待處理的遊戲物件重生:', 'Reapariciones de objetos pendientes:', 'Reapariciones de objetos pendientes:', 'Ожидающие респауны игровых объектов:'),
(35422, '  DB GUID: {} - {} ({}) - {}s', '  DB GUID: {} - {} ({}) - {}초', '  DB GUID : {} - {} ({}) - {}s', '  DB GUID: {} - {} ({}) - {}s', '  DB GUID: {} - {} ({}) - {}秒', '  DB GUID: {} - {} ({}) - {}秒', '  DB GUID: {} - {} ({}) - {}s', '  DB GUID: {} - {} ({}) - {}s', '  DB GUID: {} - {} ({}) - {}с'),
(35423, '  ... and more (limited to 50)', '  ... 그 외 다수 (50개로 제한)', '  ... et plus (limité à 50)', '  ... und mehr (auf 50 begrenzt)', '  ... 以及更多（限制为50）', '  ... 以及更多（限制為50）', '  ... y más (limitado a 50)', '  ... y más (limitado a 50)', '  ... и ещё (ограничено 50)'),
(35424, 'Spawn group {} not found.', '스폰 그룹 {}을(를) 찾을 수 없습니다.', 'Groupe d''apparition {} introuvable.', 'Spawngruppe {} nicht gefunden.', '刷新组 {} 未找到。', '重生組 {} 未找到。', 'Grupo de aparición {} no encontrado.', 'Grupo de aparición {} no encontrado.', 'Группа спавна {} не найдена.');

-- Register pool debug commands
DELETE FROM `command` WHERE `name` IN ('pool info', 'pool lookup');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('pool info', 2, 'Syntax: .pool info #poolId\r\nShows pool details: description, max active, all creature/gameobject/sub-pool members with active/inactive status.'),
('pool lookup', 2, 'Syntax: .pool lookup\r\nTarget a creature or stand near a gameobject to find which pool it belongs to and its current spawn status.');

-- Pool debug command localized strings
DELETE FROM `acore_string` WHERE `entry` BETWEEN 35425 AND 35434;
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(35425, 'Pool {} does not exist.', '풀 {}이(가) 존재하지 않습니다.', 'Le pool {} n''existe pas.', 'Pool {} existiert nicht.', '池 {} 不存在。', '池 {} 不存在。', 'El pool {} no existe.', 'El pool {} no existe.', 'Пул {} не существует.'),
(35426, '=== Pool {} | {} | max active: {} | spawned: {} ===', '=== 풀 {} | {} | 최대 활성: {} | 생성됨: {} ===', '=== Pool {} | {} | max actifs : {} | apparus : {} ===', '=== Pool {} | {} | max. aktiv: {} | gespawnt: {} ===', '=== 池 {} | {} | 最大活跃: {} | 已生成: {} ===', '=== 池 {} | {} | 最大活躍: {} | 已生成: {} ===', '=== Pool {} | {} | máx activos: {} | generados: {} ===', '=== Pool {} | {} | máx activos: {} | generados: {} ===', '=== Пул {} | {} | макс. активных: {} | создано: {} ==='),
(35427, '  {} ({} total):', '  {} (총 {}):', '  {} ({} au total) :', '  {} ({} insgesamt):', '  {}（共 {}）：', '  {}（共 {}）：', '  {} ({} en total):', '  {} ({} en total):', '  {} (всего {}):'),
(35428, '    [{}] GUID {} | {} (entry {}) | map {} ({}, {}, {})', '    [{}] GUID {} | {} (항목 {}) | 맵 {} ({}, {}, {})', '    [{}] GUID {} | {} (entrée {}) | carte {} ({}, {}, {})', '    [{}] GUID {} | {} (Eintrag {}) | Karte {} ({}, {}, {})', '    [{}] GUID {} | {} (条目 {}) | 地图 {} ({}, {}, {})', '    [{}] GUID {} | {} (條目 {}) | 地圖 {} ({}, {}, {})', '    [{}] GUID {} | {} (entrada {}) | mapa {} ({}, {}, {})', '    [{}] GUID {} | {} (entrada {}) | mapa {} ({}, {}, {})', '    [{}] GUID {} | {} (запись {}) | карта {} ({}, {}, {})'),
(35429, '  Sub-pools ({} total):', '  하위 풀 (총 {}):', '  Sous-pools ({} au total) :', '  Unter-Pools ({} insgesamt):', '  子池（共 {}）：', '  子池（共 {}）：', '  Sub-pools ({} en total):', '  Sub-pools ({} en total):', '  Под-пулы (всего {}):'),
(35430, '    [{}] Pool {} | {}', '    [{}] 풀 {} | {}', '    [{}] Pool {} | {}', '    [{}] Pool {} | {}', '    [{}] 池 {} | {}', '    [{}] 池 {} | {}', '    [{}] Pool {} | {}', '    [{}] Pool {} | {}', '    [{}] Пул {} | {}'),
(35431, '{} (GUID {}) is in pool {}. Status: {}', '{} (GUID {})이(가) 풀 {}에 있습니다. 상태: {}', '{} (GUID {}) est dans le pool {}. Statut : {}', '{} (GUID {}) ist in Pool {}. Status: {}', '{} (GUID {}) 在池 {} 中。状态：{}', '{} (GUID {}) 在池 {} 中。狀態：{}', '{} (GUID {}) está en el pool {}. Estado: {}', '{} (GUID {}) está en el pool {}. Estado: {}', '{} (GUID {}) в пуле {}. Статус: {}'),
(35432, '{} (GUID {}) is not in any pool.', '{} (GUID {})은(는) 어떤 풀에도 속해 있지 않습니다.', '{} (GUID {}) n''est dans aucun pool.', '{} (GUID {}) ist in keinem Pool.', '{} (GUID {}) 不在任何池中。', '{} (GUID {}) 不在任何池中。', '{} (GUID {}) no está en ningún pool.', '{} (GUID {}) no está en ningún pool.', '{} (GUID {}) не в пуле.'),
(35433, '  Use ''.pool info {}'' for full details.', '  전체 세부정보는 ''.pool info {}''를 사용하세요.', '  Utilisez ''.pool info {}'' pour les détails complets.', '  Verwenden Sie ''.pool info {}'' für vollständige Details.', '  使用".pool info {}"查看完整详情。', '  使用「.pool info {}」查看完整詳情。', '  Use ''.pool info {}'' para ver los detalles completos.', '  Use ''.pool info {}'' para ver los detalles completos.', '  Используйте ''.pool info {}'' для полной информации.'),
(35434, 'No creature selected and no nearby gameobject found. Target a creature or stand near a gameobject.', '선택된 생물이 없고 근처 게임오브젝트도 없습니다. 생물을 대상으로 지정하거나 게임오브젝트 근처에 서세요.', 'Aucune créature sélectionnée et aucun objet de jeu à proximité. Ciblez une créature ou approchez-vous d''un objet de jeu.', 'Keine Kreatur ausgewählt und kein Spielobjekt in der Nähe gefunden. Wählen Sie eine Kreatur oder stehen Sie neben einem Spielobjekt.', '未选择生物且附近没有游戏对象。请选择一个生物或站在游戏对象旁边。', '未選擇生物且附近沒有遊戲物件。請選擇一個生物或站在遊戲物件旁邊。', 'No hay criatura seleccionada ni objeto cercano. Seleccione una criatura o acérquese a un objeto.', 'No hay criatura seleccionada ni objeto cercano. Seleccione una criatura o acérquese a un objeto.', 'Существо не выбрано и рядом нет игровых объектов. Выберите существо или встаньте рядом с объектом.');

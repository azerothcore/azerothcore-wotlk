-- DB update 2026_07_04_05 -> 2026_07_04_06
--
-- Issue #18038: add .npc showloot command entry and matching acore_string rows.
DELETE FROM `command` WHERE `name` = 'npc showloot';
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('npc showloot', 2, 'Syntax: .npc showloot\nShows the loot generated on the selected creature''s corpse.');

DELETE FROM `acore_string` WHERE `entry` IN (35456, 35457, 35458, 35459, 35460, 35461);
INSERT INTO `acore_string` (`entry`, `content_default`, `locale_koKR`, `locale_frFR`, `locale_deDE`, `locale_zhCN`, `locale_zhTW`, `locale_esES`, `locale_esMX`, `locale_ruRU`) VALUES
(35456, '{} is not dead, or its corpse contains no loot.', '{}이(가) 죽지 않았거나 시체에 전리품이 없습니다.', '{} n''est pas mort, ou son cadavre ne contient aucun butin.', '{} ist nicht tot, oder sein Leichnam enthält keine Beute.', '{} 未死亡，或其尸体上没有战利品。', '{} 未死亡，或其屍體上沒有戰利品。', '{} no está muerto, o su cadáver no contiene botín.', '{} no está muerto, o su cadáver no contiene botín.', '{} не убит или его труп не содержит добычи.'),
(35457, 'Loot for {} (Entry: {}):', '{} (ID: {})의 전리품:', 'Butin de {} (ID : {}) :', 'Beute von {} (ID: {}):', '{} (ID: {}) 的战利品:', '{} (ID: {}) 的戰利品：', 'Botín de {} (ID: {}):', 'Botín de {} (ID: {}):', 'Добыча с {} (ID: {}):'),
(35458, 'Money: {}g {}s {}c', '돈: {}금 {}은 {}동', 'Argent : {}po {}pa {}pc', 'Geld: {}G {}S {}K', '金币: {}金 {}银 {}铜', '金幣：{}金 {}銀 {}銅', 'Dinero: {}o {}p {}c', 'Dinero: {}o {}p {}c', 'Деньги: {}зол {}сер {}мед'),
(35459, 'Items ({}):', '아이템 ({}):', 'Objets ({}) :', 'Gegenstände ({}):', '物品 ({})：', '物品 ({})：', 'Objetos ({}):', 'Objetos ({}):', 'Предметы ({}):'),
(35460, '    {}x |c{:08x}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r (Entry: {})', '    {}개 |c{:08x}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r (ID: {})', '    {}x |c{:08x}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r (ID : {})', '    {}x |c{:08x}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r (ID: {})', '    {}个 |c{:08x}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r (ID: {})', '    {}個 |c{:08x}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r (ID: {})', '    {}x |c{:08x}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r (ID: {})', '    {}x |c{:08x}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r (ID: {})', '    {}шт. |c{:08x}|Hitem:{}:0:0:0:0:0:0:0:0|h[{}]|h|r (ID: {})'),
(35461, 'Quest items ({}):', '퀘스트 아이템 ({}):', 'Objets de quête ({}) :', 'Questgegenstände ({}):', '任务物品 ({})：', '任務物品 ({})：', 'Objetos de misión ({}):', 'Objetos de misión ({}):', 'Предметы заданий ({}):');

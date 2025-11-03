DROP TABLE IF EXISTS `物品_鉴定系统`;
CREATE TABLE `物品_鉴定系统`  (
  `注释` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `id` int NOT NULL,
  `组` int UNSIGNED NOT NULL DEFAULT 1,
  `等级` int UNSIGNED NOT NULL DEFAULT 0,
  `随机几率` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '公式：当前几率除以一个组的几率之和',
  `物品成长_系统` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '关联mod-item-growth模块的组字段，多个组用逗号隔开',
  `物品强化_系统` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '关联mod-item-enhancement模块的组字段，多个组用逗号隔开',
  `物品属性_模板` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT '' COMMENT '关联mod-item-attributes模块的组字段，多个组用逗号隔开',
  `基础属性最小数量` int NOT NULL DEFAULT 0,
  `基础属性最大数量` int NOT NULL DEFAULT 0,
  `基础最小属性值` int UNSIGNED NOT NULL DEFAULT 0,
  `基础最大属性值` int UNSIGNED NOT NULL DEFAULT 0,
  `基础属性允许重复` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '0可以重复获取；1不可重复获取',
  `物品属性_模板_组` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '关联mod-item-attributes模块的组字段，多个组用逗号隔开，按顺序每个组取一个',
  `追加属性最小数量` int NOT NULL DEFAULT 0,
  `追加属性最大数量` int NOT NULL DEFAULT 0,
  `追加属性最小值` int NOT NULL DEFAULT 0,
  `追加属性最大值` int NOT NULL DEFAULT 0,
  `追加属性允许重复` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '0可以重复获取；1不可重复获取',
  `物品技能_模板_组` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '关联mod-item-skills模块的组字段，多个组用逗号隔开，按顺序每个组取一个',
  `追加技能最小数量` int NOT NULL DEFAULT 0,
  `追加技能最大数量` int NOT NULL DEFAULT 0,
  `追加技能允许重复` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '0可以重复获取；1不可重复获取',
  `鉴定品质显示` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `物品名字前缀` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `物品名字后缀` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `物品名字颜色_多个逗号隔开` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '例如：|cffff00ff,|cffff0080,|cffff0080表示名字由三种颜色组成',
  `物品底部描述` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `需求_模板` int UNSIGNED NOT NULL DEFAULT 0 COMMENT '关联mod-requirement-template模块的id字段',
  `符文系统_符文` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '关联mod-rune-system模块的组字段，多个组用逗号隔开',
  `符文凹槽最小数量` int UNSIGNED NOT NULL DEFAULT 0,
  `符文凹槽最大数量` int UNSIGNED NOT NULL DEFAULT 0,
  `技能模板_套装_组` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '关联mod-item-skills模块技能模板_套装表的组字段，多个组用逗号隔开，随机取一个组',
  `公告模板` int UNSIGNED NULL DEFAULT 0 COMMENT '成功后公告',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'Item System' ROW_FORMAT = DYNAMIC;

-- 示例鉴定模板数据（字段顺序必须和CREATE TABLE一致）
INSERT INTO `物品_鉴定系统` (
  `注释`,
  `id`, `组`, `等级`, `随机几率`,
  `物品成长_系统`, `物品强化_系统`, `物品属性_模板`,
  `基础属性最小数量`, `基础属性最大数量`, `基础最小属性值`, `基础最大属性值`, `基础属性允许重复`,
  `物品属性_模板_组`, `追加属性最小数量`, `追加属性最大数量`, `追加属性最小值`, `追加属性最大值`, `追加属性允许重复`,
  `物品技能_模板_组`, `追加技能最小数量`, `追加技能最大数量`, `追加技能允许重复`,
  `鉴定品质显示`, `物品名字前缀`, `物品名字后缀`, `物品名字颜色_多个逗号隔开`, `物品底部描述`,
  `需求_模板`, `符文系统_符文`, `符文凹槽最小数量`, `符文凹槽最大数量`, `技能模板_套装_组`, `公告模板`
) VALUES
-- 基础鉴定模板（1-20级装备）
('基础鉴定模板 - 适用于1-20级装备',
 1, 1, 20, 100,
 '1', '1', '1',
 1, 2, 5, 15, 0,
 '1,2', 0, 1, 3, 8, 0,
 '1', 0, 1, 0,
 '精良', '强化的', '', '|cff1eff00', '经过鉴定的装备，拥有基础属性加成。',
 0, '1', 0, 1, '1', 1),

-- 中级鉴定模板（21-40级装备）
('中级鉴定模板 - 适用于21-40级装备',
 2, 1, 40, 80,
 '1,2', '1,2', '1,2',
 2, 3, 10, 25, 0,
 '1,2,3', 1, 2, 5, 15, 0,
 '1,2', 0, 1, 0,
 '精良', '强化的', '之力', '|cff0070dd', '经过鉴定的装备，拥有多重属性加成。',
 0, '1,2', 1, 2, '1,2', 2),

-- 高级鉴定模板（41-60级装备）
('高级鉴定模板 - 适用于41-60级装备',
 3, 1, 60, 60,
 '2,3', '2,3', '2,3',
 2, 4, 15, 35, 0,
 '2,3,4', 1, 3, 10, 25, 0,
 '2,3', 1, 2, 0,
 '史诗', '卓越的', '之怒', '|cffa335ee', '经过鉴定的装备，拥有强大的属性和技能加成。',
 0, '2,3', 1, 3, '2,3', 3),

-- 传说鉴定模板（61-80级装备）
('传说鉴定模板 - 适用于61-80级装备',
 4, 1, 80, 40,
 '3,4', '3,4', '3,4',
 3, 5, 20, 50, 0,
 '3,4,5', 2, 4, 15, 35, 0,
 '3,4', 1, 3, 0,
 '传说', '传奇的', '之魂', '|cffff8000', '经过鉴定的传说装备，拥有极其强大的属性、技能和符文加成。',
 0, '3,4,5', 2, 4, '3', 4),

-- 特殊鉴定模板（稀有装备专用）
('特殊鉴定模板 - 稀有装备专用',
 5, 2, 60, 20,
 '4,5', '4,5', '4,5',
 3, 6, 25, 60, 1,
 '4,5,6', 2, 5, 20, 45, 1,
 '4,5', 2, 4, 1,
 '神器', '神圣的', '之光', '|cffe6cc80', '经过特殊鉴定的神器装备，拥有独特的属性组合和强大的技能套装。',
 1, '4,5,6', 2, 5, '3,4', 5);

-- Module RBAC permissions table
-- Maps (module, id) composite key to auto-assigned global_id for core RBAC integration
-- Avoids ID collisions between independently developed modules

CREATE TABLE IF NOT EXISTS `module_rbac_permissions` (
  `module` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL
    COMMENT 'module dir name, eg mod-cfbg',
  `id` int unsigned NOT NULL
    COMMENT 'module-local permission id',
  `global_id` int unsigned NOT NULL AUTO_INCREMENT UNIQUE
    COMMENT 'auto-assigned global permission ID for core RBAC',
  `name` varchar(100) NOT NULL
    COMMENT 'Permission name',
  PRIMARY KEY (`module`,`id`),
  UNIQUE KEY `idx_global_id` (`global_id`)
) ENGINE=InnoDB AUTO_INCREMENT=100000 DEFAULT CHARSET=utf8mb4
  COLLATE=utf8mb4_unicode_ci COMMENT='Module RBAC permissions - composite key avoids ID collisions';

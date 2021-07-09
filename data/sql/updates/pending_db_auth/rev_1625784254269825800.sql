-- INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1625784254269825800');

DROP TABLE IF EXISTS `rbac_permissions`;
CREATE TABLE `rbac_permissions`
(
  `id` INT UNSIGNED NOT NULL DEFAULT 0 COMMENT 'Permission id',
  `name` VARCHAR(100) NOT NULL COMMENT 'Permission name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Permission List';

LOCK TABLES `rbac_permissions` WRITE;
/*!40000 ALTER TABLE `rbac_permissions` DISABLE KEYS */;
DELETE FROM rbac_permissions;
INSERT INTO `rbac_permissions` VALUES
(200, 'Command: rbac'),
(201, 'Command: rbac account'),
(202, 'Command: rbac account list'),
(203, 'Command: rbac account grant'),
(204, 'Command: rbac account deny'),
(205, 'Command: rbac account revoke'),
(206, 'Command: rbac list');
/*!40000 ALTER TABLE `rbac_permissions` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rbac_account_permissions`;
CREATE TABLE `rbac_account_permissions`
(
  `accountId` INT UNSIGNED NOT NULL COMMENT 'Account id',
  `permissionId` INT UNSIGNED NOT NULL COMMENT 'Permission id',
  `granted` TINYINT NOT NULL DEFAULT 1 COMMENT 'Granted = 1, Denied = 0',
  `realmId` INT NOT NULL DEFAULT -1 COMMENT 'Realm Id, -1 means all',
  PRIMARY KEY (`accountId`,`permissionId`,`realmId`),
  KEY `fk__rbac_account_roles__rbac_permissions` (`permissionId`),
  CONSTRAINT `fk__rbac_account_permissions__account` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__rbac_account_roles__rbac_permissions` FOREIGN KEY (`permissionId`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Account-Permission relation';

DROP TABLE IF EXISTS `rbac_default_permissions`;
CREATE TABLE `rbac_default_permissions`
(
  `secId` INT UNSIGNED NOT NULL COMMENT 'Security Level id',
  `permissionId` INT UNSIGNED NOT NULL COMMENT 'permission id',
  `realmId` INT NOT NULL DEFAULT -1 COMMENT 'Realm Id, -1 means all',
  PRIMARY KEY (`secId`,`permissionId`,`realmId`),
  KEY `fk__rbac_default_permissions__rbac_permissions` (`permissionId`),
  CONSTRAINT `fk__rbac_default_permissions__rbac_permissions` FOREIGN KEY (`permissionId`) REFERENCES `rbac_permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Default permission to assign to different account security levels';

LOCK TABLES `rbac_default_permissions` WRITE;
/*!40000 ALTER TABLE `rbac_default_permissions` DISABLE KEYS */;
DELETE FROM `rbac_default_permissions`;
INSERT INTO `rbac_default_permissions` VALUES
(3,192,-1), -- Administrator
(2,193,-1), -- GameMaster
(1,194,-1), -- Moderator
(0,195,-1); -- Player
/*!40000 ALTER TABLE `rbac_default_permissions` ENABLE KEYS */;
UNLOCK TABLES;

DROP TABLE IF EXISTS `rbac_linked_permissions`;
CREATE TABLE `rbac_linked_permissions`
(
  `id` INT UNSIGNED NOT NULL COMMENT 'Permission id',
  `linkedId` INT UNSIGNED NOT NULL COMMENT 'Linked Permission id',
  PRIMARY KEY (`id`,`linkedId`),
  KEY `fk__rbac_linked_permissions__rbac_permissions1` (`id`),
  KEY `fk__rbac_linked_permissions__rbac_permissions2` (`linkedId`),
  CONSTRAINT `fk__rbac_linked_permissions__rbac_permissions1` FOREIGN KEY (`id`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__rbac_linked_permissions__rbac_permissions2` FOREIGN KEY (`linkedId`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Permission - Linked Permission relation';

LOCK TABLES `rbac_linked_permissions` WRITE;
/*!40000 ALTER TABLE `rbac_linked_permissions` DISABLE KEYS */;
INSERT INTO `rbac_linked_permissions` VALUES
(192, 196),
(193, 197),
(194, 198),
(195, 199),
(196, 200),
(196, 201);
/*!40000 ALTER TABLE `rbac_linked_permissions` ENABLE KEYS */;
UNLOCK TABLES;

DROP VIEW IF EXISTS `vw_rbac`;
CREATE SQL SECURITY INVOKER VIEW `vw_rbac` AS
(
    SELECT `t1`.`linkedId` AS `Permission ID`,
           `t1`.`id` AS `Permission Group`,
           IFNULL(`t2`.`secId`, 'linked') AS `Security Level`,
       `t3`.`name` AS `Permission`
    FROM `rbac_linked_permissions` `t1`
    LEFT JOIN `rbac_default_permissions` `t2` ON `t1`.`id` = `t2`.`permissionId`
    LEFT JOIN `rbac_permissions` `t3` ON `t1`.`linkedId` = `t3`.`id`
);

INSERT INTO `version_db_auth` (`sql_rev`) VALUES ('1625784254269825800');

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumpar struktur för tabell acore_auth.rbac_account_permissions
CREATE TABLE IF NOT EXISTS `rbac_account_permissions` (
  `accountId` int unsigned NOT NULL COMMENT 'Account id',
  `permissionId` int unsigned NOT NULL COMMENT 'Permission id',
  `granted` tinyint NOT NULL DEFAULT 1 COMMENT 'Granted = 1, Denied = 0',
  `realmId` int NOT NULL DEFAULT -1 COMMENT 'Realm Id, -1 means all',
  PRIMARY KEY (`accountId`,`permissionId`,`realmId`),
  KEY `fk__rbac_account_roles__rbac_permissions` (`permissionId`),
  CONSTRAINT `fk__rbac_account_permissions__account` FOREIGN KEY (`accountId`) REFERENCES `account` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__rbac_account_roles__rbac_permissions` FOREIGN KEY (`permissionId`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Account-Permission relation';

-- Dumpar data för tabell acore_auth.rbac_account_permissions: ~0 rows (ungefär)
DELETE FROM `rbac_account_permissions`;
/*!40000 ALTER TABLE `rbac_account_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `rbac_account_permissions` ENABLE KEYS */;

-- Dumpar struktur för tabell acore_auth.rbac_default_permissions
CREATE TABLE IF NOT EXISTS `rbac_default_permissions` (
  `secId` int unsigned NOT NULL COMMENT 'Security Level id',
  `permissionId` int unsigned NOT NULL COMMENT 'permission id',
  `realmId` int NOT NULL DEFAULT -1 COMMENT 'Realm Id, -1 means all',
  PRIMARY KEY (`secId`,`permissionId`,`realmId`),
  KEY `fk__rbac_default_permissions__rbac_permissions` (`permissionId`),
  CONSTRAINT `fk__rbac_default_permissions__rbac_permissions` FOREIGN KEY (`permissionId`) REFERENCES `rbac_permissions` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Default permission to assign to different account security levels';

-- Dumpar data för tabell acore_auth.rbac_default_permissions: ~4 rows (ungefär)
DELETE FROM `rbac_default_permissions`;
/*!40000 ALTER TABLE `rbac_default_permissions` DISABLE KEYS */;
INSERT INTO `rbac_default_permissions` (`secId`, `permissionId`, `realmId`) VALUES
(3, 192, -1),
(2, 193, -1),
(1, 194, -1),
(0, 195, -1);
/*!40000 ALTER TABLE `rbac_default_permissions` ENABLE KEYS */;

-- Dumpar struktur för tabell acore_auth.rbac_linked_permissions
CREATE TABLE IF NOT EXISTS `rbac_linked_permissions` (
  `id` int unsigned NOT NULL COMMENT 'Permission id',
  `linkedId` int unsigned NOT NULL COMMENT 'Linked Permission id',
  PRIMARY KEY (`id`,`linkedId`),
  KEY `fk__rbac_linked_permissions__rbac_permissions1` (`id`),
  KEY `fk__rbac_linked_permissions__rbac_permissions2` (`linkedId`),
  CONSTRAINT `fk__rbac_linked_permissions__rbac_permissions1` FOREIGN KEY (`id`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk__rbac_linked_permissions__rbac_permissions2` FOREIGN KEY (`linkedId`) REFERENCES `rbac_permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Permission - Linked Permission relation';

-- Dumpar data för tabell acore_auth.rbac_linked_permissions: ~0 rows (ungefär)
DELETE FROM `rbac_linked_permissions`;
/*!40000 ALTER TABLE `rbac_linked_permissions` DISABLE KEYS */;
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(192, 196),
(193, 197),
(194, 198),
(195, 199),
(196, 200),
(196, 201);
/*!40000 ALTER TABLE `rbac_linked_permissions` ENABLE KEYS */;

-- Dumpar struktur för tabell acore_auth.rbac_permissions
CREATE TABLE IF NOT EXISTS `rbac_permissions` (
  `id` int unsigned NOT NULL DEFAULT '0' COMMENT 'Permission id',
  `name` varchar(100) NOT NULL COMMENT 'Permission name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Permission List';

-- Dumpar data för tabell acore_auth.rbac_permissions: ~7 rows (ungefär)
DELETE FROM `rbac_permissions`;
/*!40000 ALTER TABLE `rbac_permissions` DISABLE KEYS */;
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(200, 'Command: rbac'),
(201, 'Command: rbac account'),
(202, 'Command: rbac account list'),
(203, 'Command: rbac account grant'),
(204, 'Command: rbac account deny'),
(205, 'Command: rbac account revoke'),
(206, 'Command: rbac list');
/*!40000 ALTER TABLE `rbac_permissions` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
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

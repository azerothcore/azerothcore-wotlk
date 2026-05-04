-- mod-nostrum-crossfaction: RBAC permission for .world command
--
-- Grants all players (secId = 0) access to the .world chat command.
-- Permission ID 9000010 is in the NostrumWoW custom range (9000001+).
-- Apply to: acore_auth

USE acore_auth;

INSERT IGNORE INTO `rbac_permissions` (`id`, `name`)
    VALUES (9000010, 'Nostrum: Command world chat');

INSERT IGNORE INTO `rbac_default_permissions` (`secId`, `permissionId`, `realmId`)
    VALUES (0, 9000010, -1);

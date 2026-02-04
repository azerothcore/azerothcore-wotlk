-- RBAC Language strings (uses {} format placeholders for Acore::StringFormat)
DELETE FROM `acore_string` WHERE `entry` BETWEEN 63 AND 79;
INSERT INTO `acore_string` (`entry`, `content_default`) VALUES
(63, 'Wrong parameter id: {}, does not exist'),
(64, 'Wrong parameter realmId: {}'),
(65, 'Account {} ({}) granted permissions:'),
(66, 'Account {} ({}) denied permissions:'),
(67, 'Account {} ({}) inherited permissions by sec level {}:'),
(68, 'Permissions:'),
(69, 'Linked permissions:'),
(70, 'Empty List'),
(71, '- {} ({})'),
(72, 'Could not grant permission {} ({}) realmId {}. Account {} ({}) already has that permission'),
(73, 'Could not grant permission {} ({}) realmId {}. Account {} ({}) has that permission in deny list'),
(74, 'Granted permission {} ({}) realmId {} to account {} ({})'),
(75, 'Could not deny permission {} ({}) realmId {}. Account {} ({}) already has that permission'),
(76, 'Could not deny permission {} ({}) realmId {}. Account {} ({}) has that permission in grant list'),
(77, 'Denied permission {} ({}) realmId {} to account {} ({})'),
(78, 'Revoked permission {} ({}) realmId {} to account {} ({})'),
(79, 'Could not revoke permission {} ({}) realmId {}. Account {} ({}) does not have that permission');

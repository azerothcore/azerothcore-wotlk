delete from rbac_permissions where id = 1003;
insert into rbac_permissions(id, name) values (1003, 'Command azth custom xp rate');

delete from rbac_linked_permissions where linkedId = 1003;
insert into rbac_linked_permissions (id, linkedId) values
(192, 1003),
(193, 1003),
(194, 1003),
(195, 1003);

delete from rbac_permissions where id = 1002;
insert into rbac_permissions(id, name) values (1002, 'Command azth custom maxskill');

delete from rbac_linked_permissions where linkedId = 1002;
insert into rbac_linked_permissions (id, linkedId) values
(192, 1002),
(193, 1002),
(194, 1002),
(195, 1002);

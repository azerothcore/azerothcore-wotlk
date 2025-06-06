-- DB update 2023_05_13_12 -> 2023_05_13_13
DELETE FROM `warden_checks` WHERE `id` IN (795,796);
INSERT INTO `warden_checks` (`id`, `type`, `data`, `str`, `address`, `length`, `result`, `comment`) VALUES
(795, 139, NULL, 'local f=DEFAULT_CHAT_FRAME for i=1,f:GetNumMessages() do if (f:GetMessageInfo(i)):find("Rotation Mode Disable") then return true end end', NULL, NULL, NULL, 'Detects PQR'),
(796, 139, NULL, 'local f=DEFAULT_CHAT_FRAME for i=1,f:GetNumMessages() do if (f:GetMessageInfo(i)):find("Rotation Mode Enable") then return true end end', NULL, NULL, NULL, 'Detects PQR');

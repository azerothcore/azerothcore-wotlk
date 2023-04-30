-- DB update 2023_04_29_06 -> 2023_04_30_00
--

DELETE FROM `warden_checks` WHERE `id` IN (793,794,795,796,797,798,799,800,801,802,803,804,805,806,807,808,809,810,811);
INSERT INTO `warden_checks` (`id`, `type`, `data`, `str`, `address`, `length`, `result`, `comment`) VALUES
(793, 139, NULL, 'local f=DEFAULT_CHAT_FRAME for i=1,f:GetNumMessages() do if (f:GetMessageInfo(i)):find("New addon name is ") then return true end end', NULL, NULL, NULL, 'Detects KickKitty'),
(794, 139, NULL, 'local f=DEFAULT_CHAT_FRAME for i=1,f:GetNumMessages() do if (f:GetMessageInfo(i)):find(". It\'s in new directory not this one") then return true end end', NULL, NULL, NULL, 'Detects KickKitty'),
(795, 217, '', 'BlackMagic.dll', 0, 0, '', 'BlackMagic - injected dll'),
(796, 217, '', 'x0.dll', 0, 0, '', 'x0 gold hack dll'),
(797, 217, '', 'Luim.dll', 0, 0, '', 'Lua Unlocker dll'),
(798, 217, '', 'Gold Hack.dll', 0, 0, '', 'Gold Hack dll'),
(799, 217, '', 'fasmdll_managed.dll', 0, 0, '', 'Rotation Bot'),
(800, 217, '', 'PortBlock.dll', 0, 0, '', 'Multiclient Lagger'),
(801, 217, '', 'PinvokeCollection.dll', 0, 0, '', 'Keysender'),
(802, 217, '', 'FuncCollection.dll', 0, 0, '', 'Multi Hack dll'),
(803, 139, NULL, 'local f=DEFAULT_CHAT_FRAME for i=1,f:GetNumMessages() do if (f:GetMessageInfo(i)):find("Rotation :        %3s") then return true end end', NULL, NULL, NULL, 'Cloud Magic Rotation Bot'),
(804, 217, '', 'nampower.dll', 0, 0, '', 'Multi Hack dll'),
(805, 217, '', 'EWTDll.dll', 0, 0, '', 'Multi Hack dll'),
(806, 217, '', 'iKillFish.dll', 0, 0, '', 'Fish Bot'),
(807, 217, '', 'iwanna.dll', 0, 0, '', 'Fish Bot'),
(808, 217, '', 'oGasai.dll', 0, 0, '', 'Multi Hack dll'),
(809, 217, '', 'tMorph.dll', 0, 0, '', 'tMorph - injected dll'),
(810, 217, '', 'jMorph.dll', 0, 0, '', 'jMorph - injected dll'),
(811, 217, '', 'dmorph.dll', 0, 0, '', 'dmorph - injected dll');

-- DB update 2026_05_14_00 -> 2026_05_17_00
-- Split RBAC_PERM_COMMAND_DEBUG (300) into three permission tiers:
--
--   300 (Command: debug)           -- state-modifying commands (unchanged)
--   920 (Command: debug info)      -- read-only / informational commands
--   921 (Command: debug cosmetic)  -- client-side / cosmetic commands
--
-- Backward compatibility: perm 300 links to both 920 and 921, so any account
-- or role that already held perm 300 automatically receives the new sub-perms
-- via RBAC expansion. No existing setups are affected.
--
-- Informational (920): threat, threatinfo, combat, hostile, getvalue,
--   getitemvalue, getitemstate, lootrecipient, los, loot, visibilitydata,
--   objectcount, mapdata, factionchange, zonestats
--
-- Cosmetic (921): play *, send (all except opcode/setphaseshift), anim,
--   areatriggers, boundary, wpgps
--
-- State-modifying (300, unchanged): setbit, Mod32Value, setaurastate,
--   setitemvalue, setvalue, spawnvehicle, setvid, entervehicle, uws, update,
--   itemexpire, arena, bg, lfg, cooldown, moveflags, unitstate, dummy,
--   send opcode, send setphaseshift

DELETE FROM `rbac_permissions` WHERE `id` IN (920, 921);
INSERT INTO `rbac_permissions` (`id`, `name`) VALUES
(920, 'Command: debug info'),
(921, 'Command: debug cosmetic');

-- Existing holders of perm 300 automatically receive both new sub-perms.
-- Role 197 (GM Commands) already includes perm 300, so it reaches 920 and 921
-- transitively — no direct links to role 197 are needed or added.
DELETE FROM `rbac_linked_permissions` WHERE `id` = 300 AND `linkedId` IN (920, 921);
INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(300, 920),
(300, 921);

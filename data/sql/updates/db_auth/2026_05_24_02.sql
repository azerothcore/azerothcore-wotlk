-- DB update 2026_05_24_01 -> 2026_05_24_02
-- Grant cross-faction social/economy permissions to the default Player role (195).
-- Mirrors the previous Blackrose AllowTwoSide.{Mail,WhoList,AddFriend,Trade} = 1
-- worldserver.conf settings that upstream migrated from server config flags into
-- the RBAC permission system (handlers now read HasPermission(rbac::...) instead
-- of sWorld->getBoolConfig(CONFIG_ALLOW_TWO_SIDE_*)). Cross-faction Group and
-- Chat are still wired through their server config flags.
DELETE FROM `rbac_linked_permissions`
WHERE `id` = 195 AND `linkedId` IN (27, 28, 29, 51);

INSERT INTO `rbac_linked_permissions` (`id`, `linkedId`) VALUES
(195, 27),  -- Two side mail interaction
(195, 28),  -- See two side who list
(195, 29),  -- Add friends of other faction
(195, 51);  -- Allow two side trade

-- DB update 2026_11_21_02 -> 2026_11_21_03
-- Dark Essence and Light Essence are clicked through spellclick, not gossip
UPDATE `creature_template` SET `npcflag` = 16777216, `ScriptName` = '', `VerifiedBuild` = 50664 WHERE `entry` IN (34567, 34568);

DELETE FROM `npc_spellclick_spells` WHERE `npc_entry` IN (34567, 34568);
INSERT INTO `npc_spellclick_spells` (`npc_entry`, `spell_id`, `cast_flags`, `user_type`) VALUES
(34567, 65684, 3, 0),
(34568, 65686, 3, 0);

-- These aura links made each essence grant immunity to the other one; the essence aura script now removes it instead
DELETE FROM `spell_linked_spell` WHERE `spell_trigger` IN (65684, 65686, 67176, 67177, 67178, 67222, 67223, 67224) AND `type` = 2;

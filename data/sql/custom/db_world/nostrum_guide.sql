-- ============================================================
-- mod-nostrum-guide — World DB setup
-- ============================================================
--
-- Custom GUID ranges used by this module:
--   creature  guids : 9000001 – 9000009
--   gameobject guids: 9000001 – 9000009
--
-- Both ranges are intentionally placed well above the AC default
-- auto-increment (~5.3M creature, ~5.7M gameobject) to avoid
-- collisions with base spawns. After this INSERT the respective
-- AUTO_INCREMENT values will advance to 9000009.
--
-- Display IDs:
--   Alliance guide (entry 900001) → CreatureDisplayID 16024 (from creature 16128, Rhonin)
--   Horde guide    (entry 900002) → CreatureDisplayID 4307  (from creature 3057,  Tauren elder)
--
-- To remove all spawns and templates:
--   DELETE FROM gameobject          WHERE guid BETWEEN 9000001 AND 9000009;
--   DELETE FROM creature            WHERE guid BETWEEN 9000001 AND 9000009;
--   DELETE FROM creature_template_model WHERE CreatureID IN (900001, 900002);
--   DELETE FROM creature_template   WHERE entry IN (900001, 900002);
--   DELETE FROM npc_text            WHERE ID = 900001;
-- ============================================================

-- ============================================================
-- 1. NPC text (main gossip greeting box)
-- ============================================================

-- npc_text entries for guide pages.
-- The module writes these dynamically at startup via EnsureNpcText() so they
-- always reflect the current config (phase, rates, channel name, URLs).
-- Entry 900001 is also kept here as a fallback if the module hasn't loaded yet.
-- Entries 900010-900015 are purely module-managed; do not edit manually.

DELETE FROM npc_text WHERE ID BETWEEN 900001 AND 900015;
INSERT INTO npc_text (ID, Probability0, text0_0) VALUES
(900001, 1, 'Welcome to NostrumWoW!$B$BI can help you get started. What would you like to know?'),
(900010, 1, 'NostrumWoW is a progressive WotLK 3.3.5a server with blizzlike gameplay, quality-of-life improvements, optional Hardcore mode, and phased content releases.$B$BWebsite: nostrumwow.com$BDiscord: join from the website'),
(900011, 1, 'Phase and rates info is written at startup from the current config.$B$BThis entry is updated automatically by the module.'),
(900012, 1, 'Hardcore is optional permadeath. One life -- die and your character becomes a permanent ghost.$B$BAvailable on fresh level 1 characters with 0 XP and no prior player interaction.$B$BSelf-Found adds trade, mail, and Auction House restrictions on top of permadeath.$B$BChoose your path below.'),
(900013, 1, 'Hardcore Mode -- IMPORTANT:$B$B- Death is permanent$B- PvE and environmental deaths count$B- Duel deaths do NOT count$B- Trading, mail, and AH are allowed$B- You will join the Deathwalkers guild$B- This cannot be undone$B$BClick Confirm ONLY if you understand.'),
(900014, 1, 'Self-Found Hardcore -- IMPORTANT:$B$B- Death is permanent$B- Trading is disabled$B- Auction House is disabled$B- Player mail is disabled$B- You will join the Deathwalkers guild$B- This cannot be undone$B$BClick Confirm ONLY if you understand.'),
(900015, 1, 'Talk to the entire server! Both factions share one channel.$B$BCommands:$B.chat <msg> -- send a message$B.chat on / .chat off -- toggle$B$BOr join manually: /join world');

-- ============================================================
-- 2. Creature templates
-- ============================================================

DELETE FROM creature_template WHERE entry IN (900001, 900002);

-- Alliance guide: Loremaster Caedric
INSERT INTO creature_template
    (entry, name, subname, minlevel, maxlevel, faction, npcflag, unit_flags, type, flags_extra, ScriptName)
VALUES
    (900001, 'Loremaster Caedric', 'New Player Guide', 1, 1, 35, 1, 2, 7, 2, 'nostrum_guide');

-- Horde guide: Elder Gromak
INSERT INTO creature_template
    (entry, name, subname, minlevel, maxlevel, faction, npcflag, unit_flags, type, flags_extra, ScriptName)
VALUES
    (900002, 'Elder Gromak', 'New Player Guide', 1, 1, 35, 1, 2, 7, 2, 'nostrum_guide');

-- ============================================================
-- 3. Creature models (creature_template_model)
--
-- Alliance: DisplayID 16024 (Rhonin-style, from creature_template_model for entry 16128)
-- Horde:    DisplayID 4307  (Tauren elder-style, from creature_template_model for entry 3057)
-- ============================================================

DELETE FROM creature_template_model WHERE CreatureID IN (900001, 900002);
INSERT INTO creature_template_model (CreatureID, Idx, CreatureDisplayID, DisplayScale, Probability) VALUES
(900001, 0, 16024, 1.0, 1.0),
(900002, 0, 4307,  1.0, 1.0);

-- ============================================================
-- 4. Creature spawns
--
-- Column order:
--   guid, id1, id2, id3, map, zoneId, areaId, spawnMask, phaseMask, equipment_id,
--   position_x, position_y, position_z, orientation,
--   spawntimesecs, wander_distance, currentwaypoint,
--   curhealth, curmana, MovementType,
--   npcflag, unit_flags, dynamicflags,
--   ScriptName, VerifiedBuild, CreateObject, Comment
-- ============================================================

DELETE FROM creature WHERE guid BETWEEN 9000001 AND 9000009;
INSERT INTO creature
    (guid, id1, map, position_x, position_y, position_z, orientation,
     spawnMask, phaseMask, equipment_id, spawntimesecs, wander_distance,
     curhealth, MovementType)
VALUES
-- Alliance: Human — Northshire Abbey (map 0)
(9000001, 900001, 0, -8941.313, -134.2646, 83.7039,  2.6290636, 1, 1, 0, 120, 0, 100, 0),
-- Alliance: Dwarf/Gnome — Coldridge Valley (map 0)
(9000002, 900001, 0, -6230.0347, 334.72903, 383.20734, 2.887422,  1, 1, 0, 120, 0, 100, 0),
-- Alliance: Night Elf — Shadowglen (map 1)
(9000003, 900001, 1,  10329.68,  831.41565, 1326.3103, 3.151634,  1, 1, 0, 120, 0, 100, 0),
-- Alliance: Draenei — Ammen Vale (map 530)
(9000004, 900001, 530, -3968.444, -13928.292, 100.41841, 5.5865216, 1, 1, 0, 120, 0, 100, 0),
-- Horde: Orc/Troll — Valley of Trials (map 1)
(9000005, 900002, 1, -609.5119, -4248.518, 38.956173,  4.170307,  1, 1, 0, 120, 0, 100, 0),
-- Horde: Undead — Deathknell (map 0)
(9000006, 900002, 0, 1660.0216,  1673.9454, 121.02462, 0.28368708,1, 1, 0, 120, 0, 100, 0),
-- Horde: Tauren — Camp Narache (map 1)
(9000007, 900002, 1, -2911.7666, -252.0669, 52.940895, 3.755963,  1, 1, 0, 120, 0, 100, 0),
-- Horde: Blood Elf — Sunstrider Isle (map 530)
(9000008, 900002, 530, 10351.972, -6357.193, 33.478085, 3.8034222, 1, 1, 0, 120, 0, 100, 0),
-- Alliance: Death Knight — Ebon Hold (map 609)
(9000009, 900001, 609, 2341.0974, -5667.3594, 426.0278, 0.2159737, 1, 1, 0, 120, 0, 100, 0);

-- ============================================================
-- 5. Gameobject spawns — permanent visual cue (entry 149410)
--
-- Spawned at the same coordinates as each guide NPC.
-- Default config (NostrumGuide.VisualCue.Enable = 1) expects these to exist.
-- If you set VisualCue.Enable = 0 you must DELETE these rows manually:
--   DELETE FROM gameobject WHERE guid BETWEEN 9000001 AND 9000008;
--
-- Column order:
--   guid, id, map, zoneId, areaId, spawnMask, phaseMask,
--   position_x, position_y, position_z, orientation,
--   rotation0, rotation1, rotation2, rotation3,
--   spawntimesecs, animprogress, state
-- ============================================================

DELETE FROM gameobject WHERE guid BETWEEN 9000001 AND 9000009;
INSERT INTO gameobject
    (guid, id, map, spawnMask, phaseMask,
     position_x, position_y, position_z, orientation,
     rotation0, rotation1, rotation2, rotation3,
     spawntimesecs, animprogress, state)
VALUES
-- Alliance: Human — Northshire Abbey
(9000001, 149410, 0, 1, 1, -8941.313, -134.2646, 83.7039,  2.6290636, 0, 0, 0, 1, -1, 100, 1),
-- Alliance: Dwarf/Gnome — Coldridge Valley
(9000002, 149410, 0, 1, 1, -6230.0347, 334.72903, 383.20734, 2.887422, 0, 0, 0, 1, -1, 100, 1),
-- Alliance: Night Elf — Shadowglen
(9000003, 149410, 1, 1, 1,  10329.68,  831.41565, 1326.3103, 3.151634,  0, 0, 0, 1, -1, 100, 1),
-- Alliance: Draenei — Ammen Vale
(9000004, 149410, 530, 1, 1, -3968.444, -13928.292, 100.41841, 5.5865216, 0, 0, 0, 1, -1, 100, 1),
-- Horde: Orc/Troll — Valley of Trials
(9000005, 149410, 1, 1, 1, -609.5119, -4248.518, 38.956173,  4.170307, 0, 0, 0, 1, -1, 100, 1),
-- Horde: Undead — Deathknell
(9000006, 149410, 0, 1, 1, 1660.0216,  1673.9454, 121.02462, 0.28368708, 0, 0, 0, 1, -1, 100, 1),
-- Horde: Tauren — Camp Narache
(9000007, 149410, 1, 1, 1, -2911.7666, -252.0669, 52.940895, 3.755963, 0, 0, 0, 1, -1, 100, 1),
-- Horde: Blood Elf — Sunstrider Isle
(9000008, 149410, 530, 1, 1, 10351.972, -6357.193, 33.478085, 3.8034222, 0, 0, 0, 1, -1, 100, 1),
-- Alliance: Death Knight — Ebon Hold
(9000009, 149410, 609, 1, 1, 2341.0974, -5667.3594, 426.0278, 0.2159737, 0, 0, 0, 1, -1, 100, 1);

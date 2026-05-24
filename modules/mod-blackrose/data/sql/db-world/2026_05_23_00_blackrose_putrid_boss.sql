-- =============================================================
-- The Black Rose: Putrid Husk encounter
--
-- Adds Faegrim, the Putrid Husk - a level 23 elite (group-scaled)
-- mini-boss that reuses the stock 3.3.5a Rotface model
-- (CreatureDisplayInfo 31005). Spawned in Ashenvale near the
-- Shrine of Aessina, in the level 23-24 Lesser Felguard area:
-- contested ground with both faction flight paths in range
-- (Astranaar for Alliance, Splintertree Post for Horde). Replaces
-- the previous placeholder kill objective on the Black Rose quest
-- (900100 Alliance / 900101 Horde) so completing the chain
-- actually means defeating something thematic.
--
-- The quest is also re-titled "The Black Rose (Elite)" and
-- flagged as group content via QuestInfoID = 41.
--
-- Festering Spawnlings (900201) periodically spawn during the
-- fight. SmartAI handles all combat phases.
-- =============================================================

SET @BR_BOSS         := 900200;
SET @BR_BOSS_ADD     := 900201;
SET @BR_QUEST_ALLI   := 900100;
SET @BR_QUEST_HORDE  := 900101;

SET @ROTFACE_DISPLAY := 31005;
SET @SLIME_DISPLAY   := 2028;

-- Quest-credit kill counter currently sits at the placeholder
-- creature 100 (Gruff Swiftbite). Repoint both quests at our boss,
-- re-tag them as a group/elite quest, and rewrite the quest text
-- to frame it as a Felwood corruption spilling into Ashenvale.
UPDATE `quest_template`
   SET `RequiredNpcOrGo1` = @BR_BOSS,
       `RequiredNpcOrGoCount1` = 1,
       `LogTitle` = 'The Black Rose (Elite)',
       `QuestInfoID` = 41,
       `LogDescription` =
         'Travel to the Fire Scar Shrine in northern Ashenvale. '
         'Slay Faegrim, the Putrid Husk, and return to Norah Rose.',
       `AreaDescription` =
         'Fire Scar Shrine, northern Ashenvale.',
       `QuestCompletionLog` =
         'The bloom is held back another season. Return to Norah Rose.',
       `QuestDescription` =
         '$N. The thorns drink deep tonight, and they whisper of a '
         'wound that bleeds far from here.$B$B'
         'In Ashenvale, where the moonwells once sang clean, a rot '
         'has crept across the border from Felwood. The Burning '
         'Legion''s ruin festers anew at the Fire Scar Shrine, and '
         'from that pit walks Faegrim, the Putrid Husk - once a '
         'man, now a vessel of plague and despair, sent to drown '
         'the whole forest in his bloom.$B$B'
         'If he is allowed to wither even one more grove, Ashenvale '
         'will be Felwood, and there will be no holding him after '
         'that.$B$B'
         'Take those who would stand with you - he is too strong '
         'to face alone. The Rose remembers the names of those who '
         'refuse to let the green die.'
 WHERE `ID` IN (@BR_QUEST_ALLI, @BR_QUEST_HORDE);

-- =============================================================
-- Boss creature template
-- =============================================================
DELETE FROM `creature_template` WHERE `entry` IN (@BR_BOSS, @BR_BOSS_ADD);
DELETE FROM `creature_template_model` WHERE `CreatureID` IN (@BR_BOSS, @BR_BOSS_ADD);

INSERT INTO `creature_template`
    (`entry`, `name`, `subname`, `gossip_menu_id`,
     `minlevel`, `maxlevel`, `exp`, `faction`, `npcflag`,
     `speed_walk`, `speed_run`,
     `rank`, `BaseAttackTime`, `RangeAttackTime`,
     `unit_class`, `unit_flags`, `unit_flags2`, `dynamicflags`,
     `family`, `type`, `type_flags`,
     `lootid`, `HealthModifier`, `ManaModifier`,
     `ArmorModifier`, `DamageModifier`, `RegenHealth`,
     `flags_extra`, `AIName`, `MovementType`, `ScriptName`)
VALUES
    (@BR_BOSS, 'Faegrim, the Putrid Husk', 'Aberration of the Black Rose', 0,
     23, 23, 0, 14, 0,
     1, 1.14286,
     1, 2000, 0,
     1, 0, 2048, 8,
     0, 6, 72,
     @BR_BOSS, 15, 1,
     1.5, 2.5, 1,
     0, 'SmartAI', 0, ''),
    (@BR_BOSS_ADD, 'Festering Spawnling', 'Servitor of the Husk', 0,
     21, 21, 0, 14, 0,
     1, 1.14286,
     0, 1500, 0,
     1, 0, 2048, 0,
     0, 6, 8,
     0, 1, 1,
     1, 1, 1,
     0, 'SmartAI', 0, '');

INSERT INTO `creature_template_model`
    (`CreatureID`, `Idx`, `CreatureDisplayID`, `DisplayScale`, `Probability`)
VALUES
    (@BR_BOSS,     0, @ROTFACE_DISPLAY, 1.05, 1),
    (@BR_BOSS_ADD, 0, @SLIME_DISPLAY,   0.8,  1);

-- =============================================================
-- Boss spawn: Ashenvale, Fire Scar Shrine (zone 331, area 417).
-- Burning Legion ruin in the north of Ashenvale, a thematic seed
-- for the corruption-spilling-from-Felwood quest text. Spawn
-- time long so the boss persists for groups travelling in.
-- =============================================================
DELETE FROM `creature` WHERE `id1` IN (@BR_BOSS, @BR_BOSS_ADD);

INSERT INTO `creature`
    (`guid`, `id1`, `map`, `zoneId`, `areaId`, `spawnMask`, `phaseMask`,
     `equipment_id`, `position_x`, `position_y`, `position_z`,
     `orientation`, `spawntimesecs`, `wander_distance`, `currentwaypoint`,
     `curhealth`, `curmana`, `MovementType`, `npcflag`, `unit_flags`, `dynamicflags`)
VALUES
    (900200, @BR_BOSS, 1, 331, 417, 1, 1,
     0, 2204.9844, 102.90483, 111.54919,
     -1.0471803, 1800, 0, 0,
     0, 0, 0, 0, 0, 0);

-- =============================================================
-- SmartAI: Faegrim, the Putrid Husk (@BR_BOSS)
--
-- Damage tuned for a level-20 group via SMART_ACTION_CUSTOM_CAST
-- (action 218 - spell, castflag, bp0, bp1, bp2). We use stock
-- player spells as templates and override the base points so the
-- visual + cast bar are already in the client and we don't have
-- to ship more Spell.dbc rows for combat tuning.
--
-- In combat:
--   - Putrid Slime Spray  : Shadow Bolt template, ~600 hit on tank every 7-10s
--   - Mutating Infection  : Corruption template, ~140/tick DoT (~840/18s)
--                           on a random non-tank every 11-14s
--   - Festering Spawn     : summons 2 spawnlings every 25-32s
--
-- HP triggers:
--   - 30% HP one-shot: Frenzy (8269) + flavor line
-- =============================================================
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (@BR_BOSS, @BR_BOSS_ADD)
    AND `source_type` = 0;

INSERT INTO `smart_scripts`
    (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`,
     `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`,
     `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`,
     `action_param3`, `action_param4`, `action_param5`, `action_param6`,
     `target_type`, `target_param1`, `target_param2`, `target_param3`,
     `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
    -- 0: aggro yell
    (@BR_BOSS, 0, 0, 0, 4, 0, 100, 0, 0, 0, 0, 0, 0,
     1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
     'Faegrim - on aggro - Talk 0'),

    -- 1: Slime Spray - actual Rotface signature (spell 71215, green cone of
    --    vomit). CUSTOM_CAST overrides bp0 to ~700 damage so the visual is
    --    iconic but the damage is tuned for level 23 group. Every 9-13s.
    (@BR_BOSS, 0, 1, 0, 0, 0, 100, 0, 9000, 13000, 10000, 14000, 0,
     218, 71215, 0, 699, 0, 0, 0,
     2, 0, 0, 0, 0, 0, 0, 0,
     'Faegrim - in combat - CUSTOM_CAST Slime Spray (vomit) on victim'),

    -- 2: Mutating Infection - Corruption template (172), bp0 = 139 -> ~140/tick
    --    on a random non-tank every 11-14s. Stock periodic is 6 ticks/18s.
    (@BR_BOSS, 0, 2, 0, 0, 0, 100, 0, 11000, 14000, 12000, 15000, 0,
     218, 172, 0, 139, 0, 0, 0,
     6, 0, 0, 0, 0, 0, 0, 0,
     'Faegrim - in combat - CUSTOM_CAST Mutating Infection on random non-tank'),

    -- 2b: Vile Gas - actual Rotface room AoE (spell 71218, green cloud puddle)
    --     dropped on a random hostile every 18-24s. CUSTOM_CAST bp0 = 199
    --     -> ~200 nature dmg per tick (3 ticks). Encourages the group to
    --     spread / move out of the cloud.
    (@BR_BOSS, 0, 12, 0, 0, 0, 100, 0, 18000, 24000, 20000, 26000, 0,
     218, 71218, 0, 199, 0, 0, 0,
     5, 0, 0, 0, 0, 0, 0, 0,
     'Faegrim - in combat - CUSTOM_CAST Vile Gas on random hostile'),

    -- 3+4: Festering Spawn - summon 2 Festering Spawnlings every 25-32s
    --      with offsets so they appear flanking the boss.
    (@BR_BOSS, 0, 3, 0, 0, 0, 100, 0, 25000, 32000, 25000, 32000, 0,
     12, @BR_BOSS_ADD, 8, 45000, 0, 0, 0,
     1, 0, 0, 0, 4, 4, 0, 0,
     'Faegrim - in combat - Summon Spawnling (left)'),
    (@BR_BOSS, 0, 4, 0, 0, 0, 100, 0, 25000, 32000, 25000, 32000, 0,
     12, @BR_BOSS_ADD, 8, 45000, 0, 0, 0,
     1, 0, 0, 0, -4, -4, 0, 0,
     'Faegrim - in combat - Summon Spawnling (right)'),

    -- 5+6: at 30% HP one-shot - Frenzy + flavor line
    (@BR_BOSS, 0, 5, 0, 2, 0, 100, 0, 0, 30, 0, 0, 0,
     11, 8269, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
     'Faegrim - at 30% HP - Cast Frenzy'),
    (@BR_BOSS, 0, 6, 0, 2, 0, 100, 0, 0, 30, 0, 0, 0,
     1, 2, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
     'Faegrim - at 30% HP - Talk 2'),

    -- 7+8: 60% HP one-shot - flavor line + initial spawnling burst (3 at once)
    (@BR_BOSS, 0, 7, 0, 2, 0, 100, 0, 30, 60, 0, 0, 0,
     1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
     'Faegrim - at 60% HP - Talk 1'),
    (@BR_BOSS, 0, 8, 0, 2, 0, 100, 0, 30, 60, 0, 0, 0,
     12, @BR_BOSS_ADD, 8, 45000, 0, 0, 0,
     1, 0, 0, 0, 0, 6, 0, 0,
     'Faegrim - at 60% HP - Burst Spawnling A'),
    (@BR_BOSS, 0, 9, 0, 2, 0, 100, 0, 30, 60, 0, 0, 0,
     12, @BR_BOSS_ADD, 8, 45000, 0, 0, 0,
     1, 0, 0, 0, 6, -6, 0, 0,
     'Faegrim - at 60% HP - Burst Spawnling B'),
    (@BR_BOSS, 0, 10, 0, 2, 0, 100, 0, 30, 60, 0, 0, 0,
     12, @BR_BOSS_ADD, 8, 45000, 0, 0, 0,
     1, 0, 0, 0, -6, -6, 0, 0,
     'Faegrim - at 60% HP - Burst Spawnling C'),

    -- 11: on death - yell
    (@BR_BOSS, 0, 11, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0,
     1, 3, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
     'Faegrim - on death - Talk 3'),

    -- ---- Festering Spawnling AI ----
    -- 0: in combat - CUSTOM_CAST Frostbolt (116) bp0 = 79 -> ~80 dmg every 3-5s
    (@BR_BOSS_ADD, 0, 0, 0, 0, 0, 100, 0, 3000, 5000, 3500, 5500, 0,
     218, 116, 0, 79, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0,
     'Spawnling - in combat - CUSTOM_CAST Putrid Bolt on victim'),
    -- 1: on death - small AoE damage burst via passive Plague Cloud aura tick
    (@BR_BOSS_ADD, 0, 1, 0, 6, 0, 100, 0, 0, 0, 0, 0, 0,
     11, 3815, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0,
     'Spawnling - on death - Burst Plague Cloud');

-- =============================================================
-- Boss flavor lines
-- =============================================================
DELETE FROM `creature_text` WHERE `CreatureID` IN (@BR_BOSS, @BR_BOSS_ADD);

INSERT INTO `creature_text`
    (`CreatureID`, `groupId`, `id`, `text`, `type`, `language`,
     `probability`, `emote`, `duration`, `sound`, `BroadcastTextId`, `comment`)
VALUES
    (@BR_BOSS, 0, 0,
     'Bloom... in rot... bloom in me...',
     14, 0, 100, 0, 0, 0, 0, 'Faegrim aggro'),
    (@BR_BOSS, 1, 0,
     'My petals... my children... rise!',
     14, 0, 100, 0, 0, 0, 0, 'Faegrim 60% HP'),
    (@BR_BOSS, 2, 0,
     'The thorns drink deep tonight!',
     14, 0, 100, 0, 0, 0, 0, 'Faegrim 30% HP enrage'),
    (@BR_BOSS, 3, 0,
     'The garden... wilts...',
     14, 0, 100, 0, 0, 0, 0, 'Faegrim death');

-- =============================================================
-- Loot - drop a few Black Petals on kill (currency for vendors).
-- Both faction quests use the same boss kill credit, so Petals
-- drop equally for everyone who tags it.
-- =============================================================
DELETE FROM `creature_loot_template` WHERE `Entry` = @BR_BOSS;
INSERT INTO `creature_loot_template`
    (`Entry`, `Item`, `Reference`, `Chance`, `QuestRequired`,
     `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`)
VALUES
    (@BR_BOSS, 900201, 0, 100, 0, 1, 0, 3, 5, 'Black Petals'),
    (@BR_BOSS, 900200, 0, 100, 0, 1, 0, 1, 2, 'Black Miasma'),
    (@BR_BOSS, 900202, 0,  20, 0, 1, 0, 1, 1, 'Black Thorns (uncommon)');

-- =============================================================
-- creature_template_addon - no passive aura on the boss; the
-- visual flair comes from the active SmartAI casts (Slime Spray,
-- Vile Gas) instead. Keep the row in case we want to add
-- emote/visibility tweaks later.
-- =============================================================
DELETE FROM `creature_template_addon` WHERE `entry` IN (@BR_BOSS, @BR_BOSS_ADD);
INSERT INTO `creature_template_addon`
    (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`,
     `emote`, `visibilityDistanceType`, `auras`)
VALUES
    (@BR_BOSS, 0, 0, 0, 1, 0, 0, ''),
    (@BR_BOSS_ADD, 0, 0, 0, 1, 0, 0, '');

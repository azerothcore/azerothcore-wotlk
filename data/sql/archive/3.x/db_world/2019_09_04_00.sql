-- DB update 2019_09_03_01 -> 2019_09_04_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2019_09_03_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2019_09_03_01 2019_09_04_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1566600036032917597'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1566600036032917597');

-- These quests should reward 30% more reputation for the Sons of Hodir (see patch notes 3.3.0)
-- ("A Spark of Hope" already has the correct value, so no need to update)
UPDATE `quest_template` SET `RewardFactionOverride1` = 2860000 WHERE `ID` = 12915; -- Mending Fences
UPDATE `quest_template` SET `RewardFactionOverride1` =   32500 WHERE `ID` = 12924; -- Forging an Alliance
UPDATE `quest_template` SET `RewardFactionOverride1` =    9700 WHERE `ID` = 12966; -- You Can't Miss Him
UPDATE `quest_template` SET `RewardFactionOverride1` =    9700 WHERE `ID` = 12967; -- Battling the Elements
UPDATE `quest_template` SET `RewardFactionOverride1` =   45500 WHERE `ID` = 13010; -- Krolmir, Hammer of Storms
UPDATE `quest_template` SET `RewardFactionOverride1` =   32500 WHERE `ID` = 13011; -- Jormuttar is Soo Fat...
UPDATE `quest_template` SET `RewardFactionOverride1` =   32500 WHERE `ID` = 12975; -- In Memoriam
UPDATE `quest_template` SET `RewardFactionOverride1` =    9700 WHERE `ID` = 12976; -- A Monument to the Fallen
UPDATE `quest_template` SET `RewardFactionOverride1` =   32500 WHERE `ID` = 12985; -- Forging a Head
UPDATE `quest_template` SET `RewardFactionOverride1` =   19500 WHERE `ID` = 12987; -- Mounting Hodir's Helm
UPDATE `quest_template` SET `RewardFactionOverride1` =   32500 WHERE `ID` = 13001; -- Raising Hodir's Spear
UPDATE `quest_template` SET `RewardFactionOverride1` =   45500 WHERE `ID` = 13420; -- Everfrost
UPDATE `quest_template` SET `RewardFactionOverride1` =   65000 WHERE `ID` = 13108; -- Whatever it Takes!
UPDATE `quest_template` SET `RewardFactionOverride1` =   45500 WHERE `ID` = 12981; -- Hot and Cold            (Daily)
UPDATE `quest_template` SET `RewardFactionOverride1` =   45500 WHERE `ID` = 12977; -- Blowing Hodir's Horn    (Daily)
UPDATE `quest_template` SET `RewardFactionOverride1` =   45500 WHERE `ID` = 13006; -- Polishing the Helm      (Daily)
UPDATE `quest_template` SET `RewardFactionOverride1` =   65000 WHERE `ID` = 13003; -- Thrusting Hodir's Spear (Daily)
UPDATE `quest_template` SET `RewardFactionOverride1` =   45500 WHERE `ID` = 12994; -- Spy Hunter              (Daily)
UPDATE `quest_template` SET `RewardFactionOverride1` =   45500 WHERE `ID` = 13046; -- Feeding Arngrim         (Daily)
UPDATE `quest_template` SET `RewardFactionOverride1` =   65000 WHERE `ID` = 13559; -- Hodir's Tribute         (Repeatable)
UPDATE `quest_template` SET `RewardFactionOverride1` =   45500 WHERE `ID` = 13421; -- Remember Everfrost!     (Repeatable)

-- King Jokkum: Should only be visible in phase 4
UPDATE `creature` SET `phaseMask` = 4 WHERE `guid` = 207220;

-- Seething Revenants: Reduce respawn time from 300 to 10 seconds (quest "Battling the Elements")
UPDATE `creature` SET `spawntimesecs` = 10 WHERE `id` = 30120;

-- Frost Giant Stormherald: Change faction to "Sons of Hodir" (quest "Battling the Elements", they are trying to cool the anvil)
UPDATE `creature_template` SET `faction` = 2107 WHERE `entry` = 30121;

-- Frost Giant Stormherald: Remove this one, as he stands too far away from the anvil
DELETE FROM `creature` WHERE `guid` = 1975992;

-- Horn Fragments: Apply correct phase mask (quest "In Memoriam")
UPDATE `gameobject` SET `phaseMask` = 4 WHERE `id` = 192081;

-- Quest "A Monument to the Fallen" has to be finished before "Blowing Hodir's Horn" becomes available
UPDATE `quest_template_addon` SET `PrevQuestID` = 12976 WHERE `id` = 12977;

-- Hide "Hodir's Helm", "Hodir's Spear" and "Hodir's Horn" until their quests have been finished
DELETE FROM `gameobject_addon` WHERE `guid` IN (270,268853,268854);
INSERT INTO `gameobject_addon` (`guid`, `invisibilityType`, `invisibilityValue`)
VALUES
(270,9,1000),    -- Hodir's Helm
(268853,8,1000), -- Hodir's Spear
(268854,5,1000); -- Hodir's Horn

DELETE FROM `spell_area` WHERE `spell` IN (56773,56772,56774) AND `area` = 4438;
INSERT INTO `spell_area` (`spell`, `area`, `quest_start`, `quest_end`, `aura_spell`, `racemask`, `gender`, `autocast`, `quest_start_status`, `quest_end_status`)
VALUES
(56773,4438,12987,0,0,0,2,1,66,0), -- Mod Invisibility Detection (9), Value: 1000 ("Mounting Hodir's Helm" complete or rewarded)
(56772,4438,13001,0,0,0,2,1,64,0), -- Mod Invisibility Detection (8), Value: 1000 ("Raising Hodir's Spear" rewarded)
(56774,4438,12976,0,0,0,2,1,64,0); -- Mod Invisibility Detection (5), Value: 1000 ("A Monument to the Fallen" rewarded)

-- Hide "Dun Niffelem Spear Chain Bunny (Phase 2)" together with Hodir's Spear (they are used to cast the chains attached to the spear)
DELETE FROM `creature_addon` WHERE `guid` IN (142407,142408,142409,142410);
INSERT INTO `creature_addon` (`guid`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`)
VALUES
(142407,0,0,0,0,0,'54503'),
(142408,0,0,0,0,0,'54503'),
(142409,0,0,0,0,0,'54503'),
(142410,0,0,0,0,0,'54503');

-- Dead Iron Giant: Creature text
DELETE FROM `creature_text` WHERE `CreatureID` IN (29914,30163);
INSERT INTO `creature_text` (`CreatureID`, `GroupID`, `ID`, `Text`, `Type`, `Language`, `Probability`, `Emote`, `Duration`, `Sound`, `BroadcastTextId`, `TextRange`, `comment`)
VALUES
(29914,0,0,'Stormforged dwarves pour out of the broken corpse!',16,0,100,0,0,0,30892,0,'Dead Iron Giant - Summon Stormforged Ambushers - Emote'),
(30163,0,0,'Stormforged dwarves pour out of the broken corpse!',16,0,100,0,0,0,30892,0,'Dead Iron Giant - Summon Stormforged Ambushers - Emote');

-- Dead Iron Giant: Randomly summon 3 Stormforged Ambushers or 2 Fireforged Eyes
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (29914,30163) AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` IN (2991400,2991401,3016300,3016301) AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(29914,0,0,0,8,0,100,0,56227,0,0,0,0,87,2991400,2991401,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Spell Hit - Call Random Action List'),
(29914,0,1,0,37,0,100,1,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On AI Init - Set React State ''Passive'''),

(2991400,9,0,0,0,0,100,0,0,0,0,0,0,11,56230,2,0,0,0,0,7,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Cast ''Create Fireforged Eyes'''),
(2991400,9,1,0,0,0,100,0,0,0,0,0,0,11,56230,2,0,0,0,0,7,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Cast ''Create Fireforged Eyes'''),
(2991400,9,2,0,0,0,100,0,2000,2000,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Force Despawn'),

(2991401,9,0,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Say Line 0'),
(2991401,9,1,0,0,0,100,0,0,0,0,0,0,11,56243,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Cast ''Summon Iron Dwarf'''),
(2991401,9,2,0,0,0,100,0,0,0,0,0,0,11,56243,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Cast ''Summon Iron Dwarf'''),
(2991401,9,3,0,0,0,100,0,0,0,0,0,0,11,56243,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Cast ''Summon Iron Dwarf'''),
(2991401,9,4,0,0,0,100,0,2000,2000,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Force Despawn'),

(30163,0,0,0,8,0,100,0,56227,0,0,0,0,87,3016300,3016301,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Spell Hit - Call Random Action List'),
(30163,0,1,0,37,0,100,1,0,0,0,0,0,8,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On AI Init - Set React State ''Passive'''),

(3016300,9,0,0,0,0,100,0,0,0,0,0,0,11,56230,2,0,0,0,0,7,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Cast ''Create Fireforged Eyes'''),
(3016300,9,1,0,0,0,100,0,0,0,0,0,0,11,56230,2,0,0,0,0,7,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Cast ''Create Fireforged Eyes'''),
(3016300,9,2,0,0,0,100,0,2000,2000,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Force Despawn'),

(3016301,9,0,0,0,0,100,0,0,0,0,0,0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Say Line 0'),
(3016301,9,1,0,0,0,100,0,0,0,0,0,0,11,56243,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Cast ''Summon Iron Dwarf'''),
(3016301,9,2,0,0,0,100,0,0,0,0,0,0,11,56243,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Cast ''Summon Iron Dwarf'''),
(3016301,9,3,0,0,0,100,0,0,0,0,0,0,11,56243,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Cast ''Summon Iron Dwarf'''),
(3016301,9,4,0,0,0,100,0,2000,2000,0,0,0,41,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Dead Iron Giant - On Script - Force Despawn');

-- Stormforged Ambushers: Decrease chance for drop "Stormforged Ambushers" from 100% to 50%
UPDATE `creature_loot_template` SET `Chance` = 50 WHERE `Entry` = 30208 AND `Item` = 42423;

-- Stormforged Ambushers: Despawn after 120 seconds; attack closest player
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30208;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30208 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(30208,0,0,1,54,0,100,0,0,0,0,0,0,41,120000,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Stormforged Ambushers - On Just Summoned - Force Despawn After 120 Seconds'),
(30208,0,1,0,61,0,100,0,0,0,0,0,0,49,0,0,0,0,0,0,21,30,0,0,0,0,0,0,0,'Stormforged Ambushers - Linked - Attack Closest Player (30 Yards)');

-- Hodir's Spear Event Bunny: Used for the small event after the quest "Raising Hodir's Spear" is rewarded
DELETE FROM `creature_template_addon` WHERE `entry` = 32608;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`)
VALUES
(32608,0,0,0,0,0,'61392'); -- Aura "Ice Missile State"

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 32608;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 32608 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 3260800 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(32608,0,0,0,54,0,100,0,0,0,0,0,0,80,3260800,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Hodir''s Spear Event Bunny - On Just Summoned - Call Action List'),
(3260800,9,0,0,0,0,100,0,0,0,0,0,0,60,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Hodir''s Spear Event Bunny - On Script - Set Fly On'),
(3260800,9,1,0,0,0,100,0,2000,2000,0,0,0,69,1,0,0,0,0,0,1,0,0,0,0,0,0,20,0,'Hodir''s Spear Event Bunny - On Script - Move 20 Yards Up');

-- Lorekeeper Randvir: Trigger the small event after the quest "Raising Hodir's Spear" is rewarded
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30252;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30252 AND `source_type` = 0;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 3025200 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(30252,0,0,0,20,0,100,0,13001,0,0,0,0,80,3025200,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lorekeeper Randvir - On Quest ''Raising Hodir''s Spear'' Rewarded - Call Action List'),
(3025200,9,0,0,0,0,100,0,0,0,0,0,0,12,32608,3,3000,0,0,0,8,0,0,0,0,7392.68,-2763.27,771.487,5.31692,'Lorekeeper Randvir - On Script - Summon ''Hodir''s Spear Event Bunny'''),
(3025200,9,1,0,0,0,100,0,0,0,0,0,0,12,32608,3,3000,0,0,0,8,0,0,0,0,7392.68,-2763.27,771.487,6.11802,'Lorekeeper Randvir - On Script - Summon ''Hodir''s Spear Event Bunny'''),
(3025200,9,2,0,0,0,100,0,0,0,0,0,0,12,32608,3,3000,0,0,0,8,0,0,0,0,7392.68,-2763.27,771.487,4.5865,'Lorekeeper Randvir - On Script - Summon ''Hodir''s Spear Event Bunny'''),
(3025200,9,3,0,0,0,100,0,2000,2000,0,0,0,5,1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Lorekeeper Randvir - On Script - Play Emote ''ONESHOT_TALK(DNR)''');

-- Helm Sparkle Bunny: Used for the sparkle effect after the quest "Polishing the Helm" is rewarded
UPDATE `creature_template` SET `InhabitType` = `InhabitType` | 4 WHERE `entry` = 30302;

DELETE FROM `creature_template_addon` WHERE `entry` = 30302;
INSERT INTO `creature_template_addon` (`entry`, `path_id`, `mount`, `bytes1`, `bytes2`, `emote`, `auras`)
VALUES
(30302,0,0,0,0,0,'56494'); -- Aura "Helm Sparkle"

UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = 30302;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 30302 AND `source_type` = 0;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(30302,0,0,0,54,0,100,0,0,0,0,0,0,44,4,0,0,0,0,0,1,0,0,0,0,0,0,0,0,'Helm Sparkle Bunny - On Just Summoned - Set Ingame Phase Mask 4');

-- Hodir's Helm: Trigger sparkle effect after the quest "Polishing the Helm" is rewarded
UPDATE `gameobject_template` SET `AIName` = 'SmartGameObjectAI' WHERE `entry` = 192080;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 192080 AND `source_type` = 1;
DELETE FROM `smart_scripts` WHERE `entryorguid` = 19208000 AND `source_type` = 9;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`)
VALUES
(192080,1,0,0,20,0,100,0,13006,0,0,0,0,80,19208000,2,0,0,0,0,1,0,0,0,0,0,0,0,0,'Hodir''s Helm - On Quest ''Polishing the Helm'' Rewarded - Call Action List'),
(19208000,9,0,0,0,0,100,0,0,0,0,0,0,12,30302,3,10000,0,0,0,8,0,0,0,0,7376.32,-2713.19,853.177,0,'Hodir''s Helm - On Script - Summon ''Helm Sparkle Bunny'''),
(19208000,9,1,0,0,0,100,0,0,0,0,0,0,12,30302,3,10000,0,0,0,8,0,0,0,0,7372.99,-2727.2,857.806,0,'Hodir''s Helm - On Script - Summon ''Helm Sparkle Bunny'''),
(19208000,9,2,0,0,0,100,0,1500,1500,0,0,0,12,30302,3,10000,0,0,0,8,0,0,0,0,7362.5,-2741.22,853.751,0,'Hodir''s Helm - On Script - Summon ''Helm Sparkle Bunny'''),
(19208000,9,3,0,0,0,100,0,1500,1500,0,0,0,12,30302,3,10000,0,0,0,8,0,0,0,0,7389.53,-2731.87,871.723,0,'Hodir''s Helm - On Script - Summon ''Helm Sparkle Bunny'''),
(19208000,9,4,0,0,0,100,0,1500,1500,0,0,0,12,30302,3,10000,0,0,0,8,0,0,0,0,7389.56,-2715.5,867.216,0,'Hodir''s Helm - On Script - Summon ''Helm Sparkle Bunny'''),
(19208000,9,5,0,0,0,100,0,1500,1500,0,0,0,12,30302,3,10000,0,0,0,8,0,0,0,0,7377.39,-2726.03,868.973,0,'Hodir''s Helm - On Script - Summon ''Helm Sparkle Bunny''');

--
-- END UPDATING QUERIES
--
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

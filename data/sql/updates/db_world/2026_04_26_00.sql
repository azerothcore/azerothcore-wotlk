-- DB update 2026_04_25_04 -> 2026_04_26_00
-- Lasagna HC / custom: remove all Spirit Healer spawns from the world.
-- Matches UNIT_NPC_FLAG_SPIRITHEALER (0x4000 = 16384). Does not remove
-- Spirit Guides (battleground graveyard NPCs, 0x8000).

SET @SPIRIT_HEALER_NPCFLAG := 16384;

DROP TEMPORARY TABLE IF EXISTS `tmp_spirit_healer_creature_guid`;
CREATE TEMPORARY TABLE `tmp_spirit_healer_creature_guid` (`guid` INT UNSIGNED NOT NULL PRIMARY KEY);

INSERT IGNORE INTO `tmp_spirit_healer_creature_guid` (`guid`)
SELECT c.`guid`
FROM `creature` c
WHERE (c.`npcflag` & @SPIRIT_HEALER_NPCFLAG) <> 0
   OR EXISTS (
        SELECT 1
        FROM `creature_template` ct
        WHERE ct.`entry` = c.`id1` AND c.`id1` <> 0
          AND (ct.`npcflag` & @SPIRIT_HEALER_NPCFLAG) <> 0
   )
   OR EXISTS (
        SELECT 1
        FROM `creature_template` ct
        WHERE ct.`entry` = c.`id2` AND c.`id2` <> 0
          AND (ct.`npcflag` & @SPIRIT_HEALER_NPCFLAG) <> 0
   )
   OR EXISTS (
        SELECT 1
        FROM `creature_template` ct
        WHERE ct.`entry` = c.`id3` AND c.`id3` <> 0
          AND (ct.`npcflag` & @SPIRIT_HEALER_NPCFLAG) <> 0
   );

DELETE lr
FROM `linked_respawn` lr
INNER JOIN `tmp_spirit_healer_creature_guid` t ON lr.`guid` = t.`guid`;

DELETE lr
FROM `linked_respawn` lr
INNER JOIN `tmp_spirit_healer_creature_guid` t ON lr.`linkedGuid` = t.`guid`;

DELETE pc
FROM `pool_creature` pc
INNER JOIN `tmp_spirit_healer_creature_guid` t ON pc.`guid` = t.`guid`;

DELETE gec
FROM `game_event_creature` gec
INNER JOIN `tmp_spirit_healer_creature_guid` t ON gec.`guid` = t.`guid`;

DELETE cf
FROM `creature_formations` cf
INNER JOIN `tmp_spirit_healer_creature_guid` t ON cf.`memberGUID` = t.`guid`;

DELETE cf
FROM `creature_formations` cf
INNER JOIN `tmp_spirit_healer_creature_guid` t ON cf.`leaderGUID` = t.`guid`;

DELETE ss
FROM `smart_scripts` ss
INNER JOIN `tmp_spirit_healer_creature_guid` t
  ON ss.`source_type` = 0 AND ss.`entryorguid` = -CAST(t.`guid` AS SIGNED);

DELETE ca
FROM `creature_addon` ca
INNER JOIN `tmp_spirit_healer_creature_guid` t ON ca.`guid` = t.`guid`;

DELETE c
FROM `creature` c
INNER JOIN `tmp_spirit_healer_creature_guid` t ON c.`guid` = t.`guid`;

DROP TEMPORARY TABLE IF EXISTS `tmp_spirit_healer_creature_guid`;

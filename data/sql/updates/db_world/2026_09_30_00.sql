-- DB update 2026_09_29_00 -> 2026_09_30_00
--
-- Move summon group to Sara
UPDATE `creature_summon_groups` SET `summonerId` = 33134 WHERE `summonerId` = 33280 AND `summonerType` = 0 AND `groupId` = 0;

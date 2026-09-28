--
-- Move summon group to Sara
UPDATE `creature_summon_groups` SET `summonerId` = 33134 WHERE `summonerId` = 33280 AND `groupId` = 0;

-- DB update 2022_10_07_04 -> 2022_10_07_05
--
-- There are twice as many NPC Grimscale Forager (15670) as NPC Grimscale Seer (15950) and twice as many NPC Grimscale Murloc (15668) as NPC Grimscale Oracle (15669)
UPDATE `creature` SET `id1`=15670, `id2`=15670, `id3`=15950 WHERE `id1` IN (15670, 15950);
UPDATE `creature` SET `id1`=15668, `id2`=15668, `id3`=15669 WHERE `id1` IN (15668, 15669);

-- NPC Mmmrrrggglll (15937)'s spawn timer is just over 2 mins
UPDATE `creature` SET `spawntimesecs`=130 WHERE  `guid`=41792;

-- DB update 2026_09_03_03 -> 2026_09_03_04
-- Ulduar: Remove excess 4th trash pack before Mimiron tram (removed in patch 3.3.0/3.3.2)
DELETE FROM `creature` WHERE `id` IN (34191, 34192, 34193) AND `guid` IN (
    136570, 136571, 136572, 136573, 136574, 136575,
    136578, 136579, 136580, 136581, 136591, 136592
);
DELETE FROM `creature_addon` WHERE `guid` IN (136591, 136592);
DELETE FROM `creature_formations` WHERE `leaderGUID` = 136575 OR `memberGUID` IN (
    136570, 136571, 136572, 136573, 136574, 136575,
    136578, 136579, 136580, 136581, 136591, 136592
);

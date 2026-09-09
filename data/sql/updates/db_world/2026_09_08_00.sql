-- DB update 2026_09_07_07 -> 2026_09_08_00
-- Update groupAI.
UPDATE `creature_formations` SET `groupAI` = 3 WHERE (`leaderGUID` IN (136763, 136764, 136765, 136766));

-- DB update 2026_06_16_00 -> 2026_06_16_01
-- Troll Patrol dailies 12563 and 12587 were missing the spells that gate the
-- "Congratulations!" (12604) follow-up. 12604 requires both On Patrol (51573)
-- and On Patrol Heartbeat Script (53707); the time limit is enforced by 51573's
-- 20-minute duration. 12501 already grants both and works, so match it:
-- 51573 on accept (SourceSpellID), 53707 on turn-in (RewardSpell).

-- On Patrol (51573) on accept of Troll Patrol 12563
UPDATE `quest_template_addon` SET `SourceSpellID` = 51573 WHERE `ID` = 12563;

-- On Patrol Heartbeat Script (53707) on turn-in of Troll Patrol 12563 and 12587
UPDATE `quest_template` SET `RewardSpell` = 53707 WHERE `ID` IN (12563, 12587);

-- Mimiron DB Target is the anchor VX-001 aims the P3Wx2 Laser Barrage at. Without the trigger flag
-- it can be dragged into combat refs it never releases, since NullCreatureAI never evades.
-- Matches Illidan DB Target (23070).
UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = 33576;

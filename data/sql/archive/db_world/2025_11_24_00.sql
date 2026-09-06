-- DB update 2025_11_23_00 -> 2025_11_24_00
--
-- Set GOSSIP flag
UPDATE `creature_template` SET `npcflag` = `npcflag` | 1 WHERE (`entry` IN (34712, 34713, 34714, 34786, 34785));
-- 10568 -- Hello, $N. If you're looking for cooking training, you've come to the right place. I usually get lots of new students when Pilgrim's Bounty rolls around.
UPDATE `creature_template` SET `gossip_menu_id` = 10568 WHERE (`entry` IN (34708, 34712, 34713, 34714, 34786, 34785, 34711));

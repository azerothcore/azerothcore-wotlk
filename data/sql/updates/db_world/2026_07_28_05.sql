-- DB update 2026_07_28_04 -> 2026_07_28_05
--
-- Invisibility and Stealth Detection
UPDATE `creature_template_addon` SET `auras` = '18950' WHERE (`entry` IN (16024, 29355));
-- 3.0 speed
UPDATE `creature_template` SET `speed_run` = 0.42857 WHERE (`entry` = 29355);
-- mech=0x3C8B3E12(DISORIENTED|FEAR|SLEEP|SNARE|STUN|FREEZE|KNOCKOUT|POLYMORPH|BANISH|SHACKLE|HORROR|DAZE|DISCOVERY|IMMUNE_SHIELD|SAPPED)
UPDATE `creature_template` SET `CreatureImmunitiesId` = -393 WHERE (`entry` IN (16024, 29355));

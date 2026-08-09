-- Thorim: Clash of Thunder factions (sniffed). The captured mercenaries (1692) and the
-- Jormungar Behemoth (1693) are mutually hostile, driving the pre-encounter mock fight;
-- the arena Dark Rune Acolyte (2119) is friendly to both sides so it can heal across it.
UPDATE `creature_template` SET `faction` = 1693 WHERE `entry` IN (32882, 33154);
UPDATE `creature_template` SET `faction` = 1692 WHERE `entry` IN (32883, 32885, 32907, 32908, 33150, 33151, 33152, 33153);
UPDATE `creature_template` SET `faction` = 2119 WHERE `entry` IN (32886, 33159);

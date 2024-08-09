-- Bug Report #19575
-- Update required levels for:
-- 3638 (Goblin Engineering - Pledge of Secrecy)
UPDATE `quest_template` SET `MinLevel`=20 WHERE `ID`=3638;
-- 3640 (gnome engineering - pledge of secrecy, alliance)
UPDATE `quest_template` SET `MinLevel`=20 WHERE `ID`=3640;
-- 3642 (gnome engineering - pledge of secrecy, horde)
UPDATE `quest_template` SET `MinLevel`=20 WHERE `ID`=3642;


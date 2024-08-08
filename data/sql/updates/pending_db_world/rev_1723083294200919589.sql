-- Bug Report #19575
-- Update required levels for:
-- 3638 (Goblin Engineering - Pledge of Secrecy)
UPDATE `quest_template_addon` SET `MinLevel`=20 WHERE `ID`=3638;
-- 3640 (Gnome Engineering - Pledge of Secrecy, Alliance)
UPDATE `quest_template_addon` SET `MinLevel`=20 WHERE `ID`=3640;
-- 3642 (Gnome Engineering - Pledge of Secrecy, Horde)
UPDATE `quest_template_addon` SET `MinLevel`=20 WHERE `ID`=3642;


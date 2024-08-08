-- Bug Report #19575
-- Update required levels for:
-- 3638 (Goblin Engineering - Pledge of Secrecy)
update `quest_template` set `minlevel`=20 where `id`=3638;
-- 3640 (gnome engineering - pledge of secrecy, alliance)
update `quest_template` set `minlevel`=20 where `id`=3640;
-- 3642 (gnome engineering - pledge of secrecy, horde)
update `quest_template` set `minlevel`=20 where `id`=3642;


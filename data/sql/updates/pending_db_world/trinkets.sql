--
update `spell_proc_event` set `Cooldown` = '50000' where `entry` = 37655;
update `spell_proc_event` set `Cooldown` = '40000' where `entry` = 37247;
update `spell_proc_event` set `Cooldown` = '50000' where `entry` = 60066;
update `spell_proc_event` set `Cooldown` = '2000' where `entry` = 15600;

update `spell_proc_event` set `procEx` = '262144' where `entry` = 37655;
UPDATE `item_template` SET `spellcooldown_2` = -1 WHERE (`entry` = 28823);

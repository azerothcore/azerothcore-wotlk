-- Eye of Magtheridon - add proc on miss
UPDATE `spell_proc_event` SET `procEx` = `procEx`|4 WHERE `entry`=34749;

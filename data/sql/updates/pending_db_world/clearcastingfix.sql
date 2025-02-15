
UPDATE `spell_proc_event` SET `procFlags`=`procFlags`&~(1024|4096) WHERE `entry`=16864;

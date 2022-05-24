-- (Hunter) Set Lock and Load procPhase to 0, allowing Black Arrow procs
UPDATE `spell_proc_event` SET `procPhase`=0 WHERE `entry` = -56342;

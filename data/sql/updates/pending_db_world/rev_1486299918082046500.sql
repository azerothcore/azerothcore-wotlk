INSERT INTO version_db_world (`sql_rev`) VALUES ('1486299918082046500');
-- DB/Creature: Add flag guard Deathguard Elite
-- creature is a guard (Will ignore feign death and vanish)
UPDATE `creature_template` SET `flags_extra`=32768 WHERE `entry`=7980;
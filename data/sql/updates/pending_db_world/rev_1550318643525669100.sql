INSERT INTO version_db_world (`sql_rev`) VALUES ('1550318643525669100');

-- Scattered Crate drop Lost Supplies should have 100 drop chance
UPDATE `gameobject_loot_template` SET `Chance`='100' WHERE `Entry`=3597 AND `Item`=6172;

-- Creature "Flanis Swiftwing" should be dead.
UPDATE `creature_template_addon` SET `emote`=65 WHERE  `entry`=21727;
UPDATE `creature_template` SET `flags_extra`=2 WHERE  `entry`=21727;
UPDATE `creature_template` SET `unit_flags`=536904450 WHERE  `entry`=21727;
UPDATE `creature_template` SET `dynamicflags`=32 WHERE  `entry`=21727;

-- Duplicate creature Commander Jordan
DELETE FROM `creature` WHERE `guid`=105029;
DELETE FROM `creature_addon` WHERE `guid`=105029;

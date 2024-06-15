-- DB update 2024_01_02_00 -> 2024_01_03_00
# Lord Cobrahn
DELETE FROM `smart_scripts` WHERE `entryorguid`=3669 AND `source_type`=0 AND `id`=6 AND `link`=7;
UPDATE `smart_scripts` SET `id`=6 WHERE `entryorguid`=3669 AND `source_type`=0 AND `id`=7 AND `link`=0;
UPDATE `smart_scripts` SET `id`=7 WHERE `entryorguid`=3669 AND `source_type`=0 AND `id`=8 AND `link`=0;

# Druid of the Fang
DELETE FROM `smart_scripts` WHERE `entryorguid`=3840 AND `source_type`=0 AND `id`=4 AND `link`=0;
UPDATE `smart_scripts` SET `link`=0 WHERE `entryorguid`=3840 AND `source_type`=0 AND `id`=3 AND `link`=4;
UPDATE `smart_scripts` SET `id`=4, `link`=5 WHERE `entryorguid`=3840 AND `source_type`=0 AND `id`=5 AND `link`=6;
UPDATE `smart_scripts` SET `id`=5 WHERE `entryorguid`=3840 AND `source_type`=0 AND `id`=6 AND `link`=0;
UPDATE `smart_scripts` SET `id`=6 WHERE `entryorguid`=3840 AND `source_type`=0 AND `id`=7 AND `link`=0;

# Phantom Guest
DELETE FROM `smart_scripts` WHERE `entryorguid`=16409 AND `source_type`=0 AND `id`=6 AND `link`=0;
UPDATE `smart_scripts` SET `id`=6 WHERE `entryorguid`=16409 AND `source_type`=0 AND `id`=7 AND `link`=0;
UPDATE `smart_scripts` SET `id`=7 WHERE `entryorguid`=16409 AND `source_type`=0 AND `id`=8 AND `link`=0;
UPDATE `smart_scripts` SET `id`=8 WHERE `entryorguid`=16409 AND `source_type`=0 AND `id`=9 AND `link`=0;
UPDATE `smart_scripts` SET `id`=9 WHERE `entryorguid`=16409 AND `source_type`=0 AND `id`=10 AND `link`=0;
UPDATE `smart_scripts` SET `id`=10 WHERE `entryorguid`=16409 AND `source_type`=0 AND `id`=11 AND `link`=0;
UPDATE `smart_scripts` SET `id`=11 WHERE `entryorguid`=16409 AND `source_type`=0 AND `id`=12 AND `link`=0;
UPDATE `smart_scripts` SET `id`=12 WHERE `entryorguid`=16409 AND `source_type`=0 AND `id`=13 AND `link`=0;
UPDATE `smart_scripts` SET `id`=13 WHERE `entryorguid`=16409 AND `source_type`=0 AND `id`=14 AND `link`=0;
UPDATE `smart_scripts` SET `id`=14 WHERE `entryorguid`=16409 AND `source_type`=0 AND `id`=15 AND `link`=0;
UPDATE `smart_scripts` SET `id`=15 WHERE `entryorguid`=16409 AND `source_type`=0 AND `id`=20 AND `link`=0;
UPDATE `smart_scripts` SET `id`=16 WHERE `entryorguid`=16409 AND `source_type`=0 AND `id`=21 AND `link`=0;
UPDATE `smart_scripts` SET `id`=17 WHERE `entryorguid`=16409 AND `source_type`=0 AND `id`=22 AND `link`=0;

# Maiev Shadowsong
DELETE FROM `smart_scripts` WHERE `entryorguid`=23197 AND `source_type`=0 AND `id`=7 AND `link`=0;
DELETE FROM `smart_scripts` WHERE `entryorguid`=23197 AND `source_type`=0 AND `id`=8 AND `link`=0;
UPDATE `smart_scripts` SET `id`=7 WHERE `entryorguid`=23197 AND `source_type`=0 AND `id`=9 AND `link`=0;
UPDATE `smart_scripts` SET `id`=8 WHERE `entryorguid`=23197 AND `source_type`=0 AND `id`=10 AND `link`=0;

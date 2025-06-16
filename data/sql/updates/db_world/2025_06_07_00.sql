-- DB update 2025_06_06_01 -> 2025_06_07_00
--
UPDATE `command` SET `help`='Syntax: .wchange #weathertype #grade
Set current weather to #weathertype with an intensity of #grade.

#weathertype can be 0 for fine, 1 for rain, 2 for snow, 3 for storm, 86 for thunders, 90 for blackrain.
#grade is a float value from 0.0 (disabled) to 1.0 (maximum intensity).'
WHERE `name`='wchange';

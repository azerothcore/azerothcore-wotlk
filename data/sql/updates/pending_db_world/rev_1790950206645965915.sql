-- The gargoyle script controls flying during arrival and departure.
UPDATE `creature_template` SET `flags_extra` = `flags_extra` | 0x200 WHERE `entry` = 27829;

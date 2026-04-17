--
UPDATE `creature_template` SET `flags_extra` = `flags_extra` & ~0x1
    WHERE `entry` IN (30449, 30451, 30452, 31520, 31534, 31535);

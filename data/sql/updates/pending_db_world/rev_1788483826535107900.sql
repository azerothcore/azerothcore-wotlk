-- Thunder Orb never enters combat; its charged zap and player AoE must not leave combat refs behind
UPDATE `creature_template` SET `flags_extra` = `flags_extra`|8192 WHERE `entry` = 33378;

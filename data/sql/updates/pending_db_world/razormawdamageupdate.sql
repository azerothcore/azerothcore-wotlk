-- damage modifier edit of Razormaw from 7.5 to 2.5

UPDATE `creature_template` SET `DamageModifier` = 2.5 WHERE `entry` = 17592 AND `modelid1` = 17256;

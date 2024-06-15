-- DB update 2023_04_04_08 -> 2023_04_04_09
-- damage modifier edit of Razormaw from 7.5 to 1.36 based on mangos values
UPDATE `creature_template` SET `DamageModifier` = 1.36 WHERE `entry` = 17592;

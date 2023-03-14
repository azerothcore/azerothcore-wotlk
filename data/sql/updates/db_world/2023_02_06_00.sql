-- DB update 2023_02_05_01 -> 2023_02_06_00
-- Use properly sniffed IMMUNE_TO_PC instead of NON_ATTACKABLE, Cannot Turn
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|256&~2, `unit_flags2`=`unit_flags2`|32768 WHERE (`entry` = 17838);
-- Dark Portal Black Crystal Invisible Stalker (18553)
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE (`entry` = 18553);
-- Dark Portal Beam Invisible Stalker (18555) - Scale down from 1.35 to 1
DELETE FROM `creature_template_movement` WHERE (`CreatureId` = 18555);
INSERT INTO `creature_template_movement` (`CreatureId`, `Ground`, `Swim`, `Flight`, `Rooted`, `Chase`, `Random`, `InteractionPauseTimer`) VALUES
(18555, 0, 0, 1, 0, 0, 0, 0);
UPDATE `creature_template` SET `scale`=1, `unit_flags`=`unit_flags`|33554432 WHERE (`entry` = 18555);
-- Dark Portal Dummy (18625)
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|33554432 WHERE (`entry` = 18625);
-- Dark Portal Dummy 1.30 (21862)
UPDATE `creature_template` SET `unit_flags`=`unit_flags`|256|33554432 WHERE (`entry` = 21862);
UPDATE `creature_template_addon` SET `auras` = '32570' WHERE (`entry` = 21862);

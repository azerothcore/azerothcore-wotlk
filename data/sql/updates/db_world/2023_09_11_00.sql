-- DB update 2023_09_10_01 -> 2023_09_11_00
UPDATE `creature_template_spell` SET `VerifiedBuild` = 0 WHERE `CreatureID` IN (17211, 17469, 21160, 21664, 21682, 21683, 21684, 21726, 21747, 21748, 21750, 21752);

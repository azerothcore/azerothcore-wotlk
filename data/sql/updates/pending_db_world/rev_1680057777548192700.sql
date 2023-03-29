--
UPDATE `creature_template` SET `flags_extra`=512 WHERE `entry` IN (36725,38058);
UPDATE `creature_template_addon` SET `bytes1`=0 WHERE `entry` IN (36725,38058);
UPDATE `creature_template_movement` SET `Flight`=0, `Ground`=1 WHERE `CreatureId` IN (36725,38058);

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633797104916104200');

UPDATE `quest_template_addon` SET `RequiredMinRepFaction`=890 WHERE `id` IN (7863,7864,7865);
UPDATE `quest_template_addon` SET `RequiredMinRepFaction`=889 WHERE `id` IN (7866,7867,7868);
UPDATE `quest_template_addon` SET `RequiredMinRepFaction`=509 WHERE `id` IN (8260,8261,8262);
UPDATE `quest_template_addon` SET `RequiredMinRepFaction`=510 WHERE `id` IN (8263,8264,8265);

UPDATE `quest_template_addon` SET `RequiredMinRepValue`=3000 WHERE `id` IN (7863,7866,8260,8263);
UPDATE `quest_template_addon` SET `RequiredMinRepValue`=9000 WHERE `id` IN (7864,7867,8261,8264);
UPDATE `quest_template_addon` SET `RequiredMinRepValue`=21000 WHERE `id` IN (7865,7868,8262,8265);

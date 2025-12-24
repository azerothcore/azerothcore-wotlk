--
SET @ENTRY := 24705;

UPDATE `creature_template` SET `flags_extra` = 128 WHERE `entry` = @ENTRY;

UPDATE `creature_template_model` SET `CreatureDisplayID` = 17612 WHERE `CreatureID` = @ENTRY AND `CreatureDisplayID` = 11686;

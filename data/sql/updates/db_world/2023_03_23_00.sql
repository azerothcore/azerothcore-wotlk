-- DB update 2023_03_22_03 -> 2023_03_23_00
--
UPDATE `creature_text` SET `Emote` = 33 WHERE `CreatureID` = 19220 AND `GroupID` = 6;
UPDATE `smart_scripts` SET `action_param1` = 1 WHERE `id`=1003 AND `action_type` = 223 AND `entryorguid` IN (-138820, -138869, -138893, -138879);
UPDATE `creature_template_addon` SET `emote` = 0 WHERE (`entry` = 19220);

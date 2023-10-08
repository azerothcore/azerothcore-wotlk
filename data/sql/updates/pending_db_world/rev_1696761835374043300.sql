-- Venomhide Hatchling feed items
DELETE FROM `spell_script_names` WHERE `spell_id` IN (65200,65258,65265,68359,68358,68360);
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(65200, 'spell_item_venomhide_feed'),
(65258, 'spell_item_venomhide_feed'),
(65265, 'spell_item_venomhide_feed'),
(68359, 'spell_item_venomhide_feed'),
(68358, 'spell_item_venomhide_feed'),
(68360, 'spell_item_venomhide_feed');

DELETE FROM `conditions` WHERE `SourceTypeOrReferenceId` = 13 AND `SourceGroup` = 1 AND `SourceEntry` IN (65200,65258,65265);

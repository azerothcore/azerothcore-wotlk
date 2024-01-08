--
DELETE FROM `conditions` WHERE (`SourceTypeOrReferenceId` = 17) AND (`SourceGroup` = 0) AND (`SourceEntry` = 41621) AND (`SourceId` = 0) AND (`ElseGroup` = 0) AND (`ConditionTypeOrReference` = 31) AND (`ConditionTarget` = 1) AND (`ConditionValue1` = 3) AND (`ConditionValue2` = 23487) AND (`ConditionValue3` = 0);
INSERT INTO `conditions` (`SourceTypeOrReferenceId`, `SourceGroup`, `SourceEntry`, `SourceId`, `ElseGroup`, `ConditionTypeOrReference`, `ConditionTarget`, `ConditionValue1`, `ConditionValue2`, `ConditionValue3`, `NegativeCondition`, `ErrorType`, `ErrorTextId`, `ScriptName`, `Comment`) VALUES
(17, 0, 41621, 0, 0, 31, 1, 3, 23487, 0, 0, 0, 0, '', 'Throw a net at a wild wolpertinger, which will allow you to capture it and place it in your pack.');

-- both missions are for the horde and alliance factions
UPDATE `spell_script_names` SET `ScriptName`='spell_catch_the_wild_wolpertinger' WHERE  `spell_id`=41621 AND `ScriptName`='spell_q11117_catch_the_wild_wolpertinger';

-- doesn't match the spell
DELETE FROM `spell_linked_spell` WHERE  `spell_trigger`=41621 AND `spell_effect`=63726 AND `type`=2;
DELETE FROM `spell_linked_spell` WHERE  `spell_trigger`=41621 AND `spell_effect`=52656 AND `type`=2;

UPDATE `creature_template` SET `AIName` = '', `ScriptName` = 'npc_wild_wolpertinger' WHERE (`entry` = 23487);

DELETE FROM `smart_scripts` WHERE (`entryorguid` = 23487) AND (`source_type` = 0);

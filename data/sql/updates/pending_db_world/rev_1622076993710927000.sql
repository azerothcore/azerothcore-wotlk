INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1622076993710927000');

SET @CAT_FIGURINE:=13873;
SET @SPELL_SUMMON_GHOST_SABER:=5968;

UPDATE `gameobject_template` SET `AIName`='SmartGameObjectAI', `ScriptName`='' WHERE `entry`=@CAT_FIGURINE;

DELETE FROM `smart_scripts` WHERE `entryorguid`=@CAT_FIGURINE AND `source_type`=1;

INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@CAT_FIGURINE, 1, 0, 0, 64, 0, 100, 257, 0, 0, 0, 0, 0, 11, @SPELL_SUMMON_GHOST_SABER, 0, 0, 0, 0, 0, 7, 0, 0, 0, 0, 0, 0, 0, 0, "Cat Figurine - On Gossip Hello - Cast Summon Ghost Saber");

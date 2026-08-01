--
-- Crimson Hall darkfallen trash: remove SmartAI superseded by ScriptName.
--
-- These entries received a ScriptName in ac6592a, and ScriptName takes
-- precedence over AIName in FactorySelector::SelectAI, so SmartAI is never
-- instantiated for them and none of the rows below can execute. The behaviours
-- that were lost with them are now handled in icecrown_citadel.cpp:
--   * SMART_EVENT_DEATH -> SMART_ACTION_SET_INST_DATA (field 300), feeding
--     BloodPrinceTrashCount, which opens GO_CRIMSON_HALL_DOOR
--   * SMART_EVENT_AGGRO -> SMART_ACTION_CALL_FOR_HELP (19 yd)
--   * 38463 (Empowering Orb Visual Stalker): spell hit 70293 / 70227, replaced
--     by npc_icc_orb_controller
--
DELETE FROM `smart_scripts`
WHERE `source_type` = 0 AND `entryorguid` IN (37571, 37595, 37663, 37664, 37666, 38463, -201479, -201482, -201646, -201659);

UPDATE `creature_template` SET `AIName` = ''
WHERE `entry` IN (37571, 37595, 37663, 37664, 37666, 38463);

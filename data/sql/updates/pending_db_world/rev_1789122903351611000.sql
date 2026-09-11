--
-- Quest 6027 'Book of the Ancients': using the Gem of the Serpent lights the Naga Beam but
-- often summons nothing, leaving Lord Kragaru (12369) unreachable. The beam is a temporary
-- gameobject whose lifetime is rounded to whole seconds, so it frequently expires before its
-- own 3500ms summon timer fires, depending on when inside a second the player clicked.
-- Drive the summon from the statue instead - a permanent spawn whose SmartAI cannot despawn.
--
DELETE FROM `smart_scripts` WHERE (`source_type` = 1 AND `entryorguid` IN (177673, 177705)) OR (`source_type` = 9 AND `entryorguid` = 17767300);
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `event_param5`, `event_param6`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_param4`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
    (177673, 1, 0, 1, 70, 0, 100, 0, 2, 0, 0, 0, 0, 0, 80, 17767300, 2, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Serpent Statue - On Loot State Changed (Activated) - Call Timed Actionlist'),
    (177673, 1, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 0, 0, 241, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 'Serpent Statue - On Link - Summon Gameobject Group 0 \'Naga Beam\''),
    (17767300, 9, 0, 0, 0, 0, 100, 0, 3500, 3500, 0, 0, 0, 0, 12, 12369, 1, 180000, 0, 0, 0, 8, 0, 0, 0, 0, 252.57, 2963.7, 1.72356, 1.29154, 'Serpent Statue - On Script - Summon Creature \'Lord Kragaru\'');

-- The beam is summoned through a gameobject summon group so that its sniffed rotation survives:
-- SMART_ACTION_SUMMON_GO hands SummonGameObject an identity quaternion and cannot carry one.
DELETE FROM `gameobject_summon_groups` WHERE (`summonerId` = 177673 AND `summonerType` = 1 AND `groupId` = 0);
INSERT INTO `gameobject_summon_groups` (`summonerId`, `summonerType`, `groupId`, `entry`, `position_x`, `position_y`, `position_z`, `orientation`, `rotation0`, `rotation1`, `rotation2`, `rotation3`, `respawnTime`, `Comment`) VALUES
    (177673, 1, 0, 177705, 252.547, 2963.69, 1.64267, 5.58505, 0, 0, -0.34202, 0.939693, 4, 'Serpent Statue - Naga Beam');

-- The Naga Beam is purely cosmetic now; it carries no script.
UPDATE `gameobject_template` SET `AIName` = '' WHERE (`entry` = 177705);

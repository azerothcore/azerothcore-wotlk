DELETE FROM `acore_world`.`acore_string` WHERE entry = '1910000';
DELETE FROM `acore_world`.`acore_string` WHERE entry = '1910001';
DELETE FROM `acore_world`.`acore_string` WHERE entry = '1910002';

INSERT INTO `acore_world`.`acore_string` (`entry`, `content_default`) VALUES ('1910000', '%s has completed challenge(s) %s in %s!');
INSERT INTO `acore_world`.`acore_string` (`entry`, `content_default`) VALUES ('1910001', 'Congratulations %s the Forged! They have completed the all challenge run to 80!');
INSERT INTO `acore_world`.`acore_string` (`entry`, `content_default`) VALUES ('1910002', '%s has been %s by %s at level %s attempting to complete the challenge(s) %s!');


DELETE FROM `acore_world`.`spell_script_names` WHERE spell_id = '1910004';
INSERT INTO `acore_world`.`spell_script_names` (`spell_id`, `ScriptName`) VALUES ('1910004', 'spell_insanity');


DELETE FROM `acore_world`.`character_modes_rewards` WHERE mode = 0;

INSERT INTO acore_world.character_modes_rewards VALUES (0, 1, 178);

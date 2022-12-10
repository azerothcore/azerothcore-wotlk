-- DB update 2021_11_19_02 -> 2021_11_20_00
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_19_02';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_19_02 2021_11_20_00 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1637191609234345200'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1637191609234345200');

UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32688 WHERE `id` = 40804;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32689 WHERE `id` = 40805;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32690 WHERE `id` = 40806;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32691 WHERE `id` = 40807;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32692 WHERE `id` = 40808;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32693 WHERE `id` = 40809;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32700 WHERE `id` = 40908;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32701 WHERE `id` = 40910;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32702 WHERE `id` = 40911;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32703 WHERE `id` = 40912;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32704 WHERE `id` = 40913;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32705 WHERE `id` = 40914;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32706 WHERE `id` = 40915;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32707 WHERE `id` = 40916;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32708 WHERE `id` = 40918;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32709 WHERE `id` = 40919;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32710 WHERE `id` = 40920;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32711 WHERE `id` = 40921;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32712 WHERE `id` = 40922;
UPDATE `spell_dbc` SET `effect_1` = 24, `ImplicitTargetA_1` = 25, `EffectItemType_1` = 32713 WHERE `id` = 40923;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_20_00' WHERE sql_rev = '1637191609234345200';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;

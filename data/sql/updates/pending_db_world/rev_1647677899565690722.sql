INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1647677899565690722');

ALTER TABLE `spell_proc`
    CHANGE `spellId` `SpellId` int(11) NOT NULL DEFAULT 0 FIRST,
    CHANGE `schoolMask` `SchoolMask` tinyint(3) unsigned NOT NULL DEFAULT 0 AFTER `SpellId`,
    CHANGE `spellFamilyName` `SpellFamilyName` smallint(5) unsigned NOT NULL DEFAULT 0 AFTER `SchoolMask`,
    CHANGE `spellFamilyMask0` `SpellFamilyMask0` int(10) unsigned NOT NULL DEFAULT 0 AFTER `SpellFamilyName`,
    CHANGE `spellFamilyMask1` `SpellFamilyMask1` int(10) unsigned NOT NULL DEFAULT 0 AFTER `SpellFamilyMask0`,
    CHANGE `spellFamilyMask2` `SpellFamilyMask2` int(10) unsigned NOT NULL DEFAULT 0 AFTER `SpellFamilyMask1`,
    CHANGE `typeMask` `ProcFlags` int(10) unsigned NOT NULL DEFAULT 0 AFTER `SpellFamilyMask2`,
    CHANGE `spellTypeMask` `SpellTypeMask` int(10) unsigned NOT NULL DEFAULT 0 AFTER `ProcFlags`,
    CHANGE `spellPhaseMask` `SpellPhaseMask` int(10) unsigned NOT NULL DEFAULT 0 AFTER `SpellTypeMask`,
    CHANGE `hitMask` `HitMask` int(10) unsigned NOT NULL DEFAULT 0 AFTER `SpellPhaseMask`,
    CHANGE `attributesMask` `AttributesMask` int(10) unsigned NOT NULL DEFAULT 0 AFTER `HitMask`,
    CHANGE `ratePerMinute` `ProcsPerMinute` float NOT NULL DEFAULT 0 AFTER `AttributesMask`,
    CHANGE `chance` `Chance` float NOT NULL DEFAULT 0 AFTER `ProcsPerMinute`,
    CHANGE `cooldown` `Cooldown` int(10) unsigned NOT NULL DEFAULT 0 AFTER `Chance`,
    CHANGE `charges` `Charges` tinyint(3) unsigned NOT NULL DEFAULT 0 AFTER `Cooldown`;

DELETE FROM `spell_script_names` WHERE `ScriptName` IN
('spell_mage_blazing_speed','spell_pri_blessed_recovery','spell_dru_forms_trinket','spell_dru_t9_feral_relic',
'spell_sha_nature_guardian','spell_warl_nether_protection','spell_hun_piercing_shots','spell_hun_t9_4p_bonus',
'spell_sha_lightning_shield','spell_dk_acclimation','spell_dk_advantage_t10_4p',
'spell_rog_t10_2p_bonus','spell_pal_illumination','spell_item_soul_preserver','spell_item_death_choice',
'spell_item_lightning_capacitor','spell_item_thunder_capacitor','spell_item_toc25_normal_caster_trinket','spell_item_toc25_heroic_caster_trinket',
'spell_igb_battle_experience_check','spell_gen_blood_reserve','spell_item_darkmoon_card_greatness',
'spell_item_charm_witch_doctor','spell_item_mana_drain', 'spell_item_blood_draining_enchant');
DELETE FROM `spell_script_names` WHERE `ScriptName` = 'spell_gen_proc_above_75' AND `spell_id` = 64568;

INSERT INTO `spell_script_names` (`spell_id`,`ScriptName`) VALUES
(-49200, 'spell_dk_acclimation'),                       -- DK Acclimation
(70656, 'spell_dk_advantage_t10_4p'),                   -- DK Advantage t10 4p melee
(37336, 'spell_dru_forms_trinket'),                     -- Druid Forms Trinket
(67353, 'spell_dru_t9_feral_relic'),                    -- Druid T9 Feral Relic (Idol of Mutilation)
(64568, 'spell_gen_blood_reserve'),                     -- Blood Reserve (weapon enchant proc)
(-53234, 'spell_hun_piercing_shots'),                   -- Hunter Piercing Shots
(-67151, 'spell_hun_t9_4p_bonus'),                      -- Hunter T9 Bonus
(71201, 'spell_igb_battle_experience_check'),           -- Battle Experience (Gunship - ICC)
(60510, 'spell_item_soul_preserver'),                   -- Soul Preserver
(67702, 'spell_item_death_choice'),                     -- Death Choice Trinket
(67771, 'spell_item_death_choice'),                     -- Death Choice Trinket
(37657, 'spell_item_lightning_capacitor'),              -- Lightning Capcitor
(54841, 'spell_item_thunder_capacitor'),                -- Thunder Capacitor
(67712, 'spell_item_toc25_normal_caster_trinket'),      -- Item - Coliseum 25 Normal Caster Trinket
(67758, 'spell_item_toc25_heroic_caster_trinket'),      -- Item - Coliseum 25 Heroic Caster Trinket
(57345, 'spell_item_darkmoon_card_greatness'),          -- Darkmoon Card: Greatness
(43820, 'spell_item_charm_witch_doctor'),               -- Charm of the Witch Doctor
(27522, 'spell_item_mana_drain'),                       -- Mana Drain
(40336, 'spell_item_mana_drain'),                       -- Mana Drain
(-31641, 'spell_mage_blazing_speed'),                   -- Mage Blazing Speed
(-20210, 'spell_pal_illumination'),                     -- Paladin Illumination (for Holy Shock)
(-27811, 'spell_pri_blessed_recovery'),                 -- Priest Blessed Recovery
(-30881, 'spell_sha_nature_guardian'),                  -- Shaman Nature's Guardian
(-324, 'spell_sha_lightning_shield'),                   -- Shaman Lightning Shield
(-30299, 'spell_warl_nether_protection');               -- Warlock Nether protection

UPDATE `spell_proc` SET `SpellPhaseMask`=0x2 WHERE `SpellId` IN (
-61846, -- Aspect of the Dragonhawk
-13165, -- Aspect of the Hawk
7434,   -- Fate Rune of Unsurpassed Vigor
39958,  -- Skyfire Swiftness
55380,  -- Skyflare Swiftness
70727   -- Item - Hunter T10 2P Bonus
);

DELETE FROM `spell_script_names` WHERE `ScriptName`='spell_pri_pain_and_suffering_dummy';
INSERT INTO `spell_script_names` (`spell_id`, `ScriptName`) VALUES
(-47580, 'spell_pri_pain_and_suffering_dummy');

-- DB update 2026_05_09_01 -> 2026_05_10_00
-- Restore TEMPSUMMON_MANUAL_DESPAWN (8) with no timer for Thiassi -> Antiok
-- accessory. With timer 0 this is rewritten to TEMPSUMMON_DEAD_DESPAWN at
-- runtime, so Antiok only despawns when he dies and no longer ticks down
-- while seated on Thiassi pre-engage.
UPDATE `vehicle_template_accessory` SET `summontype` = 8, `summontimer` = 0
    WHERE `entry` = 28018 AND `accessory_entry` = 28006;

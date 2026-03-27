-- DB update 2026_03_25_04 -> 2026_03_25_05
-- Also add spark visual aura from Power Spark to Power Spark (1)
UPDATE `creature_template_addon` SET `auras` = '55845' WHERE (`entry` = 32187);

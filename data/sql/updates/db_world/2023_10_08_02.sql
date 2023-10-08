-- DB update 2023_10_08_01 -> 2023_10_08_02
-- Ghostweave Patterns
DELETE FROM `reference_loot_template` WHERE `Entry` IN (24708,24709) AND `Item` IN (14495,14480,14473,14477);

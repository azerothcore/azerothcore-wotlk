-- DB update 2024_11_24_04 -> 2024_11_24_05
--
UPDATE `spell_area` SET `gender` = 2 WHERE `spell` IN (43816, 43818, 43820, 43822);

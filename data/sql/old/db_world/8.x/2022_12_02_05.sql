-- DB update 2022_12_02_04 -> 2022_12_02_05
--
UPDATE `quest_offer_reward_locale` SET `RewardText` = 'Bien, bien, $n. No sé si esto es de buena calidad, pero si Zurdibrujo quería algo más específico, tenía que haberlo dejado claro antes de enviar a los Reivindicadores  aquí fuera.$B$B¿Qué te pareces si te pones con el siguiente objeto de su lista?' WHERE `ID` = 1458 AND `locale` IN ('esMX', 'esES');

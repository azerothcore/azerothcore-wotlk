-- DB update 2024_12_22_01 -> 2024_12_22_02
--
DELETE FROM `quest_request_items_locale` WHERE `CompletionText` = '';
DELETE FROM `quest_request_items_locale` WHERE `CompletionText` = 'NULL';
DELETE FROM `quest_request_items_locale` WHERE `CompletionText` IS NULL;

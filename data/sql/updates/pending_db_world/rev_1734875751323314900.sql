--
DELETE FROM `quest_request_items_locale` WHERE `CompletionText` = '';
DELETE FROM `quest_request_items_locale` WHERE `CompletionText` = 'NULL';
DELETE FROM `quest_request_items_locale` WHERE `CompletionText` IS NULL;

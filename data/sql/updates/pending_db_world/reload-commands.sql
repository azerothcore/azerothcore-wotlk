DELETE FROM `command` WHERE `name` IN ('reload reputation_spillover_template','reload reputation_reward_rate','reload quest_offer_reward_locale','reload quest_request_item_locale','reload antidos_opcode_policies','reload areatrigger','reload profanity_name','reload warden_action');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('reload reputation_spillover_template', 3,'Syntax: .reload reputation_spillover_template\n\nReloads reputation_spillover_template table.'),
('reload reputation_reward_rate', 3,'Syntax: .reload reputation_reward_rate\n\nReloads reputation_reward_rate table.'),
('reload quest_offer_reward_locale', 3,'Syntax: .reload quest_offer_reward_locale\n\nReloads quest_offer_reward_locale table.'),
('reload quest_request_item_locale', 3,'Syntax: .reload quest_request_item_locale\n\nReloads quest_request_item_locale table.'),
('reload antidos_opcode_policies', 3,'Syntax: .reload antidos_opcode_policies\n\nReloads antidos_opcode_policies table.'),
('reload areatrigger', 3,'Syntax: .reload areatrigger\n\nReloads areatrigger table.'),
('reload profanity_name', 3,'Syntax: .reload profanity_name\n\nReloads profanity_name table.'),
('reload warden_action', 3,'Syntax: .reload warden_action\n\nReloads warden_action table.');

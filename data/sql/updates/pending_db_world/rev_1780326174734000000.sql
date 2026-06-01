-- Add chatfilter and reload chat_filter commands.
DELETE FROM `command` WHERE `name` IN ('chatfilter', 'chatfilter list', 'chatfilter add', 'chatfilter remove', 'reload chat_filter');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('chatfilter', 2, 'Syntax: .chatfilter $subcommand\nType .chatfilter to see a list of subcommands or .help chatfilter $subcommand to see info on subcommands.'),
('chatfilter list', 2, 'Syntax: .chatfilter list\nList all entries from the `chat_filter` table.'),
('chatfilter add', 3, 'Syntax: .chatfilter add $word\nAdd $word to the `chat_filter` table and reload the chat filter.'),
('chatfilter remove', 3, 'Syntax: .chatfilter remove $word\nRemove $word from the `chat_filter` table and reload the chat filter.'),
('reload chat_filter', 3, 'Syntax: .reload chat_filter\n\nReload the `chat_filter` table.');

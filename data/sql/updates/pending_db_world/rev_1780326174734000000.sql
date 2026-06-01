-- Add filteredwords and reload filtered_words commands.
DELETE FROM `command` WHERE `name` IN ('filteredwords', 'filteredwords list', 'filteredwords add', 'filteredwords remove', 'reload filtered_words');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('filteredwords', 2, 'Syntax: .filteredwords $subcommand\nType .filteredwords to see a list of subcommands or .help filteredwords $subcommand to see info on subcommands.'),
('filteredwords list', 2, 'Syntax: .filteredwords list\nList all entries from the `filtered_words` table.'),
('filteredwords add', 3, 'Syntax: .filteredwords add $word\nAdd $word to the `filtered_words` table and reload the chat filter.'),
('filteredwords remove', 3, 'Syntax: .filteredwords remove $word\nRemove $word from the `filtered_words` table and reload the chat filter.'),
('reload filtered_words', 3, 'Syntax: .reload filtered_words\n\nReload the `filtered_words` table.');

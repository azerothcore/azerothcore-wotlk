-- DB update 2026_02_26_02 -> 2026_02_26_03
--
DELETE FROM `command` WHERE `name` IN ('spellinfo', 'spellinfo attributes', 'spellinfo effects', 'spellinfo targets', 'spellinfo all');
INSERT INTO `command` (`name`, `security`, `help`) VALUES
('spellinfo', 2, 'Syntax: .spellinfo $subcommand\n\nType .spellinfo to see a list of subcommands or .help spellinfo $subcommand to see info on subcommands.'),
('spellinfo attributes', 2, 'Syntax: .spellinfo attributes #spellid\n\nDisplays basic info and attribute flags for spell #spellid including SpellAttr0-7, custom attributes, stances, dispel type and mechanic.'),
('spellinfo effects', 2, 'Syntax: .spellinfo effects #spellid\n\nDisplays effect data for spell #spellid including effect type, aura type, base points, multipliers, misc values, mechanic, trigger spell, amplitude and class mask per effect.'),
('spellinfo targets', 2, 'Syntax: .spellinfo targets #spellid\n\nDisplays target data for spell #spellid including target mask, creature type, max affected targets, and per-effect TargetA, TargetB, radius and chain targets.'),
('spellinfo all', 2, 'Syntax: .spellinfo all #spellid\n\nDisplays all available data for spell #spellid including attributes, general properties, effects and targets.');

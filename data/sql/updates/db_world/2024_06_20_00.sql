-- DB update 2024_06_18_06 -> 2024_06_20_00
--
UPDATE `command` SET `help`='Syntax: .cast #spellid [triggered]\r\n  Cast #spellid to selected target. If no target selected cast to self. If \'triggered\' or part provided then spell cast with triggered flag.' WHERE `name`='cast';
UPDATE `command` SET `help`='Syntax: .cast back #spellid [triggered]\r\n  Selected target will cast #spellid to your character. If \'triggered\' or part provided then spell cast with triggered flag.' WHERE `name`='cast back';
UPDATE `command` SET `help`='Syntax: .cast dest #spellid #x #y #z [triggered]\r\n  Selected target will cast #spellid at provided destination. If \'triggered\' or part provided then spell cast with triggered flag.' WHERE `name`='cast dest';
UPDATE `command` SET `help`='Syntax: .cast dist #spellid [#dist [triggered]]\r\n  You will cast spell to point at distance #dist. If \'triggered\' or part provided then spell cast with triggered flag. Not all spells can be cast as area spells.' WHERE `name`='cast dist';
UPDATE `command` SET `help`='Syntax: .cast self #spellid [triggered]\r\n  Cast #spellid by target at target itself. If \'triggered\' or part provided then spell cast with triggered flag.' WHERE `name`='cast self';
UPDATE `command` SET `help`='Syntax: .cast target #spellid [triggered]\r\n  Selected target will cast #spellid to his victim. If \'triggered\' or part provided then spell cast with triggered flag.' WHERE `name`='cast target';

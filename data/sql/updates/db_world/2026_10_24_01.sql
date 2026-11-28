-- DB update 2026_10_24_00 -> 2026_10_24_01
UPDATE `command` SET `help` = 'Syntax: .instance unbind <mapid|all> [difficulty] [$playername]\nClear all or some instance binds of the selected player, yourself, or the named character, online or offline. The map the character is on keeps its bind. From the console the name is required.' WHERE `name` = 'instance unbind';

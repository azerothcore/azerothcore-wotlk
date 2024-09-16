-- wp modify

UPDATE `command` SET `help` = 'Syntax: .gobject set $subcommand
Type .gobject set to see the list of possible subcommands or .help gobject set $subcommand to see info on subcommands.' WHERE `name` = 'gobject set';

UPDATE `command` SET `help` = 'Syntax: .skirmish [arena] [XvX] [Nick1] [Nick2] ... [NickN]
[arena] can be \"all\" or comma-separated list of possible arenas (NA, BE, RL, DS, RV).
[XvX] can be 1v1, 2v2, 3v3, 5v5. After [XvX] specify enough nicknames for that mode.' WHERE `name` = 'skirmish';

UPDATE `command` SET `help` = 'Syntax: .bf $subcommand
Type .bf to see the list of possible subcommands or .help bf $subcommand to see info on subcommands.' WHERE `name` = 'bf';

UPDATE `command` SET `help` = 'Syntax: .debug entervehicle #entry #seatID
Enter the targeted or given vehicle ID in the given seat.' WHERE `name` = 'debug entervehicle';

UPDATE `command` SET `help` = 'Syntax: .debug getitemstate #itemState [unchanged/changed/new/removed/queue/check_all]
Returns all items in a given player''s inventory with a given item state.' WHERE `name` = 'debug getitemstate';

UPDATE `command` SET `help` = 'Syntax: .debug getitemvalue #GUID #index
Returns the value of the given index for the given item GUID.' WHERE `name` = 'debug getitemvalue';

UPDATE `command` SET `help` = 'Syntax: .debug getvalue #index #isInt
Returns either an integer or float value at a given index of your target.' WHERE `name` = 'debug getvalue';

UPDATE `command` SET `help` = 'Syntax: .debug hostile
Returns the hostile reference list of a given player.' WHERE `name` = 'debug hostile';

UPDATE `command` SET `help` = 'Syntax: .debug itemexpire #GUID
Destroy an item with the given GUID.' WHERE `name` = 'debug itemexpire';

UPDATE `command` SET `help` = 'Syntax: .debug lootrecipient
Returns the loot recipient of the targeted creature.' WHERE `name` = 'debug lootrecipient';

UPDATE `command` SET `help` = 'Syntax: .debug los
Returns line of sight status between you and your target.' WHERE `name` = 'debug los';

UPDATE `command` SET `help` = 'Syntax: .debug play $subcommand
Type .debug play to see the list of possible subcommands or .help debug play $subcommand to see info on subcommands.' WHERE `name` = 'debug play';

UPDATE `command` SET `help` = 'Syntax: .debug send $subcommand
Type .debug send to see the list of possible subcommands or .help debug send $subcommand to see info on subcommands.' WHERE `name` = 'debug send';

UPDATE `command` SET `help` = 'Syntax: .debug send buyerror #error
Sends the given buy error result.' WHERE `name` = 'debug send buyerror';

UPDATE `command` SET `help` = 'Syntax: .debug send channelnotify #type
Sends a channel notify message of the given type.' WHERE `name` = 'debug send channelnotify';

UPDATE `command` SET `help` = 'Syntax: .debug send chatmessage #type
Sends a chat message of the given type.', `name` = 'debug send chatmessage' WHERE `name` = 'debug send chatmmessage';

UPDATE `command` SET `help` = 'Syntax: .debug send equiperror #error
Sends the given equip error result.' WHERE `name` = 'debug send equiperror';

UPDATE `command` SET `help` = 'Syntax: .debug send largepacket
Sends a system message of 128 kilobytes.' WHERE `name` = 'debug send largepacket';

UPDATE `command` SET `help` = 'Syntax: .debug send opcode
Sends opcodes contained in "opcode.txt".' WHERE `name` = 'debug send opcode';

UPDATE `command` SET `help` = 'Syntax: .debug send qinvalidmsg #error
Sends the given quest error result.' WHERE `name` = 'debug send qinvalidmsg';

UPDATE `command` SET `help` = 'Syntax: .debug send qpartymsg #message
Sends the given party quest share message.' WHERE `name` = 'debug send qpartymsg';

UPDATE `command` SET `help` = 'Syntax: .debug send sellerror #error
Sends the given sell error result.' WHERE `name` = 'debug send sellerror';

UPDATE `command` SET `help` = 'Syntax: .debug send setphaseshift #phaseShift
Sends a phase shift message with the given phase shift value.' WHERE `name` = 'debug send setphaseshift';

UPDATE `command` SET `help` = 'Syntax: .debug send spellfail #result #failArgument1 #failArgument2
Sends a spell failure message with the given result and argument values.' WHERE `name` = 'debug send spellfail';

UPDATE `command` SET `help` = 'Syntax: .debug setaurastate #state #apply
Sets the selected units aura state using the given apply value.' WHERE `name` = 'debug setaurastate';

UPDATE `command` SET `help` = 'Syntax: .debug setbit #index #bit
Sets the unsigned 32-bit integer value of the target at the given index to the given bit.' WHERE `name` = 'debug setbit';

UPDATE `command` SET `help` = 'Syntax: .debug setitemvalue #GUID #index #value
Sets the value of the given index for the given item GUID to the given value.' WHERE `name` = 'debug setitemvalue';

UPDATE `command` SET `help` = 'Syntax: .debug setvalue #index #value
Sets the unsigned 32-bit integer or float value of the target at the given index to the given value.' WHERE `name` = 'debug setvalue';

UPDATE `command` SET `help` = 'Syntax: .debug setvid #ID
Currently disabled.
Sets the given target''s vehicle ID to the given value.' WHERE `name` = 'debug setvid';

UPDATE `command` SET `help` = 'Syntax: .debug spawnvehicle #entry #ID
Creates a vehicle with the given ID.' WHERE `name` = 'debug spawnvehicle';

UPDATE `command` SET `help` = 'Syntax: .debug threat
Returns the threat list of a given creature.' WHERE `name` = 'debug threat';

UPDATE `command` SET `help` = 'Syntax: .debug update #index #value
Sets the unsigned 32-bit integer value of the target at the given index to the given bit.' WHERE `name` = 'debug update';

UPDATE `command` SET `help` = 'Syntax: .debug uws #variable #value
Sends a worldstate update for the given variable to the given value.' WHERE `name` = 'debug uws';

UPDATE `command` SET `help` = 'Syntax: .gobject set state #GUIDLow, #objectType, #objectState
Sets the byte value or sends a custom animation for a given gameobject GUID.' WHERE `name` = 'gobject set state';

UPDATE `command` SET `help` = 'Syntax: .learn all $subcommand
Type .learn all to see the list of possible subcommands or .help learn all $subcommand to see info on subcommands.' WHERE `name` = 'learn all';

UPDATE `command` SET `help` = 'Syntax: .learn all my $subcommand
Type .learn all my to see the list of possible subcommands or .help learn all my $subcommand to see info on subcommands.' WHERE `name` = 'learn all my';

UPDATE `command` SET `help` = 'Syntax: .lfg $subcommand
Type .lfg to see the list of possible subcommands or .help lfg $subcommand to see info on subcommands.' WHERE `name` = 'lfg';

UPDATE `command` SET `help` = 'Syntax: .lookup player $subcommand
Type .lookup player to see the list of possible subcommands or .help lookup player $subcommand to see info on subcommands.' WHERE `name` = 'lookup player';

UPDATE `command` SET `help` = 'Syntax: .npc near #distance
Returns all database creature spawns in a given distance.' WHERE `name` = 'npc near';

UPDATE `command` SET `help` = 'Syntax: .npc set $subcommand
Type .npc set to see the list of possible subcommands or .help npc set $subcommand to see info on subcommands.' WHERE `name` = 'npc set';

UPDATE `command` SET `help` = 'Syntax: .npc tame
Creates a player pet of the targeted creature.' WHERE `name` = 'npc tame';

UPDATE `command` SET `help` = 'Syntax: .reload npc_spellclick_spells
Reload npc_spellclick_spells table.' WHERE `name` = 'reload npc_spellclick_spells';

UPDATE `command` SET `help` = 'Syntax: .spect $subcommand
Type .spect to see the list of possible subcommands or .help spect $subcommand to see info on subcommands.' WHERE `name` = 'spect';

UPDATE `command` SET `help` = 'Syntax: .spect leave
Leave an arena you are spectating.' WHERE `name` = 'spect leave';

UPDATE `command` SET `help` = 'Syntax: .spect reset
Reset various values related to spectating.' WHERE `name` = 'spect reset';

UPDATE `command` SET `help` = 'Syntax: .spect spectate #name
Begin spectating the given player.' WHERE `name` = 'spect spectate';

UPDATE `command` SET `help` = 'Syntax: .spect version #version
Verify addon version for arena spectating.' WHERE `name` = 'spect version';

UPDATE `command` SET `help` = 'Syntax: .spect watch #name
Begin watching the given player.' WHERE `name` = 'spect watch';

UPDATE `command` SET `help` = 'Syntax: .ticket complete #ticketID
Mark a ticket of the given ID as complete.' WHERE `name` = 'ticket complete';

UPDATE `command` SET `help` = 'Syntax: .ticket escalate #ticketID
Add a ticket of the given ID to the escalation queue.' WHERE `name` = 'ticket escalate';

UPDATE `command` SET `help` = 'Syntax: .ticket escalatedlist
Return all open tickets in the escalation queue.' WHERE `name` = 'ticket escalatedlist';

UPDATE `command` SET `help` = 'Syntax: .ticket response $subcommand
Type .ticket response to see the list of possible subcommands or .help ticket response $subcommand to see info on subcommands.' WHERE `name` = 'ticket response';

UPDATE `command` SET `help` = 'Syntax: .ticket togglesystem
Toggle whether tickets are allowed or disallowed.' WHERE `name` = 'ticket togglesystem';

UPDATE `command` SET `help` = 'Syntax: .titles $subcommand
Type .titles to see the list of possible subcommands or .help titles $subcommand to see info on subcommands.' WHERE `name` = 'titles';

UPDATE `command` SET `help` = 'Syntax: .titles set $subcommand
Type .titles set to see the list of possible subcommands or .help titles set $subcommand to see info on subcommands.' WHERE `name` = 'titles set';

UPDATE `command` SET `help` = 'Syntax: .unban playeraccount #name
Unban accounts for character name pattern.' WHERE `name` = 'unban playeraccount';

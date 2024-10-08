## Introduction

Module: mod-chat-transmitter allows you to send and recieve information from your worldserver of AzerothCore. 

The module main job is to allow a connection between worldserver and your discord bot.

This guide was made for and tested on a Windows 10 machine.

## Requirements

You will need to have: [mod-eluna](https://github.com/azerothcore/mod-eluna) alongside this module into your AzerothCore Modules and Server.

And you also will need this: [chat-transmitter-bot](https://github.com/azerothcore/chat-transmitter-bot).

## Setup
If you have used Eluna before and have created a database previous for it, ignore step 1.

1) Go into "mod-chat-transmitter\data\sql\eluna_create" and run in your MySQL Client. It should create a database called "acore_eluna" and should not have any tables and that's intended.

2) Make sure you've Eluna enabled and ran at least once on your server.

3) Close your worldserver and changed the ChatTransmitter.config.dist and edit it.

| Option | Description 
| :---: | --- |
| Enabled | Enable or Disable this Module.
| BowWsHost | The IPv4 where the Discord BOT is being Hosted.
| BotWsPort | The port where the Discord BOT is listening to.
| BotWsKey | Discord Bot Token same value as Secret Key in chat-transmitter.
| DiscordGuildId | What Discord Server should it send the information to.
| ElunaDatabaseInfo | Your ElunaDatabase: IPv4; Port; username; password; database.

Note: If you're new to using Discord Bots, just do a quick search how to create one and get their ID and Token.

4) For your worldserver you're all done for now. Close it.

5) Go to: [chat-transmitter-bot](https://github.com/azerothcore/chat-transmitter-bot)

## Show some love

If you appreciate this Module buy the author a [coffee](https://ko-fi.com/roboto).

Thanks Roboto for this!
-Ryan

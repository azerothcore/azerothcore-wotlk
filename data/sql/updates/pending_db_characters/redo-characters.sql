ALTER TABLE `account_data`
	RENAME COLUMN `accountId`				TO `AccountID`,
	RENAME COLUMN `type`					TO `Type`,
	RENAME COLUMN `time`					TO `Time`,
	RENAME COLUMN `data`					TO `Data`;

ALTER TABLE `account_instance_times`
	RENAME COLUMN `accountId`				TO `AccountID`,
	RENAME COLUMN `instanceId`				TO `InstanceID`,
	RENAME COLUMN `releaseTime`				TO `ReleaseTime`;

ALTER TABLE `account_tutorial`
	RENAME COLUMN `accountId`				TO `AccountID`,
	RENAME COLUMN `tut0`					TO `Tutorial1`,
	RENAME COLUMN `tut1`					TO `Tutorial2`,
	RENAME COLUMN `tut2`					TO `Tutorial3`,
	RENAME COLUMN `tut3`					TO `Tutorial4`,
	RENAME COLUMN `tut4`					TO `Tutorial5`,
	RENAME COLUMN `tut5`					TO `Tutorial6`,
	RENAME COLUMN `tut6`					TO `Tutorial7`,
	RENAME COLUMN `tut7`					TO `Tutorial8`;

ALTER TABLE `addons`
	RENAME COLUMN `name`					TO `Name`,
	RENAME COLUMN `crc`						TO `CRC`;

ALTER TABLE `arena_team`
	RENAME COLUMN `arenaTeamId`				TO `ArenaTeamID`,
	RENAME COLUMN `name`					TO `Name`,
	RENAME COLUMN `captainGuid`				TO `CaptainGUID`,
	RENAME COLUMN `type`					TO `Type`,
	RENAME COLUMN `rating`					TO `Rating`,
	RENAME COLUMN `seasonGames`				TO `SeasonGames`,
	RENAME COLUMN `seasonWins`				TO `SeasonWins`,
	RENAME COLUMN `weekGames`				TO `WeekGames`,
	RENAME COLUMN `weekWins`				TO `WeekWins`,
	RENAME COLUMN `rank`					TO `Rank`,
	RENAME COLUMN `backgroundColor`			TO `BackgroundColor`,
	RENAME COLUMN `emblemStyle`				TO `EmblemStyle`,
	RENAME COLUMN `emblemColor`				TO `EmblemColor`,
	RENAME COLUMN `borderStyle`				TO `BorderStyle`,
	RENAME COLUMN `borderColor`				TO `BorderColor`;

ALTER TABLE `arena_team_member`
	RENAME COLUMN `arenaTeamId`				TO `ArenaTeamID`,
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `weekGames`				TO `WeekGames`,
	RENAME COLUMN `weekWins`				TO `WeekWins`,
	RENAME COLUMN `seasonGames`				TO `SeasonGames`,
	RENAME COLUMN `seasonWins`				TO `SeasonWins`,
	RENAME COLUMN `personalRating`			TO `PersonalRating`;

ALTER TABLE `auctionhouse`
	RENAME COLUMN `id`						TO `ID`,
	RENAME COLUMN `houseid`					TO `HouseID`,
	RENAME COLUMN `itemguid`				TO `ItemGUID`,
	RENAME COLUMN `itemowner`				TO `ItemOwner`,
	RENAME COLUMN `buyoutprice`				TO `BuyoutPrice`,
	RENAME COLUMN `time`					TO `Time`,
	RENAME COLUMN `buyguid`					TO `BuyGUID`,
	RENAME COLUMN `lastbid`					TO `LastBid`,
	RENAME COLUMN `startbid`				TO `StartBid`,
	RENAME COLUMN `deposit`					TO `Deposit`,
	RENAME								TO `auction_house`;

ALTER TABLE `banned_addons`
	RENAME COLUMN `Id`						TO `ID`;

ALTER TABLE `battleground_deserters`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `type`					TO `Type`,
	RENAME COLUMN `datetime`				TO `DateTime`;

ALTER TABLE `bugreport`
	RENAME COLUMN `id`						TO `ID`,
	RENAME COLUMN `type`					TO `Type`,
	RENAME COLUMN `content`					TO `Content`,
	RENAME								TO `bug_report`;

ALTER TABLE `calendar_events`
	RENAME COLUMN `id`						TO `ID`,
	RENAME COLUMN `creator`					TO `Creator`,
	RENAME COLUMN `title`					TO `Title`,
	RENAME COLUMN `description`				TO `Description`,
	RENAME COLUMN `type`					TO ``,
	RENAME COLUMN `dungeon`					TO ``,
	RENAME COLUMN `eventtime`				TO ``,
	RENAME COLUMN `flags`					TO ``,
	RENAME COLUMN `time2`					TO ``;

ALTER TABLE `calendar_invites`
	RENAME COLUMN `id`						TO ``,
	RENAME COLUMN `event`					TO ``,
	RENAME COLUMN `invitee`					TO ``,
	RENAME COLUMN `sender`					TO ``,
	RENAME COLUMN `status`					TO ``,
	RENAME COLUMN `statustime`				TO ``,
	RENAME COLUMN `rank`					TO ``,
	RENAME COLUMN `text`					TO ``;

ALTER TABLE `channels`
	RENAME COLUMN `channelId`				TO ``,
	RENAME COLUMN `name`					TO ``,
	RENAME COLUMN `team`					TO ``,
	RENAME COLUMN `announce`				TO ``,
	RENAME COLUMN `ownership`				TO ``,
	RENAME COLUMN `password`				TO ``,
	RENAME COLUMN `lastUsed`				TO ``;

ALTER TABLE `channels_bans`
	RENAME COLUMN `channelId`				TO ``,
	RENAME COLUMN `playerGUID`				TO ``,
	RENAME COLUMN `banTime`					TO ``;

ALTER TABLE `channels_rights`
	RENAME COLUMN `name`					TO ``,
	RENAME COLUMN `flags`					TO ``,
	RENAME COLUMN `speakdelay`				TO ``,
	RENAME COLUMN `joinmessage`				TO ``,
	RENAME COLUMN `delaymessage`			TO ``,
	RENAME COLUMN `moderators`				TO ``;

ALTER TABLE `characters`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `account`					TO ``,
	RENAME COLUMN `name`					TO ``,
	RENAME COLUMN `race`					TO ``,
	RENAME COLUMN `class`					TO ``,
	RENAME COLUMN `gender`					TO ``,
	RENAME COLUMN `level`					TO ``,
	RENAME COLUMN `xp`						TO ``,
	RENAME COLUMN `money`					TO ``,
	RENAME COLUMN `skin`					TO ``,
	RENAME COLUMN `face`					TO ``,
	RENAME COLUMN `hairStyle`				TO ``,
	RENAME COLUMN `hairColor`				TO ``,
	RENAME COLUMN `facialStyle`				TO ``,
	RENAME COLUMN `bankSlots`				TO ``,
	RENAME COLUMN `restState`				TO ``,
	RENAME COLUMN `playerFlags`				TO ``,
	RENAME COLUMN `position_x`				TO ``,
	RENAME COLUMN `position_y`				TO ``,
	RENAME COLUMN `position_z`				TO ``,
	RENAME COLUMN `map`						TO ``,
	RENAME COLUMN `instance_id`				TO ``,
	RENAME COLUMN `instance_mode_mask`		TO ``,
	RENAME COLUMN `orientation`				TO ``,
	RENAME COLUMN `taximask`				TO ``,
	RENAME COLUMN `online`					TO ``,
	RENAME COLUMN `cinematic`				TO ``,
	RENAME COLUMN `totaltime`				TO ``,
	RENAME COLUMN `leveltime`				TO ``,
	RENAME COLUMN `logout_time`				TO ``,
	RENAME COLUMN `is_logout_resting`		TO ``,
	RENAME COLUMN `rest_bonus`				TO ``,
	RENAME COLUMN `resettalents_cost`		TO ``,
	RENAME COLUMN `resettalents_time`		TO ``,
	RENAME COLUMN `trans_x`					TO ``,
	RENAME COLUMN `trans_y`					TO ``,
	RENAME COLUMN `trans_z`					TO ``,
	RENAME COLUMN `trans_o`					TO ``,
	RENAME COLUMN `transguid`				TO ``,
	RENAME COLUMN `extra_flags`				TO ``,
	RENAME COLUMN `stable_slots`			TO ``,
	RENAME COLUMN `at_login`				TO ``,
	RENAME COLUMN `zone`					TO ``,
	RENAME COLUMN `death_expire_time`		TO ``,
	RENAME COLUMN `taxi_path`				TO ``,
	RENAME COLUMN `arenaPoints`				TO ``,
	RENAME COLUMN `totalHonorPoints`		TO ``,
	RENAME COLUMN `todayHonorPoints`		TO ``,
	RENAME COLUMN `yesterdayHonorPoints`	TO ``,
	RENAME COLUMN `totalKills`				TO ``,
	RENAME COLUMN `todayKills`				TO ``,
	RENAME COLUMN `yesterdayKills`			TO ``,
	RENAME COLUMN `chosenTitle`				TO ``,
	RENAME COLUMN `knownCurrencies`			TO ``,
	RENAME COLUMN `watchedFaction`			TO ``,
	RENAME COLUMN `drunk`					TO ``,
	RENAME COLUMN `health`					TO ``,
	RENAME COLUMN `power1`					TO ``,
	RENAME COLUMN `power2`					TO ``,
	RENAME COLUMN `power3`					TO ``,
	RENAME COLUMN `power4`					TO ``,
	RENAME COLUMN `power5`					TO ``,
	RENAME COLUMN `power6`					TO ``,
	RENAME COLUMN `power7`					TO ``,
	RENAME COLUMN `latency`					TO ``,
	RENAME COLUMN `talentGroupsCount`		TO ``,
	RENAME COLUMN `activeTalentGroup`		TO ``,
	RENAME COLUMN `exploredZones`			TO ``,
	RENAME COLUMN `equipmentCache`			TO ``,
	RENAME COLUMN `ammoId`					TO ``,
	RENAME COLUMN `knownTitles`				TO ``,
	RENAME COLUMN `actionBars`				TO ``,
	RENAME COLUMN `grantableLevels`			TO ``,
	RENAME COLUMN `order`					TO ``,
	RENAME COLUMN `creation_date`			TO ``,
	RENAME COLUMN `deleteInfos_Account`		TO ``,
	RENAME COLUMN `deleteInfos_Name`		TO ``,
	RENAME COLUMN `deleteDate`				TO ``,
	RENAME COLUMN `innTriggerId`			TO ``;

ALTER TABLE `character_account_data`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `type`					TO ``,
	RENAME COLUMN `time`					TO ``,
	RENAME COLUMN `data`					TO ``;

ALTER TABLE `character_achievement`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `achievement`				TO ``,
	RENAME COLUMN `date`					TO ``;

ALTER TABLE `character_achievement_progress`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `criteria`				TO ``,
	RENAME COLUMN `counter`					TO ``,
	RENAME COLUMN `date`					TO ``;

ALTER TABLE `character_action`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `spec`					TO ``,
	RENAME COLUMN `button`					TO ``,
	RENAME COLUMN `action`					TO ``,
	RENAME COLUMN `type`					TO ``;

ALTER TABLE `character_arena_stats`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `slot`					TO ``,
	RENAME COLUMN `matchMakerRating`		TO ``,
	RENAME COLUMN `maxMMR`					TO ``;

ALTER TABLE `character_aura`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `casterGuid`				TO ``,
	RENAME COLUMN `itemGuid`				TO ``,
	RENAME COLUMN `spell`					TO ``,
	RENAME COLUMN `effectMask`				TO ``,
	RENAME COLUMN `recalculateMask`			TO ``,
	RENAME COLUMN `stackCount`				TO ``,
	RENAME COLUMN `amount0`					TO ``,
	RENAME COLUMN `amount1`					TO ``,
	RENAME COLUMN `amount2`					TO ``,
	RENAME COLUMN `base_amount0`			TO ``,
	RENAME COLUMN `base_amount1`			TO ``,
	RENAME COLUMN `base_amount2`			TO ``,
	RENAME COLUMN `maxDuration`				TO ``,
	RENAME COLUMN `remainTime`				TO ``,
	RENAME COLUMN `remainCharges`			TO ``;

ALTER TABLE `character_banned`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `bandate`					TO ``,
	RENAME COLUMN `unbandate`				TO ``,
	RENAME COLUMN `bannedby`				TO ``,
	RENAME COLUMN `banreason`				TO ``,
	RENAME COLUMN `active`					TO ``;

ALTER TABLE `character_battleground_random`
	RENAME COLUMN `guid`					TO ``;

ALTER TABLE `character_brew_of_the_month`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `lastEventId`				TO ``;

ALTER TABLE `character_declinedname`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `genitive`				TO ``,
	RENAME COLUMN `dative`					TO ``,
	RENAME COLUMN `accusative`				TO ``,
	RENAME COLUMN `instrumental`			TO ``,
	RENAME COLUMN `prepositional`			TO ``,
	RENAME								TO ``;

ALTER TABLE `character_entry_point`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `joinX`					TO ``,
	RENAME COLUMN `joinY`					TO ``,
	RENAME COLUMN `joinZ`					TO ``,
	RENAME COLUMN `joinO`					TO ``,
	RENAME COLUMN `joinMapId`				TO ``,
	RENAME COLUMN `taxiPath0`				TO ``,
	RENAME COLUMN `taxiPath1`				TO ``,
	RENAME COLUMN `mountSpell`				TO ``;

ALTER TABLE `character_equipmentsets`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `setguid`					TO ``,
	RENAME COLUMN `setindex`				TO ``,
	RENAME COLUMN `name`					TO ``,
	RENAME COLUMN `iconname`				TO ``,
	RENAME COLUMN `ignore_mask`				TO ``,
	RENAME COLUMN `item0`					TO ``,
	RENAME COLUMN `item1`					TO ``,
	RENAME COLUMN `item2`					TO ``,
	RENAME COLUMN `item3`					TO ``,
	RENAME COLUMN `item4`					TO ``,
	RENAME COLUMN `item5`					TO ``,
	RENAME COLUMN `item6`					TO ``,
	RENAME COLUMN `item7`					TO ``,
	RENAME COLUMN `item8`					TO ``,
	RENAME COLUMN `item9`					TO ``,
	RENAME COLUMN `item10`					TO ``,
	RENAME COLUMN `item11`					TO ``,
	RENAME COLUMN `item12`					TO ``,
	RENAME COLUMN `item13`					TO ``,
	RENAME COLUMN `item14`					TO ``,
	RENAME COLUMN `item15`					TO ``,
	RENAME COLUMN `item16`					TO ``,
	RENAME COLUMN `item17`					TO ``,
	RENAME COLUMN `item18`					TO ``,
	RENAME								TO ``;

ALTER TABLE `character_gifts`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `item_guid`				TO ``,
	RENAME COLUMN `entry`					TO ``,
	RENAME COLUMN `flags`					TO ``;

ALTER TABLE `character_glyphs`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `talentGroup`				TO ``,
	RENAME COLUMN `glyph1`					TO ``,
	RENAME COLUMN `glyph2`					TO ``,
	RENAME COLUMN `glyph3`					TO ``,
	RENAME COLUMN `glyph4`					TO ``,
	RENAME COLUMN `glyph5`					TO ``,
	RENAME COLUMN `glyph6`					TO ``;

ALTER TABLE `character_homebind`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `mapId`					TO ``,
	RENAME COLUMN `zoneId`					TO ``,
	RENAME COLUMN `posX`					TO ``,
	RENAME COLUMN `posY`					TO ``,
	RENAME COLUMN `posZ`					TO ``,
	RENAME COLUMN `posO`					TO ``;

ALTER TABLE `character_instance`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `instance`				TO ``,
	RENAME COLUMN `permanent`				TO ``,
	RENAME COLUMN `extended`				TO ``;

ALTER TABLE `character_inventory`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `bag`						TO ``,
	RENAME COLUMN `slot`					TO ``,
	RENAME COLUMN `item`					TO ``;

ALTER TABLE `character_pet`
	RENAME COLUMN `id`						TO ``,
	RENAME COLUMN `entry`					TO ``,
	RENAME COLUMN `owner`					TO ``,
	RENAME COLUMN `modelid`					TO ``,
	RENAME COLUMN `level`					TO ``,
	RENAME COLUMN `exp`						TO ``,
	RENAME COLUMN `Reactstate`				TO ``,
	RENAME COLUMN `name`					TO ``,
	RENAME COLUMN `renamed`					TO ``,
	RENAME COLUMN `slot`					TO ``,
	RENAME COLUMN `curhealth`				TO ``,
	RENAME COLUMN `curmana`					TO ``,
	RENAME COLUMN `curhappiness`			TO ``,
	RENAME COLUMN `savetime`				TO ``,
	RENAME COLUMN `abdata`					TO ``;

ALTER TABLE `character_pet_declinedname`
	RENAME COLUMN `id`						TO ``,
	RENAME COLUMN `owner`					TO ``,
	RENAME COLUMN `genitive`				TO ``,
	RENAME COLUMN `dative`					TO ``,
	RENAME COLUMN `accusative`				TO ``,
	RENAME COLUMN `instrumental`			TO ``,
	RENAME COLUMN `prepositional`			TO ``,
	RENAME								TO ``;

ALTER TABLE `character_queststatus`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `quest`					TO ``,
	RENAME COLUMN `status`					TO ``,
	RENAME COLUMN `explored`				TO ``,
	RENAME COLUMN `timer`					TO ``,
	RENAME COLUMN `mobcount1`				TO ``,
	RENAME COLUMN `mobcount2`				TO ``,
	RENAME COLUMN `mobcount3`				TO ``,
	RENAME COLUMN `mobcount4`				TO ``,
	RENAME COLUMN `itemcount1`				TO ``,
	RENAME COLUMN `itemcount2`				TO ``,
	RENAME COLUMN `itemcount3`				TO ``,
	RENAME COLUMN `itemcount4`				TO ``,
	RENAME COLUMN `itemcount5`				TO ``,
	RENAME COLUMN `itemcount6`				TO ``,
	RENAME COLUMN `playercount`				TO ``,
	RENAME								TO ``;

ALTER TABLE `character_queststatus_daily`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `quest`					TO ``,
	RENAME COLUMN `time`					TO ``,
	RENAME								TO ``;

ALTER TABLE `character_queststatus_monthly`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `quest`					TO ``,
	RENAME								TO ``;

ALTER TABLE `character_queststatus_rewarded`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `quest`					TO ``,
	RENAME COLUMN `active`					TO ``,
	RENAME								TO ``;

ALTER TABLE `character_queststatus_seasonal`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `quest`					TO ``,
	RENAME COLUMN `event`					TO ``,
	RENAME								TO ``;

ALTER TABLE `character_queststatus_weekly`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `quest`					TO ``,
	RENAME								TO ``;

ALTER TABLE `character_reputation`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `faction`					TO ``,
	RENAME COLUMN `standing`				TO ``,
	RENAME COLUMN `flags`					TO ``;

ALTER TABLE `character_settings`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `source`					TO ``,
	RENAME COLUMN `data`					TO ``;

ALTER TABLE `character_skills`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `skill`					TO ``,
	RENAME COLUMN `value`					TO ``,
	RENAME COLUMN `max`						TO ``;

ALTER TABLE `character_social`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `friend`					TO ``,
	RENAME COLUMN `flags`					TO ``,
	RENAME COLUMN `note`					TO ``;

ALTER TABLE `character_spell`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `spell`					TO ``,
	RENAME COLUMN `specMask`				TO ``;

ALTER TABLE `character_spell_cooldown`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `spell`					TO ``,
	RENAME COLUMN `category`				TO ``,
	RENAME COLUMN `item`					TO ``,
	RENAME COLUMN `time`					TO ``,
	RENAME COLUMN `needSend`				TO ``;

ALTER TABLE `character_stats` -- This has a fucking constraint again I'm going to bawl my fucking eyes out.
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `maxhealth`				TO ``,
	RENAME COLUMN `maxpower1`				TO ``,
	RENAME COLUMN `maxpower2`				TO ``,
	RENAME COLUMN `maxpower3`				TO ``,
	RENAME COLUMN `maxpower4`				TO ``,
	RENAME COLUMN `maxpower5`				TO ``,
	RENAME COLUMN `maxpower6`				TO ``,
	RENAME COLUMN `maxpower7`				TO ``,
	RENAME COLUMN `strength`				TO ``,
	RENAME COLUMN `agility`					TO ``,
	RENAME COLUMN `stamina`					TO ``,
	RENAME COLUMN `intellect`				TO ``,
	RENAME COLUMN `spirit`					TO ``,
	RENAME COLUMN `armor`					TO ``,
	RENAME COLUMN `resHoly`					TO ``,
	RENAME COLUMN `resFire`					TO ``,
	RENAME COLUMN `resNature`				TO ``,
	RENAME COLUMN `resFrost`				TO ``,
	RENAME COLUMN `resShadow`				TO ``,
	RENAME COLUMN `resArcane`				TO ``,
	RENAME COLUMN `blockPct`				TO ``,
	RENAME COLUMN `dodgePct`				TO ``,
	RENAME COLUMN `parryPct`				TO ``,
	RENAME COLUMN `critPct`					TO ``,
	RENAME COLUMN `rangedCritPct`			TO ``,
	RENAME COLUMN `spellCritPct`			TO ``,
	RENAME COLUMN `attackPower`				TO ``,
	RENAME COLUMN `rangedAttackPower`		TO ``,
	RENAME COLUMN `spellPower`				TO ``,
	RENAME COLUMN `resilience`				TO ``;

ALTER TABLE `character_talent`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `spell`					TO ``,
	RENAME COLUMN `specMask`				TO ``;

ALTER TABLE `corpse`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `posX`					TO ``,
	RENAME COLUMN `posY`					TO ``,
	RENAME COLUMN `posZ`					TO ``,
	RENAME COLUMN `orientation`				TO ``,
	RENAME COLUMN `mapId`					TO ``,
	RENAME COLUMN `phaseMask`				TO ``,
	RENAME COLUMN `displayId`				TO ``,
	RENAME COLUMN `itemCache`				TO ``,
	RENAME COLUMN `bytes1`					TO ``,
	RENAME COLUMN `bytes2`					TO ``,
	RENAME COLUMN `guildId`					TO ``,
	RENAME COLUMN `flags`					TO ``,
	RENAME COLUMN `dynFlags`				TO ``,
	RENAME COLUMN `time`					TO ``,
	RENAME COLUMN `corpseType`				TO ``,
	RENAME COLUMN `instanceId`				TO ``;

ALTER TABLE `creature_respawn`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `respawnTime`				TO ``,
	RENAME COLUMN `mapId`					TO ``,
	RENAME COLUMN `instanceId`				TO ``;

ALTER TABLE `gameobject_respawn`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `respawnTime`				TO ``,
	RENAME COLUMN `mapId`					TO ``,
	RENAME COLUMN `instanceId`				TO ``;

ALTER TABLE `game_event_condition_save`
	RENAME COLUMN `eventEntry`				TO ``,
	RENAME COLUMN `condition_id`			TO ``,
	RENAME COLUMN `done`					TO ``;

ALTER TABLE `game_event_save`
	RENAME COLUMN `eventEntry`				TO ``,
	RENAME COLUMN `state`					TO ``,
	RENAME COLUMN `next_start`				TO ``;

ALTER TABLE `gm_subsurvey`
	RENAME COLUMN `surveyId`				TO ``,
	RENAME COLUMN `questionId`				TO ``,
	RENAME COLUMN `answer`					TO ``,
	RENAME COLUMN `answerComment`			TO ``;

ALTER TABLE `gm_survey`
	RENAME COLUMN `surveyId`				TO ``,
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `mainSurvey`				TO ``,
	RENAME COLUMN `comment`					TO ``,
	RENAME COLUMN `createTime`				TO ``,
	RENAME COLUMN `maxMMR`					TO ``;

ALTER TABLE `gm_ticket`
	RENAME COLUMN `id`						TO ``,
	RENAME COLUMN `type`					TO ``,
	RENAME COLUMN `playerGuid`				TO ``,
	RENAME COLUMN `name`					TO ``,
	RENAME COLUMN `description`				TO ``,
	RENAME COLUMN `createTime`				TO ``,
	RENAME COLUMN `mapId`					TO ``,
	RENAME COLUMN `posX`					TO ``,
	RENAME COLUMN `posY`					TO ``,
	RENAME COLUMN `posZ`					TO ``,
	RENAME COLUMN `lastModifiedTime`		TO ``,
	RENAME COLUMN `closedBy`				TO ``,
	RENAME COLUMN `assignedTo`				TO ``,
	RENAME COLUMN `comment`					TO ``,
	RENAME COLUMN `response`				TO ``,
	RENAME COLUMN `completed`				TO ``,
	RENAME COLUMN `escalated`				TO ``,
	RENAME COLUMN `viewed`					TO ``,
	RENAME COLUMN `needMoreHelp`			TO ``,
	RENAME COLUMN `resolvedBy`				TO ``;

ALTER TABLE `groups`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `leaderGuid`				TO ``,
	RENAME COLUMN `lootMethod`				TO ``,
	RENAME COLUMN `looterGuid`				TO ``,
	RENAME COLUMN `lootThreshold`			TO ``,
	RENAME COLUMN `icon1`					TO ``,
	RENAME COLUMN `icon2`					TO ``,
	RENAME COLUMN `icon3`					TO ``,
	RENAME COLUMN `icon4`					TO ``,
	RENAME COLUMN `icon5`					TO ``,
	RENAME COLUMN `icon6`					TO ``,
	RENAME COLUMN `icon7`					TO ``,
	RENAME COLUMN `icon8`					TO ``,
	RENAME COLUMN `groupType`				TO ``,
	RENAME COLUMN `difficulty`				TO ``,
	RENAME COLUMN `raidDifficulty`			TO ``,
	RENAME COLUMN `masterLooterGuid`		TO ``;

ALTER TABLE `group_member`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `memberGuid`				TO ``,
	RENAME COLUMN `memberFlags`				TO ``,
	RENAME COLUMN `subgroup`				TO ``,
	RENAME COLUMN `roles`					TO ``;

ALTER TABLE `guild`
	RENAME COLUMN `guildid`					TO ``,
	RENAME COLUMN `name`					TO ``,
	RENAME COLUMN `leaderguid`				TO ``,
	RENAME COLUMN `info`					TO ``,
	RENAME COLUMN `motd`					TO ``,
	RENAME COLUMN `createdate`				TO ``;

ALTER TABLE `guild_bank_eventlog`
	RENAME COLUMN `guildid`					TO ``,
	RENAME COLUMN `LogGuid`					TO ``,
	RENAME COLUMN `TabId`					TO ``,
	RENAME COLUMN `PlayerGuid`				TO ``,
	RENAME COLUMN `DestTabId`				TO ``,
	RENAME									TO ``;

ALTER TABLE `guild_bank_item`
	RENAME COLUMN `guildid`					TO ``,
	RENAME COLUMN `TabId`					TO ``,
	RENAME COLUMN `SlotId`					TO ``,
	RENAME COLUMN `item_guid`				TO ``;

ALTER TABLE `guild_bank_right`
	RENAME COLUMN `guildid`					TO ``,
	RENAME COLUMN `TabId`					TO ``,
	RENAME COLUMN `rid`						TO ``,
	RENAME COLUMN `gbright`					TO ``;

ALTER TABLE `guild_bank_tab`
	RENAME COLUMN `guildid`					TO ``,
	RENAME COLUMN `TabId`					TO ``;

ALTER TABLE `guild_eventlog`
	RENAME COLUMN `guildid`					TO ``,
	RENAME COLUMN `LogGuid`					TO ``,
	RENAME COLUMN `PlayerGuid1`				TO ``,
	RENAME COLUMN `PlayerGuid2`				TO ``,
	RENAME									TO ``;

ALTER TABLE `guild_member`
	RENAME COLUMN `guildid`					TO ``,
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `rank`					TO ``,
	RENAME COLUMN `pnote`					TO ``,
	RENAME COLUMN `offnote`					TO ``;

ALTER TABLE `guild_member_withdraw`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `tab0`					TO ``,
	RENAME COLUMN `tab1`					TO ``,
	RENAME COLUMN `tab2`					TO ``,
	RENAME COLUMN `tab3`					TO ``,
	RENAME COLUMN `tab4`					TO ``,
	RENAME COLUMN `tab5`					TO ``,
	RENAME COLUMN `money`					TO ``;

ALTER TABLE `guild_rank`
	RENAME COLUMN `guildid`					TO ``,
	RENAME COLUMN `rid`						TO ``,
	RENAME COLUMN `rname`					TO ``,
	RENAME COLUMN `rights`					TO ``;

ALTER TABLE `instance`
	RENAME COLUMN `id`						TO ``,
	RENAME COLUMN `map`						TO ``,
	RENAME COLUMN `resettime`				TO ``,
	RENAME COLUMN `difficulty`				TO ``,
	RENAME COLUMN `completedEncounters`		TO ``,
	RENAME COLUMN `data`					TO ``;

ALTER TABLE `instance_reset`
	RENAME COLUMN `mapid`					TO ``,
	RENAME COLUMN `difficulty`				TO ``,
	RENAME COLUMN `resettime`				TO ``;

ALTER TABLE `instance_saved_go_state_data`
	RENAME COLUMN `id`						TO ``,
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `state`					TO ``;

ALTER TABLE `item_instance`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `itemEntry`				TO ``,
	RENAME COLUMN `owner_guid`				TO ``,
	RENAME COLUMN `creatorGuid`				TO ``,
	RENAME COLUMN `giftCreatorGuid`			TO ``,
	RENAME COLUMN `count`					TO ``,
	RENAME COLUMN `duration`				TO ``,
	RENAME COLUMN `charges`					TO ``,
	RENAME COLUMN `flags`					TO ``,
	RENAME COLUMN `enchantments`			TO ``,
	RENAME COLUMN `randomPropertyId`		TO ``,
	RENAME COLUMN `durability`				TO ``,
	RENAME COLUMN `playedTime`				TO ``,
	RENAME COLUMN `text`					TO ``;

ALTER TABLE `item_loot_storage`
	RENAME COLUMN `containerGUID`			TO ``,
	RENAME COLUMN `itemid`					TO ``,
	RENAME COLUMN `count`					TO ``,
	RENAME COLUMN `item_index`				TO ``,
	RENAME COLUMN `randomPropertyId`		TO ``,
	RENAME COLUMN `randomSuffix`			TO ``,
	RENAME COLUMN `follow_loot_rules`		TO ``,
	RENAME COLUMN `freeforall`				TO ``,
	RENAME COLUMN `is_blocked`				TO ``,
	RENAME COLUMN `is_counted`				TO ``,
	RENAME COLUMN `is_underthreshold`		TO ``,
	RENAME COLUMN `needs_quest`				TO ``,
	RENAME COLUMN `conditionLootId`			TO ``;

ALTER TABLE `item_refund_instance`
	RENAME COLUMN `item_guid`				TO ``,
	RENAME COLUMN `player_guid`				TO ``,
	RENAME COLUMN `paidMoney`				TO ``,
	RENAME COLUMN `paidExtendedCost`		TO ``;

ALTER TABLE `item_soulbound_trade_data`
	RENAME COLUMN `itemGuid`				TO ``,
	RENAME COLUMN `allowedPlayers`			TO ``;

ALTER TABLE `lag_reports`
	RENAME COLUMN `reportId`				TO ``,
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `lagType`					TO ``,
	RENAME COLUMN `mapId`					TO ``,
	RENAME COLUMN `posX`					TO ``,
	RENAME COLUMN `posY`					TO ``,
	RENAME COLUMN `posZ`					TO ``,
	RENAME COLUMN `latency`					TO ``,
	RENAME COLUMN `createTime`				TO ``;

ALTER TABLE `lfg_data`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `dungeon`					TO ``,
	RENAME COLUMN `state`					TO ``;

ALTER TABLE `log_arena_fights`
	RENAME COLUMN `fight_id`				TO ``,
	RENAME COLUMN `time`					TO ``,
	RENAME COLUMN `type`					TO ``,
	RENAME COLUMN `duration`				TO ``,
	RENAME COLUMN `winner`					TO ``,
	RENAME COLUMN `loser`					TO ``,
	RENAME COLUMN `winner_tr`				TO ``,
	RENAME COLUMN `winner_mmr`				TO ``,
	RENAME COLUMN `winner_tr_change`		TO ``,
	RENAME COLUMN `loser_tr`				TO ``,
	RENAME COLUMN `loser_mmr`				TO ``,
	RENAME COLUMN `loser_tr_change`			TO ``,
	RENAME COLUMN `currOnline`				TO ``;

ALTER TABLE `log_arena_memberstats`
	RENAME COLUMN `fight_id`				TO ``,
	RENAME COLUMN `member_id`				TO ``,
	RENAME COLUMN `name`					TO ``,
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `team`					TO ``,
	RENAME COLUMN `account`					TO ``,
	RENAME COLUMN `ip`						TO ``,
	RENAME COLUMN `damage`					TO ``,
	RENAME COLUMN `heal`					TO ``,
	RENAME COLUMN `kblows`					TO ``,
	RENAME								TO ``;

ALTER TABLE `log_encounter`
	RENAME COLUMN `time`					TO ``,
	RENAME COLUMN `map`						TO ``,
	RENAME COLUMN `difficulty`				TO ``,
	RENAME COLUMN `creditType`				TO ``,
	RENAME COLUMN `creditEntry`				TO ``,
	RENAME COLUMN `playersInfo`				TO ``;

ALTER TABLE `log_money`
	RENAME COLUMN `sender_acc`				TO ``,
	RENAME COLUMN `sender_guid`				TO ``,
	RENAME COLUMN `sender_name`				TO ``,
	RENAME COLUMN `sender_ip`				TO ``,
	RENAME COLUMN `receiver_acc`			TO ``,
	RENAME COLUMN `receiver_name`			TO ``,
	RENAME COLUMN `money`					TO ``,
	RENAME COLUMN `topic`					TO ``,
	RENAME COLUMN `date`					TO ``,
	RENAME COLUMN `type`					TO ``;

ALTER TABLE `mail`
	RENAME COLUMN `id`						TO ``,
	RENAME COLUMN `messageType`				TO ``,
	RENAME COLUMN `stationery`				TO ``,
	RENAME COLUMN `mailTemplateId`			TO ``,
	RENAME COLUMN `sender`					TO ``,
	RENAME COLUMN `receiver`				TO ``,
	RENAME COLUMN `subject`					TO ``,
	RENAME COLUMN `body`					TO ``,
	RENAME COLUMN `has_items`				TO ``,
	RENAME COLUMN `expire_time`				TO ``,
	RENAME COLUMN `deliver_time`			TO ``,
	RENAME COLUMN `money`					TO ``,
	RENAME COLUMN `cod`						TO ``,
	RENAME COLUMN `checked`					TO ``;

ALTER TABLE `mail_items`
	RENAME COLUMN `mail_id`					TO ``,
	RENAME COLUMN `item_guid`				TO ``,
	RENAME COLUMN `receiver`				TO ``;

ALTER TABLE `mail_server_character`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `mailId`					TO ``;

ALTER TABLE `mail_server_template`
	RENAME COLUMN `id`						TO ``,
	RENAME COLUMN `reqLevel`				TO ``,
	RENAME COLUMN `reqPlayTime`				TO ``,
	RENAME COLUMN `moneyA`					TO ``,
	RENAME COLUMN `moneyH`					TO ``,
	RENAME COLUMN `itemA`					TO ``,
	RENAME COLUMN `itemCountA`				TO ``,
	RENAME COLUMN `itemH`					TO ``,
	RENAME COLUMN `itemCountH`				TO ``,
	RENAME COLUMN `subject`					TO ``,
	RENAME COLUMN `body`					TO ``,
	RENAME COLUMN `active`					TO ``;

ALTER TABLE `petition`
	RENAME COLUMN `ownerguid`				TO ``,
	RENAME COLUMN `petitionguid`			TO ``,
	RENAME COLUMN `name`					TO ``,
	RENAME COLUMN `type`					TO ``;

ALTER TABLE `petition_sign`
	RENAME COLUMN `ownerguid`				TO ``,
	RENAME COLUMN `petitionguid`			TO ``,
	RENAME COLUMN `playerguid`				TO ``,
	RENAME COLUMN `player_account`			TO ``,
	RENAME COLUMN `type`					TO ``;

ALTER TABLE `pet_aura`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `casterGuid`				TO ``,
	RENAME COLUMN `spell`					TO ``,
	RENAME COLUMN `effectMask`				TO ``,
	RENAME COLUMN `recalculateMask`			TO ``,
	RENAME COLUMN `stackCount`				TO ``,
	RENAME COLUMN `amount0`					TO ``,
	RENAME COLUMN `amount1`					TO ``,
	RENAME COLUMN `amount2`					TO ``,
	RENAME COLUMN `base_amount0`			TO ``,
	RENAME COLUMN `base_amount1`			TO ``,
	RENAME COLUMN `base_amount2`			TO ``,
	RENAME COLUMN `maxDuration`				TO ``,
	RENAME COLUMN `remainTime`				TO ``,
	RENAME COLUMN `remainCharges`			TO ``;

ALTER TABLE `pet_spell`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `spell`					TO ``,
	RENAME COLUMN `active`					TO ``;

ALTER TABLE `pet_spell_cooldown`
	RENAME COLUMN `guid`					TO ``,
	RENAME COLUMN `spell`					TO ``,
	RENAME COLUMN `category`				TO ``,
	RENAME COLUMN `time`					TO ``;

ALTER TABLE `pool_quest_save`
	RENAME COLUMN `pool_id`					TO ``,
	RENAME COLUMN `quest_id`				TO ``;

ALTER TABLE `pvpstats_battlegrounds`
	RENAME COLUMN `id`						TO ``,
	RENAME COLUMN `winner_faction`			TO ``,
	RENAME COLUMN `bracket_id`				TO ``,
	RENAME COLUMN `type`					TO ``,
	RENAME COLUMN `date`					TO ``,
	RENAME								TO ``;

ALTER TABLE `pvpstats_players`
	RENAME COLUMN `battleground_id`			TO ``,
	RENAME COLUMN `character_guid`			TO ``,
	RENAME COLUMN `winner`					TO ``,
	RENAME COLUMN `score_killing_blows`		TO ``,
	RENAME COLUMN `score_deaths`			TO ``,
	RENAME COLUMN `score_honorable_kills`	TO ``,
	RENAME COLUMN `score_bonus_honor`		TO ``,
	RENAME COLUMN `score_damage_done`		TO ``,
	RENAME COLUMN `score_healing_done`		TO ``,
	RENAME COLUMN `attr_1`					TO ``,
	RENAME COLUMN `attr_2`					TO ``,
	RENAME COLUMN `attr_3`					TO ``,
	RENAME COLUMN `attr_4`					TO ``,
	RENAME COLUMN `attr_5`					TO ``,
	RENAME								TO ``;

ALTER TABLE `quest_tracker`
	RENAME COLUMN `id`						TO ``,
	RENAME COLUMN `character_guid`			TO ``,
	RENAME COLUMN `quest_accept_time`		TO ``,
	RENAME COLUMN `quest_complete_time`		TO ``,
	RENAME COLUMN `quest_abandon_time`		TO ``,
	RENAME COLUMN `completed_by_gm`			TO ``,
	RENAME COLUMN `core_hash`				TO ``,,
	RENAME COLUMN `core_revision`			TO ``;

ALTER TABLE `recovery_item`
	RENAME COLUMN `Id`						TO ``,
	RENAME COLUMN `Guid`					TO ``;

ALTER TABLE `reserved_name`
	RENAME COLUMN `name`					TO ``;

ALTER TABLE `updates`
	RENAME COLUMN `name`					TO ``,
	RENAME COLUMN `hash`					TO ``,
	RENAME COLUMN `state`					TO ``,
	RENAME COLUMN `timestamp`				TO ``,
	RENAME COLUMN `speed`					TO ``;

ALTER TABLE `updates_include`
	RENAME COLUMN `path`					TO ``,
	RENAME COLUMN `state`					TO ``;

ALTER TABLE `warden_action`
	RENAME COLUMN `wardenId`				TO ``,
	RENAME COLUMN `action`					TO ``;

ALTER TABLE `worldstates`
	RENAME COLUMN `entry`					TO ``,
	RENAME COLUMN `value`					TO ``,
	RENAME COLUMN `comment`					TO ``,
	RENAME								TO ``;
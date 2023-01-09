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
	RENAME COLUMN `type`					TO `Type`,
	RENAME COLUMN `dungeon`					TO `Dungeon`,
	RENAME COLUMN `eventtime`				TO `EventTime1`,
	RENAME COLUMN `flags`					TO `Flags`,
	RENAME COLUMN `time2`					TO `EventTime2`;
ALTER TABLE `calendar_invites`
	RENAME COLUMN `id`						TO `ID`,
	RENAME COLUMN `event`					TO `Event`,
	RENAME COLUMN `invitee`					TO `Invitee`,
	RENAME COLUMN `sender`					TO `Sender`,
	RENAME COLUMN `status`					TO `Status`,
	RENAME COLUMN `statustime`				TO `StatusTime`,
	RENAME COLUMN `rank`					TO `Rank`,
	RENAME COLUMN `text`					TO `Text`;
ALTER TABLE `channels`
	RENAME COLUMN `channelId`				TO `ChannelID`,
	RENAME COLUMN `name`					TO `Name`,
	RENAME COLUMN `team`					TO `Team`,
	RENAME COLUMN `announce`				TO `Announce`,
	RENAME COLUMN `ownership`				TO `Ownership`,
	RENAME COLUMN `password`				TO `Password`,
	RENAME COLUMN `lastUsed`				TO `LastUsed`;
ALTER TABLE `channels_bans`
	RENAME COLUMN `channelId`				TO `ChannelID`,
	RENAME COLUMN `playerGUID`				TO `PlayerGUID`,
	RENAME COLUMN `banTime`					TO `BanTime`;
ALTER TABLE `channels_rights`
	RENAME COLUMN `name`					TO `Name`,
	RENAME COLUMN `flags`					TO `Flags`,
	RENAME COLUMN `speakdelay`				TO `SpeakDelay`,
	RENAME COLUMN `joinmessage`				TO `JoinMessage`,
	RENAME COLUMN `delaymessage`			TO `DelayMessage`,
	RENAME COLUMN `moderators`				TO `Moderators`;
ALTER TABLE `characters`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `account`					TO `Account`,
	RENAME COLUMN `name`					TO `Name`,
	RENAME COLUMN `race`					TO `Race`,
	RENAME COLUMN `class`					TO `Class`,
	RENAME COLUMN `gender`					TO `Gender`,
	RENAME COLUMN `level`					TO `Level`,
	RENAME COLUMN `xp`						TO `XP`,
	RENAME COLUMN `money`					TO `Money`,
	RENAME COLUMN `skin`					TO `Skin`,
	RENAME COLUMN `face`					TO `Face`,
	RENAME COLUMN `hairStyle`				TO `HairStyle`,
	RENAME COLUMN `hairColor`				TO `HairColor`,
	RENAME COLUMN `facialStyle`				TO `FacialStyle`,
	RENAME COLUMN `bankSlots`				TO `BankSlots`,
	RENAME COLUMN `restState`				TO `RestState`,
	RENAME COLUMN `playerFlags`				TO `PlayerFlags`,
	RENAME COLUMN `position_x`				TO `PositionX`,
	RENAME COLUMN `position_y`				TO `PositionY`,
	RENAME COLUMN `position_z`				TO `PositionZ`,
	RENAME COLUMN `map`						TO `Map`,
	RENAME COLUMN `instance_id`				TO `InstanceID`,
	RENAME COLUMN `instance_mode_mask`		TO `InstanceModeMask`,
	RENAME COLUMN `orientation`				TO `Orientation`,
	RENAME COLUMN `taximask`				TO `TaxiMask`,
	RENAME COLUMN `online`					TO `Online`,
	RENAME COLUMN `cinematic`				TO `Cinematic`,
	RENAME COLUMN `totaltime`				TO `TotalTime`,
	RENAME COLUMN `leveltime`				TO `LevelTime`,
	RENAME COLUMN `logout_time`				TO `LogoutTime`,
	RENAME COLUMN `is_logout_resting`		TO `IsLogoutResting`,
	RENAME COLUMN `rest_bonus`				TO `RestBonus`,
	RENAME COLUMN `resettalents_cost`		TO `ResetTalentsCost`,
	RENAME COLUMN `resettalents_time`		TO `ResetTalentsTime`,
	RENAME COLUMN `trans_x`					TO `TransportX`,
	RENAME COLUMN `trans_y`					TO `TransportY`,
	RENAME COLUMN `trans_z`					TO `TransportZ`,
	RENAME COLUMN `trans_o`					TO `TransportO`,
	RENAME COLUMN `transguid`				TO `TransportGUID`,
	RENAME COLUMN `extra_flags`				TO `ExtraFlags`,
	RENAME COLUMN `stable_slots`			TO `StableSlots`,
	RENAME COLUMN `at_login`				TO `AtLogin`,
	RENAME COLUMN `zone`					TO `Zone`,
	RENAME COLUMN `death_expire_time`		TO `DeathExpireTime`,
	RENAME COLUMN `taxi_path`				TO `TaxiPath`,
	RENAME COLUMN `arenaPoints`				TO `ArenaPoints`,
	RENAME COLUMN `totalHonorPoints`		TO `TotalHonorPoints`,
	RENAME COLUMN `todayHonorPoints`		TO `TodayHonorPoints`,
	RENAME COLUMN `yesterdayHonorPoints`	TO `YesterdayHonorPoints`,
	RENAME COLUMN `totalKills`				TO `TotalKills`,
	RENAME COLUMN `todayKills`				TO `TodayKills`,
	RENAME COLUMN `yesterdayKills`			TO `YesterdayKills`,
	RENAME COLUMN `chosenTitle`				TO `ChosenTitle`,
	RENAME COLUMN `knownCurrencies`			TO `KnownCurrencies`,
	RENAME COLUMN `watchedFaction`			TO `WatchedFaction`,
	RENAME COLUMN `drunk`					TO `Drunk`,
	RENAME COLUMN `health`					TO `Health`,
	RENAME COLUMN `power1`					TO `Power1`,
	RENAME COLUMN `power2`					TO `Power2`,
	RENAME COLUMN `power3`					TO `Power3`,
	RENAME COLUMN `power4`					TO `Power4`,
	RENAME COLUMN `power5`					TO `Power5`,
	RENAME COLUMN `power6`					TO `Power6`,
	RENAME COLUMN `power7`					TO `Power7`,
	RENAME COLUMN `latency`					TO `Latency`,
	RENAME COLUMN `talentGroupsCount`		TO `TalentGroupsCount`,
	RENAME COLUMN `activeTalentGroup`		TO `ActiveTalentGroup`,
	RENAME COLUMN `exploredZones`			TO `ExploredZones`,
	RENAME COLUMN `equipmentCache`			TO `EquipmentCache`,
	RENAME COLUMN `ammoId`					TO `AmmoID`,
	RENAME COLUMN `knownTitles`				TO `KnownTitles`,
	RENAME COLUMN `actionBars`				TO `ActionBars`,
	RENAME COLUMN `grantableLevels`			TO `GrantableLevels`,
	RENAME COLUMN `order`					TO `Order`,
	RENAME COLUMN `creation_date`			TO `CreationDate`,
	RENAME COLUMN `deleteInfos_Account`		TO `DeleteInfoAccount`,
	RENAME COLUMN `deleteInfos_Name`		TO `DeleteInfoName`,
	RENAME COLUMN `deleteDate`				TO `DeleteDate`,
	RENAME COLUMN `innTriggerId`			TO `InnTriggerID`;
ALTER TABLE `character_account_data`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `type`					TO `Type`,
	RENAME COLUMN `time`					TO `Time`,
	RENAME COLUMN `data`					TO `Data`;
ALTER TABLE `character_achievement`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `achievement`				TO `Achievement`,
	RENAME COLUMN `date`					TO `Date`;
ALTER TABLE `character_achievement_progress`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `criteria`				TO `Criteria`,
	RENAME COLUMN `counter`					TO `Counter`,
	RENAME COLUMN `date`					TO `Data`;
ALTER TABLE `character_action`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `spec`					TO `Spec`,
	RENAME COLUMN `button`					TO `Button`,
	RENAME COLUMN `action`					TO `Action`,
	RENAME COLUMN `type`					TO `Type`;
ALTER TABLE `character_arena_stats`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `slot`					TO `Slot`,
	RENAME COLUMN `matchMakerRating`		TO `MatchmakerRating`,
	RENAME COLUMN `maxMMR`					TO `MaxMMR`;
ALTER TABLE `character_aura`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `casterGuid`				TO `CasterGUID`,
	RENAME COLUMN `itemGuid`				TO `ItemGUID`,
	RENAME COLUMN `spell`					TO `Spell`,
	RENAME COLUMN `effectMask`				TO `EffectMask`,
	RENAME COLUMN `recalculateMask`			TO `RecalculateMask`,
	RENAME COLUMN `stackCount`				TO `StackCount`,
	RENAME COLUMN `amount0`					TO `Amount1`,
	RENAME COLUMN `amount1`					TO `Amount2`,
	RENAME COLUMN `amount2`					TO `Amount3`,
	RENAME COLUMN `base_amount0`			TO `BaseAmount1`,
	RENAME COLUMN `base_amount1`			TO `BaseAmount2`,
	RENAME COLUMN `base_amount2`			TO `BaseAmount3`,
	RENAME COLUMN `maxDuration`				TO `MaxDuration`,
	RENAME COLUMN `remainTime`				TO `RemainTime`,
	RENAME COLUMN `remainCharges`			TO `RemainCharges`;
ALTER TABLE `character_banned`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `bandate`					TO `BanDate`,
	RENAME COLUMN `unbandate`				TO `UnbanDate`,
	RENAME COLUMN `bannedby`				TO `BannedBy`,
	RENAME COLUMN `banreason`				TO `BanReason`,
	RENAME COLUMN `active`					TO `Active`;
ALTER TABLE `character_battleground_random`
	RENAME COLUMN `guid`					TO `GUID`;
ALTER TABLE `character_brew_of_the_month`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `lastEventId`				TO `LastEventID`;
ALTER TABLE `character_declinedname`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `genitive`				TO `Genitive`,
	RENAME COLUMN `dative`					TO `Dative`,
	RENAME COLUMN `accusative`				TO `Accusative`,
	RENAME COLUMN `instrumental`			TO `Instrumental`,
	RENAME COLUMN `prepositional`			TO `Prepositional`,
	RENAME								TO `character_declined_name`;
ALTER TABLE `character_entry_point`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `joinX`					TO `JoinX`,
	RENAME COLUMN `joinY`					TO `JoinY`,
	RENAME COLUMN `joinZ`					TO `JoinZ`,
	RENAME COLUMN `joinO`					TO `JoinO`,
	RENAME COLUMN `joinMapId`				TO `JoinMapID`,
	RENAME COLUMN `taxiPath0`				TO `TaxiPath1`,
	RENAME COLUMN `taxiPath1`				TO `TaxiPath2`,
	RENAME COLUMN `mountSpell`				TO `MountSpell`;
ALTER TABLE `character_equipmentsets`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `setguid`					TO `SetGUID`,
	RENAME COLUMN `setindex`				TO `SetIndex`,
	RENAME COLUMN `name`					TO `Name`,
	RENAME COLUMN `iconname`				TO `IconName`,
	RENAME COLUMN `ignore_mask`				TO `IgnoreMask`,
	RENAME COLUMN `item0`					TO `Item0`,
	RENAME COLUMN `item1`					TO `Item1`,
	RENAME COLUMN `item2`					TO `Item2`,
	RENAME COLUMN `item3`					TO `Item3`,
	RENAME COLUMN `item4`					TO `Item4`,
	RENAME COLUMN `item5`					TO `Item5`,
	RENAME COLUMN `item6`					TO `Item6`,
	RENAME COLUMN `item7`					TO `Item7`,
	RENAME COLUMN `item8`					TO `Item8`,
	RENAME COLUMN `item9`					TO `Item9`,
	RENAME COLUMN `item10`					TO `Item10`,
	RENAME COLUMN `item11`					TO `Item11`,
	RENAME COLUMN `item12`					TO `Item12`,
	RENAME COLUMN `item13`					TO `Item13`,
	RENAME COLUMN `item14`					TO `Item14`,
	RENAME COLUMN `item15`					TO `Item15`,
	RENAME COLUMN `item16`					TO `Item16`,
	RENAME COLUMN `item17`					TO `Item17`,
	RENAME COLUMN `item18`					TO `Item18`,
	RENAME								TO `character_equipment_sets`;
ALTER TABLE `character_gifts`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `item_guid`				TO `ItemGUID`,
	RENAME COLUMN `entry`					TO `Entry`,
	RENAME COLUMN `flags`					TO `Flags`;
ALTER TABLE `character_glyphs`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `talentGroup`				TO `TalentGroup`,
	RENAME COLUMN `glyph1`					TO `Glyph1`,
	RENAME COLUMN `glyph2`					TO `Glyph2`,
	RENAME COLUMN `glyph3`					TO `Glyph3`,
	RENAME COLUMN `glyph4`					TO `Glyph4`,
	RENAME COLUMN `glyph5`					TO `Glyph5`,
	RENAME COLUMN `glyph6`					TO `Glyph6`;
ALTER TABLE `character_homebind`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `mapId`					TO `MapID`,
	RENAME COLUMN `zoneId`					TO `ZoneID`,
	RENAME COLUMN `posX`					TO `PositionX`,
	RENAME COLUMN `posY`					TO `PositionY`,
	RENAME COLUMN `posZ`					TO `PositionZ`,
	RENAME COLUMN `posO`					TO `Orientation`;
ALTER TABLE `character_instance`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `instance`				TO `Instance`,
	RENAME COLUMN `permanent`				TO `Permanent`,
	RENAME COLUMN `extended`				TO `Extended`;
ALTER TABLE `character_inventory`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `bag`						TO `Bag`,
	RENAME COLUMN `slot`					TO `Slot`,
	RENAME COLUMN `item`					TO `Item`;
ALTER TABLE `character_pet`
	RENAME COLUMN `id`						TO `ID`,
	RENAME COLUMN `entry`					TO `Entry`,
	RENAME COLUMN `owner`					TO `Owner`,
	RENAME COLUMN `modelid`					TO `ModelID`,
	RENAME COLUMN `level`					TO `Level`,
	RENAME COLUMN `exp`						TO `XP`,
	RENAME COLUMN `Reactstate`				TO `ReactState`,
	RENAME COLUMN `name`					TO `Name`,
	RENAME COLUMN `renamed`					TO `Renamed`,
	RENAME COLUMN `slot`					TO `Slot`,
	RENAME COLUMN `curhealth`				TO `CurrentHealth`,
	RENAME COLUMN `curmana`					TO `CurrentMana`,
	RENAME COLUMN `curhappiness`			TO `CurrentHappiness`,
	RENAME COLUMN `savetime`				TO `SaveTime`,
	RENAME COLUMN `abdata`					TO `ActionBar`;
ALTER TABLE `character_pet_declinedname`
	RENAME COLUMN `id`						TO `ID`,
	RENAME COLUMN `owner`					TO `Owner`,
	RENAME COLUMN `genitive`				TO `Genitive`,
	RENAME COLUMN `dative`					TO `Dative`,
	RENAME COLUMN `accusative`				TO `Accusative`,
	RENAME COLUMN `instrumental`			TO `Instrumental`,
	RENAME COLUMN `prepositional`			TO `Prepositional`,
	RENAME								TO `character_pet_declined_name`;
ALTER TABLE `character_queststatus`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `quest`					TO `Quest`,
	RENAME COLUMN `status`					TO `Status`,
	RENAME COLUMN `explored`				TO `Explored`,
	RENAME COLUMN `timer`					TO `Timer`,
	RENAME COLUMN `mobcount1`				TO `MobCount1`,
	RENAME COLUMN `mobcount2`				TO `MobCount2`,
	RENAME COLUMN `mobcount3`				TO `MobCount3`,
	RENAME COLUMN `mobcount4`				TO `MobCount4`,
	RENAME COLUMN `itemcount1`				TO `ItemCount1`,
	RENAME COLUMN `itemcount2`				TO `ItemCount2`,
	RENAME COLUMN `itemcount3`				TO `ItemCount3`,
	RENAME COLUMN `itemcount4`				TO `ItemCount4`,
	RENAME COLUMN `itemcount5`				TO `ItemCount5`,
	RENAME COLUMN `itemcount6`				TO `ItemCount6`,
	RENAME COLUMN `playercount`				TO `PlayerCount`,
	RENAME								TO `character_quest_status`;
ALTER TABLE `character_queststatus_daily`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `quest`					TO `Quest`,
	RENAME COLUMN `time`					TO `Time`,
	RENAME								TO `character_quest_status_daily`;
ALTER TABLE `character_queststatus_monthly`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `quest`					TO `Quest`,
	RENAME								TO `character_quest_status_monthly`;
ALTER TABLE `character_queststatus_rewarded`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `quest`					TO `Quest`,
	RENAME COLUMN `active`					TO `Active`,
	RENAME								TO `character_quest_status_rewarded`;
ALTER TABLE `character_queststatus_seasonal`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `quest`					TO `Quest`,
	RENAME COLUMN `event`					TO `Event`,
	RENAME								TO `character_quest_status_seasonal`;
ALTER TABLE `character_queststatus_weekly`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `quest`					TO `Quest`,
	RENAME								TO `character_quest_status_weekly`;
ALTER TABLE `character_reputation`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `faction`					TO `Faction`,
	RENAME COLUMN `standing`				TO `Standing`,
	RENAME COLUMN `flags`					TO `Flags`;
ALTER TABLE `character_settings`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `source`					TO `Source`,
	RENAME COLUMN `data`					TO `Data`;
ALTER TABLE `character_skills`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `skill`					TO `Skill`,
	RENAME COLUMN `value`					TO `Value`,
	RENAME COLUMN `max`						TO `Max`;
ALTER TABLE `character_social`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `friend`					TO `Friend`,
	RENAME COLUMN `flags`					TO `Flags`,
	RENAME COLUMN `note`					TO `Note`;
ALTER TABLE `character_spell`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `spell`					TO `Spell`,
	RENAME COLUMN `specMask`				TO `SpecMask`;
ALTER TABLE `character_spell_cooldown`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `spell`					TO `Spell`,
	RENAME COLUMN `category`				TO `Category`,
	RENAME COLUMN `item`					TO `Item`,
	RENAME COLUMN `time`					TO `Time`,
	RENAME COLUMN `needSend`				TO `NeedSend`;
ALTER TABLE `character_stats`
	DROP CONSTRAINT `character_stats_chk_1`,
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `maxhealth`				TO `MaxHealth`,
	RENAME COLUMN `maxpower1`				TO `MaxPower1`,
	RENAME COLUMN `maxpower2`				TO `MaxPower2`,
	RENAME COLUMN `maxpower3`				TO `MaxPower3`,
	RENAME COLUMN `maxpower4`				TO `MaxPower4`,
	RENAME COLUMN `maxpower5`				TO `MaxPower5`,
	RENAME COLUMN `maxpower6`				TO `MaxPower6`,
	RENAME COLUMN `maxpower7`				TO `MaxPower7`,
	RENAME COLUMN `strength`				TO `Strength`,
	RENAME COLUMN `agility`					TO `Agility`,
	RENAME COLUMN `stamina`					TO `Stamina`,
	RENAME COLUMN `intellect`				TO `Intellect`,
	RENAME COLUMN `spirit`					TO `Spirit`,
	RENAME COLUMN `armor`					TO `Armor`,
	RENAME COLUMN `resHoly`					TO `ResistanceHoly`,
	RENAME COLUMN `resFire`					TO `ResistanceFire`,
	RENAME COLUMN `resNature`				TO `ResistanceNature`,
	RENAME COLUMN `resFrost`				TO `ResistanceFrost`,
	RENAME COLUMN `resShadow`				TO `ResistanceShadow`,
	RENAME COLUMN `resArcane`				TO `ResistanceArcane`,
	RENAME COLUMN `blockPct`				TO `BlockPercent`,
	RENAME COLUMN `dodgePct`				TO `DodgePercent`,
	RENAME COLUMN `parryPct`				TO `ParryPercent`,
	RENAME COLUMN `critPct`					TO `CriticalPercent`,
	RENAME COLUMN `rangedCritPct`			TO `RangedCriticalPercent`,
	RENAME COLUMN `spellCritPct`			TO `SpellCriticalPercent`,
	RENAME COLUMN `attackPower`				TO `AttackPower`,
	RENAME COLUMN `rangedAttackPower`		TO `RangedAttackPower`,
	RENAME COLUMN `spellPower`				TO `SpellPower`,
	RENAME COLUMN `resilience`				TO `Resilience`,
	ADD CONSTRAINT `character_stats_chk_1` CHECK ((`BlockPercent` >= 0) and (`DodgePercent` >= 0) and (`ParryPercent` >= 0) and (`CriticalPercent` >= 0) and (`RangedCriticalPercent` >= 0) and (`SpellCriticalPercent` >= 0));
ALTER TABLE `character_talent`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `spell`					TO `Spell`,
	RENAME COLUMN `specMask`				TO `SpecMask`;
ALTER TABLE `corpse`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `posX`					TO `PositionX`,
	RENAME COLUMN `posY`					TO `PositionY`,
	RENAME COLUMN `posZ`					TO `PositionZ`,
	RENAME COLUMN `orientation`				TO `Orientation`,
	RENAME COLUMN `mapId`					TO `MapID`,
	RENAME COLUMN `phaseMask`				TO `PhaseMask`,
	RENAME COLUMN `displayId`				TO `DisplayID`,
	RENAME COLUMN `itemCache`				TO `ItemCache`,
	RENAME COLUMN `bytes1`					TO `Bytes1`,
	RENAME COLUMN `bytes2`					TO `Bytes2`,
	RENAME COLUMN `guildId`					TO `GuildID`,
	RENAME COLUMN `flags`					TO `Flags`,
	RENAME COLUMN `dynFlags`				TO `DynamicFlags`,
	RENAME COLUMN `time`					TO `Time`,
	RENAME COLUMN `corpseType`				TO `CorpseType`,
	RENAME COLUMN `instanceId`				TO `InstanceID`;
ALTER TABLE `creature_respawn`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `respawnTime`				TO `RespawnTime`,
	RENAME COLUMN `mapId`					TO `MapID`,
	RENAME COLUMN `instanceId`				TO `InstanceID`;
ALTER TABLE `gameobject_respawn`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `respawnTime`				TO `RespawnTime`,
	RENAME COLUMN `mapId`					TO `MapID`,
	RENAME COLUMN `instanceId`				TO `InstanceID`;
ALTER TABLE `game_event_condition_save`
	RENAME COLUMN `eventEntry`				TO `EventEntry`,
	RENAME COLUMN `condition_id`			TO `ConditionID`,
	RENAME COLUMN `done`					TO `Done`;
ALTER TABLE `game_event_save`
	RENAME COLUMN `eventEntry`				TO `EventEntry`,
	RENAME COLUMN `state`					TO `State`,
	RENAME COLUMN `next_start`				TO `NextStart`;
ALTER TABLE `gm_subsurvey`
	RENAME COLUMN `surveyId`				TO `SurveyID`,
	RENAME COLUMN `questionId`				TO `QuestionID`,
	RENAME COLUMN `answer`					TO `Answer`,
	RENAME COLUMN `answerComment`			TO `AnswerComment`;
ALTER TABLE `gm_survey`
	RENAME COLUMN `surveyId`				TO `SurveyID`,
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `mainSurvey`				TO `MainSurvey`,
	RENAME COLUMN `comment`					TO `Comment`,
	RENAME COLUMN `createTime`				TO `CreateTime`,
	RENAME COLUMN `maxMMR`					TO `MaxMMR`;
ALTER TABLE `gm_ticket`
	RENAME COLUMN `id`						TO `ID`,
	RENAME COLUMN `type`					TO `Type`,
	RENAME COLUMN `playerGuid`				TO `PlayerGUID`,
	RENAME COLUMN `name`					TO `Name`,
	RENAME COLUMN `description`				TO `Description`,
	RENAME COLUMN `createTime`				TO `CreateTime`,
	RENAME COLUMN `mapId`					TO `MapID`,
	RENAME COLUMN `posX`					TO `PositionX`,
	RENAME COLUMN `posY`					TO `PositionY`,
	RENAME COLUMN `posZ`					TO `PositionZ`,
	RENAME COLUMN `lastModifiedTime`		TO `LasModifiedTime`,
	RENAME COLUMN `closedBy`				TO `ClosedBy`,
	RENAME COLUMN `assignedTo`				TO `AssignedTo`,
	RENAME COLUMN `comment`					TO `Comment`,
	RENAME COLUMN `response`				TO `Response`,
	RENAME COLUMN `completed`				TO `Completed`,
	RENAME COLUMN `escalated`				TO `Escalated`,
	RENAME COLUMN `viewed`					TO `Viewed`,
	RENAME COLUMN `needMoreHelp`			TO `NeedMoreHelp`,
	RENAME COLUMN `resolvedBy`				TO `ResolvedBy`;
ALTER TABLE `groups`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `leaderGuid`				TO `LeaderGUID`,
	RENAME COLUMN `lootMethod`				TO `LootMethod`,
	RENAME COLUMN `looterGuid`				TO `LooterGUID`,
	RENAME COLUMN `lootThreshold`			TO `LootThreshold`,
	RENAME COLUMN `icon1`					TO `Icon1`,
	RENAME COLUMN `icon2`					TO `Icon2`,
	RENAME COLUMN `icon3`					TO `Icon3`,
	RENAME COLUMN `icon4`					TO `Icon4`,
	RENAME COLUMN `icon5`					TO `Icon5`,
	RENAME COLUMN `icon6`					TO `Icon6`,
	RENAME COLUMN `icon7`					TO `Icon7`,
	RENAME COLUMN `icon8`					TO `Icon8`,
	RENAME COLUMN `groupType`				TO `GroupType`,
	RENAME COLUMN `difficulty`				TO `Difficulty`,
	RENAME COLUMN `raidDifficulty`			TO `RaidDifficulty`,
	RENAME COLUMN `masterLooterGuid`		TO `MasterLooterGUID`;
ALTER TABLE `group_member`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `memberGuid`				TO `MemberGUID`,
	RENAME COLUMN `memberFlags`				TO `MemberFlags`,
	RENAME COLUMN `subgroup`				TO `Subgroup`,
	RENAME COLUMN `roles`					TO `Roles`;
ALTER TABLE `guild`
	RENAME COLUMN `guildid`					TO `GuildID`,
	RENAME COLUMN `name`					TO `Name`,
	RENAME COLUMN `leaderguid`				TO `LeaderGUID`,
	RENAME COLUMN `info`					TO `Info`,
	RENAME COLUMN `motd`					TO `MOTD`,
	RENAME COLUMN `createdate`				TO `CreateDate`;
ALTER TABLE `guild_bank_eventlog`
	RENAME COLUMN `guildid`					TO `GuildID`,
	RENAME COLUMN `LogGuid`					TO `LogGUID`,
	RENAME COLUMN `TabId`					TO `TabID`,
	RENAME COLUMN `PlayerGuid`				TO `PlayerGUID`,
	RENAME COLUMN `DestTabId`				TO `DestinationTabID`,
	RENAME								TO `guild_bank_event_log`;
ALTER TABLE `guild_bank_item`
	RENAME COLUMN `guildid`					TO `GuildID`,
	RENAME COLUMN `TabId`					TO `TabID`,
	RENAME COLUMN `SlotId`					TO `SlotID`,
	RENAME COLUMN `item_guid`				TO `ItemGUID`;
ALTER TABLE `guild_bank_right`
	RENAME COLUMN `guildid`					TO `GuildID`,
	RENAME COLUMN `TabId`					TO `TabID`,
	RENAME COLUMN `rid`						TO `RankID`,
	RENAME COLUMN `gbright`					TO `RightsFlags`,
	RENAME								TO `guild_bank_rights`;
ALTER TABLE `guild_bank_tab`
	RENAME COLUMN `guildid`					TO `GuildID`,
	RENAME COLUMN `TabId`					TO `TabID`;
ALTER TABLE `guild_eventlog`
	RENAME COLUMN `guildid`					TO `GuildID`,
	RENAME COLUMN `LogGuid`					TO `LogGUID`,
	RENAME COLUMN `PlayerGuid1`				TO `PlayerGUID1`,
	RENAME COLUMN `PlayerGuid2`				TO `PlayerGUID2`,
	RENAME								TO `guild_event_log`;
ALTER TABLE `guild_member`
	RENAME COLUMN `guildid`					TO `GuildID`,
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `rank`					TO `Rank`,
	RENAME COLUMN `pnote`					TO `PlayerNote`,
	RENAME COLUMN `offnote`					TO `OfficerNote`;
ALTER TABLE `guild_member_withdraw`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `tab0`					TO `Tab0`,
	RENAME COLUMN `tab1`					TO `Tab1`,
	RENAME COLUMN `tab2`					TO `Tab2`,
	RENAME COLUMN `tab3`					TO `Tab3`,
	RENAME COLUMN `tab4`					TO `Tab4`,
	RENAME COLUMN `tab5`					TO `Tab5`,
	RENAME COLUMN `money`					TO `Money`;
ALTER TABLE `guild_rank`
	RENAME COLUMN `guildid`					TO `GuildID`,
	RENAME COLUMN `rid`						TO `RankID`,
	RENAME COLUMN `rname`					TO `RankName`,
	RENAME COLUMN `rights`					TO `RankRights`;
ALTER TABLE `instance`
	RENAME COLUMN `id`						TO `ID`,
	RENAME COLUMN `map`						TO `Map`,
	RENAME COLUMN `resettime`				TO `ResetTime`,
	RENAME COLUMN `difficulty`				TO `Difficulty`,
	RENAME COLUMN `completedEncounters`		TO `CompletedEncounters`,
	RENAME COLUMN `data`					TO `Data`;
ALTER TABLE `instance_reset`
	RENAME COLUMN `mapid`					TO `MapID`,
	RENAME COLUMN `difficulty`				TO `Difficulty`,
	RENAME COLUMN `resettime`				TO `ResetTime`;
ALTER TABLE `instance_saved_go_state_data`
	RENAME COLUMN `id`						TO `ID`,
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `state`					TO `State`;
ALTER TABLE `item_instance`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `itemEntry`				TO `ItemEntry`,
	RENAME COLUMN `owner_guid`				TO `OwnerGUID`,
	RENAME COLUMN `creatorGuid`				TO `CreatorGUID`,
	RENAME COLUMN `giftCreatorGuid`			TO `GiftCreatorGUID`,
	RENAME COLUMN `count`					TO `Count`,
	RENAME COLUMN `duration`				TO `Duration`,
	RENAME COLUMN `charges`					TO `Charges`,
	RENAME COLUMN `flags`					TO `Flags`,
	RENAME COLUMN `enchantments`			TO `Enchantments`,
	RENAME COLUMN `randomPropertyId`		TO `RandomPropertyID`,
	RENAME COLUMN `durability`				TO `Durability`,
	RENAME COLUMN `playedTime`				TO `PlayedTime`,
	RENAME COLUMN `text`					TO `Text`;
ALTER TABLE `item_loot_storage`
	RENAME COLUMN `containerGUID`			TO `ContainerGUID`,
	RENAME COLUMN `itemid`					TO `ItemID`,
	RENAME COLUMN `count`					TO `Count`,
	RENAME COLUMN `item_index`				TO `ItemIndex`,
	RENAME COLUMN `randomPropertyId`		TO `RandomPropertyID`,
	RENAME COLUMN `randomSuffix`			TO `RandomSuffix`,
	RENAME COLUMN `follow_loot_rules`		TO `FollowLootRules`,
	RENAME COLUMN `freeforall`				TO `FreeForAll`,
	RENAME COLUMN `is_blocked`				TO `IsBlocked`,
	RENAME COLUMN `is_counted`				TO `IsCounted`,
	RENAME COLUMN `is_underthreshold`		TO `IsUnderThreshold`,
	RENAME COLUMN `needs_quest`				TO `NeedsQuest`,
	RENAME COLUMN `conditionLootId`			TO `ConditionLootID`;
ALTER TABLE `item_refund_instance`
	RENAME COLUMN `item_guid`				TO `ItemGUID`,
	RENAME COLUMN `player_guid`				TO `PlayerGUID`,
	RENAME COLUMN `paidMoney`				TO `PaidMoney`,
	RENAME COLUMN `paidExtendedCost`		TO `PaidExtendedCost`;
ALTER TABLE `item_soulbound_trade_data`
	RENAME COLUMN `itemGuid`				TO `ItemGUID`,
	RENAME COLUMN `allowedPlayers`			TO `AllowedPlayers`;
ALTER TABLE `lag_reports`
	RENAME COLUMN `reportId`				TO `ReportID`,
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `lagType`					TO `LagType`,
	RENAME COLUMN `mapId`					TO `MapID`,
	RENAME COLUMN `posX`					TO `PositionX`,
	RENAME COLUMN `posY`					TO `PositionY`,
	RENAME COLUMN `posZ`					TO `PositionZ`,
	RENAME COLUMN `latency`					TO `Latency`,
	RENAME COLUMN `createTime`				TO `CreateTime`;
ALTER TABLE `lfg_data`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `dungeon`					TO `Dungeon`,
	RENAME COLUMN `state`					TO `State`;
ALTER TABLE `log_arena_fights`
	RENAME COLUMN `fight_id`				TO `FightID`,
	RENAME COLUMN `time`					TO `Time`,
	RENAME COLUMN `type`					TO `Type`,
	RENAME COLUMN `duration`				TO `Duration`,
	RENAME COLUMN `winner`					TO `Winner`,
	RENAME COLUMN `loser`					TO `Loser`,
	RENAME COLUMN `winner_tr`				TO `WinnerTeamRating`,
	RENAME COLUMN `winner_mmr`				TO `WinnerMMR`,
	RENAME COLUMN `winner_tr_change`		TO `WinnerRatingChange`,
	RENAME COLUMN `loser_tr`				TO `LoserTeamRating`,
	RENAME COLUMN `loser_mmr`				TO `LoserMMR`,
	RENAME COLUMN `loser_tr_change`			TO `LoserRatingChange`,
	RENAME COLUMN `currOnline`				TO `Online`;
ALTER TABLE `log_arena_memberstats`
	RENAME COLUMN `fight_id`				TO `FightID`,
	RENAME COLUMN `member_id`				TO `MemberID`,
	RENAME COLUMN `name`					TO `Name`,
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `team`					TO `Team`,
	RENAME COLUMN `account`					TO `Account`,
	RENAME COLUMN `ip`						TO `IP`,
	RENAME COLUMN `damage`					TO `Damage`,
	RENAME COLUMN `heal`					TO `Heal`,
	RENAME COLUMN `kblows`					TO `KillingBlows`,
	RENAME								TO `log_arena_member_stats`;
ALTER TABLE `log_encounter`
	RENAME COLUMN `time`					TO `Time`,
	RENAME COLUMN `map`						TO `Map`,
	RENAME COLUMN `difficulty`				TO `Difficulty`,
	RENAME COLUMN `creditType`				TO `CreditType`,
	RENAME COLUMN `creditEntry`				TO `CreditEntry`,
	RENAME COLUMN `playersInfo`				TO `PlayerInfo`;
ALTER TABLE `log_money`
	RENAME COLUMN `sender_acc`				TO `SenderAccount`,
	RENAME COLUMN `sender_guid`				TO `SenderGUID`,
	RENAME COLUMN `sender_name`				TO `SenderName`,
	RENAME COLUMN `sender_ip`				TO `SenderIP`,
	RENAME COLUMN `receiver_acc`			TO `ReceiverAccount`,
	RENAME COLUMN `receiver_name`			TO `ReceiverName`,
	RENAME COLUMN `money`					TO `Money`,
	RENAME COLUMN `topic`					TO `Topic`,
	RENAME COLUMN `date`					TO `Date`,
	RENAME COLUMN `type`					TO `Type`;
ALTER TABLE `mail`
	RENAME COLUMN `id`						TO `ID`,
	RENAME COLUMN `messageType`				TO `MessageType`,
	RENAME COLUMN `stationery`				TO `Stationery`,
	RENAME COLUMN `mailTemplateId`			TO `MailTemplateID`,
	RENAME COLUMN `sender`					TO `Sender`,
	RENAME COLUMN `receiver`				TO `Receiver`,
	RENAME COLUMN `subject`					TO `Subject`,
	RENAME COLUMN `body`					TO `Body`,
	RENAME COLUMN `has_items`				TO `HasItems`,
	RENAME COLUMN `expire_time`				TO `ExpireTime`,
	RENAME COLUMN `deliver_time`			TO `DeliverTime`,
	RENAME COLUMN `money`					TO `Money`,
	RENAME COLUMN `cod`						TO `CoD`,
	RENAME COLUMN `checked`					TO `Checked`;
ALTER TABLE `mail_items`
	RENAME COLUMN `mail_id`					TO `MailID`,
	RENAME COLUMN `item_guid`				TO `ItemGUID`,
	RENAME COLUMN `receiver`				TO `Receiver`;
ALTER TABLE `mail_server_character`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `mailId`					TO `MailID`;
ALTER TABLE `mail_server_template`
	RENAME COLUMN `id`						TO `ID`,
	RENAME COLUMN `reqLevel`				TO `RequiredLevel`,
	RENAME COLUMN `reqPlayTime`				TO `RequiredPlayTime`,
	RENAME COLUMN `moneyA`					TO `MoneyAlliance`,
	RENAME COLUMN `moneyH`					TO `MoneyHorde`,
	RENAME COLUMN `itemA`					TO `ItemAlliance`,
	RENAME COLUMN `itemCountA`				TO `ItemCountAlliance`,
	RENAME COLUMN `itemH`					TO `ItemHorde`,
	RENAME COLUMN `itemCountH`				TO `ItemCountHorde`,
	RENAME COLUMN `subject`					TO `Subject`,
	RENAME COLUMN `body`					TO `Body`,
	RENAME COLUMN `active`					TO `Active`;
ALTER TABLE `petition`
	RENAME COLUMN `ownerguid`				TO `OwnerGUID`,
	RENAME COLUMN `petitionguid`			TO `PetitionGUID`,
	RENAME COLUMN `name`					TO `Name`,
	RENAME COLUMN `type`					TO `Type`;
ALTER TABLE `petition_sign`
	RENAME COLUMN `ownerguid`				TO `OwnerGUID`,
	RENAME COLUMN `petitionguid`			TO `PetitionGUID`,
	RENAME COLUMN `playerguid`				TO `PlayerGUID`,
	RENAME COLUMN `player_account`			TO `PlayerAccount`,
	RENAME COLUMN `type`					TO `Type`;
ALTER TABLE `pet_aura`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `casterGuid`				TO `CasterGUID`,
	RENAME COLUMN `spell`					TO `Spell`,
	RENAME COLUMN `effectMask`				TO `EffectMask`,
	RENAME COLUMN `recalculateMask`			TO `RecalculateMask`,
	RENAME COLUMN `stackCount`				TO `StackCount`,
	RENAME COLUMN `amount0`					TO `Amount1`,
	RENAME COLUMN `amount1`					TO `Amount2`,
	RENAME COLUMN `amount2`					TO `Amount3`,
	RENAME COLUMN `base_amount0`			TO `BaseAmount1`,
	RENAME COLUMN `base_amount1`			TO `BaseAmount2`,
	RENAME COLUMN `base_amount2`			TO `BaseAmount3`,
	RENAME COLUMN `maxDuration`				TO `MaxDuration`,
	RENAME COLUMN `remainTime`				TO `RemainTime`,
	RENAME COLUMN `remainCharges`			TO `RemainCharges`;
ALTER TABLE `pet_spell`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `spell`					TO `Spell`,
	RENAME COLUMN `active`					TO `Active`;
ALTER TABLE `pet_spell_cooldown`
	RENAME COLUMN `guid`					TO `GUID`,
	RENAME COLUMN `spell`					TO `Spell`,
	RENAME COLUMN `category`				TO `Category`,
	RENAME COLUMN `time`					TO `Time`;
ALTER TABLE `pool_quest_save`
	RENAME COLUMN `pool_id`					TO `PoolID`,
	RENAME COLUMN `quest_id`				TO `QuestID`;
ALTER TABLE `pvpstats_battlegrounds`
	RENAME COLUMN `id`						TO `ID`,
	RENAME COLUMN `winner_faction`			TO `WinnerFaction`,
	RENAME COLUMN `bracket_id`				TO `BracketID`,
	RENAME COLUMN `type`					TO `Type`,
	RENAME COLUMN `date`					TO `Date`,
	RENAME								TO `pvp_stats_battlegrounds`;
ALTER TABLE `pvpstats_players`
	RENAME COLUMN `battleground_id`			TO `BattlegroundID`,
	RENAME COLUMN `character_guid`			TO `CharacterGUID`,
	RENAME COLUMN `winner`					TO `Winner`,
	RENAME COLUMN `score_killing_blows`		TO `ScoreKillingBlows`,
	RENAME COLUMN `score_deaths`			TO `ScoreDeaths`,
	RENAME COLUMN `score_honorable_kills`	TO `ScoreHonorableKills`,
	RENAME COLUMN `score_bonus_honor`		TO `ScoreBonusHonor`,
	RENAME COLUMN `score_damage_done`		TO `ScoreDamageDone`,
	RENAME COLUMN `score_healing_done`		TO `ScoreHealingDone`,
	RENAME COLUMN `attr_1`					TO `Attribute1`,
	RENAME COLUMN `attr_2`					TO `Attribute2`,
	RENAME COLUMN `attr_3`					TO `Attribute3`,
	RENAME COLUMN `attr_4`					TO `Attribute4`,
	RENAME COLUMN `attr_5`					TO `Attribute5`,
	RENAME								TO `pvp_stats_players`;
ALTER TABLE `quest_tracker`
	RENAME COLUMN `id`						TO `ID`,
	RENAME COLUMN `character_guid`			TO `CharacterGUID`,
	RENAME COLUMN `quest_accept_time`		TO `QuestAcceptTime`,
	RENAME COLUMN `quest_complete_time`		TO `QuestCompleteTime`,
	RENAME COLUMN `quest_abandon_time`		TO `QuestAbandonTime`,
	RENAME COLUMN `completed_by_gm`			TO `CompletedByGM`,
	RENAME COLUMN `core_hash`				TO `CoreHash`,
	RENAME COLUMN `core_revision`			TO `CoreRevision`;
ALTER TABLE `recovery_item`
	RENAME COLUMN `Id`						TO `ID`,
	RENAME COLUMN `Guid`					TO `GUID`;
ALTER TABLE `reserved_name`
	RENAME COLUMN `name`					TO `Name`;
ALTER TABLE `updates`
	RENAME COLUMN `name`					TO `Name`,
	RENAME COLUMN `hash`					TO `Hash`,
	RENAME COLUMN `state`					TO `State`,
	RENAME COLUMN `timestamp`				TO `Timestamp`,
	RENAME COLUMN `speed`					TO `Duration`;
ALTER TABLE `updates_include`
	RENAME COLUMN `path`					TO `Path`,
	RENAME COLUMN `state`					TO `State`;
ALTER TABLE `warden_action`
	RENAME COLUMN `wardenId`				TO `WardenID`,
	RENAME COLUMN `action`					TO `Action`;
ALTER TABLE `worldstates`
	RENAME COLUMN `entry`					TO `Entry`,
	RENAME COLUMN `value`					TO `Value`,
	RENAME COLUMN `comment`					TO `Comment`,
	RENAME								TO `world_states`;
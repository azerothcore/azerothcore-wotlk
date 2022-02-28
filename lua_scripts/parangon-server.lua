--[[
    Created by iThorgrim

        Parangon with Interface

 You are going to use a script shared by myself (iThorgrim) so i would ask you to respect my work and not to assign this work to you.
 If you want to learn more about World of Warcraft development.

 (Only for French speaking people.)
 Open-Wow -> https://open-wow.eu
 Discord -> https://discord.gg/JUYgbNMwQu

 If you wish to thank me for my work you can make a small donation.
 Paypal ->

 Thank you for using my script, if you have a suggestion or a problem with it please make a topic about it:
 Issues -> https://github.com/iThorgrim-Hub/lua-aio-parangon/issues

 See you soon for a next script.
]]--

local AIO = AIO or require("AIO")

local parangon = {

    config = {
        db_name = 'acore',

        pointsPerLevel = 1,
        minLevel = 1,

        expMulti = 1,
        expMax = 500,

        pveKill = 100,
        pvpKill = 10,

        levelDiff = 10,

        maxStat = 255,
    },

    spells = {
        [7464] = 'Strength',
        [7471] = 'Agility',
        [7477] = 'Stamina',
        [7468] = 'Intellect',
    },
}

local parangon_addon = AIO.AddHandlers("AIO_Parangon", {})

parangon.account = {}

function Player:setParangonInfo(strength, agility, stamina, intellect)
    self:SetData('parangon_stats_7464', strength)
    self:SetData('parangon_stats_7471', agility)
    self:SetData('parangon_stats_7477', stamina)
    self:SetData('parangon_stats_7468', intellect)
end

function parangon_addon.sendInformations(msg, player)
    local pGuid = player:GetGUIDLow()
    local pAcc = player:GetAccountId()

    local temp = {
        stats = {},
        level = 1,
        points = 1,
    }
    for stat, _ in pairs(parangon.spells) do
        temp.stats[stat] = player:GetData('parangon_stats_'..stat)
    end

    if not parangon.account[pAcc] then
        parangon.account[pAcc] = {
            level = 1,
            exp = 0,
            exp_max = 0,
        }
    end

    temp.level = parangon.account[player:GetAccountId()].level
    temp.points = player:GetData('parangon_points')
    temp.exps = {
        exp = parangon.account[player:GetAccountId()].exp,
        exp_max = parangon.account[player:GetAccountId()].exp_max
    }

    return msg:Add("AIO_Parangon", "setInfo", temp.stats, temp.level, temp.points, temp.exps)
end
AIO.AddOnInit(parangon_addon.sendInformations)

function parangon.setAddonInfo(player)
    parangon_addon.sendInformations(AIO.Msg(), player):Send(player)
end

function parangon.onServerStart(event)
    CharDBExecute('CREATE DATABASE IF NOT EXISTS `'..parangon.config.db_name..'`;')
    CharDBExecute('CREATE TABLE IF NOT EXISTS `'..parangon.config.db_name..'`.`account_parangon` (`account_id` INT(11) NOT NULL, `level` INT(11) DEFAULT 1, `exp` INT(11) DEFAULT 0, PRIMARY KEY (`account_id`) );');
    CharDBExecute('CREATE TABLE IF NOT EXISTS `'..parangon.config.db_name..'`.`characters_parangon` (`account_id` INT(11) NOT NULL, `guid` INT(11) NOT NULL, `strength` INT(11) DEFAULT 0, `agility` INT(11) DEFAULT 0, `stamina` INT(11) DEFAULT 0, `intellect` INT(11) DEFAULT 0, PRIMARY KEY (`account_id`, `guid`));');
    io.write('Eluna :: Parangon System start \n')
end
RegisterServerEvent(14, parangon.onServerStart)

function parangon_addon.setStats(player)
    local pLevel = player:GetLevel()

    if pLevel >= parangon.config.minLevel then
        for spell, _ in pairs(parangon.spells) do
            player:RemoveAura(spell)
            player:AddAura(spell, player)
            player:GetAura(spell):SetStackAmount(player:GetData('parangon_stats_'..spell))
        end
    end
    parangon.setAddonInfo(player)
end

function parangon_addon.setStatsInformation(player, stat, value, flags)
    local pCombat = player:IsInCombat()
    if (not pCombat) then
        local pLevel = player:GetLevel()
        if (pLevel >= parangon.config.minLevel) then

            if not tonumber(value) or value < 0 then
                if ( player:GetDbLocaleIndex() == 2 ) then
                  player:SendNotification('Merci d\'entrer un nombre valide.')
                else
                  player:SendNotification('Please enter a valid number.')
                end
                return false
            end

            if (flags and player:GetData('parangon_stats_'..stat) + value > parangon.config.maxStat) then
                if ( player:GetDbLocaleIndex() == 2 ) then
                  player:SendBroadcastMessage('Vous ne pouvez plus ajouter de points.')
                else
                  player:SendBroadcastMessage('You can no longer add points.')
                end
                return false
            end

            if flags then
                if ((player:GetData('parangon_points') - value) >= 0) then
                    player:SetData('parangon_stats_'..stat, (player:GetData('parangon_stats_'..stat) + value))
                    parangon.calcPoints(player)
                else
                    if ( player:GetDbLocaleIndex() == 2 ) then
                      player:SendNotification('Vous n\'avez plus de points à attribuer.')
                    else
                      player:SendNotification('You have no more points to award.')
                    end
                    return false
                end
            else
                if value > player:GetData('parangon_stats_'..stat) then
                  value = player:GetData('parangon_stats_'..stat)
                end
                
                if (player:GetData('parangon_stats_'..stat) > 0) then
                    player:SetData('parangon_stats_'..stat, (player:GetData('parangon_stats_'..stat) - value))
                    parangon.calcPoints(player)
                else
                    if ( player:GetDbLocaleIndex() == 2 ) then
                      player:SendNotification('Vous n\'avez pas de points à retirer.')
                    else
                      player:SendNotification('You have no points to take out.')
                    end
                    return false
                end
            end
            parangon.setAddonInfo(player)
        else
            if ( player:GetDbLocaleIndex() == 2 ) then
              player:SendBroadcastMessage('Vous n\'avez pas le niveau requis pour le faire.')
            else
              player:SendBroadcastMessage('You don\'t have the level required to do that.')
            end
        end
    else
        if ( player:GetDbLocaleIndex() == 2 ) then
          player:SendBroadcastMessage('Vous ne pouvez pas faire ça en combat.')
        else
          player:SendBroadcastMessage('You can\'t do this in combat.')
        end
    end
end

function parangon.calcPoints(player)
  local pAcc = player:GetAccountId()

  if not parangon.account[pAcc] then
    parangon.account[pAcc] = {
        level = 1,
        exp = 0,
        exp_max = 0,
    }
    parangon.onLogin(event, player)
  end

  local str = player:GetData('parangon_stats_7464')
  local agi = player:GetData('parangon_stats_7471')
  local sta = player:GetData('parangon_stats_7477')
  local int = player:GetData('parangon_stats_7468')

  local points_spend = str + agi + sta + int
  local points_calc = parangon.account[pAcc].level * parangon.config.pointsPerLevel

  points_calc = points_calc - points_spend

  player:SetData('parangon_points', points_calc)
end

function parangon.onLogin(event, player)
    local pGuid = player:GetGUIDLow()
    local pAcc = player:GetAccountId()

    local getParangonCharInfo = CharDBQuery('SELECT strength, agility, stamina, intellect FROM `'..parangon.config.db_name..'`.`characters_parangon` WHERE guid = '..pGuid)
    if getParangonCharInfo then
        player:setParangonInfo(getParangonCharInfo:GetUInt32(0), getParangonCharInfo:GetUInt32(1), getParangonCharInfo:GetUInt32(2), getParangonCharInfo:GetUInt32(3))
    else
        local pGuid = player:GetGUIDLow()
        CharDBExecute('INSERT INTO `'..parangon.config.db_name..'`.`characters_parangon` VALUES ('..pAcc..', '..pGuid..', 0, 0, 0, 0)')
        player:setParangonInfo(0, 0, 0, 0)
    end

    local pAcc = player:GetAccountId()
    if not parangon.account[pAcc] then
        parangon.account[pAcc] = {
            level = 1,
            exp = 0,
            exp_max = 0,
        }

        local getParangonAccInfo = AuthDBQuery('SELECT level, exp FROM `'..parangon.config.db_name..'`.`account_parangon` WHERE account_id = '..pAcc)
        if getParangonAccInfo then
            parangon.account[pAcc].level = getParangonAccInfo:GetUInt32(0)
            parangon.account[pAcc].exp = getParangonAccInfo:GetUInt32(1)
            parangon.account[pAcc].exp_max = parangon.config.expMax * parangon.account[pAcc].level
        else
            AuthDBExecute('INSERT INTO `'..parangon.config.db_name..'`.`account_parangon` VALUES ('..pAcc..', 1, 0)')
        end
    end

    parangon.calcPoints(player)
    parangon_addon.setStats(player)
end
RegisterPlayerEvent(3, parangon.onLogin)

function parangon.getPlayers(event)
    for _, player in pairs(GetPlayersInWorld()) do
        parangon.onLogin(event, player)
    end
    io.write('Eluna :: Parangon System start \n')
end
RegisterServerEvent(33, parangon.getPlayers)

function parangon.onLogout(event, player)
    local pAcc = player:GetAccountId()
    local pGuid = player:GetGUIDLow()
    local strength, agility, stamina, intellect = player:GetData('parangon_stats_7464'), player:GetData('parangon_stats_7471'), player:GetData('parangon_stats_7477'), player:GetData('parangon_stats_7468')
    CharDBExecute('REPLACE INTO `'..parangon.config.db_name..'`.`characters_parangon` VALUES ('..pAcc..', '..pGuid..', '..strength..', '..agility..', '..stamina..', '..intellect..')')

    if not parangon.account[pAcc] then
        parangon.account[pAcc] = {
            level = 1,
            exp = 0,
            exp_max = 0,
        }
    end

    local level, exp = parangon.account[pAcc].level, parangon.account[pAcc].exp
    AuthDBExecute('REPLACE INTO `'..parangon.config.db_name..'`.`account_parangon` VALUES ('..pAcc..', '..level..', '..exp..')')
end
RegisterPlayerEvent(4, parangon.onLogout)

function parangon.setPlayers(event)
    for _, player in pairs(GetPlayersInWorld()) do
        parangon.onLogout(event, player)
    end
end
RegisterServerEvent(16, parangon.setPlayers)

function parangon.setExp(player, victim)
    local pLevel = player:GetLevel()
    local vLevel = victim:GetLevel()
    local pAcc = player:GetAccountId()

    if (vLevel - pLevel <= parangon.config.levelDiff) and (vLevel - pLevel >= 0) or (pLevel - vLevel <= parangon.config.levelDiff) and (pLevel - vLevel >= 0) then
        local isPlayer = GetGUIDEntry(victim:GetGUID())
        if (isPlayer == 0) then
            parangon.account[pAcc].exp = parangon.account[pAcc].exp + parangon.config.pvpKill
            if ( player:GetDbLocaleIndex() == 2 ) then
              player:SendBroadcastMessage('Votre victime vous donne '..parangon.config.pvpKill..' points d\'expériences Parangon.')
            else
              player:SendBroadcastMessage('Your victim gives you '..parangon.config.pvpKill..' Parangon experience points.')
            end
        else
            parangon.account[pAcc].exp = parangon.account[pAcc].exp + parangon.config.pveKill
            if ( player:GetDbLocaleIndex() == 2 ) then
              player:SendBroadcastMessage('Votre victime vous donne '..parangon.config.pveKill..' points d\'expériences Parangon.')
            else
              player:SendBroadcastMessage('Your victim gives you '..parangon.config.pveKill..' Parangon experience points.')
            end
        end
    end

    if parangon.account[pAcc].exp >= parangon.account[pAcc].exp_max then
        player:SetParangonLevel(1)
    end
    parangon_addon.setStats(player)
end

function parangon.onKillCreatureOrPlayer(event, player, victim)
    local pLevel = player:GetLevel()

    if (pLevel >= parangon.config.minLevel) then
        local pGroup = player:GetGroup()
        local vLevel = victim:GetLevel()
        if pGroup then
            for _, player in pairs(pGroup:GetMembers()) do
                parangon.setExp(player, victim)
            end
        else
            parangon.setExp(player, victim)
        end
    end
end
RegisterPlayerEvent(6, parangon.onKillCreatureOrPlayer)
RegisterPlayerEvent(7, parangon.onKillCreatureOrPlayer)

function Player:SetParangonLevel(level)
    local pAcc = self:GetAccountId()

    parangon.account[pAcc].level = parangon.account[pAcc].level + level
    parangon.account[pAcc].exp = parangon.account[pAcc].exp - parangon.account[pAcc].exp_max
    parangon.account[pAcc].exp_max = parangon.config.expMax * parangon.account[pAcc].level

    parangon.calcPoints(self)

    self:CastSpell(self, 24312, true)
    self:RemoveAura( 24312 )
    if ( self:GetDbLocaleIndex() == 2 ) then
      self:SendBroadcastMessage('|CFF00A2FFVous venez de passer un niveau de Paragon.\nFélicitations, vous êtes maintenant de niveau '..parangon.account[pAcc].level..'!')
    else
      self:SendBroadcastMessage('|CFF00A2FFYou have just passed a level of Paragon.\nCongratulations, you are now level '..parangon.account[pAcc].level..'!')
    end
end

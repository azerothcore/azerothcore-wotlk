/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

#include "ScriptMgr.h"
#include "Player.h"
#include "Config.h"
#include "Chat.h"
#include "TopicRouter.h"
#include <LoadDKSpells.cpp>
#include <LoadDruidSpells.cpp>
#include <LoadHunterSpells.cpp>
#include <LoadMageSpells.cpp>
#include <LoadPaladinSpells.cpp>
#include <LoadPriestSpells.cpp>
#include <LoadRogueSpells.cpp>
#include <LoadWarlockSpells.cpp>
#include <LoadWarriorSpells.cpp>
#include <LoadShamanSpells.cpp>

struct SpellTooltipInfo
{
    std::unordered_map<std::string, uint32> DescriptionTokens;
    std::vector<uint32> AddedTooltipEffects;
};

class ForgePlayerSpellCache : public PlayerScript
{
public:
    std::vector<std::string> validTokens = { "^dm;" };
    std::unordered_map<uint32, std::vector<uint32>> SpellTokenMap;

    // char id, spell id
    std::unordered_map<uint32, std::unordered_map<uint32, SpellTooltipInfo*>> m_tooltipInfo;

    ForgePlayerSpellCache() : PlayerScript("ForgePlayerSpellCache")
    {

    }

    void OnLogin(Player* player) override
    {
        RecalcTooltips(player);
    }

    void OnLearnSpell(Player* player, uint32 spellID) override
    {
        uint32 charId = player->GetGUID().GetCounter();
        auto forgeSpellMap = sSpellMgr->GetDummyMap();

        auto spellItt = forgeSpellMap.find(spellID);

        if (spellItt == forgeSpellMap.end())
        {
            auto* si = sSpellMgr->GetSpellInfo(spellID);

            if (si)
            {
                auto fs = sSpellMgr->GetSpellInfosForDummyId(si->Effects[0].MiscValue, si->Effects[0].MiscValueB); // get the forge skill, if it is we can use the spell id

                if (fs.size() > 0)
                {
                    spellItt = forgeSpellMap.find(si->Effects[0].MiscValue);
                    spellID = si->Effects[0].MiscValue;
                }
            }
        }

        if (spellItt != forgeSpellMap.end())
        {
            m_tooltipInfo[charId][spellID] = new SpellTooltipInfo();

            for (auto& enchKvp : spellItt->second)
                for (auto& rankKvp : enchKvp.second)
                {
                    auto* tti = m_tooltipInfo[charId][spellID];
                    tti->AddedTooltipEffects.push_back(rankKvp->Id);
                    CacheTokens(spellID, player, tti);
                }

            SendSpellTooltip(player, spellID);
        }
    }

    // Called when a player forgot spell
    void OnForgotSpell(Player* player, uint32 spellID) override
    {
        uint32 charId = player->GetGUID().GetCounter();
        auto pItt = m_tooltipInfo.find(charId);

        if (pItt != m_tooltipInfo.end())
        {
            auto spellItt = pItt->second.find(spellID);

            if (spellItt == pItt->second.end())
            {
                auto* si = sSpellMgr->GetSpellInfo(spellID);

                if (si)
                {
                    auto fs = sSpellMgr->GetSpellInfosForDummyId(si->Effects[0].MiscValue, si->Effects[0].MiscValueB); // get the forge skill, if it is we can use the spell id

                    if (fs.size() > 0)
                    {
                        auto internalSpell = pItt->second.find(si->Effects[0].MiscValue);

                        if (internalSpell != pItt->second.end())
                        {
                            m_tooltipInfo[charId][si->Effects[0].MiscValue]->AddedTooltipEffects.clear();

                            for (auto i : fs)
                                m_tooltipInfo[charId][si->Effects[0].MiscValue]->AddedTooltipEffects.push_back(i->Id);

                            player->SendForgeUIMsg(ForgeTopic::FORGET_TOOLTIP, std::to_string(si->Effects[0].MiscValue));
                            return;
                        }
                    }
                }
            }

            if (spellItt != pItt->second.end())
            {
                m_tooltipInfo[charId].erase(spellID);
                player->SendForgeUIMsg(ForgeTopic::FORGET_TOOLTIP, std::to_string(spellID));
            }
        }
    }

    void SendSpellTooltip(Player* player, uint32 spellId)
    {
        auto pItt = m_tooltipInfo.find(player->GetGUID().GetCounter());

        if (pItt != m_tooltipInfo.end())
        {
            auto spellItt = pItt->second.find(spellId);

            if (spellItt != pItt->second.end())
            {
                std::string msg = "";

                PopulateMessage(msg, spellItt->first, spellItt->second);
                player->SendForgeUIMsg(ForgeTopic::GET_TOOLTIPS, msg);
            }
        }
    }

    void SendAllTooltips(Player* player)
    {
        auto pItt = m_tooltipInfo.find(player->GetGUID().GetCounter());

        if (pItt != m_tooltipInfo.end())
        {
            std::string msg = "";

            for (auto& s : pItt->second)
            {
                PopulateMessage(msg, s.first, s.second);
            }

            player->SendForgeUIMsg(ForgeTopic::GET_TOOLTIPS, msg);
        }
    }

    void PopulateMessage(std::string& msg, uint32 spellId, SpellTooltipInfo* info)
    {
        std::string delimiter = ";";

        if (msg == "")
            delimiter = "";

        msg += delimiter + std::to_string(spellId) + "#";

        uint32 i = 0;

        for (auto& eff : info->AddedTooltipEffects)
        {
            std::string delim = "%";

            if (i == 0)
                delim = "";

            msg += delim + std::to_string(eff);

            i++;
        }

        for (auto& dt : info->DescriptionTokens)
        {
            std::string delim = "*";

            if (i == 0)
            {
                delim = "";
                msg + "#";
            }

            msg += delim + dt.first + "~" + std::to_string(dt.second);

            i++;
        }
    }

    void RecalcTooltips(Player* player)
    {
        // Spell ID, Effect ID, list of ranks
       // std::unordered_map<uint32, std::unordered_map<uint32, std::vector<SpellInfo*>>>
       // we get all the forge spells to setup tooltip info
        auto forgeSpellMap = sSpellMgr->GetDummyMap();

        auto knownSpells = player->GetKnownSpells();
        uint32 charId = player->GetGUID().GetCounter();

        if (m_tooltipInfo.find(charId) != m_tooltipInfo.end())
            m_tooltipInfo.erase(charId);

        for (auto& sIdKvp : knownSpells)
        {
            if (sIdKvp.second->Active)
            {
                auto spellItt = forgeSpellMap.find(sIdKvp.first);
                
                if (spellItt != forgeSpellMap.end())
                {
                    for (auto& enchKvp : spellItt->second)
                    {
                        for (auto& rankKvp : enchKvp.second)
                        {
                            if (player->HasSpell(rankKvp->Id))
                            {
                                auto pItt = m_tooltipInfo.find(charId);

                                if (pItt == m_tooltipInfo.end())
                                {
                                    m_tooltipInfo[charId][sIdKvp.first] = new SpellTooltipInfo();
                                }
                                else if (pItt->second.find(sIdKvp.first) == pItt->second.end())
                                {
                                    m_tooltipInfo[charId][sIdKvp.first] = new SpellTooltipInfo();
                                }

                                auto* tti = m_tooltipInfo[charId][sIdKvp.first];

                                tti->AddedTooltipEffects.push_back(rankKvp->Id);

                                CacheTokens(sIdKvp.first, player, tti);
                            }
                        }
                    }
                }
            }
        }
    }

    void CacheTokens(uint32 spellId, Player* player, SpellTooltipInfo* tti)
    {
        auto tokenItt = SpellTokenMap.find(spellId);

        if (tokenItt != SpellTokenMap.end())
        {
            for (auto t : tokenItt->second)
            {
                auto tkn = validTokens[t];
                auto si = sSpellMgr->GetSpellInfo(spellId);

                switch (t)
                {
                case 0:
                {
                    int32 damage = 0;

                    for (uint8 i = 0; i < MAX_SPELL_EFFECTS; ++i)
                    {
                        damage += player->CalculateSpellDamage(player, si, i);
                        auto auraType = (AuraType)si->Effects[i].ApplyAuraName;

                        DamageEffectType det = SPELL_DIRECT_DAMAGE;

                        if (auraType == SPELL_AURA_PERIODIC_DAMAGE)
                            det = DOT;

                        damage = player->SpellDamageBonusDone(player, si, damage, det, EFFECT_0);
                        damage = player->SpellDamageBonusTaken(player, si, damage, det);
                    }

                    sScriptMgr->ModifySpellDamageTaken(player, player, damage, si);

                    tti->DescriptionTokens[tkn] = damage;
                }
                break;
                default:
                    break;
                }
            }
        }
    }

private:
    TopicRouter* Router;
};

class GetToolTipsHandler : public ForgeTopicHandler
{
public:
    GetToolTipsHandler(ForgePlayerSpellCache* cache) : ForgeTopicHandler(ForgeTopic::GET_TOOLTIPS)
    {
        fc = cache;
    }

    void HandleMessage(ForgeAddonMessage& iam) override
    {
        fc->SendAllTooltips(iam.player);
    }

private:

    ForgePlayerSpellCache* fc;
};


class ForgeSpellStartup : public WorldScript
{
public:
    ForgeSpellStartup(ForgePlayerSpellCache* psc) : WorldScript("ForgeSpellStartup")
    {
        sc = psc;
    }

    void OnStartup() override
    {
        int i = 0;

       /* for (auto t : sc->validTokens)
        {
            auto query = WorldDatabase.Query("SELECT ID FROM acore_world.db_spell_12340 where AuraDescription_Lang_enUS IS NOT NULL AND AuraDescription_Lang_enUS != '' AND AuraDescription_Lang_enUS LIKE '%" + t + "%'");

            if (!query)
                return;

            do
            {
                Field* fields = query->Fetch();
                uint32 spellId = fields[0].Get<uint32>();

                sc->SpellTokenMap[spellId].push_back(i);

            } while (query->NextRow());

            i++;
        }*/
    }

    ForgePlayerSpellCache* sc;
};



// Add all scripts in one
void AddForgeSpellsScripts()
{
    auto* pc = new ForgePlayerSpellCache();
    sTopicRouter->AddHandler(new GetToolTipsHandler(pc));
    new ForgeSpellStartup(pc);

    //(new LoadDKSpells())->Load();
    (new LoadDruidSpells())->Load();
    (new LoadHunterSpells())->Load();
    (new LoadMageSpells())->Load();
    (new LoadPaladinSpells())->Load();
    (new LoadPriestSpells())->Load();
    (new LoadRogueSpells())->Load();
    (new LoadShamanSpells())->Load();
    (new LoadWarlockSpells())->Load();
    (new LoadWarriorSpells())->Load();
}


#ifndef AZEROTHCORE_ARENASPECTATOR_H
#define AZEROTHCORE_ARENASPECTATOR_H

#include "Player.h"
#include "World.h"
#include "Map.h"
#include "Battleground.h"
#include "Pet.h"
#include "SpellAuras.h"
#include "SpellAuraEffects.h"
#include "Chat.h"
#include "LFGMgr.h"

#define SPECTATOR_ADDON_VERSION 27
#define SPECTATOR_BUFFER_LEN 150
#define SPECTATOR_ADDON_PREFIX "ASSUN\x09"
#define SPECTATOR_COOLDOWN_MIN 20
#define SPECTATOR_COOLDOWN_MAX 900
#define SPECTATOR_SPELL_BINDSIGHT 6277
#define SPECTATOR_SPELL_SPEED 1557

namespace ArenaSpectator
{
    template<class T> inline void SendCommand(T* o, const char* format, ...) ATTR_PRINTF(2, 3);
    inline void CreatePacket(WorldPacket& data, const char* m);
    inline void SendPacketTo(const Player* p, const char* m);
    inline void SendPacketTo(const Map* map, const char* m);
    inline void HandleResetCommand(Player* p);
    inline bool ShouldSendAura(Aura* aura, uint8 effMask, uint64 targetGUID, bool remove);

    template<class T> inline void SendCommand_String(T* p, uint64 targetGUID, const char* prefix, const std::string& c);
    template<class T> inline void SendCommand_UInt32Value(T* o, uint64 targetGUID, const char* prefix, uint32 t);
    template<class T> inline void SendCommand_GUID(T* o, uint64 targetGUID, const char* prefix, uint64 t);
    template<class T> inline void SendCommand_Spell(T* o, uint64 targetGUID, const char* prefix, uint32 id, int32 casttime);
    template<class T> inline void SendCommand_Cooldown(T* o, uint64 targetGUID, const char* prefix, uint32 id, uint32 dur, uint32 maxdur);
    template<class T> inline void SendCommand_Aura(T* o, uint64 targetGUID, const char* prefix, uint64 caster, uint32 id, bool isDebuff, uint32 dispel, int32 dur, int32 maxdur, uint32 stack, bool remove);

    bool HandleSpectatorSpectateCommand(ChatHandler* handler, char const* args);
    bool HandleSpectatorWatchCommand(ChatHandler* handler, char const* args);

    // definitions below:

    template<class T>
    void SendCommand(T* o, const char* format, ...)
    {
        if (!format)
            return;
        char buffer[SPECTATOR_BUFFER_LEN];
        va_list ap;
        va_start(ap, format);
        vsnprintf(buffer, SPECTATOR_BUFFER_LEN, format, ap);
        va_end(ap);
        SendPacketTo(o, buffer);
    }

    void CreatePacket(WorldPacket& data, const char* m)
    {
        size_t len = strlen(m);
        data.Initialize(SMSG_MESSAGECHAT, 1+4+8+4+8+4+1+len+1);
        data << uint8(CHAT_MSG_WHISPER);
        data << uint32(LANG_ADDON);
        data << uint64(0);
        data << uint32(0);
        data << uint64(0);
        data << uint32(len + 1);
        data << m;
        data << uint8(0);
    }

    void SendPacketTo(const Player* p, const char* m)
    {
        WorldPacket data;
        CreatePacket(data, m);
        p->GetSession()->SendPacket(&data);
    }

    void SendPacketTo(const Map* map, const char* m)
    {
        if (!map->IsBattleArena())
            return;
        Battleground* bg = ((BattlegroundMap*)map)->GetBG();
        if (!bg || bg->GetStatus() != STATUS_IN_PROGRESS)
            return;
        WorldPacket data;
        CreatePacket(data, m);
        bg->SpectatorsSendPacket(data);
    }

    template<class T> 
    void SendCommand_String(T* o, uint64 targetGUID, const char* prefix, const char* c)
    {
        if (!IS_PLAYER_GUID(targetGUID))
            return;
        SendCommand(o, "%s0x%016llX;%s=%s;", SPECTATOR_ADDON_PREFIX, (unsigned long long)targetGUID, prefix, c);
    }

    template<class T>
    void SendCommand_UInt32Value(T* o, uint64 targetGUID, const char* prefix, uint32 t)
    {
        if (!IS_PLAYER_GUID(targetGUID))
            return;
        SendCommand(o, "%s0x%016llX;%s=%u;", SPECTATOR_ADDON_PREFIX, (unsigned long long)targetGUID, prefix, t);
    }

    template<class T>
    void SendCommand_GUID(T* o, uint64 targetGUID, const char* prefix, uint64 t)
    {
        if (!IS_PLAYER_GUID(targetGUID))
            return;
        SendCommand(o, "%s0x%016llX;%s=0x%016llX;", SPECTATOR_ADDON_PREFIX, (unsigned long long)targetGUID, prefix, (unsigned long long)t);
    }

    template<class T>
    void SendCommand_Spell(T* o, uint64 targetGUID, const char* prefix, uint32 id, int32 casttime)
    {
        if (!IS_PLAYER_GUID(targetGUID))
            return;
        SendCommand(o, "%s0x%016llX;%s=%u,%i;", SPECTATOR_ADDON_PREFIX, (unsigned long long)targetGUID, prefix, id, casttime);
    }

    template<class T>
    void SendCommand_Cooldown(T* o, uint64 targetGUID, const char* prefix, uint32 id, uint32 dur, uint32 maxdur)
    {
        if (!IS_PLAYER_GUID(targetGUID))
            return;
        if (const SpellInfo* si = sSpellMgr->GetSpellInfo(id))
            if (si->SpellIconID == 1)
                return;
        SendCommand(o, "%s0x%016llX;%s=%u,%u,%u;", SPECTATOR_ADDON_PREFIX, (unsigned long long)targetGUID, prefix, id, dur, maxdur);
    }

    template<class T>
    void SendCommand_Aura(T* o, uint64 targetGUID, const char* prefix, uint64 caster, uint32 id, bool isDebuff, uint32 dispel, int32 dur, int32 maxdur, uint32 stack, bool remove)
    {
        if (!IS_PLAYER_GUID(targetGUID))
            return;
        SendCommand(o, "%s0x%016llX;%s=%u,%u,%i,%i,%u,%u,%u,0x%016llX;", SPECTATOR_ADDON_PREFIX, (unsigned long long)targetGUID, prefix, remove ? 1 : 0, stack, dur, maxdur, id, dispel, isDebuff ? 1 : 0, (unsigned long long)caster);
    }

    void HandleResetCommand(Player* p)
    {
        if (!p->FindMap() || !p->IsInWorld() || !p->FindMap()->IsBattleArena())
            return;
        Battleground* bg = ((BattlegroundMap*)p->FindMap())->GetBG();
        if (!bg || bg->GetStatus() != STATUS_IN_PROGRESS)
            return;
        Battleground::BattlegroundPlayerMap const& pl = bg->GetPlayers();
        for (Battleground::BattlegroundPlayerMap::const_iterator itr = pl.begin(); itr != pl.end(); ++itr)
        {
            if (p->HasReceivedSpectatorResetFor(GUID_LOPART(itr->first)))
                continue;

            Player* plr = itr->second;
            p->AddReceivedSpectatorResetFor(GUID_LOPART(itr->first));

            SendCommand_String(p, itr->first, "NME", plr->GetName().c_str());
            // Xinef: addon compatibility
            SendCommand_UInt32Value(p, itr->first, "TEM", plr->GetBgTeamId() == TEAM_ALLIANCE ? ALLIANCE : HORDE);
            SendCommand_UInt32Value(p, itr->first, "CLA", plr->getClass());
            SendCommand_UInt32Value(p, itr->first, "MHP", plr->GetMaxHealth());
            SendCommand_UInt32Value(p, itr->first, "CHP", plr->GetHealth());
            SendCommand_UInt32Value(p, itr->first, "STA", plr->IsAlive() ? 1 : 0);
            Powers ptype = plr->getPowerType();
            SendCommand_UInt32Value(p, itr->first, "PWT", ptype);
            SendCommand_UInt32Value(p, itr->first, "MPW", ptype == POWER_RAGE || ptype == POWER_RUNIC_POWER ? plr->GetMaxPower(ptype)/10 : plr->GetMaxPower(ptype));
            SendCommand_UInt32Value(p, itr->first, "CPW", ptype == POWER_RAGE || ptype == POWER_RUNIC_POWER ? plr->GetPower(ptype)/10 : plr->GetPower(ptype));
            Pet* pet = plr->GetPet();
            SendCommand_UInt32Value(p, itr->first, "PHP", pet && pet->GetCreatureTemplate()->family ? (uint32)pet->GetHealthPct() : 0);
            SendCommand_UInt32Value(p, itr->first, "PET", pet ? pet->GetCreatureTemplate()->family : 0);
            SendCommand_GUID(p, itr->first, "TRG", plr->GetTarget());
            SendCommand_UInt32Value(p, itr->first, "RES", 1);
            SendCommand_UInt32Value(p, itr->first, "CDC", 1);
            SendCommand_UInt32Value(p, itr->first, "TIM", (bg->GetStartTime() < 46*MINUTE*IN_MILLISECONDS) ? (46*MINUTE*IN_MILLISECONDS-bg->GetStartTime())/IN_MILLISECONDS : 0);
            // "SPE" not here (only possible to send starting a new cast)

            // send all "CD"
            SpellCooldowns const& sc = plr->GetSpellCooldownMap();
            for (SpellCooldowns::const_iterator itrc = sc.begin(); itrc != sc.end(); ++itrc)
                if (itrc->second.sendToSpectator && itrc->second.maxduration >= SPECTATOR_COOLDOWN_MIN*IN_MILLISECONDS && itrc->second.maxduration <= SPECTATOR_COOLDOWN_MAX*IN_MILLISECONDS)
                    if (uint32 cd = (getMSTimeDiff(World::GetGameTimeMS(), itrc->second.end)/1000))
                        SendCommand_Cooldown(p, itr->first, "ACD", itrc->first, cd, itrc->second.maxduration/1000);

            // send all visible "AUR"
            Unit::VisibleAuraMap const *visibleAuras = plr->GetVisibleAuras();
            for (Unit::VisibleAuraMap::const_iterator aitr = visibleAuras->begin(); aitr != visibleAuras->end(); ++aitr)
            {
                Aura *aura = aitr->second->GetBase();
                if (ShouldSendAura(aura, aitr->second->GetEffectMask(), plr->GetGUID(), false))
                    SendCommand_Aura(p, itr->first, "AUR", aura->GetCasterGUID(), aura->GetSpellInfo()->Id, aura->GetSpellInfo()->IsPositive(), aura->GetSpellInfo()->Dispel, aura->GetDuration(), aura->GetMaxDuration(), (aura->GetCharges() > 1 ? aura->GetCharges() : aura->GetStackAmount()), false);
            }
        }
    }

    bool ShouldSendAura(Aura* aura, uint8 effMask, uint64 targetGUID, bool remove)
    {
        if (aura->GetSpellInfo()->SpellIconID == 1 || aura->GetSpellInfo()->HasAttribute(SPELL_ATTR1_DONT_DISPLAY_IN_AURA_BAR))
            return false;

        if (remove || aura->GetSpellInfo()->HasAttribute(SPELL_ATTR0_CU_DONT_BREAK_STEALTH) || aura->GetSpellInfo()->SpellFamilyName == SPELLFAMILY_GENERIC)
            return true;

        for(uint8 i=EFFECT_0; i<MAX_SPELL_EFFECTS; ++i)
        {
            if (effMask & (1<<i))
            {
                AuraType at = aura->GetEffect(i)->GetAuraType();
                if ((aura->GetEffect(i)->GetAmount() && (aura->GetSpellInfo()->IsPositive() || targetGUID != aura->GetCasterGUID())) || 
                    at == SPELL_AURA_MECHANIC_IMMUNITY || at == SPELL_AURA_EFFECT_IMMUNITY || at == SPELL_AURA_STATE_IMMUNITY || at == SPELL_AURA_SCHOOL_IMMUNITY || at == SPELL_AURA_DISPEL_IMMUNITY)
                    return true;
            }
        }
        return false;
    }
}

#endif

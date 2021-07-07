/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license, you may redistribute it and/or modify it under version 2 of the License, or (at your option), any later version.
 * Copyright (C) 2008-2021 TrinityCore <http://www.trinitycore.org/>
 */

#ifndef Trainer_h__
#define Trainer_h__

#include "Common.h"
#include <array>
#include <vector>

class Creature;
class ObjectMgr;
class Player;

namespace Trainer
{
    enum class Type : uint32
    {
        Class = 0,
        Mount = 1,
        Tradeskill = 2,
        Pet = 3
    };

    enum class SpellState : uint8
    {
        Available = 0,
        Unavailable = 1,
        Known = 2
    };

    enum class FailReason : uint32
    {
        Unavailable = 0,
        NotEnoughMoney = 1,
        NotEnoughSkill = 2
    };

    struct Spell
    {
        uint32 SpellId = 0;
        uint32 MoneyCost = 0;
        uint32 ReqSkillLine = 0;
        uint32 ReqSkillRank = 0;
        std::array<uint32, 3> ReqAbility = { };
        uint8 ReqLevel = 0;

        bool IsCastable() const;
    };

    class Trainer
    {
    public:
        Trainer(uint32 trainerId, Type type, uint32 requirement, std::string greeting, std::vector<Spell> spells);

        void SendSpells(Creature const* npc, Player const* player, LocaleConstant locale) const;
        void TeachSpell(Creature const* npc, Player* player, uint32 spellId) const;

        Type GetTrainerType() const { return _type; }
        uint32 GetTrainerRequirement() const { return _requirement; }
        bool IsTrainerValidForPlayer(Player const* player) const;

    private:
        Spell const* GetSpell(uint32 spellId) const;
        bool CanTeachSpell(Player const* player, Spell const* trainerSpell) const;
        SpellState GetSpellState(Player const* player, Spell const* trainerSpell) const;
        void SendTeachFailure(Creature const* npc, Player const* player, uint32 spellId, FailReason reason) const;
        void SendTeachSucceeded(Creature const* npc, Player const* player, uint32 spellId) const;
        std::string const& GetGreeting(LocaleConstant locale) const;

        friend ObjectMgr;
        void AddGreetingLocale(LocaleConstant locale, std::string greeting);

        uint32 _trainerId;
        Type _type;
        uint32 _requirement;
        std::vector<Spell> _spells;
        std::array<std::string, TOTAL_LOCALES> _greeting;
    };
}

#endif // Trainer_h__

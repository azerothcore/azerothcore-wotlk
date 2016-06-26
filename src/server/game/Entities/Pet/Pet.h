/*
 * Copyright (C) 
 * Copyright (C) 
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License as published by the
 * Free Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef SUNWELLCORE_PET_H
#define SUNWELLCORE_PET_H

#include "PetDefines.h"
#include "TemporarySummon.h"

#define PET_FOCUS_REGEN_INTERVAL	4 * IN_MILLISECONDS
#define PET_LOSE_HAPPINES_INTERVAL	7500
#define HAPPINESS_LEVEL_SIZE        333000

struct PetSpell
{
    ActiveStates active;
    PetSpellState state;
    PetSpellType type;
};


class AsynchPetSummon
{
	public:
		AsynchPetSummon(uint32 entry, Position position, PetType petType, uint32 duration, uint32 createdBySpell, uint64 casterGUID) : 
			m_entry(entry), pos(position), m_petType(petType),
			m_duration(duration), m_createdBySpell(createdBySpell), m_casterGUID(casterGUID) { }
	
		Position pos;
		uint32 m_entry, m_createdBySpell, m_duration;
		PetType m_petType;
		uint64 m_casterGUID;
};

typedef UNORDERED_MAP<uint32, PetSpell> PetSpellMap;
typedef std::vector<uint32> AutoSpellList;

class Player;

class Pet : public Guardian
{
    public:
        explicit Pet(Player* owner, PetType type = MAX_PET_TYPE);
        virtual ~Pet();

        void AddToWorld();
        void RemoveFromWorld();

        void SetDisplayId(uint32 modelId);

        PetType getPetType() const { return m_petType; }
        void setPetType(PetType type) { m_petType = type; }
        bool isControlled() const { return getPetType() == SUMMON_PET || getPetType() == HUNTER_PET; }
        bool isTemporarySummoned() const { return m_duration > 0; }

        bool IsPermanentPetFor(Player* owner) const;              // pet have tab in character windows and set UNIT_FIELD_PETNUMBER

        bool Create(uint32 guidlow, Map* map, uint32 phaseMask, uint32 Entry, uint32 pet_number);
        bool CreateBaseAtCreature(Creature* creature);
        bool CreateBaseAtCreatureInfo(CreatureTemplate const* cinfo, Unit* owner);
        bool CreateBaseAtTamed(CreatureTemplate const* cinfo, Map* map, uint32 phaseMask);
		static bool LoadPetFromDB(Player* owner, uint8 asynchLoadType, uint32 petentry = 0, uint32 petnumber = 0, bool current = false, AsynchPetSummon* info = NULL);
        bool isBeingLoaded() const { return m_loading;}
        void SavePetToDB(PetSaveMode mode, bool logout);
        void Remove(PetSaveMode mode, bool returnreagent = false);
        static void DeleteFromDB(uint32 guidlow);

        void setDeathState(DeathState s, bool despawn = false);                   // overwrite virtual Creature::setDeathState and Unit::setDeathState
        void Update(uint32 diff);                           // overwrite virtual Creature::Update and Unit::Update

        uint8 GetPetAutoSpellSize() const { return m_autospells.size(); }
        uint32 GetPetAutoSpellOnPos(uint8 pos) const
        {
            if (pos >= m_autospells.size())
                return 0;
            else
                return m_autospells[pos];
        }

        void LoseHappiness();
        HappinessState GetHappinessState();
        void GivePetXP(uint32 xp);
        void GivePetLevel(uint8 level);
        void SynchronizeLevelWithOwner();
        bool HaveInDiet(ItemTemplate const* item) const;
        uint32 GetCurrentFoodBenefitLevel(uint32 itemlevel) const;
        void SetDuration(int32 dur) { m_duration = dur; }
		int32 GetDuration() const { return m_duration; }

        /*
        bool UpdateStats(Stats stat);
        bool UpdateAllStats();
        void UpdateResistances(uint32 school);
        void UpdateArmor();
        void UpdateMaxHealth();
        void UpdateMaxPower(Powers power);
        void UpdateAttackPowerAndDamage(bool ranged = false);
        void UpdateDamagePhysical(WeaponAttackType attType);
        */

        void ToggleAutocast(SpellInfo const* spellInfo, bool apply);

        bool HasSpell(uint32 spell) const;

        void LearnPetPassives();
        void CastPetAuras(bool current);

        void _SaveSpellCooldowns(SQLTransaction& trans, bool logout);
        void _SaveAuras(SQLTransaction& trans, bool logout);
        void _SaveSpells(SQLTransaction& trans);

		void _LoadSpellCooldowns(PreparedQueryResult result);
        void _LoadAuras(PreparedQueryResult result, uint32 timediff);
        void _LoadSpells(PreparedQueryResult result);

        bool addSpell(uint32 spellId, ActiveStates active = ACT_DECIDE, PetSpellState state = PETSPELL_NEW, PetSpellType type = PETSPELL_NORMAL);
        bool learnSpell(uint32 spell_id);
        void learnSpellHighRank(uint32 spellid);
        void InitLevelupSpellsForLevel();
        bool unlearnSpell(uint32 spell_id, bool learn_prev, bool clear_ab = true);
        bool removeSpell(uint32 spell_id, bool learn_prev, bool clear_ab = true);
        void CleanupActionBar();

        PetSpellMap     m_spells;
        AutoSpellList   m_autospells;

        void InitPetCreateSpells();

        bool resetTalents();
        static void resetTalentsForAllPetsOf(Player* owner, Pet* online_pet = NULL);
        void InitTalentForLevel();

        uint8 GetMaxTalentPointsForLevel(uint8 level);
        uint8 GetFreeTalentPoints() { return GetByteValue(UNIT_FIELD_BYTES_1, 1); }
        void SetFreeTalentPoints(uint8 points) { SetByteValue(UNIT_FIELD_BYTES_1, 1, points); }

        uint32  m_usedTalentCount;

        uint64 GetAuraUpdateMaskForRaid() const { return m_auraRaidUpdateMask; }
        void SetAuraUpdateMaskForRaid(uint8 slot) { m_auraRaidUpdateMask |= (uint64(1) << slot); }
        void ResetAuraUpdateMaskForRaid() { m_auraRaidUpdateMask = 0; }

        DeclinedName const* GetDeclinedNames() const { return m_declinedname; }

        bool    m_removed;                                  // prevent overwrite pet state in DB at next Pet::Update if pet already removed(saved)

        Player* GetOwner() const { return m_owner; }
		void SetLoading(bool load) { m_loading = load; }
		void HandleAsynchLoadSucceed();
		static void HandleAsynchLoadFailed(AsynchPetSummon* info, Player* player, uint8 asynchLoadType, uint8 loadResult);
		uint8 GetAsynchLoadType() const { return asynchLoadType; }
		void SetAsynchLoadType(uint8 type) { asynchLoadType = type; }
    protected:
        Player* m_owner;
        int32   m_happinessTimer;
        PetType m_petType;
        int32   m_duration;                                 // time until unsummon (used mostly for summoned guardians and not used for controlled pets)
        uint64  m_auraRaidUpdateMask;
        bool    m_loading;
        int32   m_petRegenTimer;							// xinef: used for focus regeneration

        DeclinedName *m_declinedname;
		uint8 asynchLoadType;

    private:
        void SaveToDB(uint32, uint8, uint32)                // override of Creature::SaveToDB     - must not be called
        {
            ASSERT(false);
        }
        void DeleteFromDB()                                 // override of Creature::DeleteFromDB - must not be called
        {
            ASSERT(false);
        }
};
#endif

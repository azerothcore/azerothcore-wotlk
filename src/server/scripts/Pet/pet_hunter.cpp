/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_hun_".
 */

#include "ScriptMgr.h"
#include "ScriptPCH.h"
#include "ScriptedCreature.h"

enum HunterSpells
{
    SPELL_HUNTER_CRIPPLING_POISON       = 30981, // Viper
    SPELL_HUNTER_DEADLY_POISON_PASSIVE  = 34657, // Venomous Snake
    SPELL_HUNTER_MIND_NUMBING_POISON    = 25810, // Viper
    SPELL_HUNTER_GLYPH_OF_SNAKE_TRAP    = 56849,
    SPELL_HUNTER_PET_SCALING            = 62915
};

enum HunterCreatures
{
    NPC_HUNTER_VIPER                    = 19921
};

class npc_pet_hunter_snake_trap : public CreatureScript
{
    public:
        npc_pet_hunter_snake_trap() : CreatureScript("npc_pet_hunter_snake_trap") { }

        struct npc_pet_hunter_snake_trapAI : public ScriptedAI
        {
            npc_pet_hunter_snake_trapAI(Creature* creature) : ScriptedAI(creature) { _init = false; }

            void Reset()
            {
                _spellTimer = urand(1500, 3000);

                // Start attacking attacker of owner on first ai update after spawn - move in line of sight may choose better target
                if (!me->GetVictim())
                    if (Unit *tgt = me->SelectNearestTarget(10.0f))
                    {
                        me->AddThreat(tgt, 100000.0f);
                        AttackStart(tgt);
                    }
            }

            void EnterEvadeMode()
            {
                // _EnterEvadeMode();
                me->DeleteThreatList();
                me->CombatStop(true);
                me->LoadCreaturesAddon(true);
                me->SetLootRecipient(NULL);
                me->ResetPlayerDamageReq();
                me->SetLastDamagedTime(0); 
                
                me->AddUnitState(UNIT_STATE_EVADE);
                me->GetMotionMaster()->MoveTargetedHome();

                Reset();
            }

            //Redefined for random target selection:
            void MoveInLineOfSight(Unit* who)
            {
                if (!me->GetVictim() && who->isTargetableForAttack() && (me->IsHostileTo(who)) && who->isInAccessiblePlaceFor(me))
                {
                    if (me->GetDistanceZ(who) > CREATURE_Z_ATTACK_RANGE)
                        return;

                    if (me->IsWithinDistInMap(who, 10.0f))
                    {
                        me->AddThreat(who, 100000.0f);
                        AttackStart(who);
                    }
                }
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                if (me->GetVictim()->HasBreakableByDamageCrowdControlAura(me))
                {
                    me->InterruptNonMeleeSpells(false);
                    return;
                }

                if (!_init)
                {
                    _init = true;

                    CreatureTemplate const* Info = me->GetCreatureTemplate();
                    uint32 health = uint32(107 * (me->getLevel() - 40) * 0.025f);
                    me->SetCreateHealth(health);

                    for (uint8 stat = 0; stat < MAX_STATS; ++stat)
                    {
                        me->SetStat(Stats(stat), 0);
                        me->SetCreateStat(Stats(stat), 0);
                    }

                    me->SetModifierValue(UNIT_MOD_HEALTH, BASE_VALUE, (float)health);
                    me->SetMaxHealth(health);
                    //Add delta to make them not all hit the same time
                    uint32 delta = urand(0, 700);
                    me->SetAttackTime(BASE_ATTACK, Info->BaseAttackTime + delta);
                    me->SetStatFloatValue(UNIT_FIELD_RANGED_ATTACK_POWER , float(Info->attackpower));
                    me->CastSpell(me, SPELL_HUNTER_DEADLY_POISON_PASSIVE, true);

                    // Glyph of Snake Trap
                    if (Unit* owner = me->GetOwner())
                        if (owner->GetAuraEffectDummy(SPELL_HUNTER_GLYPH_OF_SNAKE_TRAP))
                            me->CastSpell(me, SPELL_HUNTER_PET_SCALING, true);
                }

                _spellTimer += diff;
                if (_spellTimer >= 3000)
                {
                    if (urand(0, 2) == 0) // 33% chance to cast
                        DoCastVictim(RAND(SPELL_HUNTER_MIND_NUMBING_POISON, SPELL_HUNTER_CRIPPLING_POISON));

                    _spellTimer = 0;
                }

                DoMeleeAttackIfReady();
            }

        private:
            bool _init;
            uint32 _spellTimer;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_pet_hunter_snake_trapAI(creature);
        }
};

void AddSC_hunter_pet_scripts()
{
    new npc_pet_hunter_snake_trap();
}

/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/*
 * Ordered alphabetically using scriptname.
 * Scriptnames of files in this file should be prefixed with "npc_pet_sha_".
 */

#include "Player.h"
#include "ScriptMgr.h"
#include "ScriptedCreature.h"

enum ShamanSpells
{
    SPELL_SHAMAN_ANGEREDEARTH   = 36213,
    SPELL_SHAMAN_FIREBLAST      = 57984,
    SPELL_SHAMAN_FIRENOVA       = 12470,
    SPELL_SHAMAN_FIRESHIELD     = 13377
};

enum ShamanEvents
{
    // Earth Elemental
    EVENT_SHAMAN_ANGEREDEARTH   = 1,
    // Fire Elemental
    EVENT_SHAMAN_FIRENOVA       = 1,
    EVENT_SHAMAN_FIRESHIELD     = 2,
    EVENT_SHAMAN_FIREBLAST      = 3
};

class npc_pet_shaman_earth_elemental : public CreatureScript
{
    public:
        npc_pet_shaman_earth_elemental() : CreatureScript("npc_pet_shaman_earth_elemental") { }

        struct npc_pet_shaman_earth_elementalAI : public ScriptedAI
        {
            npc_pet_shaman_earth_elementalAI(Creature* creature) : ScriptedAI(creature), _initAttack(true) { }


            void EnterCombat(Unit*)
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_SHAMAN_ANGEREDEARTH, 0);
            }

            void InitializeAI()
            {
                me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_NATURE, true);
            }

            void UpdateAI(uint32 diff)
            {
                if (_initAttack)
                {
                    if (!me->IsInCombat())
                        if (Player* owner = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                            if (Unit* target = owner->GetSelectedUnit())
                                if (me->_CanDetectFeignDeathOf(target) && me->CanCreatureAttack(target))
                                    AttackStart(target);
                    _initAttack = false;
                }

                if (!UpdateVictim())
                    return;

                _events.Update(diff);

                if (_events.ExecuteEvent() == EVENT_SHAMAN_ANGEREDEARTH)
                {
                    DoCastVictim(SPELL_SHAMAN_ANGEREDEARTH);
                    _events.ScheduleEvent(EVENT_SHAMAN_ANGEREDEARTH, urand(5000, 20000));
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
            bool _initAttack;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_pet_shaman_earth_elementalAI(creature);
        }
};

class npc_pet_shaman_fire_elemental : public CreatureScript
{
    public:
        npc_pet_shaman_fire_elemental() : CreatureScript("npc_pet_shaman_fire_elemental") { }

        struct npc_pet_shaman_fire_elementalAI : public ScriptedAI
        {
            npc_pet_shaman_fire_elementalAI(Creature* creature) : ScriptedAI(creature), _initAttack(true) { }

            void InitializeAI()
            {
                me->ApplySpellImmune(0, IMMUNITY_SCHOOL, SPELL_SCHOOL_MASK_FIRE, true);
            }

            void EnterCombat(Unit*)
            {
                _events.Reset();
                _events.ScheduleEvent(EVENT_SHAMAN_FIRENOVA, urand(5000, 20000));
                _events.ScheduleEvent(EVENT_SHAMAN_FIREBLAST, urand(5000, 20000));
                //_events.ScheduleEvent(EVENT_SHAMAN_FIRESHIELD, 0);

                me->RemoveAurasDueToSpell(SPELL_SHAMAN_FIRESHIELD);
                me->CastSpell(me, SPELL_SHAMAN_FIRESHIELD, true);
            }

            void UpdateAI(uint32 diff)
            {
                if (_initAttack)
                {
                    if (!me->IsInCombat())
                        if (Player* owner = me->GetCharmerOrOwnerPlayerOrPlayerItself())
                            if (Unit* target = owner->GetSelectedUnit())
                                if (me->_CanDetectFeignDeathOf(target) && me->CanCreatureAttack(target))
                                    AttackStart(target);
                    _initAttack = false;
                }

                if (!UpdateVictim())
                    return;

                _events.Update(diff);
                while (uint32 eventId = _events.ExecuteEvent())
                {
                    switch (eventId)
                    {
                        case EVENT_SHAMAN_FIRENOVA:
                            me->CastSpell(me, SPELL_SHAMAN_FIRENOVA, false);
                            _events.ScheduleEvent(EVENT_SHAMAN_FIRENOVA, urand(8000, 15000));
                            break;
                        case EVENT_SHAMAN_FIREBLAST:
                            me->CastSpell(me->GetVictim(), SPELL_SHAMAN_FIREBLAST, false);
                            _events.ScheduleEvent(EVENT_SHAMAN_FIREBLAST, urand(4000, 8000));
                            break;
                        default:
                            break;
                    }
                }

                DoMeleeAttackIfReady();
            }

        private:
            EventMap _events;
            bool _initAttack;
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new npc_pet_shaman_fire_elementalAI(creature);
        }
};

void AddSC_shaman_pet_scripts()
{
    new npc_pet_shaman_earth_elemental();
    new npc_pet_shaman_fire_elemental();
}

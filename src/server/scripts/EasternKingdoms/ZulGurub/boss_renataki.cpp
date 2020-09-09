/*
 * Copyright (C) 2016+     AzerothCore <www.azerothcore.org>, released under GNU GPL v2 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-GPL2
 * Copyright (C) 2008-2016 TrinityCore <http://www.trinitycore.org/>
 * Copyright (C) 2005-2009 MaNGOS <http://getmangos.com/>
 */

/* ScriptData
SDName: Boss_Renataki
SD%Complete: 100
SDComment:
SDCategory: Zul'Gurub
EndScriptData */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "zulgurub.h"

enum Spells
{
    SPELL_AMBUSH                = 34794,
    SPELL_THOUSANDBLADES        = 34799
};

enum Misc
{
    EQUIP_ID_MAIN_HAND          = 0  //was item display id 31818, but this id does not exist
};

class boss_renataki : public CreatureScript
{
    public: boss_renataki() : CreatureScript("boss_renataki") { }

        struct boss_renatakiAI : public BossAI
        {
            boss_renatakiAI(Creature* creature) : BossAI(creature, DATA_EDGE_OF_MADNESS) { }

            uint32 Invisible_Timer;
            uint32 Ambush_Timer;
            uint32 Visible_Timer;
            uint32 Aggro_Timer;
            uint32 ThousandBlades_Timer;

            bool Invisible;
            bool Ambushed;

            void Reset()
            {
                _Reset();
                Invisible_Timer = urand(8000, 18000);
                Ambush_Timer = 3000;
                Visible_Timer = 4000;
                Aggro_Timer = urand(15000, 25000);
                ThousandBlades_Timer = urand(4000, 8000);

                Invisible = false;
                Ambushed = false;
            }

            void JustDied(Unit* /*killer*/)
            {
                _JustDied();
            }

            void EnterCombat(Unit* /*who*/)
            {
                _EnterCombat();
            }

            void UpdateAI(uint32 diff)
            {
                if (!UpdateVictim())
                    return;

                //Invisible_Timer
                if (Invisible_Timer <= diff)
                {
                    me->InterruptSpell(CURRENT_GENERIC_SPELL);

                    SetEquipmentSlots(false, EQUIP_UNEQUIP, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE);
                    me->SetDisplayId(11686);

                    me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                    Invisible = true;

                    Invisible_Timer = urand(15000, 30000);
                } else Invisible_Timer -= diff;

                if (Invisible)
                {
                    if (Ambush_Timer <= diff)
                    {
                        Unit* target = nullptr;
                        target = SelectTarget(SELECT_TARGET_RANDOM, 0);
                        if (target)
                        {
                            me->NearTeleportTo(target->GetPositionX(), target->GetPositionY(), target->GetPositionZ(), me->GetOrientation());
                            DoCast(target, SPELL_AMBUSH);
                        }

                        Ambushed = true;
                        Ambush_Timer = 3000;
                    } else Ambush_Timer -= diff;
                }

                if (Ambushed)
                {
                    if (Visible_Timer <= diff)
                    {
                        me->InterruptSpell(CURRENT_GENERIC_SPELL);

                        me->SetDisplayId(15268);
                        SetEquipmentSlots(false, EQUIP_ID_MAIN_HAND, EQUIP_NO_CHANGE, EQUIP_NO_CHANGE);

                        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
                        Invisible = false;

                        Visible_Timer = 4000;
                    } else Visible_Timer -= diff;
                }

                //Resetting some aggro so he attacks other gamers
                if (!Invisible)
                {
                    if (Aggro_Timer <= diff)
                    {
                        Unit* target = nullptr;
                        target = SelectTarget(SELECT_TARGET_RANDOM, 1);

                        if (DoGetThreat(me->GetVictim()))
                            DoModifyThreatPercent(me->GetVictim(), -50);

                        if (target)
                            AttackStart(target);

                        Aggro_Timer = urand(7000, 20000);
                    } else Aggro_Timer -= diff;

                    if (ThousandBlades_Timer <= diff)
                    {
                        DoCastVictim(SPELL_THOUSANDBLADES);
                        ThousandBlades_Timer = urand(7000, 12000);
                    } else ThousandBlades_Timer -= diff;
                }

                DoMeleeAttackIfReady();
            }
        };

        CreatureAI* GetAI(Creature* creature) const
        {
            return new boss_renatakiAI(creature);
        }
};

void AddSC_boss_renataki()
{
    new boss_renataki();
}


/*
 * This file is part of the AzerothCore Project. See AUTHORS file for Copyright information
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Affero General Public License as published by the
 * Free Software Foundation; either version 3 of the License, or (at your
 * option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program. If not, see <http://www.gnu.org/licenses/>.
 */

#include "ScriptMgr.h"
#include "ScriptedCreature.h"
#include "the_botanica.h"

enum Spells
{
    SPELL_ALLERGIC_REACTION    = 34697,
    SPELL_TELEPORT_SELF        = 34673,

    SPELL_SUMMON_LASHER_1      = 34681,
    SPELL_SUMMON_FLAYER_1      = 34682,
    SPELL_SUMMON_LASHER_2      = 34684,
    SPELL_SUMMON_FLAYER_2      = 34685,
    SPELL_SUMMON_LASHER_3      = 34686,
    SPELL_SUMMON_FLAYER_4      = 34687,
    SPELL_SUMMON_LASHER_4      = 34688,
    SPELL_SUMMON_FLAYER_3      = 34690,

    SPELL_DAMAGE_IMMUNE_ARCANE  = 34304,
    SPELL_DAMAGE_IMMUNE_FIRE    = 34305,
    SPELL_DAMAGE_IMMUNE_FROST   = 34306,
    SPELL_DAMAGE_IMMUNE_NATURE  = 34308,
    SPELL_DAMAGE_IMMUNE_SHADOW  = 34309
};

enum Misc
{
    EMOTE_SUMMON               = 0,
    MODEL_DEFAULT              = 13109,
    MODEL_ARCANE               = 14213,
    MODEL_FIRE                 = 13110,
    MODEL_FROST                = 14112,
    MODEL_NATURE               = 14214,
};

struct LajTransformData
{
    uint32 spellId;
    uint32 modelId;
};

LajTransformData const LajTransform[5] =
{
    { SPELL_DAMAGE_IMMUNE_SHADOW, MODEL_DEFAULT },
    { SPELL_DAMAGE_IMMUNE_ARCANE, MODEL_ARCANE  },
    { SPELL_DAMAGE_IMMUNE_FIRE,   MODEL_FIRE    },
    { SPELL_DAMAGE_IMMUNE_FROST,  MODEL_FROST   },
    { SPELL_DAMAGE_IMMUNE_NATURE, MODEL_NATURE  }
};

struct boss_laj : public BossAI
{
    boss_laj(Creature* creature) : BossAI(creature, DATA_LAJ) { }

    void Reset() override
    {
        _Reset();
        me->SetDisplayId(MODEL_DEFAULT);
        _lastTransform = LajTransform[0];
        DoCastSelf(SPELL_DAMAGE_IMMUNE_SHADOW, true);

        if (_transformContainer.empty())
        {
            for (auto const& val : LajTransform)
            {
                _transformContainer.push_back(val);
            }
        }
    }

    void JustEngagedWith(Unit* /*who*/) override
    {
        _JustEngagedWith();

        scheduler.Schedule(5s, [this](TaskContext context)
        {
            DoCastVictim(SPELL_ALLERGIC_REACTION);
            context.Repeat(25s);
        }).Schedule(30s, [this](TaskContext context)
        {
            me->RemoveAurasDueToSpell(_lastTransform.spellId);
            _lastTransform = Acore::Containers::SelectRandomContainerElementIf(_transformContainer, [&](LajTransformData data) -> bool
            {
                return data.spellId != _lastTransform.spellId;
            });
            me->SetDisplayId(_lastTransform.modelId);
            DoCastSelf(_lastTransform.spellId, true);
            context.Repeat(35s);
        }).Schedule(20s, [this](TaskContext context)
        {
            DoCastSelf(SPELL_TELEPORT_SELF);
            me->SetReactState(REACT_PASSIVE);
            me->GetMotionMaster()->Clear();

            scheduler.Schedule(2500ms, [this](TaskContext)
            {
                Talk(EMOTE_SUMMON);
                DoCastAOE(SPELL_SUMMON_LASHER_1, true);
                DoCastAOE(SPELL_SUMMON_FLAYER_1, true);
                me->SetReactState(REACT_AGGRESSIVE);
                me->ResumeChasingVictim();
            });

            context.Repeat(30s);
        });
    }

private:
    LajTransformData _lastTransform;
    std::vector<LajTransformData> _transformContainer;
};

void AddSC_boss_laj()
{
    RegisterTheBotanicaCreatureAI(boss_laj);
}

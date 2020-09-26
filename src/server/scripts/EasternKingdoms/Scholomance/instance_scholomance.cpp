/*
 * Originally written by Xinef - Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
*/

#include "ScriptMgr.h"
#include "InstanceScript.h"
#include "Player.h"
#include "scholomance.h"
#include "GameObjectAI.h"
#include "SpellScript.h"
#include "SpellAuras.h"

class instance_scholomance : public InstanceMapScript
{
    public:
        instance_scholomance() : InstanceMapScript("instance_scholomance", 289) { }

        InstanceScript* GetInstanceScript(InstanceMap* map) const
        {
            return new instance_scholomance_InstanceMapScript(map);
        }

        struct instance_scholomance_InstanceMapScript : public InstanceScript
        {
            instance_scholomance_InstanceMapScript(Map* map) : InstanceScript(map),
                GateKirtonosGUID { 0 },
                GateMiliciaGUID  { 0 },
                GateTheolenGUID  { 0 },
                GatePolkeltGUID  { 0 },
                GateRavenianGUID { 0 },
                GateBarovGUID    { 0 },
                GateIlluciaGUID  { 0 },
                _kirtonosState   { 0 },
                _miniBosses      { 0 },
                _rasHuman        { 0 }
            { }

            void OnGameObjectCreate(GameObject* go)
            {
                switch (go->GetEntry())
                {
                    case GO_GATE_KIRTONOS:
                        GateKirtonosGUID = go->GetGUID();
                        break;
                    case GO_GATE_MALICIA:
                        GateMiliciaGUID = go->GetGUID();
                        break;
                    case GO_GATE_THEOLEN:
                        GateTheolenGUID = go->GetGUID();
                        break;
                    case GO_GATE_POLKELT:
                        GatePolkeltGUID = go->GetGUID();
                        break;
                    case GO_GATE_RAVENIAN:
                        GateRavenianGUID = go->GetGUID();
                        break;
                    case GO_GATE_BAROV:
                        GateBarovGUID = go->GetGUID();
                        break;
                    case GO_GATE_ILLUCIA:
                        GateIlluciaGUID = go->GetGUID();
                        break;
                }
            }

            uint64 GetData64(uint32 type) const
            {
                switch (type)
                {
                    case GO_GATE_KIRTONOS:
                        return GateKirtonosGUID;
                    case GO_GATE_MALICIA:
                        return GateMiliciaGUID;
                    case GO_GATE_THEOLEN:
                        return GateTheolenGUID;
                    case GO_GATE_POLKELT:
                        return GatePolkeltGUID;
                    case GO_GATE_RAVENIAN:
                        return GateRavenianGUID;
                    case GO_GATE_BAROV:
                        return GateBarovGUID;
                    case GO_GATE_ILLUCIA:
                        return GateIlluciaGUID;
                }

                return 0;
            }

            void SetData(uint32 type, uint32 data)
            {
                switch (type)
                {
                    case DATA_KIRTONOS_THE_HERALD:
                        _kirtonosState = data;
                        break;
                    case DATA_MINI_BOSSES:
                        ++_miniBosses;
                        break;
                    case DATA_RAS_HUMAN:
                        _rasHuman = data;
                        break;
                }

                SaveToDB();
            }

            uint32 GetData(uint32 type) const
            {
                switch (type)
                {
                    case DATA_KIRTONOS_THE_HERALD:
                        return _kirtonosState;
                    case DATA_MINI_BOSSES:
                        return _miniBosses;
                    case DATA_RAS_HUMAN:
                        return _rasHuman;
                }
                return 0;
            }

            std::string GetSaveData()
            {
                std::ostringstream saveStream;
                saveStream << "S O " << _kirtonosState << ' ' << _miniBosses;
                return saveStream.str();
            }

            void Load(const char* str)
            {
                if (!str)
                    return;

                char dataHead1, dataHead2;
                std::istringstream loadStream(str);
                loadStream >> dataHead1 >> dataHead2;

                if (dataHead1 == 'S' && dataHead2 == 'O')
                {
                    loadStream >> _kirtonosState;
                    loadStream >> _miniBosses;

                    if (_kirtonosState == IN_PROGRESS)
                        _kirtonosState = NOT_STARTED;
                }
            }

        protected:
            uint64 GateKirtonosGUID;
            uint64 GateMiliciaGUID;
            uint64 GateTheolenGUID;
            uint64 GatePolkeltGUID;
            uint64 GateRavenianGUID;
            uint64 GateBarovGUID;
            uint64 GateIlluciaGUID;

            uint32 _kirtonosState;
            uint32 _miniBosses;
            uint32 _rasHuman;
        };
};

class spell_scholomance_fixate : public SpellScriptLoader
{
    public:
        spell_scholomance_fixate() : SpellScriptLoader("spell_scholomance_fixate") { }

        class spell_scholomance_fixate_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_scholomance_fixate_AuraScript);

            void HandleEffectApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if (Unit* caster = GetCaster())
                    caster->TauntApply(target);
            }

            void HandleEffectRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                Unit* target = GetTarget();
                if (Unit* caster = GetCaster())
                    caster->TauntFadeOut(target);
            }

            void Register()
            {
                OnEffectApply += AuraEffectApplyFn(spell_scholomance_fixate_AuraScript::HandleEffectApply, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
                OnEffectRemove += AuraEffectRemoveFn(spell_scholomance_fixate_AuraScript::HandleEffectRemove, EFFECT_0, SPELL_AURA_DUMMY, AURA_EFFECT_HANDLE_REAL);
            }

        };

        AuraScript* GetAuraScript() const
        {
            return new spell_scholomance_fixate_AuraScript();
        }
};

class spell_kormok_summon_bone_mages : SpellScriptLoader
{
    public:
        spell_kormok_summon_bone_mages() : SpellScriptLoader("spell_kormok_summon_bone_mages") { }

        class spell_kormok_summon_bone_magesSpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kormok_summon_bone_magesSpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);
                for (uint8 i = 0; i < 2; ++i)
                        GetCaster()->CastSpell(GetCaster(), SPELL_SUMMON_BONE_MAGE_FRONT_LEFT+urand(0, 3), true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_kormok_summon_bone_magesSpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kormok_summon_bone_magesSpellScript();
        }
};

class spell_kormok_summon_bone_minions : SpellScriptLoader
{
    public:
       spell_kormok_summon_bone_minions() : SpellScriptLoader("spell_kormok_summon_bone_minions") { }

        class spell_kormok_summon_bone_minionsSpellScript : public SpellScript
        {
            PrepareSpellScript(spell_kormok_summon_bone_minionsSpellScript);

            void HandleScript(SpellEffIndex effIndex)
            {
                PreventHitDefaultEffect(effIndex);

                for (uint32 i = 0; i < 4; ++i)
                    GetCaster()->CastSpell(GetCaster(), SPELL_SUMMON_BONE_MINION1+i, true);
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_kormok_summon_bone_minionsSpellScript::HandleScript, EFFECT_0, SPELL_EFFECT_SCRIPT_EFFECT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_kormok_summon_bone_minionsSpellScript();
        }
};

enum Rooms
{
    ROOM_HALL_OF_SECRETS        = 0,
    ROOM_HALL_OF_THE_DAMNED     = 1,
    ROOM_THE_COVEN              = 2,
    ROOM_THE_SHADOW_VAULT       = 3,
    ROOM_BAROV_FAMILY_VAULT     = 4,
    ROOM_VAULT_OF_THE_RAVENIAN  = 5,
    ROOM_MAX                    = 6
};

class spell_scholomance_shadow_portal : public SpellScriptLoader
{
    public:
        spell_scholomance_shadow_portal() : SpellScriptLoader("spell_scholomance_shadow_portal") { }

        class spell_scholomance_shadow_portal_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_scholomance_shadow_portal_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_UNIT;
            }

            void HandleDummy(SpellEffIndex /*effIndex*/)
            {
                Creature* caster = GetCaster()->ToCreature();
                uint8 attempts = 0;
                uint8 room = urand(ROOM_HALL_OF_SECRETS, ROOM_VAULT_OF_THE_RAVENIAN);
                uint32 spellId = 0;

                while (attempts < ROOM_MAX)
                {
                    switch (room)
                    {
                        case ROOM_HALL_OF_SECRETS:
                            if (InstanceScript* instance = caster->GetInstanceScript())
                                if (GameObject* gate = ObjectAccessor::GetGameObject(*caster, instance->GetData64(GO_GATE_RAVENIAN)))
                                    if (gate->GetGoState() == GO_STATE_ACTIVE)
                                        spellId = SPELL_SHADOW_PORTAL_HALLOFSECRETS;
                            break;
                        case ROOM_HALL_OF_THE_DAMNED:
                            if (InstanceScript* instance = caster->GetInstanceScript())
                                if (GameObject* gate = ObjectAccessor::GetGameObject(*caster, instance->GetData64(GO_GATE_THEOLEN)))
                                    if (gate->GetGoState() == GO_STATE_ACTIVE)
                                        spellId = SPELL_SHADOW_PORTAL_HALLOFTHEDAMNED;
                            break;
                        case ROOM_THE_COVEN:
                            if (InstanceScript* instance = caster->GetInstanceScript())
                                if (GameObject* gate = ObjectAccessor::GetGameObject(*caster, instance->GetData64(GO_GATE_MALICIA)))
                                    if (gate->GetGoState() == GO_STATE_ACTIVE)
                                        spellId = SPELL_SHADOW_PORTAL_THECOVEN;
                            break;
                        case ROOM_THE_SHADOW_VAULT:
                            if (InstanceScript* instance = caster->GetInstanceScript())
                                if (GameObject* gate = ObjectAccessor::GetGameObject(*caster, instance->GetData64(GO_GATE_ILLUCIA)))
                                    if (gate->GetGoState() == GO_STATE_ACTIVE)
                                        spellId = SPELL_SHADOW_PORTAL_THESHADOWVAULT;
                            break;
                        case ROOM_BAROV_FAMILY_VAULT:
                            if (InstanceScript* instance = caster->GetInstanceScript())
                                if (GameObject* gate = ObjectAccessor::GetGameObject(*caster, instance->GetData64(GO_GATE_BAROV)))
                                    if (gate->GetGoState() == GO_STATE_ACTIVE)
                                        spellId = SPELL_SHADOW_PORTAL_BAROVFAMILYVAULT;
                            break;
                        case ROOM_VAULT_OF_THE_RAVENIAN:
                            if (InstanceScript* instance = caster->GetInstanceScript())
                                if (GameObject* gate = ObjectAccessor::GetGameObject(*caster, instance->GetData64(GO_GATE_POLKELT)))
                                    if (gate->GetGoState() == GO_STATE_ACTIVE)
                                        spellId = SPELL_SHADOW_PORTAL_VAULTOFTHERAVENIAN;
                            break;
                    }

                    if (spellId)
                    {
                        caster->CastSpell(GetHitUnit(), spellId, true);
                        break;
                    }
                    else
                    {
                        room = (room+1)%ROOM_MAX;
                        ++attempts;
                    }
                }
            }

            void Register()
            {
                OnEffectHitTarget += SpellEffectFn(spell_scholomance_shadow_portal_SpellScript::HandleDummy, EFFECT_0, SPELL_EFFECT_DUMMY);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_scholomance_shadow_portal_SpellScript();
        }
};

Position const SummonPos[3*ROOM_MAX] =
{
    // Hall of Secrects
    { 230.80f, 0.138f, 85.23f, 0.0f },
    { 241.23f, -6.979f, 85.23f, 0.0f },
    { 246.65f, 4.227f, 84.85f, 0.0f },
    // The Hall of the damned
    { 177.9624f, -68.23893f, 84.95197f, 3.228859f },
    { 183.7705f, -61.43489f, 84.92424f, 5.148721f },
    { 184.7035f, -77.74805f, 84.92424f, 4.660029f },
    // The Coven
    { 111.7203f, -1.105035f, 85.45985f, 3.961897f },
    { 118.0079f, 6.430664f, 85.31169f, 2.408554f },
    { 120.0276f, -7.496636f, 85.31169f, 2.984513f },
    // The Shadow Vault
    { 245.3716f, 0.628038f, 72.73877f, 0.01745329f },
    { 240.9920f, 3.405653f, 72.73877f, 6.143559f },
    { 240.9543f, -3.182943f, 72.73877f, 0.2268928f },
    // Barov Family Vault
    { 181.8245f, -42.58117f, 75.4812f, 4.660029f },
    { 177.7456f, -42.74745f, 75.4812f, 4.886922f },
    { 185.6157f, -42.91200f, 75.4812f, 4.45059f },
    // Vault of the Ravenian
    { 136.362f, 6.221f, 75.40f, 3.14f },
    { 130.79f, -0.91f, 75.40f, 3.14f },
    { 136.362f, -8.221f, 75.40f, 3.14f },
};

class spell_scholomance_shadow_portal_rooms : public SpellScriptLoader
{
    public:
        spell_scholomance_shadow_portal_rooms() : SpellScriptLoader("spell_scholomance_shadow_portal_rooms") { }

        class spell_scholomance_shadow_portal_rooms_SpellScript : public SpellScript
        {
            PrepareSpellScript(spell_scholomance_shadow_portal_rooms_SpellScript);

            bool Load()
            {
                return GetCaster()->GetTypeId() == TYPEID_UNIT;
            }

            void HandleSendEvent(SpellEffIndex effIndex)
            {
                PreventHitEffect(effIndex);
                Creature* caster = GetCaster()->ToCreature();

                uint8 summonPos = 0;
                uint32 gateId = 0;

                switch (GetSpellInfo()->Id)
                {
                    case SPELL_SHADOW_PORTAL_HALLOFSECRETS:
                        summonPos = ROOM_HALL_OF_SECRETS*3;
                        gateId = GO_GATE_POLKELT;
                        break;
                    case SPELL_SHADOW_PORTAL_HALLOFTHEDAMNED:
                        summonPos = ROOM_HALL_OF_THE_DAMNED*3;
                        gateId = GO_GATE_THEOLEN;
                        break;
                    case SPELL_SHADOW_PORTAL_THECOVEN:
                        summonPos = ROOM_THE_COVEN*3;
                        gateId = GO_GATE_MALICIA;
                        break;
                    case SPELL_SHADOW_PORTAL_THESHADOWVAULT:
                        summonPos = ROOM_THE_SHADOW_VAULT*3;
                        gateId = GO_GATE_ILLUCIA;
                        break;
                    case SPELL_SHADOW_PORTAL_BAROVFAMILYVAULT:
                        summonPos = ROOM_BAROV_FAMILY_VAULT*4;
                        gateId = GO_GATE_BAROV;
                        break;
                    case SPELL_SHADOW_PORTAL_VAULTOFTHERAVENIAN:
                        summonPos = ROOM_VAULT_OF_THE_RAVENIAN*3;
                        gateId = GO_GATE_RAVENIAN;
                        break;
                }

                if (gateId && (GetCaster()->GetMap()->GetId() == 289))
                {
                    for (uint8 i = 0; i < 3; ++i)
                    {
                        if (Creature* summon = GetCaster()->SummonCreature(NPC_RISEN_GUARDIAN, SummonPos[summonPos+i], TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 120000))
                        {
                            summon->GetMotionMaster()->MoveRandom(8.0f);
                            summon->AI()->SetData(0, summonPos/3 + 1);
                        }
                    }

                    if (InstanceScript* instance = GetCaster()->GetInstanceScript())
                        if (GameObject* gate = ObjectAccessor::GetGameObject(*caster, instance->GetData64(gateId)))
                        {
                            gate->SetGoState(GO_STATE_READY);
                            gate->AI()->SetData(1, 1);
                        }
                }
            }

            void Register()
            {
                OnEffectHit += SpellEffectFn(spell_scholomance_shadow_portal_rooms_SpellScript::HandleSendEvent, EFFECT_1, SPELL_EFFECT_SEND_EVENT);
            }
        };

        SpellScript* GetSpellScript() const
        {
            return new spell_scholomance_shadow_portal_rooms_SpellScript();
        }
};

class spell_scholomance_boon_of_life : public SpellScriptLoader
{
    public:
        spell_scholomance_boon_of_life() : SpellScriptLoader("spell_scholomance_boon_of_life") { }

        class spell_scholomance_boon_of_life_AuraScript : public AuraScript
        {
            PrepareAuraScript(spell_scholomance_boon_of_life_AuraScript);

            void OnApply(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* caster = GetCaster())
                    if (Unit* target = GetTarget())
                        if (Creature* creature = target->ToCreature())
                        {
                            creature->AI()->AttackStart(caster);
                            creature->AddThreat(caster, 10000.0f);
                        }
            }

            void OnRemove(AuraEffect const* /*aurEff*/, AuraEffectHandleModes /*mode*/)
            {
                if (Unit* target = GetTarget())
                    if (Creature* creature = target->ToCreature())
                        if (GetTargetApplication()->GetRemoveMode() != AURA_REMOVE_BY_CANCEL)
                        {
                            creature->AI()->Talk(TALK_RAS_HUMAN);
                            creature->SetDisplayId(MODEL_RAS_HUMAN);
                            creature->SetHealth(target->GetMaxHealth());
                            if (InstanceScript* instance = creature->GetInstanceScript())
                                instance->SetData(DATA_RAS_HUMAN,1);
                    }
            }

            void Register()
            {
                OnEffectRemove += AuraEffectRemoveFn(spell_scholomance_boon_of_life_AuraScript::OnRemove, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
                AfterEffectApply += AuraEffectApplyFn(spell_scholomance_boon_of_life_AuraScript::OnApply, EFFECT_0, SPELL_AURA_PERIODIC_TRIGGER_SPELL, AURA_EFFECT_HANDLE_REAL);
            }
        };

        AuraScript* GetAuraScript() const
        {
            return new spell_scholomance_boon_of_life_AuraScript();
        }
};

void AddSC_instance_scholomance()
{
    new instance_scholomance();
    new spell_scholomance_fixate();
    new spell_kormok_summon_bone_mages();
    new spell_kormok_summon_bone_minions();
    new spell_scholomance_shadow_portal();
    new spell_scholomance_shadow_portal_rooms();
    new spell_scholomance_boon_of_life();
}

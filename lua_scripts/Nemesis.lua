local BOSS_ID = 70004

-- Spell IDs (usadas como base do Ick)
local SPELL_ACID_BREATH   = 24839
local SPELL_INFECTION     = 24928
local SPELL_WRATH_AURA    = 68987
local SPELL_POISON_NOVA   = 68989

-- Armazenar fases para cada instância do boss
local phaseMap = {}

-- Casts com escalonamento
local function CastAcidBreath(eventId, delay, repeats, creature)
    if not creature:IsInCombat() then return end
    local target = creature:GetVictim()
    if target then
        creature:CastSpell(target, SPELL_ACID_BREATH, false)
    end
end

local function CastInfection(eventId, delay, repeats, creature)
    if not creature:IsInCombat() then return end
    local target = creature:GetVictim()
    if target then
        creature:CastSpell(target, SPELL_INFECTION, true)
    end
end

local function CastWrathAura(eventId, delay, repeats, creature)
    if not creature:IsInCombat() then return end
    creature:CastSpell(creature, SPELL_WRATH_AURA, true)
end

-- Após Poison Nova, escalar habilidades
local function ResumeAfterNova(eventId, delay, repeats, creature)
    if not creature:IsInCombat() then return end

    local guid = creature:GetGUIDLow()
    phaseMap[guid] = (phaseMap[guid] or 0) + 1
    local phase = phaseMap[guid]

    creature:Unroot()

    local target = creature:GetVictim()
    if target then
        creature:AttackStart(target)
    end

    -- Escalonamento progressivo das habilidades
    local acidCD   = math.max(10000 - (phase * 1000), 4000)
    local infectCD = math.max(15000 - (phase * 1000), 6000)
    local auraCD   = math.max(20000 - (phase * 1000), 8000)

    creature:RegisterEvent(CastAcidBreath,  acidCD, 0)
    creature:RegisterEvent(CastInfection,   infectCD, 0)
    creature:RegisterEvent(CastWrathAura,   auraCD, 0)

    -- Registrar próxima Poison Nova
    creature:RegisterEvent(CastPoisonNova, 60000, 1)
end

-- Poison Nova com proteção
function CastPoisonNova(eventId, delay, repeats, creature)
    if not creature:IsInCombat() then return end

    creature:RemoveEvents()
    creature:AttackStop()
    creature:Root()
    creature:CastSpell(creature, SPELL_POISON_NOVA, false)

    -- Após 3s, retoma combate e escala
    creature:RegisterEvent(ResumeAfterNova, 3000, 1)
end

-- Ao entrar em combate
function OnEnterCombat(event, creature, target)
    creature:SendUnitYell("A Praga Vai Consumir Todos Vocês!", 0)
    local guid = creature:GetGUIDLow()
    phaseMap[guid] = 0

    -- Primeira rodada de habilidades
    creature:RegisterEvent(CastAcidBreath,  10000, 0)
    creature:RegisterEvent(CastInfection,   15000, 0)
    creature:RegisterEvent(CastWrathAura,   20000, 0)

    -- Começar ciclo da Poison Nova
    creature:RegisterEvent(CastPoisonNova, 60000, 1)
end

-- Sair de combate
function OnLeaveCombat(event, creature)
    creature:RemoveEvents()
end

-- Ao morrer
function OnDied(event, creature, killer)
    creature:RemoveEvents()
    local guid = creature:GetGUIDLow()
    phaseMap[guid] = nil
end

-- Registro
RegisterCreatureEvent(BOSS_ID, 1, OnEnterCombat)
RegisterCreatureEvent(BOSS_ID, 2, OnLeaveCombat)
RegisterCreatureEvent(BOSS_ID, 4, OnDied)

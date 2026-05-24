-- ============================================================================
-- Black Rose login overlay - particle / flicker FX (pure-Lua build).
-- ============================================================================
-- This source is APPENDED onto the user's stock GlueParent.lua by
-- tools/clientpatch/build_patch.py. It is NOT shipped as its own file
-- in the patch; we never modify any glue XML and we never introduce a
-- new file at a glue-system path - both of those tripped
-- "Your login interface files are corrupt please reinstall the game"
-- in earlier attempts (the glue XML parser appears to reject second
-- <Script> directives, and brand-new Lua files at glue paths are
-- rejected too).
--
-- What this code does:
--   * creates a BlackRoseLogin overlay frame programmatically
--     (parented to GlueParent, frame strata = BACKGROUND so the login
--      form stays on top)
--   * paints our backdrop, two black vignettes, 36 ember particles
--     and 8 ash motes - all via CreateTexture using stock client
--     assets (Login-Blackrose.blp + Interface\Buttons\WHITE8X8)
--   * runs a torchlight flicker on the BG and animates the particles
--     in OnUpdate
--   * defensively hides AccountLoginModel + AccountLogin's BG-layer
--     regions when AccountLogin loads
--   * calls PlayMusic() on the replacement title MP3
--
-- Tunables live at the top of the file. All of the heavy lifting is
-- inside `BR_init()` which is called from a one-shot watchdog OnUpdate
-- so we wait for GlueParent (and AccountLogin) to exist before we
-- touch anything - this code runs while GlueParent.lua is being
-- loaded by GlueParent.xml's <Script> directive, BEFORE the
-- <Frame name="GlueParent"> tag in the same file is processed. So
-- GlueParent the frame does NOT yet exist at top-of-chunk time.
--
-- All identifiers are prefixed BR_ to avoid colliding with any stock
-- GlueParent.lua locals/globals; we share a Lua chunk with the stock
-- GlueParent.lua.
-- ============================================================================

local BR_PARTICLE_TEXTURE = "Interface\\Buttons\\WHITE8X8"
local BR_BG_TEXTURE       = "Interface\\Glues\\LoadingScreens\\Login-Blackrose"
local BR_MUSIC_PATH       = "Sound\\Music\\GlueScreenMusic\\WotlkTitleScreen.mp3"

local BR_NUM_EMBERS       = 36
local BR_NUM_ASH          = 8

-- Ember palette weights. 0..PALETTE_RED is crimson, ..PALETTE_AMBER is
-- amber, the remainder is sickly green (echoes the skull's eye-glow).
local BR_PALETTE_RED      = 0.65
local BR_PALETTE_AMBER    = 0.85

-- ---------------------------------------------------------------------------

local BR_frame
local BR_bgTex
local BR_embers = {}
local BR_motes  = {}
local BR_elapsedTotal = 0

local function BR_rand(a, b)
    return a + math.random() * (b - a)
end

local function BR_randomEmberColor()
    local roll = math.random()
    if roll < BR_PALETTE_RED then
        return BR_rand(0.85, 1.00), BR_rand(0.10, 0.30), BR_rand(0.05, 0.12)
    elseif roll < BR_PALETTE_AMBER then
        return BR_rand(0.95, 1.00), BR_rand(0.45, 0.65), BR_rand(0.10, 0.20)
    else
        return BR_rand(0.20, 0.45), BR_rand(0.70, 1.00), BR_rand(0.20, 0.40)
    end
end

local function BR_spawnEmber(e, w, h)
    e.x         = BR_rand(-w * 0.5 + 20, w * 0.5 - 20)
    e.y         = -h * 0.5 + BR_rand(-20, 60)
    e.vx        = BR_rand(-12, 12)
    e.vy        = BR_rand(28, 70)
    e.swayAmp   = BR_rand(8, 26)
    e.swayPhase = BR_rand(0, math.pi * 2)
    e.swaySpeed = BR_rand(0.6, 1.4)
    e.life      = 0
    e.maxLife   = BR_rand(4.0, 8.5)
    e.size      = BR_rand(2, 5)
    e.r, e.g, e.b = BR_randomEmberColor()
    e.peakAlpha = BR_rand(0.55, 0.95)
end

local function BR_spawnMote(m, w, h)
    m.x         = BR_rand(-w * 0.5, w * 0.5)
    m.y         = BR_rand(-h * 0.4, h * 0.4)
    m.vx        = BR_rand(-10, 10)
    m.vy        = BR_rand(-4, 4)
    m.life      = 0
    m.maxLife   = BR_rand(10, 22)
    m.size      = BR_rand(3, 7)
    local v     = BR_rand(0.55, 0.75)
    m.r, m.g, m.b = v, v * 0.97, v * 0.92
    m.peakAlpha = BR_rand(0.10, 0.22)
end

-- ---------------------------------------------------------------------------

local function BR_tryCleanupAccountLogin()
    if not AccountLogin then return end
    if BR_frame.cleanedAccountLogin then return end

    if AccountLoginModel then
        AccountLoginModel:Hide()
    end

    if AccountLogin.GetRegions then
        local regions = { AccountLogin:GetRegions() }
        for i = 1, #regions do
            local r = regions[i]
            if r and r.GetObjectType and r:GetObjectType() == "Texture" then
                local layer = "BACKGROUND"
                if r.GetDrawLayer then layer = r:GetDrawLayer() end
                if layer == "BACKGROUND" or layer == "BORDER" or layer == "ARTWORK" then
                    r:SetAlpha(0)
                end
            end
        end
    end

    BR_frame.cleanedAccountLogin = true
end

local function BR_onUpdate(self, elapsed)
    elapsed = elapsed or 0
    BR_elapsedTotal = BR_elapsedTotal + elapsed

    BR_tryCleanupAccountLogin()

    local screenW, screenH = self:GetWidth(), self:GetHeight()
    if screenW < 100 or screenH < 100 then return end

    if BR_bgTex then
        local breath = 0.92 + 0.08 * math.sin(BR_elapsedTotal * 0.55)
        local jitter = 1.0 + (math.random() - 0.5) * 0.035
        local v      = breath * jitter
        BR_bgTex:SetVertexColor(v, v * 0.96, v * 0.92, 1.0)
    end

    for i = 1, BR_NUM_EMBERS do
        local e = BR_embers[i]
        e.life = e.life + elapsed
        if e.life >= e.maxLife then
            BR_spawnEmber(e, screenW, screenH)
        end

        local t01  = e.life / e.maxLife
        local fade
        if t01 < 0.15 then
            fade = t01 / 0.15
        else
            fade = 1.0 - (t01 - 0.15) / 0.85
        end
        if fade < 0 then fade = 0 end
        if fade > 1 then fade = 1 end

        local sway = math.sin(BR_elapsedTotal * e.swaySpeed + e.swayPhase) * e.swayAmp
        local x    = e.x + e.vx * e.life + sway
        local y    = e.y + e.vy * e.life

        e.tex:SetWidth(e.size)
        e.tex:SetHeight(e.size)
        e.tex:ClearAllPoints()
        e.tex:SetPoint("CENTER", self, "CENTER", x, y)
        e.tex:SetVertexColor(e.r, e.g, e.b, fade * e.peakAlpha)
    end

    for i = 1, BR_NUM_ASH do
        local m = BR_motes[i]
        m.life = m.life + elapsed
        if m.life >= m.maxLife then
            BR_spawnMote(m, screenW, screenH)
        end
        local t01 = m.life / m.maxLife
        local fade
        if t01 < 0.5 then
            fade = t01 * 2
        else
            fade = (1 - t01) * 2
        end
        local x = m.x + m.vx * m.life
        local y = m.y + m.vy * m.life

        m.tex:SetWidth(m.size)
        m.tex:SetHeight(m.size)
        m.tex:ClearAllPoints()
        m.tex:SetPoint("CENTER", self, "CENTER", x, y)
        m.tex:SetVertexColor(m.r, m.g, m.b, fade * m.peakAlpha)
    end
end

local function BR_onShow()
    if PlayMusic then
        PlayMusic(BR_MUSIC_PATH)
    end
end

-- ---------------------------------------------------------------------------

local function BR_init()
    if BR_frame then return true end
    if not GlueParent then return false end
    if not CreateFrame then return false end

    BR_frame = CreateFrame("Frame", "BlackRoseLogin", GlueParent)
    BR_frame:SetFrameStrata("BACKGROUND")
    BR_frame:EnableMouse(false)
    BR_frame:SetAllPoints(GlueParent)

    -- Backdrop
    BR_bgTex = BR_frame:CreateTexture("BlackRoseLoginBG", "BACKGROUND")
    BR_bgTex:SetTexture(BR_BG_TEXTURE)
    BR_bgTex:SetAllPoints(BR_frame)

    -- Top vignette
    local vTop = BR_frame:CreateTexture(nil, "ARTWORK")
    vTop:SetTexture(BR_PARTICLE_TEXTURE)
    vTop:SetVertexColor(0, 0, 0, 0.55)
    vTop:SetPoint("TOPLEFT",  BR_frame, "TOPLEFT",  0, 0)
    vTop:SetPoint("TOPRIGHT", BR_frame, "TOPRIGHT", 0, 0)
    vTop:SetHeight(160)

    -- Bottom vignette
    local vBot = BR_frame:CreateTexture(nil, "ARTWORK")
    vBot:SetTexture(BR_PARTICLE_TEXTURE)
    vBot:SetVertexColor(0, 0, 0, 0.65)
    vBot:SetPoint("BOTTOMLEFT",  BR_frame, "BOTTOMLEFT",  0, 0)
    vBot:SetPoint("BOTTOMRIGHT", BR_frame, "BOTTOMRIGHT", 0, 0)
    vBot:SetHeight(220)

    -- Embers
    for i = 1, BR_NUM_EMBERS do
        local tex = BR_frame:CreateTexture(nil, "OVERLAY")
        tex:SetTexture(BR_PARTICLE_TEXTURE)
        tex:SetBlendMode("ADD")
        local e = { tex = tex }
        BR_spawnEmber(e, 1920, 1080)
        e.life = BR_rand(0, e.maxLife)
        BR_embers[i] = e
    end

    -- Ash motes
    for i = 1, BR_NUM_ASH do
        local tex = BR_frame:CreateTexture(nil, "ARTWORK")
        tex:SetTexture(BR_PARTICLE_TEXTURE)
        tex:SetBlendMode("BLEND")
        local m = { tex = tex }
        BR_spawnMote(m, 1920, 1080)
        m.life = BR_rand(0, m.maxLife)
        BR_motes[i] = m
    end

    BR_frame:SetScript("OnUpdate", BR_onUpdate)
    BR_frame:SetScript("OnShow",   BR_onShow)

    if PlayMusic then
        PlayMusic(BR_MUSIC_PATH)
    end

    return true
end

-- This source is appended to GlueParent.lua and runs while
-- GlueParent.xml is processing the <Script file="GlueParent.lua"/>
-- directive - which is BEFORE GlueParent.xml's own
-- <Frame name="GlueParent"> tag is parsed. So GlueParent the frame
-- does not exist yet at chunk load time. Use a watchdog: every frame,
-- retry BR_init() until GlueParent is registered, then self-cancel.
if CreateFrame then
    local BR_watchdog = CreateFrame("Frame")
    BR_watchdog:SetScript("OnUpdate", function(self)
        if BR_init() then
            self:SetScript("OnUpdate", nil)
        end
    end)
end

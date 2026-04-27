--[[
  WotLK 3.3.5 default UI (FrameXML/StaticPopup.lua):
  - RECOVER_CORPSE / RECOVER_CORPSE_INSTANCE -> RetrieveCorpse()
  - RESURRECT / RESURRECT_NO_SICKNESS / RESURRECT_NO_TIMER -> AcceptResurrect()
    (corpse timer + player-cast resurrections share these)

  Server already rejects CMSG_RECLAIM_CORPSE; this only hides client prompts.
  Blocking RESURRECT* also hides spell-rez Accept dialogs while addon is enabled.
]]

local BLOCK = {
    RECOVER_CORPSE = true,
    RECOVER_CORPSE_INSTANCE = true,
    RESURRECT = true,
    RESURRECT_NO_SICKNESS = true,
    RESURRECT_NO_TIMER = true,
}

local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_LOGIN")
frame:SetScript("OnEvent", function(self)
    self:UnregisterAllEvents()
    if not StaticPopup_Show or type(StaticPopup_Show) ~= "function" then
        return
    end
    local orig = StaticPopup_Show
    function StaticPopup_Show(which, text_arg1, text_arg2, data)
        if type(which) == "string" and BLOCK[which] then
            return nil
        end
        return orig(which, text_arg1, text_arg2, data)
    end

    -- Minimap corpse/graveyard arrows are client-side textures.
    -- API availability varies by client, so call defensively.
    if Minimap then
        if type(Minimap.SetCorpsePOIArrowTexture) == "function" then
            Minimap:SetCorpsePOIArrowTexture("")
        end
        if type(Minimap.SetStaticPOIArrowTexture) == "function" then
            Minimap:SetStaticPOIArrowTexture("")
        end
    end

    -- Hide corpse marker and death-related POIs on world map while dead/ghost.
    local function IsDeathPOI(name, description)
        local n = type(name) == "string" and string.lower(name) or ""
        local d = type(description) == "string" and string.lower(description) or ""
        return string.find(n, "grave", 1, true)
            or string.find(d, "grave", 1, true)
            or string.find(n, "spirit healer", 1, true)
            or string.find(d, "spirit healer", 1, true)
    end

    local function HideDeathMapMarkers()
        if not UnitIsDeadOrGhost("player") then
            return
        end

        if WorldMapCorpse then
            WorldMapCorpse:Hide()
        end

        local i = 1
        while true do
            local poi = _G["WorldMapFramePOI" .. i]
            if not poi then
                break
            end
            if poi:IsShown() and IsDeathPOI(poi.name, poi.description) then
                poi:Hide()
            end
            i = i + 1
        end
    end

    local mapFrame = CreateFrame("Frame")
    mapFrame:RegisterEvent("WORLD_MAP_UPDATE")
    mapFrame:RegisterEvent("PLAYER_DEAD")
    mapFrame:RegisterEvent("PLAYER_UNGHOST")
    mapFrame:RegisterEvent("PLAYER_ALIVE")
    mapFrame:SetScript("OnEvent", HideDeathMapMarkers)
    hooksecurefunc("WorldMapFrame_Update", HideDeathMapMarkers)
end)

void WorldSession::ReadAddonsInfo(WorldPacket &data)
{
    if (data.rpos() + 4 > data.size())
        return;

    uint32 size;
    data >> size;

    if (!size)
        return;

    if (size > 0xFFFFF)
    {
        sLog->outError("WorldSession::ReadAddonsInfo addon info too big, size %u", size);
        return;
    }

    uLongf uSize = size;

    uint32 pos = data.rpos();

    ByteBuffer addonInfo;
    addonInfo.resize(size);

    if (uncompress(addonInfo.contents(), &uSize, data.contents() + pos, data.size() - pos) == Z_OK)
    {
        uint32 addonsCount;
        addonInfo >> addonsCount;                         // addons count

        for (uint32 i = 0; i < addonsCount; ++i)
        {
            std::string addonName;
            uint8 enabled;
            uint32 crc, unk1;

            // check next addon data format correctness
            if (addonInfo.rpos() + 1 > addonInfo.size())
                return;

            addonInfo >> addonName;

            addonInfo >> enabled >> crc >> unk1;

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
            sLog->outDetail("ADDON: Name: %s, Enabled: 0x%x, CRC: 0x%x, Unknown2: 0x%x", addonName.c_str(), enabled, crc, unk1);
#endif

            AddonInfo addon(addonName, enabled, crc, 2, true);

            SavedAddon const* savedAddon = AddonMgr::GetAddonInfo(addonName);
            if (savedAddon)
            {
                #pragma GCC diagnostic ignored "-Wunused-but-set-variable"
                bool match = true;

                if (addon.CRC != savedAddon->CRC)
                    match = false;


#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                if (!match)
                    sLog->outDetail("ADDON: %s was known, but didn't match known CRC (0x%x)!", addon.Name.c_str(), savedAddon->CRC);
                else
                    sLog->outDetail("ADDON: %s was known, CRC is correct (0x%x)", addon.Name.c_str(), savedAddon->CRC);
#endif
            }
            else
            {
                AddonMgr::SaveAddon(addon);

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
                sLog->outDetail("ADDON: %s (0x%x) was not known, saving...", addon.Name.c_str(), addon.CRC);
#endif
            }

            // TODO: Find out when to not use CRC/pubkey, and other possible states.
            m_addonsList.push_back(addon);
        }

        uint32 currentTime;
        addonInfo >> currentTime;
#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        sLog->outDebug(LOG_FILTER_NETWORKIO, "ADDON: CurrentTime: %u", currentTime);
#endif

#if defined(ENABLE_EXTRAS) && defined(ENABLE_EXTRA_LOGS)
        if (addonInfo.rpos() != addonInfo.size())
            sLog->outDebug(LOG_FILTER_NETWORKIO, "packet under-read!");
#endif
    }
    else
        sLog->outError("Addon packet uncompress error!");
}

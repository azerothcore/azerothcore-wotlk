/*
 * Copyright (C) 2016+ AzerothCore <www.azerothcore.org>, released under GNU AGPL v3 license: https://github.com/azerothcore/azerothcore-wotlk/blob/master/LICENSE-AGPL3
 */

class PlayerTaxi
{
public:
    PlayerTaxi();
    ~PlayerTaxi() = default;
    // Nodes
    void InitTaxiNodesForLevel(uint32 race, uint32 chrClass, uint8 level);
    void LoadTaxiMask(std::string const& data);

    [[nodiscard]] bool IsTaximaskNodeKnown(uint32 nodeidx) const
    {
        uint8  field   = uint8((nodeidx - 1) / 32);
        uint32 submask = 1 << ((nodeidx - 1) % 32);
        return (m_taximask[field] & submask) == submask;
    }
    bool SetTaximaskNode(uint32 nodeidx)
    {
        uint8  field   = uint8((nodeidx - 1) / 32);
        uint32 submask = 1 << ((nodeidx - 1) % 32);
        if ((m_taximask[field] & submask) != submask)
        {
            m_taximask[field] |= submask;
            return true;
        }
        else
            return false;
    }
    void AppendTaximaskTo(ByteBuffer& data, bool all);

    // Destinations
    bool LoadTaxiDestinationsFromString(std::string const& values, TeamId teamId);
    std::string SaveTaxiDestinationsToString();

    void ClearTaxiDestinations() { m_TaxiDestinations.clear(); _taxiSegment = 0; }
    void AddTaxiDestination(uint32 dest) { m_TaxiDestinations.push_back(dest); }
    [[nodiscard]] uint32 GetTaxiSource() const { return m_TaxiDestinations.size() <= _taxiSegment + 1 ? 0 : m_TaxiDestinations[_taxiSegment]; }
    [[nodiscard]] uint32 GetTaxiDestination() const { return m_TaxiDestinations.size() <= _taxiSegment + 1 ? 0 : m_TaxiDestinations[_taxiSegment + 1]; }
    [[nodiscard]] uint32 GetCurrentTaxiPath() const;
    uint32 NextTaxiDestination()
    {
        ++_taxiSegment;
        return GetTaxiDestination();
    }

    // xinef:
    void SetTaxiSegment(uint32 segment) { _taxiSegment = segment; }
    [[nodiscard]] uint32 GetTaxiSegment() const { return _taxiSegment; }

    [[nodiscard]] std::vector<uint32> const& GetPath() const { return m_TaxiDestinations; }
    [[nodiscard]] bool empty() const { return m_TaxiDestinations.empty(); }

    friend std::ostringstream& operator<< (std::ostringstream& ss, PlayerTaxi const& taxi);
private:
    TaxiMask m_taximask;
    std::vector<uint32> m_TaxiDestinations;
    uint32 _taxiSegment;
};

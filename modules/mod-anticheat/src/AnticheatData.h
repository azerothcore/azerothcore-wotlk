/*
 *MIT License
 *
 *Copyright (c) 2023 Azerothcore
 *
 *Permission is hereby granted, free of charge, to any person obtaining a copy
 *of this software and associated documentation files (the "Software"), to deal
 *in the Software without restriction, including without limitation the rights
 *to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *copies of the Software, and to permit persons to whom the Software is
 *furnished to do so, subject to the following conditions:
 *
 *The above copyright notice and this permission notice shall be included in all
 *copies or substantial portions of the Software.
 *
 *THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *SOFTWARE.
 */

#ifndef SC_ACDATA_H
#define SC_ACDATA_H

#include "AnticheatMgr.h"

#define MAX_REPORT_TYPES 15

class AnticheatData
{
public:
    AnticheatData();
    ~AnticheatData();

    void SetLastInformations(MovementInfo movementInfo, uint32 opcode, uint32 mapId, float speedRate);

    void SetLastOpcode(uint32 opcode);
    uint32 GetLastOpcode() const;

    const MovementInfo& GetLastMovementInfo() const;
    void SetLastMovementInfo(MovementInfo& moveInfo);

    [[nodiscard]] uint32 GetLastMapId() const { return lastMapId; }
    void SetLastMapId(float mapId) { lastMapId = mapId; }

    [[nodiscard]] float GetLastSpeedRate() const { return lastSpeedRate; }
    void SetLastSpeedRate(float speedRate) { lastSpeedRate = speedRate; }

    void SetPosition(float x, float y, float z, float o, uint32 mapId);

    uint32 GetTotalReports() const;
    void SetTotalReports(uint32 _totalReports);

    uint32 GetTypeReports(uint8 type) const;
    void SetTypeReports(uint8 type, uint32 amount);

    float GetAverage() const;
    void SetAverage(float _average);

    uint32 GetCreationTime() const;
    void SetCreationTime(uint32 creationTime);

    void SetTempReports(uint32 amount, uint8 type);
    uint32 GetTempReports(uint8 type);

    void SetTempReportsTimer(uint32 time, uint8 type);
    uint32 GetTempReportsTimer(uint8 type);

    void SetDailyReportState(bool b);
    bool GetDailyReportState();

    [[nodiscard]] bool GetJustUsedMovementSpell() const { return justUsedMovementSpell; }
    void SetJustUsedMovementSpell(bool value) { justUsedMovementSpell = value; }
private:
    uint32 lastOpcode;
    MovementInfo lastMovementInfo;
    uint32 lastMapId;
    float lastSpeedRate;
    uint32 totalReports;
    uint32 typeReports[MAX_REPORT_TYPES];
    float average;
    uint32 creationTime;
    uint32 tempReports[MAX_REPORT_TYPES];
    uint32 tempReportsTimer[MAX_REPORT_TYPES];
    bool hasDailyReport;
    bool justUsedMovementSpell;
};

#endif

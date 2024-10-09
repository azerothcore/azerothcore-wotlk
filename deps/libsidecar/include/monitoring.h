#ifndef __MONITORING__
#define __MONITORING__

#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>

typedef enum MonitoringErrorCode {
    MonitoringErrorCodeNoError    = 0,
    MonitoringErrorCodeNoHandler  = 1,
} MonitoringErrorCode;

// MonitoringDataCollectorResponse request.
typedef struct {
    int      errorCode;
    uint32_t connectedPlayers;
    uint32_t diffMean;
    uint32_t diffMedian;
    uint32_t diff95Percentile;
    uint32_t diff99Percentile;
    uint32_t diffMaxPercentile;
} MonitoringDataCollectorResponse;

typedef MonitoringDataCollectorResponse (*MonitoringDataCollectorHandler)();
void SetMonitoringDataCollectorHandler(MonitoringDataCollectorHandler h);
MonitoringDataCollectorResponse CallMonitoringDataCollectorHandler();

#endif

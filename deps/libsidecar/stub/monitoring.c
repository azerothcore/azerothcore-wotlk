#include "monitoring.h"

static MonitoringDataCollectorHandler monitoringDataCollectorHandler;
void SetMonitoringDataCollectorHandler(MonitoringDataCollectorHandler h) {
    monitoringDataCollectorHandler = h;
}

MonitoringDataCollectorResponse CallMonitoringDataCollectorHandler() {
    if (monitoringDataCollectorHandler == 0) {
        MonitoringDataCollectorResponse resp;
        resp.errorCode = MonitoringErrorCodeNoHandler;
        return resp;
    }

    return monitoringDataCollectorHandler();
}

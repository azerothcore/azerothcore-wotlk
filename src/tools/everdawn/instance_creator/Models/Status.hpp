#ifndef EVERDAWN_STATUS_HPP
#define EVERDAWN_STATUS_HPP

#include <wx/wxprec.h>

#ifndef WX_PRECOMP
#include <wx/wx.h>
#endif

namespace everdawn
{

    namespace StatusCode
    {
        constexpr int Idle = 1000;
        constexpr int Loading = 1001;
        constexpr int Ready = 1002;
        constexpr int Error = 1003;
    };

    struct Status
    {
        int code;
        const char* message;
    };

    class StatusChangeEvent;
    wxDECLARE_EVENT(STATUS_EVENT_TYPE, StatusChangeEvent);

    class StatusChangeEvent final : public wxCommandEvent
    {
    public:
        const Status status;
        explicit StatusChangeEvent(const Status status, const int id = 0) :wxCommandEvent(STATUS_EVENT_TYPE, id), status(status) {};
        StatusChangeEvent(const StatusChangeEvent& event)
            : wxCommandEvent(event), status(event.status) {};
        [[nodiscard]] wxEvent* Clone() const override { return new StatusChangeEvent(*this); }
    };

    typedef void (wxEvtHandler::* StatusChangeEventFunction)(StatusChangeEvent&);

#define StatusChangeEventHandler(func) wxEVENT_HANDLER_CAST(StatusChangeEventFunction, func)

#define EVT_STATUS_CHANGE(id, func) \
     wx__DECLARE_EVT1(STATUS_EVENT_TYPE, id, StatusChangeEventHandler(func))

} // namespace everdawn

#endif // EVERDAWN_STATUS_HPP

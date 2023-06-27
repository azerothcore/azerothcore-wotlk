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
        constexpr int loading = 1001;
        constexpr int ready = 1002;
        constexpr int error = 1003;
    };

    struct Status
    {
        int code;
        const char* message;

        static Status Error(const char* message)
        {
           return { StatusCode::error, message };
        }

        static Status Loading(const char* message)
        {
            return {StatusCode::loading, message };
        }


        static Status Ready(const char* message)
        {
            return {StatusCode::ready, message };
        }
    };


    class StatusChangeEvent;
    wxDECLARE_EVENT(STATUS_EVENT_TYPE, StatusChangeEvent);

    class StatusChangeEvent : public wxCommandEvent
    {
    public:
        const Status status;
        StatusChangeEvent(Status status, int id = 0) :wxCommandEvent(STATUS_EVENT_TYPE, id), status(status) {};
        StatusChangeEvent(const StatusChangeEvent& event)
            : wxCommandEvent(event), status(event.status) {};
        wxEvent* Clone() const { return new StatusChangeEvent(*this); }
    };

    typedef void (wxEvtHandler::* StatusChangeEventFunction)(StatusChangeEvent&);

#define StatusChangeEventHandler(func) wxEVENT_HANDLER_CAST(StatusChangeEventFunction, func)                    

#define EVT_STATUS_CHANGE(id, func) \
 	wx__DECLARE_EVT1(STATUS_EVENT_TYPE, id, StatusChangeEventHandler(func))

} // namespace everdawn

#endif // EVERDAWN_STATUS_HPP

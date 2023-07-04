#ifndef EVERDAWN_WXMAINWINDOW_HPP_
#define EVERDAWN_WXMAINWINDOW_HPP_
#pragma once

#include "Status.hpp"

#include <wx/wxprec.h>

#ifndef WX_PRECOMP
#include <wx/wx.h>
#endif

namespace everdawn {

    class MainFrame final : public wxFrame
    {
    public:
        explicit MainFrame(const wxString& title);
    private:
        void OnExit(wxCommandEvent& event);
        void OnAbout(wxCommandEvent& event);
        void OnStatusChange(StatusChangeEvent& event);
        wxDECLARE_EVENT_TABLE();
    };

} // namespace everdawn
#endif // EVERDAWN_WXMAINWINDOW_HPP_

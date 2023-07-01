#include "MainFrame.hpp"
#include "WorldDataBaseFacade.hpp"
#include "Status.hpp"
#include "SmartEnum.h"

#include <wx/wxprec.h>

#ifndef WX_PRECOMP
#include <wx/wx.h>
#endif

#include <thread>
#include <random>
#include <atomic>

namespace everdawn {
    class Launcher final : public wxApp
    {
        MainFrame* m_frame = nullptr;

    public:
        bool OnInit() override;
    };

    bool Launcher::OnInit()
    {
        if (!wxApp::OnInit())
            return false;

        m_frame = new MainFrame(wxT("Launcher"));
        m_frame->Show(true);

        return true;
    }

} // namespace everdawn

wxIMPLEMENT_APP(everdawn::InstanceCreator);

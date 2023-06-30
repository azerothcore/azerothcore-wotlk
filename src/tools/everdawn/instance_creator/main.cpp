#include "MainFrame.hpp"
#include "WorldDataBaseFacade.hpp"
#include "Status.hpp"
#include "SmartEnum.h"

#include <wx/splash.h>
#include <wx/graphics.h>
#include <wx/dcbuffer.h>
#include <wx/progdlg.h>

#include <thread>
#include <random>
#include <atomic>

namespace everdawn {
    class InstanceCreator final : public wxApp
    {
        MainFrame* m_frame = nullptr;

    public:
        bool OnInit() override;
    };

    bool InstanceCreator::OnInit()
    {
        if (!wxApp::OnInit())
            return false;

        m_frame = new MainFrame(wxT("Realm manager"));
        m_frame->Show(true);

        return true;
    }

} // namespace everdawn

wxIMPLEMENT_APP(everdawn::InstanceCreator);

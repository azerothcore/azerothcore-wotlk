#include "MainFrame.hpp"
#include "WorldDataBaseFacade.hpp"
#include "Status.hpp"
#include "Images.hpp"

#include <wx/splash.h>
#include <wx/graphics.h>
#include <wx/dcbuffer.h>

#include <thread>
#include <random>

namespace everdawn {
    class InstanceCreator : public wxApp
    {
        MainFrame* m_frame = nullptr;
        Observable<Status>::Subscription m_subscription;
    public:
        virtual bool OnInit();
        virtual int OnRun();
        virtual int OnExit();
    };

    bool InstanceCreator::OnInit()
    {
        m_frame = new MainFrame("Realm manager", wxDefaultPosition, wxSize(800, 600));
        m_frame->CentreOnScreen();
        m_frame->Show(true);

        m_subscription = WorldDatabaseFacade::GetStatus().Subscribe([&](const Status& status)
            {
                wxPostEvent(m_frame, StatusChangeEvent(status));
            });

        return true;
    }

    int InstanceCreator::OnRun()
    {
        WorldDatabaseFacade::Load();
        return wxApp::OnRun();
    }

    int InstanceCreator::OnExit()
    {
        m_subscription.Unsubscribe();
        return wxApp::OnExit();
    }

} // namespace everdawn

wxIMPLEMENT_APP(everdawn::InstanceCreator);

#include "MainFrame.hpp"
#include "WorldDataBaseFacade.hpp"
#include "Status.hpp"
#include "Images.hpp"

#include <wx/splash.h>

#include <thread>


namespace everdawn {
    class InstanceCreator : public wxApp
    {
        MainFrame* m_frame = nullptr;
        wxSplashScreen* m_splash = nullptr;
        wxBitmap* m_bitmap = nullptr;
        Observable<Status>::Subscription m_subscription;

        void CreateSplashScreen()
        {
            m_splash->CentreOnScreen();
            m_splash->Show();
        }

        void CreateMainFrame()
        {
            if (m_splash)
            {
                m_splash->Close();
            }
            m_frame->SetSize(800, 600);
            m_frame->CentreOnScreen();
            m_frame->Show(true);

        }
    public:
        virtual bool OnInit();
        virtual int OnExit();
    };

    bool InstanceCreator::OnInit()
    {
        m_bitmap = new wxBitmap(wxBITMAP(loading));
        m_splash = new wxSplashScreen(
            *m_bitmap,
            wxSPLASH_CENTRE_ON_SCREEN | wxSPLASH_NO_TIMEOUT,
            0,
            NULL,
            wxID_ANY,
            wxDefaultPosition,
            wxDefaultSize,
            wxBORDER_SIMPLE | wxSTAY_ON_TOP);

        m_frame = new MainFrame("Realm manager", wxDefaultPosition, wxDefaultSize);

        m_subscription = WorldDatabaseFacade::GetStatus().Subscribe([&](const Status& status)
            {
                if (status.code == StatusCode::loading)
                {
                    CreateSplashScreen();
                }

                if (status.code == StatusCode::ready)
                {
                    CreateMainFrame();
                }

                if (status.code == StatusCode::error)
                {
                    wxMessageBox(status.message, "Error", wxOK | wxICON_ERROR);
                    if (m_splash)
                    {
                        m_splash->Close();
                    }
                }
            });

        WorldDatabaseFacade::Load();
        return true;
    }

    int InstanceCreator::OnExit()
    {
        m_subscription.Unsubscribe();
        return 0;
    }

} // namespace everdawn

wxIMPLEMENT_APP(everdawn::InstanceCreator);

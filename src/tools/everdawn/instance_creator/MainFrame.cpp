#include "MainFrame.hpp"

namespace everdawn
{

    MainFrame::MainFrame(const wxString& title)
        : wxFrame(nullptr, wxID_ANY, title, wxDefaultPosition, wxDefaultSize)
    {
        const auto menuFile = new wxMenu;
        menuFile->AppendSeparator();
        menuFile->Append(wxID_EXIT);

        const auto menuHelp = new wxMenu;
        menuHelp->Append(wxID_ABOUT);

        const auto menuBar = new wxMenuBar;
        menuBar->Append(menuFile, wxT("&File"));
        menuBar->Append(menuHelp, wxT("&Help"));

        SetMenuBar(menuBar);
        CreateStatusBar();

        const auto panel_top = new wxPanel(this, wxID_ANY, wxDefaultPosition, wxDefaultSize);
        panel_top->SetBackgroundColour(wxColor(100, 100, 200));

        const auto panel_bottom = new wxPanel(this, wxID_ANY, wxDefaultPosition, wxDefaultSize);
        panel_bottom->SetBackgroundColour(wxColor(100, 200, 100));

        const auto sizer = new wxBoxSizer(wxVERTICAL);
        sizer->Add(panel_top, 1, wxEXPAND | wxLEFT | wxTOP | wxRIGHT, 10);
        sizer->Add(panel_bottom, 1, wxEXPAND | wxALL, 10);

        SetSizer(sizer);
    }

    void MainFrame::OnExit(wxCommandEvent& event)
    {
        Close(true);
    }

    void MainFrame::OnAbout(wxCommandEvent& event)
    {
        wxMessageBox(wxT("Everdawn tool."),
            wxT("About Instance Creator"), wxOK | wxICON_INFORMATION);
    }

    void MainFrame::OnStatusChange(StatusChangeEvent& event)
    {
        switch (event.status.code)
        {
        case StatusCode::Loading:
            this->Enable();
            SetStatusText(wxString::Format(wxT("Loading! -- %s"), event.status.message), 0);
            break;
        case StatusCode::Ready:
            this->Enable();
            SetStatusText(wxString::Format(wxT("Ready! -- %s"), event.status.message), 0);
            break;
        case StatusCode::Error:
            this->Enable();
            SetStatusText(wxString::Format(wxT("Error! -- %s"), event.status.message), 0);
            break;
        default:
            break;
        }
    }

    wxBEGIN_EVENT_TABLE(MainFrame, wxFrame)
        EVT_MENU(wxID_EXIT, MainFrame::OnExit)
        EVT_MENU(wxID_ABOUT, MainFrame::OnAbout)
        EVT_STATUS_CHANGE(wxID_ANY, MainFrame::OnStatusChange)
        wxEND_EVENT_TABLE()
} // namespace everdawn


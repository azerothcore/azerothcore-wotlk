"""Application entry point (``invasion-authoring`` console script)."""

from __future__ import annotations

import sys


def main() -> int:
    from PySide6.QtWidgets import QApplication

    from .main_window import MainWindow

    app = QApplication(sys.argv)
    app.setApplicationName("Invasion Authoring")
    window = MainWindow()
    window.show()
    return app.exec()


if __name__ == "__main__":
    raise SystemExit(main())

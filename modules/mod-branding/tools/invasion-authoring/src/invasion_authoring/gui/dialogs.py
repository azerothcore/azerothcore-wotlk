"""Modal dialogs: image calibration and DB connection."""

from __future__ import annotations

from PySide6.QtWidgets import (
    QDialog,
    QDialogButtonBox,
    QFileDialog,
    QFormLayout,
    QHBoxLayout,
    QHeaderView,
    QLabel,
    QLineEdit,
    QPushButton,
    QSpinBox,
    QTableWidget,
    QTableWidgetItem,
    QVBoxLayout,
)

from ..db import DbConfig
from ..geometry import Affine, CalibrationError, ReferencePoint
from ..model import Calibration


class CalibrationDialog(QDialog):
    """Pick a backdrop image and 2-3 pixel<->world reference points."""

    def __init__(self, calibration: Calibration | None = None, parent=None) -> None:
        super().__init__(parent)
        self.setWindowTitle("Calibrate zone image")
        self.resize(560, 360)

        self._image_edit = QLineEdit(calibration.image_path if calibration else "")
        browse = QPushButton("Browse…")
        browse.clicked.connect(self._browse)
        img_row = QHBoxLayout()
        img_row.addWidget(self._image_edit)
        img_row.addWidget(browse)

        self._table = QTableWidget(0, 4)
        self._table.setHorizontalHeaderLabels(["pixel x", "pixel y", "world x", "world y"])
        self._table.horizontalHeader().setSectionResizeMode(QHeaderView.ResizeMode.Stretch)

        add_btn = QPushButton("Add point")
        del_btn = QPushButton("Remove selected")
        add_btn.clicked.connect(lambda: self._add_row())
        del_btn.clicked.connect(self._remove_row)
        btn_row = QHBoxLayout()
        btn_row.addWidget(add_btn)
        btn_row.addWidget(del_btn)
        btn_row.addStretch(1)

        self._hint = QLabel("Enter 2 points (axis-aligned) or 3 points (full rotation/flip).")

        buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel)
        buttons.accepted.connect(self._accept)
        buttons.rejected.connect(self.reject)

        layout = QVBoxLayout(self)
        form = QFormLayout()
        form.addRow("Image:", img_row)
        layout.addLayout(form)
        layout.addWidget(self._table)
        layout.addLayout(btn_row)
        layout.addWidget(self._hint)
        layout.addWidget(buttons)

        if calibration:
            for r in calibration.refs:
                self._add_row(r)
        else:
            self._add_row()
            self._add_row()

        self.result_calibration: Calibration | None = None

    def _browse(self) -> None:
        path, _ = QFileDialog.getOpenFileName(self, "Zone image", "", "Images (*.png *.jpg *.jpeg *.bmp)")
        if path:
            self._image_edit.setText(path)

    def _add_row(self, ref: ReferencePoint | None = None) -> None:
        row = self._table.rowCount()
        self._table.insertRow(row)
        values = (ref.px, ref.py, ref.wx, ref.wy) if ref else (0.0, 0.0, 0.0, 0.0)
        for col, val in enumerate(values):
            self._table.setItem(row, col, QTableWidgetItem(str(val)))

    def _remove_row(self) -> None:
        row = self._table.currentRow()
        if row >= 0:
            self._table.removeRow(row)

    def _collect_refs(self) -> list[ReferencePoint]:
        refs = []
        for row in range(self._table.rowCount()):
            try:
                vals = [float(self._table.item(row, c).text()) for c in range(4)]
            except (AttributeError, ValueError) as exc:
                raise CalibrationError(f"row {row + 1} has invalid numbers") from exc
            refs.append(ReferencePoint(px=vals[0], py=vals[1], wx=vals[2], wy=vals[3]))
        return refs

    def _accept(self) -> None:
        try:
            refs = self._collect_refs()
            Affine.from_reference_points(refs)  # validate
        except CalibrationError as exc:
            self._hint.setText(f"⚠ {exc}")
            return
        self.result_calibration = Calibration(image_path=self._image_edit.text().strip(), refs=refs)
        self.accept()


class DbConnectDialog(QDialog):
    """Collect read-only acore_world connection details (password not persisted to project)."""

    def __init__(self, config: DbConfig | None = None, parent=None) -> None:
        super().__init__(parent)
        self.setWindowTitle("Connect to acore_world (read-only)")
        cfg = config or DbConfig()

        self._host = QLineEdit(cfg.host)
        self._port = QSpinBox()
        self._port.setRange(1, 65535)
        self._port.setValue(cfg.port)
        self._user = QLineEdit(cfg.user)
        self._password = QLineEdit(cfg.password)
        self._password.setEchoMode(QLineEdit.EchoMode.Password)
        self._schema = QLineEdit(cfg.schema)

        form = QFormLayout()
        form.addRow("Host:", self._host)
        form.addRow("Port:", self._port)
        form.addRow("User:", self._user)
        form.addRow("Password:", self._password)
        form.addRow("Schema:", self._schema)

        buttons = QDialogButtonBox(QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel)
        buttons.accepted.connect(self.accept)
        buttons.rejected.connect(self.reject)

        layout = QVBoxLayout(self)
        layout.addLayout(form)
        layout.addWidget(buttons)

    def config(self) -> DbConfig:
        return DbConfig(
            host=self._host.text().strip(),
            port=self._port.value(),
            user=self._user.text().strip(),
            password=self._password.text(),
            schema=self._schema.text().strip(),
        )

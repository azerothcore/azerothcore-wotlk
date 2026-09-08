"""Run with python3 apps/cata/test_real_client_focus.py. No desktop input is sent."""

from pathlib import Path
from subprocess import CompletedProcess
from unittest.mock import MagicMock, patch

import run_real_client_authentication as runner


def check_focus_wait(allow_focus: bool) -> None:
    generation = {"paths": {"wine_prefix": "/tmp/owned-prefix"}, "processes": []}
    environment = {"DISPLAY": ":99", "XAUTHORITY": "/tmp/owned-xauthority"}
    elapsed = 0.0
    activations = []

    def sleep(seconds):
        nonlocal elapsed
        elapsed += seconds

    def command(args, **kwargs):
        assert kwargs["env"] == environment
        # The client replaces its first window while the WM ignores activation for eight seconds.
        window_id = "0x100" if elapsed < 2 else "0x200"
        if args == ["wmctrl", "-lpGx"]:
            output = (
                "0x999 0 99 0 0 100 100 wow.Wow host World of Warcraft\n"
                f"{window_id} 0 42 10 20 800 600 wow.Wow host World of Warcraft\n"
            )
        elif args == ["xprop", "-root", "_NET_ACTIVE_WINDOW"]:
            active = window_id if allow_focus and elapsed >= 8 else "0x999"
            output = f"_NET_ACTIVE_WINDOW(WINDOW): window id # {active}\n"
        else:
            assert args == ["wmctrl", "-i", "-a", window_id]
            activations.append(window_id)
            output = ""
        return CompletedProcess(args, 0, output.encode(), b"")

    with (
        patch.object(runner, "wine_environment", return_value=environment),
        patch.object(runner, "find_wine_processes", return_value=[{"pid": 42}]) as processes,
        patch.object(runner, "add_processes"),
        patch.object(runner, "run_command", side_effect=command),
        patch.object(runner.time, "monotonic", side_effect=lambda: elapsed),
        patch.object(runner.time, "sleep", side_effect=sleep),
    ):
        if allow_focus:
            assert runner.focus_owned_window(generation, timeout=10) == ("0x200", 10, 20, 800, 600)
            assert 8.5 <= elapsed < 10
        else:
            try:
                runner.focus_owned_window(generation, timeout=10)
            except RuntimeError as error:
                assert "did not receive stable focus" in str(error)
            else:
                raise AssertionError("an unrelated focused window must never authorize input")
        processes.assert_called_with(Path("/tmp/owned-prefix"))
    assert "0x100" in activations and "0x200" in activations
    assert "0x999" not in activations


def check_focus_loss_before_input() -> None:
    connection = MagicMock()
    connection.screen().root.get_full_property.return_value.value = [0x999]
    generation = {"paths": {"wine_prefix": "/tmp/owned-prefix"}, "inputs": {"display": ":99"}}
    with (
        patch.object(runner, "focus_owned_window", return_value=("0x200", 10, 20, 800, 600)),
        patch.object(runner, "find_wine_processes", return_value=[]),
        patch.object(runner.time, "monotonic", side_effect=[0, 0, 31, 31]),
        patch("Xlib.display.Display", return_value=connection),
        patch("Xlib.ext.xtest.fake_input") as input_event,
    ):
        try:
            runner.automate_client_login(generation)
        except RuntimeError as error:
            assert "lost focus before input" in str(error)
        else:
            raise AssertionError("focus loss after acquisition must stop input")
        input_event.assert_not_called()


if __name__ == "__main__":
    check_focus_wait(allow_focus=True)
    check_focus_wait(allow_focus=False)
    check_focus_loss_before_input()
    print("Owned client focus checks passed")

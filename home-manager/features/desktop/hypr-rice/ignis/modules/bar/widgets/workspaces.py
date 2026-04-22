from ignis import widgets
from ignis.services.hyprland import HyprlandService
from ignis.services.niri import NiriService
from modules.common import BarContainer, CenteredLabel

hyprland = HyprlandService.get_default()
niri = NiriService.get_default()


def _workspace_id(workspace) -> int:
    return int(getattr(workspace, "id", getattr(workspace, "idx", 0)))


def _workspace_button(workspace, display_label: str) -> widgets.Button:
    button = widgets.Button(
        css_classes=["workspace", "unset"],
        on_click=lambda _: workspace.switch_to(),
        child=widgets.CenterBox(
            hexpand=True,
            vexpand=True,
            center_widget=CenteredLabel(
                label=display_label,
                css_classes=["workspace-label"],
            ),
        ),
    )

    is_active = False
    if hyprland.is_available:
        is_active = workspace.id == hyprland.active_workspace.id
    elif niri.is_available:
        is_active = workspace.is_active

    if is_active:
        button.add_css_class("active")
    return button


def _workspace_buttons(workspaces: list) -> list[widgets.Button]:
    ordered = sorted(workspaces, key=_workspace_id)
    return [_workspace_button(ws, str(i + 1)) for i, ws in enumerate(ordered)]


def _scroll_workspaces(direction: str, monitor_name: str = "") -> None:
    if hyprland.is_available:
        current = hyprland.active_workspace.id
        target = current - 1 if direction == "up" else current + 1
        if target > 0:
            hyprland.switch_to_workspace(target)
        return

    if niri.is_available:
        active_on_monitor = [
            ws for ws in niri.workspaces if ws.is_active and ws.output == monitor_name
        ]
        if not active_on_monitor:
            return
        current = active_on_monitor[0].idx
        target = current + 1 if direction == "up" else current - 1
        if target > 0:
            niri.switch_to_workspace(target)


class Workspaces(BarContainer):
    def __init__(self, monitor_name: str = "") -> None:
        if hyprland.is_available:
            child = [
                widgets.EventBox(
                    on_scroll_up=lambda _: _scroll_workspaces("up"),
                    on_scroll_down=lambda _: _scroll_workspaces("down"),
                    css_classes=["workspaces"],
                    child=hyprland.bind_many(
                        ["workspaces", "active_workspace"],
                        transform=lambda workspaces, *_: _workspace_buttons(workspaces),
                    ),
                )
            ]
        elif niri.is_available:
            child = [
                widgets.EventBox(
                    on_scroll_up=lambda _: _scroll_workspaces("up", monitor_name),
                    on_scroll_down=lambda _: _scroll_workspaces("down", monitor_name),
                    css_classes=["workspaces"],
                    child=niri.bind(
                        "workspaces",
                        transform=lambda workspaces: _workspace_buttons(
                            [w for w in workspaces if w.output == monitor_name]
                        ),
                    ),
                )
            ]
        else:
            child = [widgets.Box(css_classes=["workspaces"])]

        super().__init__(child=child)

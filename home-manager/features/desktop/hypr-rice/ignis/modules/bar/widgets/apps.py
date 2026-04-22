from ignis import widgets
from ignis.services.applications import ApplicationsService
from ignis.services.hyprland import HyprlandService
from ignis.services.niri import NiriService

applications = ApplicationsService.get_default()
hyprland = HyprlandService.get_default()
niri = NiriService.get_default()


def _find_app_icon(app_hint: str, fallback_hint: str = "") -> str:
    hint = app_hint.lower().strip()
    fallback = fallback_hint.lower().strip()
    if not hint and not fallback:
        return "application-x-executable-symbolic"

    def _norm(value: str) -> str:
        return (
            value.lower()
            .replace(".desktop", "")
            .replace("-", "")
            .replace("_", "")
            .replace(" ", "")
        )

    hint_norm = _norm(hint)
    fallback_norm = _norm(fallback)

    # 1) Direct matching by app_id / StartupWMClass / display name.
    for app in applications.apps:
        app_id = (app.id or "").lower()
        app_name = app.name.lower()
        startup_wm_class = (app.app.get_string("StartupWMClass") or "").lower()

        if (
            hint == app_id
            or hint == app_id.replace(".desktop", "")
            or hint == startup_wm_class
            or hint_norm == _norm(app_id)
            or hint_norm == _norm(startup_wm_class)
            or hint_norm == _norm(app_name)
        ):
            return app.icon

    # 2) If compositor gives a generic app id (e.g. electron), use title fallback.
    generic_hints = {"electron", "chromium", "chrome", "app", "window"}
    if fallback_norm and hint_norm in generic_hints:
        best_icon = None
        best_len = -1
        for app in applications.apps:
            app_id_norm = _norm((app.id or "").lower())
            app_name_norm = _norm(app.name.lower())

            if app_name_norm and app_name_norm in fallback_norm and len(app_name_norm) > best_len:
                best_len = len(app_name_norm)
                best_icon = app.icon
            elif app_id_norm and app_id_norm in fallback_norm and len(app_id_norm) > best_len:
                best_len = len(app_id_norm)
                best_icon = app.icon

        if best_icon:
            return best_icon

    return "application-x-executable-symbolic"


class AppItem(widgets.Button):
    def __init__(self, icon: str, on_click, focused: bool = False):
        super().__init__(
            child=widgets.Icon(image=icon, pixel_size=18),
            on_click=lambda _: on_click(),
            css_classes=["app-item", "unset", "active"] if focused else ["app-item", "unset"],
        )


class Apps(widgets.Box):
    def __init__(self, show_only_active_workspace_application: bool = False):
        self._show_only_active_workspace_application = show_only_active_workspace_application

        if hyprland.is_available:
            child = hyprland.bind_many(
                ["windows", "active_window", "active_workspace"],
                transform=lambda windows, active_window, active_workspace: self._hyprland_items(
                    windows, active_window, active_workspace.id
                ),
            )
        elif niri.is_available:
            child = niri.bind_many(
                ["windows", "active_window", "workspaces", "active_output"],
                transform=lambda windows, active_window, workspaces, active_output: self._niri_items(
                    windows, active_window, workspaces, active_output
                ),
            )
        else:
            child = []

        super().__init__(
            css_classes=["apps"],
            spacing=8,
            child=child,
        )

    def _hyprland_items(
        self, windows: list, active_window, active_workspace_id: int
    ) -> list[widgets.Button]:
        if self._show_only_active_workspace_application:
            windows = [w for w in windows if w.workspace_id == active_workspace_id]

        active_address = active_window.address
        items: list[widgets.Button] = []
        for window in windows:
            app_hint = (window.class_name or window.initial_class or "").strip()
            title_hint = (window.title or "").strip()
            icon = _find_app_icon(str(app_hint), title_hint)
            items.append(
                AppItem(
                    icon,
                    lambda w=window: hyprland.send_command(
                        f"dispatch focuswindow address:{w.address}"
                    ),
                    focused=window.address == active_address,
                )
            )
        return items

    def _niri_items(
        self, windows: list, active_window, workspaces: list, active_output: str
    ) -> list[widgets.Button]:
        if self._show_only_active_workspace_application:
            focused = [ws for ws in workspaces if ws.is_focused]
            if focused:
                active_workspace_id = focused[0].id
            else:
                active_on_output = [
                    ws
                    for ws in workspaces
                    if ws.is_active and ws.output == active_output
                ]
                if active_on_output:
                    active_workspace_id = active_on_output[0].id
                else:
                    active_workspace_id = -1

            windows = [w for w in windows if w.workspace_id == active_workspace_id]

        items: list[widgets.Button] = []
        active_window_id = active_window.id
        for window in windows:
            app_hint = (window.app_id or "").strip()
            title_hint = (window.title or "").strip()
            icon = _find_app_icon(str(app_hint), title_hint)
            items.append(
                AppItem(
                    icon,
                    lambda w=window: w.focus(),
                    focused=window.id == active_window_id,
                )
            )
        return items

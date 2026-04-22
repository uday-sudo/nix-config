import datetime
from ignis import widgets
from ignis import utils
from modules.common import BarContainer
from .widgets import Apps, Workspaces


def clock() -> widgets.Label:
    return widgets.Label(
        css_classes=["clock"],
        label=utils.Poll(
            1_000, lambda _: datetime.datetime.now().strftime("%H:%M")
        ).bind("output"),
    )


def left(monitor_name: str) -> widgets.Box:
    return widgets.Box(
        css_classes=["bar-section"],
        spacing=8,
        child=[Workspaces(monitor_name)],
    )


def center() -> widgets.Box:
    return widgets.Box(
        css_classes=["bar-section"],
        spacing=8,
        child=[BarContainer(child=[Apps()])],
    )


def right() -> widgets.Box:
    return widgets.Box(
        css_classes=["bar-section"],
        spacing=8,
        child=[BarContainer(child=[clock()])],
    )


class Bar(widgets.Window):
    __gtype_name__ = "bar"

    def __init__(self, monitor: int, orientation: str):
        if orientation not in ["top", "bottom"]:
            raise ValueError("Only Top and Bottom orientation supported by bar")
        monitor_name = utils.get_monitor(monitor).get_connector()  # type: ignore
        super().__init__(
            namespace=f"ignis_bar_{monitor}",
            monitor=monitor,
            anchor=["left", orientation, "right"],
            exclusivity="exclusive",
            child=widgets.CenterBox(
                css_classes=["bar"],
                start_widget=left(monitor_name),
                center_widget=center(),
                end_widget=right(),
            ),
        )

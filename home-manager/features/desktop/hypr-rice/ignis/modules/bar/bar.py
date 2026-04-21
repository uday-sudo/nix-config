import datetime
from ignis import widgets
from ignis import utils


def clock() -> widgets.Label:
    return widgets.Label(
        css_classes=["clock"],
        label=utils.Poll(
            1_000, lambda _: datetime.datetime.now().strftime("%H:%M")
        ).bind("output"),
    )


def left() -> widgets.Box:
    return widgets.Box(
        css_classes=["bar-section"],
        spacing=8,
        child=[widgets.Label(label="Ignis")],
    )


def center() -> widgets.Box:
    return widgets.Box(
        css_classes=["bar-section"],
        spacing=8,
        child=[clock()],
    )


def right(monitor: int) -> widgets.Box:
    return widgets.Box(
        css_classes=["bar-section"],
        spacing=8,
        child=[widgets.Label(label=f"Mon {monitor}")],
    )


class Bar(widgets.Window):
    __gtype_name__ = "bar"
    def __init__(self, monitor: int):
        super().__init__(
            namespace=f"ignis_bar_{monitor}",
            monitor=monitor,
            anchor=["left", "top", "right"],
            exclusivity="exclusive",
            child=widgets.CenterBox(
                css_classes=["bar"],
                start_widget=left(),
                center_widget=center(),
                end_widget=right(monitor),
            ),
        )

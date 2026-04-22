from ignis import widgets


class CenteredLabel(widgets.Label):
    def __init__(self, **kwargs):
        super().__init__(halign="center", valign="center", **kwargs)

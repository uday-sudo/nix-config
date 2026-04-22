from ignis import widgets

class BarContainer(widgets.Box):
    def __init__(self, **kwargs):
        super().__init__(css_classes=["box-container"], **kwargs)

from __future__ import annotations
import os

from modules.settings.preferences import Preferences
from modules.bar.bar import Bar
preferences = Preferences()

from ignis.widgets import Widget
from ignis import utils
from ignis.css_manager import CssManager, CssInfoPath

css_manager = CssManager.get_default()

css_manager.apply_css(
    CssInfoPath(
        name="main",
        path=os.path.join(utils.get_current_dir(), "style/main.scss"),
        compiler_function=lambda path: utils.sass_compile(path=path),
    )
)

Bar(0)


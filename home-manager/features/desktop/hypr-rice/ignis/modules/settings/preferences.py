from __future__ import annotations

import json
from pathlib import Path
from typing import Any


class Preferences:
    def __init__(
        self,
        default_path: str | Path = "settings.json",
        preferences_path: str | Path = "preferences.json",
    ) -> None:
        base_dir = Path(__file__).resolve().parent.parent
        self.default_path = base_dir / default_path
        self.preferences_path = base_dir / preferences_path

        self.preferences = self._get_preferences()

    def _load_json(self, path: Path) -> dict[str, Any]:
        if not path.exists():
            return {}
        with path.open("r", encoding="utf-8") as file:
            data = json.load(file)
        if isinstance(data, dict):
            return data
        return {}

    def _merge(self, base: dict[str, Any], override: dict[str, Any]) -> dict[str, Any]:
        result = dict(base)
        for key, value in override.items():
            if isinstance(result.get(key), dict) and isinstance(value, dict):
                result[key] = self._merge(result[key], value)
            else:
                result[key] = value
        return result

    def _get_preferences(self) -> dict[str, Any]:
        default_preferences = self._load_json(self.default_path)
        user_preferences = self._load_json(self.preferences_path)
        return self._merge(default_preferences, user_preferences)

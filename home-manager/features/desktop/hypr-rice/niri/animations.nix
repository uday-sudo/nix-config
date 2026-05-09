{...}: {
  programs.niri.settings.animations = {
    slowdown = 0.8;

    workspace-switch.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 1400;
      epsilon = 0.0001;
    };

    window-open.kind.easing = {
      duration-ms = 110;
      curve = "ease-out-expo";
      curve-args = [];
    };

    window-close.kind.easing = {
      duration-ms = 100;
      curve = "ease-out-quad";
      curve-args = [];
    };

    horizontal-view-movement.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 1200;
      epsilon = 0.0001;
    };

    window-movement.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 1300;
      epsilon = 0.0001;
    };

    window-resize.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 1200;
      epsilon = 0.0001;
    };

    screenshot-ui-open.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 1200;
      epsilon = 0.0001;
    };

    overview-open-close.kind.spring = {
      damping-ratio = 1.0;
      stiffness = 1200;
      epsilon = 0.0001;
    };
  };
}

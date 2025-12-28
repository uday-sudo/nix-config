{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.wallpapers;

  # Yes, I know this file could be written so much better but, i will rewrite this later,
  # It was already pain enough to make these vector wallpapers based on my base16 module.
  vector1Svg = ''
    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
    <!-- Created with Inkscape (http://www.inkscape.org/) -->

    <svg
       width="1920"
       height="1080"
       viewBox="0 0 507.99999 285.75001"
       version="1.1"
       id="svg8"
       inkscape:version="0.92.4 (5da689c313, 2019-01-14)"
       sodipodi:docname="nix-wallpaper-nineish.src.svg"
       inkscape:export-filename="nixos-nineish@4k.png"
       inkscape:export-xdpi="192"
       inkscape:export-ydpi="192"
       xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
       xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
       xmlns:xlink="http://www.w3.org/1999/xlink"
       xmlns="http://www.w3.org/2000/svg"
       xmlns:svg="http://www.w3.org/2000/svg"
       xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
       xmlns:cc="http://creativecommons.org/ns#"
       xmlns:dc="http://purl.org/dc/elements/1.1/">
      <defs
         id="defs2">
        <linearGradient
           inkscape:collect="always"
           xlink:href="#linearGradient5960"
           id="linearGradient5855"
           gradientUnits="userSpaceOnUse"
           gradientTransform="translate(983.36076,601.38885)"
           x1="213.95642"
           y1="338.62445"
           x2="282.26105"
           y2="515.97058" />
        <linearGradient
           inkscape:collect="always"
           id="linearGradient5960">
          <stop
             style="stop-color:#GRADIENT1;stop-opacity:1"
             offset="0"
             id="stop5962" />
          <stop
             id="stop5964"
             offset="0.23168644"
             style="stop-color:#GRADIENT2;stop-opacity:1" />
          <stop
             style="stop-color:#GRADIENT3;stop-opacity:1"
             offset="1"
             id="stop5966" />
        </linearGradient>
      </defs>
      <g
         inkscape:label="Layer 1"
         inkscape:groupmode="layer"
         id="layer1"
         transform="translate(0,-11.249992)">
        <path
           style="opacity:1;vector-effect:none;fill:#LIGHTBLUE1;fill-opacity:1;stroke:none;stroke-width:1.5347532;stroke-linecap:square;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:0.47000002;paint-order:fill markers stroke"
           d="M 0,11.249988 H 508 V 296.99999 H 0 Z"
           id="rect5100"
           inkscape:connector-curvature="0" />
        <path
           style="opacity:1;vector-effect:none;fill:#LIGHTBLUE2;fill-opacity:1;stroke:none;stroke-width:1.82709301;stroke-linecap:square;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:0.47000002;paint-order:fill markers stroke"
           d="m 461.93027,-22.874919 93.29379,5.576457 48.83521,333.987342 -160.24703,24.93349 -88.11949,-94.54719 -64.29739,-86.44455 27.1028,-72.061848 50.27427,-1.454923 42.78753,-69.01794 z"
           id="rect5102"
           inkscape:connector-curvature="0"
           sodipodi:nodetypes="cccccccccc" />
        <g
           transform="matrix(0.62566571,-0.16764662,0.16764662,0.62566571,240.04022,681.6267)"
           style="display:inline"
           id="layer1-6"
           inkscape:label="print-logo">
           <path
             style="color:#BLACK;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#BLACK;solid-opacity:1;fill:#LIGHTBLUE1;fill-opacity:1;fill-rule:evenodd;stroke:#LIGHTBLUE3;stroke-width:31.15394934;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;paint-order:stroke fill markers;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate"
             d="m 1578.6953,-152.2207 -79.3437,21.22656 -50.3262,185.865234 -136.0859,-136.841797 -159.2696,44.28125 508.711,508.763673 42.5214,-160.35938 -138.5371,-139.09961 71.7735,-264.523433 z M 945.96289,16.371094 864.875,38.195312 843.58398,117.52148 979.38477,254.03711 792.83398,303.4707 751.54688,463.54492 1446.5039,277.36719 1328.8906,160.36523 1139.1582,210.79102 Z m 843.17971,41.277344 -186.2461,694.937502 160.1347,-43.35352 51.1954,-189.52734 264.9707,-70.10156 21.6445,-81.13672 -58.0547,-58.10157 -186.1269,49.34961 50.4668,-186.27539 z m -616.1524,311.564452 -160.1347,43.35352 -51.19534,189.52734 -264.97071,70.10352 -21.64453,81.13476 58.05469,58.10156 186.12695,-49.34961 -50.46679,186.2754 117.98437,115.79292 z m -58.9785,281.51563 -42.5215,160.35742 138.5371,139.09961 -71.7734,264.52345 59.4434,59.3125 79.3437,-21.2266 50.3262,-185.8652 136.0859,136.8418 159.2715,-44.2813 z m 909.502,6.2539 -694.9571,186.17774 117.6133,117.0039 189.7324,-50.42578 193.1973,194.41992 81.0859,-21.8262 21.2911,-79.3261 -135.8008,-136.51567 186.5527,-49.43359 z"
             transform="matrix(0.32814213,0.08792542,-0.08792542,0.32814213,1.0651316,-1021.7332)"
             id="path4861"
             inkscape:connector-curvature="0" />
          <g
             transform="translate(72.039038,-1799.4476)"
             style="display:none"
             inkscape:label="guides"
             id="layer2">
            <path
               sodipodi:type="star"
               style="color:#BLACK;display:inline;overflow:visible;visibility:visible;opacity:0.23600003;fill:#GRAY;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate"
               id="path6032"
               sodipodi:sides="6"
               sodipodi:cx="335.17407"
               sodipodi:cy="377.47382"
               sodipodi:r1="250.86446"
               sodipodi:r2="217.25499"
               sodipodi:arg1="1.0471976"
               sodipodi:arg2="1.5707963"
               inkscape:flatsided="true"
               inkscape:rounded="0"
               inkscape:randomized="0"
               d="M 460.60629,594.72881 209.74183,594.7288 84.309616,377.4738 209.74185,160.21882 l 250.86446,1e-5 125.43222,217.255 z" />
            <path
               d="m 385.59154,773.06721 -100.83495,0 -50.41747,-87.32564 50.41748,-87.32563 100.83495,10e-6 50.41748,87.32563 z"
               inkscape:randomized="0"
               inkscape:rounded="0"
               inkscape:flatsided="true"
               sodipodi:arg2="1.5707963"
               sodipodi:arg1="1.0471976"
               sodipodi:r2="87.32563"
               sodipodi:r1="100.83495"
               sodipodi:cy="685.74158"
               sodipodi:cx="335.17407"
               sodipodi:sides="6"
               id="path5875"
               style="color:#BLACK;display:inline;overflow:visible;visibility:visible;opacity:1;fill:#GRAY;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;enable-background:accumulate"
               sodipodi:type="star"
               transform="translate(0,-308.26772)" />
            <path
               style="fill:url(#linearGradient5855);fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
               d="m 1216.5591,938.53395 123.0545,228.14035 -42.6807,-1.2616 -43.4823,-79.7725 -39.6506,80.3267 -32.6875,-19.7984 53.4737,-100.2848 -371157,-73.88955 z"
               id="path5851"
               inkscape:connector-curvature="0"
               sodipodi:nodetypes="ccccccccc"
               transform="translate(0,-308.26772)" />
            <rect
               transform="rotate(-30)"
               y="446.17056"
               x="-34.74221"
               height="226.22897"
               width="48.834862"
               id="rect5884"
               style="color:#BLACK;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:0.41499999;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#BLACK;solid-opacity:1;fill:#RED;fill-opacity:1;fill-rule:nonzero;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate" />
            <path
               d="m 251.98568,878.63831 -14.02447,24.29109 h -28.04894 l -14.02447,-24.29109 14.02447,-24.2911 h 28.04894 z"
               inkscape:randomized="0"
               inkscape:rounded="0"
               inkscape:flatsided="true"
               sodipodi:arg2="0.52359878"
               sodipodi:arg1="0"
               sodipodi:r2="24.291094"
               sodipodi:r1="28.048939"
               sodipodi:cy="878.63831"
               sodipodi:cx="223.93674"
               sodipodi:sides="6"
               id="path3428"
               style="color:#BLACK;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:0.50899999;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#BLACK;solid-opacity:1;fill:#BLACK;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:3;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate"
               sodipodi:type="star"
               transform="translate(0,-308.26772)" />
            <use
               height="100%"
               width="100%"
               transform="rotate(60,268.29786,489.4515)"
               id="use4252"
               xlink:href="#rect5884"
               y="0"
               x="0" />
            <rect
               transform="rotate(30,575.23539,-154.13386)"
               y="467.07007"
               x="545.71014"
               height="115.12564"
               width="5.3947482"
               id="rect4254"
               style="color:#BLACK;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#BLACK;solid-opacity:1;fill:#BLACK;fill-opacity:0.6507937;fill-rule:evenodd;stroke:none;stroke-width:1px;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;marker:none;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate" />
          </g>
          <path
             inkscape:connector-curvature="0"
             style="color:#BLACK;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;opacity:1;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#BLACK;solid-opacity:1;fill:#LIGHTBLUE2;fill-opacity:1;fill-rule:evenodd;stroke:#LIGHTBLUE4;stroke-width:10.58354899;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;paint-order:stroke fill markers;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate"
             d="m 532.48563,-932.87576 -27.90236,-0.011 -32.85643,56.56526 -32.62364,-56.86897 -56.15652,0.5267 122.19626,211.67542 28.05273,-48.88195 -33.22947,-57.82538 46.81024,-80.49057 z m 50.6038,87.37057 -122.21787,211.66251 56.35883,-0.14621 33.46364,-57.69052 93.11176,0.29438 14.23645,-24.72127 -13.94159,-24.17006 -65.41516,-0.1716 32.93862,-56.68749 z m 24.21034,217.27391 -244.41446,-0.0117 28.30626,48.73511 66.69289,0.13551 46.30174,80.78431 28.52677,-0.0326 13.96129,-24.15821 -32.55876,-56.73689 65.56227,0.18148 z"
             id="path4861-54"
             sodipodi:nodetypes="cccccccccccccccccccccccccccccc" />
        </g>
      </g>
    </svg>
  '';

  vector2Svg = ''
    <?xml version="1.0" encoding="UTF-8" standalone="no"?>
    <!-- Created with Inkscape (http://www.inkscape.org/) -->

    <svg
       width="3840"
       height="2160"
       viewBox="0 0 3840 2160"
       version="1.1"
       id="svg1"
       xml:space="preserve"
       inkscape:version="1.3.2 (091e20ef0f, 2023-11-25)"
       sodipodi:docname="nixos-wallpaper-catppuccin-frappe.svg"
       xmlns:inkscape="http://www.inkscape.org/namespaces/inkscape"
       xmlns:sodipodi="http://sodipodi.sourceforge.net/DTD/sodipodi-0.dtd"
       xmlns:xlink="http://www.w3.org/1999/xlink"
       xmlns="http://www.w3.org/2000/svg"
       xmlns:svg="http://www.w3.org/2000/svg"><sodipodi:namedview
         id="namedview1"
         pagecolor="#PAGECOLOR"
         bordercolor="#BORDERCOLOR"
         borderopacity="1"
         inkscape:showpageshadow="0"
         inkscape:pageopacity="0"
         inkscape:pagecheckerboard="1"
         inkscape:deskcolor="#DESKCOLOR"
         inkscape:document-units="px"
         showguides="true"
         inkscape:zoom="0.1767767"
         inkscape:cx="1476.4389"
         inkscape:cy="1858.2766"
         inkscape:window-width="1280"
         inkscape:window-height="1373"
         inkscape:window-x="20"
         inkscape:window-y="20"
         inkscape:window-maximized="0"
         inkscape:current-layer="layer5" /><defs
         id="defs1" /><g
         inkscape:groupmode="layer"
         id="layer2"
         inkscape:label="Layer 2"><rect
           style="fill:#BASE02;fill-opacity:1;fill-rule:nonzero;stroke-width:0.980649"
           id="rect1"
           width="3840"
           height="2160"
           x="-2.3092639e-13"
           y="0" /></g><g
         inkscape:groupmode="layer"
         id="layer5"
         inkscape:label="Logo Background 2"><g
           id="g5"
           transform="matrix(5.1396634,0,0,5.1396634,-5216.3847,-5096.4584)"
           style="fill:none;fill-opacity:1;stroke:#BORDERCOLOR;stroke-width:7.78261082;stroke-linecap:butt;stroke-linejoin:miter;stroke-dasharray:none;stroke-opacity:1;paint-order:normal"><path
             sodipodi:nodetypes="cccccccccc"
             inkscape:connector-curvature="0"
             id="path3336-6-6"
             d="m 1271.6058,1432.537 645.6348,0.032 -72.9659,129.1638 -173.1858,-0.4801 86.0059,149.8745 -36.878,63.8165 -75.3564,0.083 -122.3074,-213.3959 -176.1741,-0.3573 z"
             style="display:inline;fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#BORDERCOLOR;stroke-width:7.78261082;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1;paint-order:normal" /><path
             sodipodi:nodetypes="cccccccccc"
             inkscape:connector-curvature="0"
             id="path4260-0-2"
             d="m 1130.3308,1215.905 322.79,559.152 -148.3421,1.3916 -86.1772,-150.2232 -86.7921,149.4204 -73.7057,-0.029 -37.7502,-65.219 123.6526,-212.6193 -87.7776,-152.7496 z"
             style="color:#BASE00;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#BASE00;solid-opacity:1;fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#BORDERCOLOR;stroke-width:7.78261082;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;paint-order:normal;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate" /><use
             x="0"
             y="0"
             xlink:href="#path3336-6-6"
             inkscape:transform-center-x="124.43045"
             inkscape:transform-center-y="151.59082"
             id="use3439-6-6"
             transform="rotate(120,1388.2462,1201.911)"
             width="100%"
             height="100%"
             style="display:inline;fill:none;fill-opacity:1;stroke:#BORDERCOLOR;stroke-width:7.78261082;stroke-linecap:butt;stroke-linejoin:miter;stroke-dasharray:none;stroke-opacity:1;paint-order:normal" /><use
             style="display:inline;fill:none;fill-opacity:1;stroke:#BORDERCOLOR;stroke-width:7.78261082;stroke-linecap:butt;stroke-linejoin:miter;stroke-dasharray:none;stroke-opacity:1;paint-order:normal"
             x="0"
             y="0"
             xlink:href="#path4260-0-2"
             id="use4354-5-1"
             transform="rotate(120,1388.6494,1200.8606)"
             width="100%"
             height="100%" /><use
             x="0"
             y="0"
             xlink:href="#path3336-6-6"
             inkscape:transform-center-x="59.669705"
             inkscape:transform-center-y="-139.94592"
             id="use3449-5-8"
             transform="rotate(-120,1388.7734,1201.5614)"
             width="100%"
             height="100%"
             style="display:inline;fill:none;fill-opacity:1;stroke:#BASE01;stroke-width:7.78261082;stroke-linecap:butt;stroke-linejoin:miter;stroke-dasharray:none;stroke-opacity:1;paint-order:normal" /><use
             style="display:inline;fill:none;fill-opacity:1;stroke:#BASE01;stroke-width:7.78261082;stroke-linecap:butt;stroke-linejoin:miter;stroke-dasharray:none;stroke-opacity:1;paint-order:normal"
             x="0"
             y="0"
             xlink:href="#path4260-0-2"
             id="use4362-2-7"
             transform="rotate(-120,1388.5148,1201.4248)"
             width="100%"
             height="100%"
             inkscape:label="use4362-2" /></g></g><g
         inkscape:groupmode="layer"
         id="layer4"
         inkscape:label="Logo Background"
         transform="translate(-106.61289,-945.43294)"><g
           id="g4"
           transform="matrix(1.6904886,0,0,1.6904886,-1367.0305,-1375.3641)"
           style="fill:none;fill-opacity:1;stroke:#BORDER_ACCENT1;stroke-opacity:1;stroke-width:23.66179813;stroke-dasharray:none;stroke-linejoin:miter"><path
             sodipodi:nodetypes="cccccccccc"
             inkscape:connector-curvature="0"
             id="path3336-6"
             d="m 1890.6058,2242.537 645.6348,0.032 -72.9659,129.1638 -173.1858,-0.4801 86.0059,149.8745 -36.878,63.8165 -75.3564,0.083 -122.3074,-213.3959 -176.1741,-0.3573 z"
             style="display:inline;fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#BORDER_ACCENT1;stroke-width:23.66179813;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1" /><path
             sodipodi:nodetypes="cccccccccc"
             inkscape:connector-curvature="0"
             id="path4260-0"
             d="m 1749.3308,2025.905 322.79,559.152 -148.3421,1.3916 -86.1772,-150.2232 -86.7921,149.4204 -73.7057,-0.029 -37.7502,-65.219 123.6526,-212.6193 -87.7776,-152.7496 z"
             style="color:#BASE00;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#BASE00;solid-opacity:1;fill:none;fill-opacity:1;fill-rule:evenodd;stroke:#BORDER_ACCENT1;stroke-width:23.66179813;stroke-linecap:butt;stroke-linejoin:miter;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate" /><use
             style="display:inline;fill:none;fill-opacity:1;stroke-width:23.66179813;stroke-dasharray:none;stroke:#BORDER_ACCENT1;stroke-opacity:1;stroke-linejoin:miter"
             x="0"
             y="0"
             xlink:href="#path4260-0"
             id="use4362-2"
             transform="rotate(-120,2007.5148,2011.4248)"
             width="100%"
             height="100%"
             inkscape:label="use4362-2" /><use
             x="0"
             y="0"
             xlink:href="#path3336-6"
             inkscape:transform-center-x="124.43045"
             inkscape:transform-center-y="151.59082"
             id="use3439-6"
             transform="rotate(120,2007.2462,2011.911)"
             width="100%"
             height="100%"
             style="display:inline;fill:none;fill-opacity:1;stroke-width:23.66179813;stroke:#BORDER_ACCENT1;stroke-opacity:1;stroke-dasharray:none;stroke-linejoin:miter" /><use
             style="display:inline;fill:none;fill-opacity:1;stroke-width:23.66179813;stroke:#BORDER_ACCENT1;stroke-opacity:1;stroke-dasharray:none;stroke-linejoin:miter"
             x="0"
             y="0"
             xlink:href="#path4260-0"
             id="use4354-5"
             transform="rotate(120,2007.6494,2010.8606)"
             width="100%"
             height="100%" /><use
             x="0"
             y="0"
             xlink:href="#path3336-6"
             inkscape:transform-center-x="59.669705"
             inkscape:transform-center-y="-139.94592"
             id="use3449-5"
             transform="rotate(-120,2007.7734,2011.5614)"
             width="100%"
             height="100%"
             style="display:inline;fill:none;fill-opacity:1;stroke-width:23.66179813;stroke:#BASE04;stroke-opacity:1;stroke-dasharray:none;stroke-linejoin:miter" /></g></g><g
         inkscape:label="Logo Middle"
         inkscape:groupmode="layer"
         id="layer1"><g
          style="display:none;fill:#BASE00"
           transform="matrix(0.2391065,0,0,0.2391065,1221.2332,657.99222)"
           inkscape:label="(pdf) background"
           id="layer1-3"><rect
             y="-2102.4253"
             x="-1045.6049"
             height="7145.4614"
             width="7947.0356"
             id="rect995"
            style="display:inline;opacity:1;fill:#BASE00;fill-opacity:1;stroke-width:10.3605" /></g><g
           id="g3"
           transform="matrix(0.45889715,0,0,0.45710002,1073.1087,525.94996)"
           inkscape:label="g1"><path
             sodipodi:nodetypes="cccccccccc"
             inkscape:connector-curvature="0"
             id="path3336-6-5"
             d="m 1728.6058,1440.537 645.6348,0.032 -72.9659,129.1638 -173.1858,-0.4801 86.0059,149.8745 -36.878,63.8165 -75.3564,0.083 -122.3074,-213.3959 -176.1741,-0.3573 z"
             style="display:inline;fill:#BASE0C;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:87.5769;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1" /><path
             sodipodi:nodetypes="cccccccccc"
             inkscape:connector-curvature="0"
             id="path4260-0-6"
             d="m 1587.3308,1223.905 322.79,559.152 -148.3421,1.3916 -86.1772,-150.2232 -86.7921,149.4204 -73.7057,-0.029 -37.7502,-65.219 123.6526,-212.6193 -87.7776,-152.7496 z"
             style="color:#BASE00;clip-rule:nonzero;display:inline;overflow:visible;visibility:visible;isolation:auto;mix-blend-mode:normal;color-interpolation:sRGB;color-interpolation-filters:linearRGB;solid-color:#BASE00;solid-opacity:1;fill:#BASE06;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:87.5768;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-dashoffset:0;stroke-opacity:1;color-rendering:auto;image-rendering:auto;shape-rendering:auto;text-rendering:auto;enable-background:accumulate"
             inkscape:label="path4260-0-6" /><use
             x="0"
             y="0"
             xlink:href="#path3336-6-5"
             inkscape:transform-center-x="124.43045"
             inkscape:transform-center-y="151.59082"
             id="use3439-6-2"
             transform="rotate(120,1845.2462,1209.911)"
             width="100%"
             height="100%"
             style="display:inline;fill:#BASE00;fill-opacity:1;stroke-width:11.0512" /><use
             style="display:inline;fill:#BASE00;fill-opacity:1;stroke-width:11.0512"
             x="0"
             y="0"
             xlink:href="#path4260-0-6"
             id="use4354-5-9"
             transform="rotate(120,1845.6494,1208.8606)"
             width="100%"
             height="100%" /><use
             x="0"
             y="0"
             xlink:href="#path3336-6-5"
             inkscape:transform-center-x="59.669705"
             inkscape:transform-center-y="-139.94592"
             id="use3449-5-1"
             transform="rotate(-120,1845.7733,1209.5614)"
             width="100%"
             height="100%"
             style="display:inline;fill:#BASE00;fill-opacity:1;stroke-width:11.0512" /><use
             style="display:inline;fill:#BASE0D;fill-opacity:1;stroke:#BASE0C;stroke-width:11.0513;stroke-dasharray:none;stroke-opacity:0.993901"
             x="0"
             y="0"
             xlink:href="#path4260-0-6"
             id="use4362-2-2"
             transform="rotate(-120,1845.5148,1209.4248)"
             width="100%"
             height="100%"
             inkscape:label="use4362-2" /></g></g></svg>
  '';

  # Vector Image color mappings
  vector1Colors = {
    GRADIENT1 = config.theme.colors.base01;
    GRADIENT2 = config.theme.colors.base0D;
    GRADIENT3 = config.theme.colors.base02;
    LIGHTBLUE1 = config.theme.colors.base00;
    LIGHTBLUE2 = config.theme.colors.base01;
    LIGHTBLUE3 = config.theme.colors.base0C;
    LIGHTBLUE4 = config.theme.colors.base05;
    GRAY = config.theme.colors.base03;
    RED = config.theme.colors.base08;
    BLACK = config.theme.colors.base00;
  };

  vector2Colors = {
    BASE00 = config.theme.colors.base00;
    BASE01 = config.theme.colors.base01;
    BASE02 = config.theme.colors.base02;
    BASE04 = config.theme.colors.base05;
    BASE06 = config.theme.colors.base06;
    BASE0C = config.theme.colors.base0C;
    BASE0D = config.theme.colors.base0D;
    PAGECOLOR = config.theme.colors.base01;
    BORDERCOLOR = config.theme.colors.base05;
    DESKCOLOR = config.theme.colors.base02;
    BORDER_ACCENT1 = config.theme.colors.base0D;
    BORDER_ACCENT2 = config.theme.colors.base0C;
  };

  # Function to replace colors in SVG
  replaceColors = svg: colors:
    builtins.foldl' (acc: color: builtins.replaceStrings ["#${color}"] [colors.${color}] acc) svg (builtins.attrNames colors);

  # Generate the themed SVGs
  vector1Themed = replaceColors vector1Svg vector1Colors;
  vector2Themed = replaceColors vector2Svg vector2Colors;

  # Create the SVG files
  vector1File = pkgs.writeText "vector-1.svg" vector1Themed;
  vector2File = pkgs.writeText "vector-2.svg" vector2Themed;
in {
  options.services.wallpapers = {
    enable = mkEnableOption "Enable themed wallpaper generation";

    directory = mkOption {
      type = types.str;
      default = "${config.home.homeDirectory}/.wallpapers";
      description = "Directory to store generated wallpapers";
    };

    vector1 = mkOption {
      type = types.str;
      readOnly = true;
      description = "Path to the generated vector-1.svg wallpaper";
    };

    vector2 = mkOption {
      type = types.str;
      readOnly = true;
      description = "Path to the generated vector-2.svg wallpaper";
    };
  };

  config = mkIf cfg.enable {
    # Create the directory
    home.file.".wallpapers/.keep".text = "";

    # Copy the SVG files to the wallpapers directory
    home.file.".wallpapers/vector-1.svg".source = vector1File;
    home.file.".wallpapers/vector-2.svg".source = vector2File;

    # Provide paths for use in other configs
    services.wallpapers.vector1 = "${cfg.directory}/vector-1.svg";
    services.wallpapers.vector2 = "${cfg.directory}/vector-2.svg";
  };
}

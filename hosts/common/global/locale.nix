{lib, ...}: let
  locale = "en_US.utf8";
in {
  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = locale;

    extraLocaleSettings = {
      LC_ADDRESS = locale;
      LC_IDENTIFICATION = locale;
      LC_MEASUREMENT = locale;
      LC_MONETARY = locale;
      LC_NAME = locale;
      LC_NUMERIC = locale;
      LC_PAPER = locale;
      LC_TELEPHONE = locale;
      LC_TIME = locale;
      LC_MESSAGES = locale;
      LC_CTYPE = locale;
      LC_ALL = locale;
      LANG = locale;
    };
  };
}

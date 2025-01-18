{
  programs.qutebrowser = {
    settings = {
      completion = {
        open_categories = ["history"];
      };
      tabs = {
        select_on_remove = "last-used";
      };
      fonts = {
        default_size = "14px";
        default_family = "Inter Display Medium";

        web = {
          family = {
            sans_serif = "Inter";
          };
        };
      };
    };
    searchEngines = {
      y = "https://www.youtube.com/results?search_query={}";
      w = "https://en.wikipedia.org/wiki/Special:Search/{}";
      r = "https://www.reddit.com/search/?q={}";
    };
    keyBindings = {
      normal = {
        "<Ctrl-o>" = "tab-focus stack-prev";
        "<Ctrl-i>" = "tab-focus stack-next";

        "ey" = ":cmd-set-text :tab-focus https://www.youtube.com";
        "eq" = ":cmd-set-text :tab-focus https://q.utoronto.ca";

        "gcy" = "open https://www.youtube.com";
        "gcq" = "open https://q.utoronto.ca";
        "gcd" = "open https://discord.com/channels/@me";

        "gcY" = "open -t https://www.youtube.com";
        "gcQ" = "open -t https://q.utoronto.ca";
        "gcD" = "open -t https://discord.com/channels/@me";
      };
    };
  };
}

{ config, lib, pkgs, user, ...}:

{
  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";
    sessionVariables = {
      EDITOR = "nvim";
    };
  };

	programs.home-manager.enable = true;

	home.packages = with pkgs; [
		ripgrep
		jq
		fzf
		fd
		zip
		unzip
	];

  programs.password-store = {
   enable = true;
  };

	programs.git = {
		enable = true;
		userName = "gordon";
		userEmail = "gordonchen2014@gmail.com";
	};

	programs.qutebrowser = {
		enable = true;
		searchEngines = {
			am = "https://man.archlinux.org/search?q={}";
			ar = "https://archlinux.org/packages/?q={}";
			aw = "https://wiki.archlinux.org/title/Special:Search/{}";
			br = "https://www.britannica.com/search?query={}";
			gh = "https://github.com/search?q={}";
			go = "https://www.google.com/search?q={}";
			hn = "https://hn.algolia.com/?q={}";
			ji = "https://jisho.org/search/{}";
			ma = "https://math.stackexchange.com/search?q={}";
			nr = "https://search.nixos.org/packages?query={}";
      no = "https://search.nixos.org/options?query={}";
			pw = "https://proofwiki.org?search={}";
			re = "https://www.reddit.com/search/?q={}";
			wi = "https://en.wikipedia.org/wiki/Special:Search/{}";
			yt = "https://www.youtube.com/results?search_query={}";
		};
		keyBindings = {
			normal = {
				"<Ctrl-o>" = "tab-focus stack-prev";
				"<Ctrl-i>" = "tab-focus stack-next";
			};
		};
		settings = {
			tabs.show = "never";
			tabs.select_on_remove = "last-used";
		};
	};

  programs.bash.enable = true;

	programs.foot = {
		enable = true;
    settings =  {
      colors.background = "ffffff";
      colors.foreground = "000000";
      cursor.color = "ffffff 000000";
    };
	};

	programs.neovim = {
		enable = true;
		plugins = with pkgs.vimPlugins; [
			nvim-treesitter.withAllGrammars
		];
    extraPackages = with pkgs; [
      ripgrep
      lua-language-server
      stylua
      nixd
    ];
		# extraLuaConfig = lib.fileContents ../nvim/init.lua;
	};

	xdg = {
		enable = true;
		configFile.nvim.source = ../nvim;
	};

	wayland.windowManager.hyprland = {
		enable = true;
		settings = {
			input.sensitivity = 1.0;
			input.accel_profile = "flat";
			decoration.rounding = 4;
			general.border_size = 0;
			animations.enabled = false;

      general.layout = "master";

      master.orientation = "right";
		};
		extraConfig = ''
		monitor=,preferred,auto,auto

    windowrulev2 = group set always,class:^(.*)$

    bind = SUPER SHIFT, return,       exec, foot
    bind = SUPER, b,       exec, qutebrowser

    bind = SUPER SHIFT, equal,        layoutmsg, mfact +0.05
    bind = SUPER,       minus,        layoutmsg, mfact -0.05
    bind = SUPER,       equal,        layoutmsg, mfact exact 0.5
    bind = SUPER,       m,            layoutmsg, focusmaster master
    bind = SUPER SHIFT, m,            layoutmsg, swapwithmaster master
    bind = SUPER,       space,        layoutmsg, orientationcycle right bottom center
    bind = SUPER,       tab,          layoutmsg, cyclenext
    bind = SUPER SHIFT, tab,          layoutmsg, cycleprev

    bind = SUPER,       bracketleft,  changegroupactive, f
    bind = SUPER,       bracketright, changegroupactive, b
    bind = SUPER SHIFT, e,            fullscreen, 1
    bind = SUPER SHIFT, q,            exit
    bind = SUPER,       t,            togglefloating
    bind = SUPER,       w,            killactive
    bind = SUPER SHIFT, a,            focuscurrentorlast
    bind = SUPER,       u,            focusurgentorlast

    bind = SUPER,       l,            movefocus, r
    bind = SUPER,       j,            movefocus, d
    bind = SUPER,       k,            movefocus, u
    bind = SUPER,       h,            movefocus, l
    bind = SUPER SHIFT, l,            movewindoworgroup, r
    bind = SUPER SHIFT, j,            movewindoworgroup, d
    bind = SUPER SHIFT, k,            movewindoworgroup, u
    bind = SUPER SHIFT, h,            movewindoworgroup, l
    bind = SUPER,       n,            moveoutofgroup

    bind = SUPER, r, submap, r

    submap = r

    bind = , l, resizeactive, 10 0
    bind = , l, submap, reset

    bind = , escape, submap, reset

    submap = reset

    bind = SUPER, space, layoutmsg, togglesplit

    bindl  =, XF86AudioMute,        exec, wpctl set-mute   @DEFAULT_AUDIO_SINK@ toggle
    bindel =, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    bindel =, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
		'';
	};

	home.stateVersion = "24.05";
}

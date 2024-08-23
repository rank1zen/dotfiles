{ config, pkgs, ...}:

{
	home.username = "gordo";
	home.homeDirectory = "/home/gordo";
	home.stateVersion = "24.05";
	
	home.packages = with pkgs; [
		ripgrep
		jq
		fzf
		tree
		which
		zip
		unzip
	];
	
	programs.git = {
		enable = true;
		userName = "Gordon Chen";
		userEmail = "gordonchen2014@gmail.com";
	};
	
	programs.home-manager.enable = true;

	programs.foot = {
		enable = true;
	};
	
	programs.neovim = {
		enable = true;
	};

	wayland.windowManager.hyprland = {
		enable = true;
		extraConfig = ''
		monitor=,preferred,auto,auto

		bind = SUPER, 0, exec, foot
		'';
	};
}

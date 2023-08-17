Nix Based Workstation Setup
Preparing Nix
Nix Installation
To install nix run the following command. This will kick off the (recommended) multi-user installation. More information can be found on the official Nix / NixOS Documentation.

The installer will guide you through the process and even show the commands it will be executing as part of the setup. Once it has completed, exit your terminal, open a new one and run nix --version.

nix --version
nix (Nix) 2.12.0
Nix Flakes
In order to use Nix Flakes we need to enable a few experimental features.

Run the following command:

mkdir -p ~/.config/nix
cat > ~/.config/nix/nix.conf << EOF
experimental-features = nix-command flakes
sandbox = true
EOF
Home Manager
To check for existing installed nix profiles run:

nix profile list
This should return an empty result. Having issued this command we can now init home-manager using the following command:

nix run home-manager/master -- init --switch
The result should be similar to:

Creating /Users/charlie/.config/home-manager/home.nix...
Creating /Users/charlie/.config/home-manager/flake.nix...

Creating initial Home Manager generation...

warning: creating lock file '/Users/charlie/.config/home-manager/flake.lock'
Starting Home Manager activation
Activating checkFilesChanged
Activating checkLaunchAgents
Activating checkLinkTargets
Activating writeBoundary
Activating copyFonts
Activating installPackages
installing 'home-manager-path'
building '/nix/store/psw0fcrh178q6604gimbqn7v00vzn9yx-user-environment.drv'...
Activating linkGeneration
Creating profile generation 1
Creating home file links in /Users/charlie
Activating onFilesChange
Activating setupLaunchAgents
All done! The home-manager tool should now be installed and you can edit

    /Users/charlie/.config/home-manager/home.nix

to configure Home Manager. Run 'man home-configuration.nix' to
see all available options.
As you can see from the above output, home-manager created ~/.config/home-manager with a flake.nix, flake.lock and home.nix file. We'll be editing flake.nix and home.nix to suit our needs. The lock file ensures the versions are captured.

Now running nix profile list should return something along:

0 - - /nix/store/0pkhivda9s8046nk66scq0clwjylz6br-home-manager-path
This is the profile home-manager has created. After a terminal reload the home-manager switch command is available. For more information on installation options, refer to the home-manager documentation.

To make home.nix a bit more managable we'll update it to look like the one in this repo.

Now is a good time to add the initial home-manager setup to a git repo.

Reorganising Structure
For the next few steps it makes sense to reorganise the file structure a little to cater for different types of categories i.e. shell scripts and nix files. The structure I prefer is something similar to this:

├── README.md
├── bin
├── flake.lock
├── flake.nix
└── modules
    ├── home.nix
    ├── packages.nix
    └── programs.nix
We'll get to the bin directory later.

Adding A Helper
Having to cd into the dotfiles directory every time we interact with it is a bit cumbersome, hence why I tend to add a bash script that makes life a bit easier.

First we'll add the following executable file bin/ws. For the time being the content is as follows:

#!/usr/bin/env bash

echo "Hello"
The script is only accessible in the bin directory, lets change that. We're going to replace line 14 in home.nix with the following:

hm = "~/.config/home-manager/bin/hm";
The assumption here is that this is where your dotfiles checkout lives. If not, just use the path you have chosen. Running nix run '.#homeConfigurations.${USER}.activationPackage' will ensure the alias is available. You'll have to reload your terminal. Running hm will result in Hello being printed out. Now it is time for adding some usefull functionality.

Building Out the Helper
#!/usr/bin/env bash

_switch() {
    home-manager switch -b backup
}

_print_help() {
	cat <<EOF
Usage: $CMD switch        # run home-manager switch
       $CMD -h|help       # print this help message.
EOF

}

# determine script base name
CMD=$(basename "$0")

# determine script base path
BASE_PATH=$(dirname "$(dirname "$0")")

# print help if no sub command was given
if [[ "$#" -eq 0 ]]; then
	_print_help
fi

while [[ "$#" -gt 0 ]]; do
	case $1 in
	switch) _switch ;;
	-h | help) _print_help ;;
	*)
		_print_help
		exit 1
		;;
	esac
	shift
done
Once the file has been edited and saved, you should now be able to just run hm switch to apply any changes you made to your nix files. We'll be adding more functionality to this utility script later.

New Terminal And Configuring ZSH
Now we can spice up the terminal UI by adding oh-my-zsh and installing another terminal emulator. This setup is optional, but will show you how to go about adding other apps and configuring you favorite shell.

Most use iTerm 2, so let us modify modules/packages.nix to look like this:

{ pkgs }:

let
  packages = with pkgs; [
    iterm2
    nvim
  ];
in packages
After running hm switch, open $HOME/Applications/Home Manager Apps, you'll find iTerm 2 there ready to use.

We could stop here but home-manager has another trick up its sleeve; programs, another way of managing applications. We'll now configure Alacritty, another terminal emulator. For starters we could just add it to modules/programs.nix but as we'll be adding more bespoke configuration this file will just get to large to maintain if we keep on adding more programs this way. So in this case we'll create a new file: modules/alacritty.nix

{...}:
{
  programs.alacritty = {
    enable = true;
  };
}
We need to reference it in flake.nix:

modules = [
  home
  ./modules/alacritty.nix
];
Git add nix/modules/alacritty.nix and hm switch after which Alacritty will be available in $HOME/Applications/Home Manager Apps.

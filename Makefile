# commands
CP = cp
RM = rm
MKDIR = mkdir

# config folders
GITCONFIG = $(HOME)/.gitconfig
TERMCONFIG = $(HOME)/.config/alacritty/alacritty.yml
NVIMCONFIG = $(HOME)/.config/nvim

# windows specific settings
ifeq ($(OS),Windows_NT)
	SHELL := powershell.exe
	.SHELLFLAGS := -Command
	TERMCONFIG := $(HOME)/AppData/Roaming/alacritty/alacritty.yml
	PWSHCONFIG := $(HOME)/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1
	NVIMCONFIG := $(HOME)/AppData/Local/nvim
endif

all: $(TERMCONFIG) $(GITCONFIG) $(PWSHCONFIG) $(NVIMCONFIG)

$(TERMCONFIG): alacritty.yml
	$(RM) $(TERMCONFIG)
	$(CP) ./alacritty.yml $(TERMCONFIG)

$(GITCONFIG): .gitconfig
	$(RM) $(GITCONFIG)
	$(CP) ./.gitconfig $(GITCONFIG)

$(NVIMCONFIG): ./nvim/lua/custom/plugins/init.lua ./nvim/init.lua
	$(RM) -r $(NVIMCONFIG)
	$(MKDIR) $(NVIMCONFIG)
	$(CP) -r ./nvim/* $(NVIMCONFIG)/

$(PWSHCONFIG): Microsoft.PowerShell_profile.ps1
	$(RM) $(PWSHCONFIG)
	$(MKDIR) $(PWSHCONFIG)
	$(CP) ./Microsoft.PowerShell_profile.ps1 $(PWSHCONFIG)
	. $$profile

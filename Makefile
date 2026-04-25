# --- --- --- --- --- --- --- --- ---
#  > gentoo config connect
# --- --- --- --- --- --- --- --- ---

# - > Verbosity off by default -
ifeq ("$(origin V)", "command line")
	CONNECT_VERBOSE = $(V)
endif
Q = @
ifneq ($(findstring 1, $(CONNECT_VERBOSE)),)
	Q =
endif

HERE := $(shell pwd)
USER_LIB := zsl
USER_BIN := gentoo-config portage menu noogetctl
USER_DOTCONFIG := hypr waybar alacritty fastfetch oh-my-posh fuzzel yazi
PORTAGE := make.conf repos.conf sets

all: change remove link

# --- --- --- --- --- --- --- --- ---
# > change permissions
# --- --- --- --- --- --- --- --- ---
change:
	@echo "[    ] Changing permission..."
	$(Q)sudo chown -R $(USER):root $(HERE)
	$(Q)$(foreach item,$(USER_LIB), chmod -x $(HERE)/lib/$(item).bash;)
	$(Q)$(foreach item,$(USER_BIN), chmod +x $(HERE)/bin/$(item).bash;)
	@echo "[ ok ] Permission granted!"

# --- --- --- --- --- --- --- --- ---
# > remove existing files
# --- --- --- --- --- --- --- --- ---
remove:
	@echo "[    ] Removing existing files..."
	$(Q)rm -f $(HOME)/.bash_profile $(HOME)/.bashrc $(HOME)/.bash_logout $(HOME)/.vimrc
	$(Q)$(foreach item,$(USER_LIB), rm -f $(HOME)/.local/lib/$(item);)
	$(Q)$(foreach item,$(USER_BIN), rm -f $(HOME)/.local/bin/$(item);)
	$(Q)$(foreach item,$(USER_DOTCONFIG), rm -rf $(HOME)/.config/$(item);)
	$(Q)rm -f $(HOME)/.config/vesktop/settings/quickCss.css
	$(Q)if command -v emerge >/dev/null; then \
		$(foreach item,$(PORTAGE), sudo rm -rf /etc/portage/$(item);) \
	fi
	@echo "[ ok ] Target directory cleaned!"

# --- --- --- --- --- --- --- --- ---
# > link files
# --- --- --- --- --- --- --- --- ---
link:
	@echo "[    ] Symbolically linking files..."
	@echo "[    ] Home..."
	$(Q)ln -sf $(HERE)/bash/profile.bash $(HOME)/.bash_profile
	$(Q)ln -sf $(HERE)/bash/rc.bash $(HOME)/.bashrc
	$(Q)ln -sf $(HERE)/bash/logout.bash $(HOME)/.bash_logout
	$(Q)ln -sf $(HERE)/vim/rc.vim $(HOME)/.vimrc
	@echo "[ ok ] Home linked!"
	@echo "[    ] Local..."
	$(Q)mkdir -p $(HOME)/.local/lib $(HOME)/.local/bin
	$(Q)$(foreach item,$(USER_LIB), ln -sf $(HERE)/lib/$(item).bash $(HOME)/.local/lib/$(item);)
	$(Q)$(foreach item,$(USER_BIN), ln -sf $(HERE)/bin/$(item).bash $(HOME)/.local/bin/$(item);)
	@echo "[ ok ] Local linked!"
	@echo "[    ] Config..."
	$(Q)mkdir -p $(HOME)/.config/vesktop/settings
	$(Q)$(foreach item,$(USER_DOTCONFIG), ln -sf $(HERE)/$(item) $(HOME)/.config/$(item);)
	$(Q)ln -sf $(HERE)/vesktop/settings/quickCss.css $(HOME)/.config/vesktop/settings/quickCss.css
	@echo "[ ok ] Config linked!"
	@echo "[    ] Pictures..."
	$(Q)mkdir -p $(HOME)/Pictures/Wallpaper
	$(Q)ln -sf $(HERE)/Pictures/Wallpapers/lemuen-panels.png $(HOME)/Pictures/Wallpaper/lemuen-panels.png
	@echo "[ ok ] Pictures linked!"
	$(Q)if command -v emerge >/dev/null; then \
		$(foreach item,$(PORTAGE), sudo ln -sf $(HERE)/portage/$(item) /etc/portage/$(item);) \
	fi

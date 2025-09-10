# Makefile for installing personal dotfiles and configurations
# Usage: make install

.PHONY: install uninstall backup help clean

# Default target
all: help

# Install all dotfiles to their proper locations
install: backup
	@echo "Installing dotfiles..."
	
	# Install shell configuration
	@echo "Installing .zshrc..."
	@cp dotfiles/.zshrc $(HOME)/.zshrc
	
	# Install tmux configuration
	@echo "Installing .tmux.conf..."
	@cp dotfiles/.tmux.conf $(HOME)/.tmux.conf
	
	# Install pip configuration
	@echo "Installing pip.conf..."
	@mkdir -p $(HOME)/.config/pip
	@cp dotfiles/pip.conf $(HOME)/.config/pip/pip.conf
	
	# Also create legacy pip config location for compatibility
	@mkdir -p $(HOME)/.pip
	@cp dotfiles/pip.conf $(HOME)/.pip/pip.conf
	
	@echo ""
	@echo "✅ Dotfiles installation completed!"
	@echo ""
	@echo "Next steps:"
	@echo "  • Restart your terminal or run: source ~/.zshrc"
	@echo "  • For tmux: restart tmux or run: tmux source-file ~/.tmux.conf"
	@echo "  • Pip will automatically use the new configuration"
	@echo ""

# Create backup of existing dotfiles
backup:
	@echo "Creating backup of existing dotfiles..."
	@mkdir -p $(HOME)/.dotfiles-backup
	@if [ -f $(HOME)/.zshrc ]; then \
		cp $(HOME)/.zshrc $(HOME)/.dotfiles-backup/.zshrc.bak; \
		echo "Backed up existing .zshrc"; \
	fi
	@if [ -f $(HOME)/.tmux.conf ]; then \
		cp $(HOME)/.tmux.conf $(HOME)/.dotfiles-backup/.tmux.conf.bak; \
		echo "Backed up existing .tmux.conf"; \
	fi
	@if [ -f $(HOME)/.config/pip/pip.conf ]; then \
		cp $(HOME)/.config/pip/pip.conf $(HOME)/.dotfiles-backup/pip.conf.bak; \
		echo "Backed up existing pip.conf"; \
	fi
	@if [ -f $(HOME)/.pip/pip.conf ]; then \
		cp $(HOME)/.pip/pip.conf $(HOME)/.dotfiles-backup/pip-legacy.conf.bak; \
		echo "Backed up existing legacy pip.conf"; \
	fi

# Uninstall dotfiles and restore backups
uninstall:
	@echo "Uninstalling dotfiles and restoring backups..."
	@if [ -f $(HOME)/.dotfiles-backup/.zshrc.bak ]; then \
		cp $(HOME)/.dotfiles-backup/.zshrc.bak $(HOME)/.zshrc; \
		echo "Restored .zshrc from backup"; \
	else \
		rm -f $(HOME)/.zshrc; \
		echo "Removed .zshrc (no backup found)"; \
	fi
	@if [ -f $(HOME)/.dotfiles-backup/.tmux.conf.bak ]; then \
		cp $(HOME)/.dotfiles-backup/.tmux.conf.bak $(HOME)/.tmux.conf; \
		echo "Restored .tmux.conf from backup"; \
	else \
		rm -f $(HOME)/.tmux.conf; \
		echo "Removed .tmux.conf (no backup found)"; \
	fi
	@if [ -f $(HOME)/.dotfiles-backup/pip.conf.bak ]; then \
		cp $(HOME)/.dotfiles-backup/pip.conf.bak $(HOME)/.config/pip/pip.conf; \
		echo "Restored pip.conf from backup"; \
	else \
		rm -f $(HOME)/.config/pip/pip.conf; \
		echo "Removed pip.conf (no backup found)"; \
	fi
	@if [ -f $(HOME)/.dotfiles-backup/pip-legacy.conf.bak ]; then \
		cp $(HOME)/.dotfiles-backup/pip-legacy.conf.bak $(HOME)/.pip/pip.conf; \
		echo "Restored legacy pip.conf from backup"; \
	else \
		rm -f $(HOME)/.pip/pip.conf; \
		echo "Removed legacy pip.conf (no backup found)"; \
	fi
	@echo "✅ Uninstallation completed!"

# Install system-specific configurations
install-ubuntu-20.04:
	@echo "Installing Ubuntu 20.04 specific configurations..."
	@if [ -f dotfiles/ubuntu.20.04 ]; then \
		echo "Ubuntu 20.04 configuration found. Please review dotfiles/ubuntu.20.04 and apply manually."; \
	else \
		echo "No Ubuntu 20.04 configuration found."; \
	fi

install-ubuntu-22.04:
	@echo "Installing Ubuntu 22.04 specific configurations..."
	@if [ -f dotfiles/ubuntu.22.04 ]; then \
		echo "Ubuntu 22.04 configuration found. Please review dotfiles/ubuntu.22.04 and apply manually."; \
	else \
		echo "No Ubuntu 22.04 configuration found."; \
	fi

# Clean backup files
clean:
	@echo "Cleaning backup files..."
	@rm -rf $(HOME)/.dotfiles-backup
	@echo "✅ Backup files cleaned!"

# Show help
help:
	@echo "Personal Dotfiles Makefile"
	@echo ""
	@echo "Available targets:"
	@echo "  install              Install all dotfiles to proper locations"
	@echo "  uninstall            Remove dotfiles and restore backups"
	@echo "  backup               Create backup of existing dotfiles"
	@echo "  install-ubuntu-20.04 Install Ubuntu 20.04 specific configs"
	@echo "  install-ubuntu-22.04 Install Ubuntu 22.04 specific configs"
	@echo "  clean                Remove backup files"
	@echo "  help                 Show this help message"
	@echo ""
	@echo "Usage examples:"
	@echo "  make install         # Install all dotfiles"
	@echo "  make uninstall       # Uninstall and restore backups"
	@echo "  make clean           # Clean backup files"
	@echo ""
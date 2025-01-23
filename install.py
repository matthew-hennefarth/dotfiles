#!/usr/bin/env python3

import os
import sys
import shutil
import argparse
import logging
import subprocess

LOGGER = logging.getLogger(__name__)

DOTFILE_DIR = os.path.realpath(os.path.dirname(__file__))

HOME = os.path.expanduser("~")
CONFIG = os.path.join(HOME, ".config")
BREW_FULL_PATH = "/opt/homebrew/bin/brew"


def init_logger() -> None:
    LOGGER.debug("Changing logger format")
    format = "%(message)s"
    logging.basicConfig(format=format)
    LOGGER.setLevel(logging.WARNING)
    LOGGER.debug("Set logger level to WARNING")


def generate_symlink(src: str, dst: str, overwrite: bool = False) -> None:
    if os.path.exists(dst) or os.path.islink(dst):
        log_string = f"{dst} already exists..."
        if overwrite:
            LOGGER.info(f"{log_string} Overwriting")
            if os.path.isdir(dst) and not os.path.islink(dst):
                LOGGER.debug(f"Removing {dst} (pure directory)")
                shutil.rmtree(dst)

            elif os.path.isdir(dst):
                LOGGER.debug(f"Removing {dst} (sym link directory)")
                os.rmdir(dst)

            else:
                LOGGER.debug(f"Removing {dst}")
                os.unlink(dst)
        
        else:
            LOGGER.info(f"{log_string} Skipping")
            return
    
    LOGGER.info(f"Creating symlink {src} --> {dst}")
    os.symlink(src, dst)


def generate_symlinks_for(
    src: str, dst: str, dot_prefix: bool = False, overwrite: bool = False
) -> None:
    LOGGER.info(f"Installing to {dst}")

    configs = [f for f in os.listdir(src) if f != ".DS_Store"]
    for config in configs:
        target = os.path.join(dst, f"{'.' if dot_prefix else ''}{config}")
        config = os.path.join(src, config)
        
        generate_symlink(config, target, overwrite=overwrite)


def configure_symlinks(overwrite: bool = False) -> None:
    LOGGER.info("Creating symlinks")

    home_dot_dir = os.path.join(DOTFILE_DIR, "home")
    config_dot_dir = os.path.join(DOTFILE_DIR, "config")

    generate_symlinks_for(home_dot_dir, HOME, dot_prefix=True, overwrite=overwrite)

    LOGGER.info("Installing scripts")
    scripts_dir = os.path.join(DOTFILE_DIR, "scripts")
    target = os.path.join(HOME, ".local/bin/scripts")
    generate_symlink(scripts_dir, target, overwrite=overwrite)

    if not os.path.isdir(CONFIG):
        LOGGER.info("Creating .config directory")
        os.mkdir(CONFIG)

    generate_symlinks_for(config_dot_dir, CONFIG, overwrite=overwrite)


def homebrew_installed() -> bool:
    return shutil.which(BREW_FULL_PATH) is not None


def nvim_installed() -> bool:
    return shutil.which("nvim") is not None


def install_homebrew() -> None:
    LOGGER.info("Installing Homebrew...")
    download_cmd = "sudo curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash --login"
    LOGGER.debug(f"Running command: {download_cmd}")
    subprocess.check_call(download_cmd, shell=True)

    install_cmd = "eval $(/opt/homebrew/bin/brew shellenv)"
    LOGGER.debug(f"Running command: {install_cmd}")
    subprocess.check_call(install_cmd, shell=True)


def install_homebrew_packages() -> None:
    pkgfile_dir = os.path.join(DOTFILE_DIR, "pkgfiles")
    install_cmd = "brew bundle"
    LOGGER.info("Installing Homebrew Packages")
    LOGGER.debug(f"Running command: {install_cmd}")
    subprocess.check_call(install_cmd, shell=True, cwd=pkgfile_dir)


def configure_homebrew() -> None:
    if not homebrew_installed():
        install_homebrew()

    install_homebrew_packages()


def configure_pkgmanager() -> None:
    if sys.platform == "darwin":
        configure_homebrew()

    else:
        LOGGER.error(f"Unknown package manager for {sys.platform}")


def configure_nvim() -> None:
    if not nvim_installed():
        LOGGER.error("Neovim is not installed!")
        return

    update_cmd = "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'"
    LOGGER.info("Running PackerSync")
    LOGGER.debug(f"Running command: {update_cmd}")
    subprocess.check_call(update_cmd, shell=True)

    ts_cmd = "nvim -c 'TSInstallSync maintained' -c q"
    LOGGER.info("Running TSInstallSync")
    LOGGER.debug(f"Running command: {ts_cmd}")
    subprocess.check_call(ts_cmd, shell=True)


def main() -> None:
    init_logger()

    parser = argparse.ArgumentParser(
        prog="install.py",
        description="Installs config files, system packages, and setup nvim",
        epilog="Currently only for MacOS, though I will work on porting to Linux over time...",
    )

    parser.add_argument("-v", "--verbose", action="store_true")
    parser.add_argument(
        "-o",
        "--overwrite",
        action="store_true",
        help="Overwrite existing symlinks and files for config files",
    )

    LOGGER.debug("Parsing command line arguments")
    args = parser.parse_args()

    if args.verbose:
        LOGGER.setLevel(logging.INFO)
        LOGGER.debug("Setting logger level to INFO")

    configure_symlinks(overwrite=args.overwrite)
    configure_pkgmanager()
    configure_nvim()

    # other things to do:
    # 1) ensure ~/.local/share/gnupg exists
    # 2) ensure !/.local/bin exists
    # 3) install the DinaRemasterII
    #   https://github.com/zshoals/Dina-Font-TTF-Remastered/tree/master to
    #   /usr/share/fonts (on linux) unsure where for MacOS
    # 4) symlink ~/.gnupg to ~/.local/share/gnupg (and maybe also include the conf files in this repo?)


if __name__ == "__main__":
    main()

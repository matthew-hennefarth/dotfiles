#!/usr/bin/env python

import os, sys, shutil
import argparse
import logging
import shutil
import subprocess

LOGGER = logging.getLogger(__name__)

DOTFILE_DIR = os.path.realpath(os.path.dirname(__file__))

HOME = os.path.expanduser("~")
CONFIG = os.path.join(HOME, ".config")
BREW_FULL_PATH = "/opt/homebrew/bin/brew"

def init_logger():
    LOGGER.debug("Changing logger format")
    format = "%(message)s"
    logging.basicConfig(format=format)
    LOGGER.setLevel(logging.WARNING)
    LOGGER.debug("Set logger level to WARNING")


def generate_symlinks_for(src: str, dst: str, dot_prefix: bool = False, overwrite: bool = False) -> None:
    LOGGER.info(f"Installing to {dst}")
    
    configs = [f for f in os.listdir(src) if f != ".DS_Store"]
    for config in configs:
        target = os.path.join(dst, f"{'.' if dot_prefix else ''}{config}")
        config = os.path.join(src, config)

        if os.path.exists(target) or os.path.islink(target):
            log_string = f"{target} already exists..."
            if overwrite:
                LOGGER.info(f"{log_string} Overwriting")
                if os.path.isdir(target) and not os.path.islink(target):
                    LOGGER.debug(f"Removing {target} (pure directory)")
                    shutil.rmtree(target)

                elif os.path.isdir(target):
                    LOGGER.debug(f"Removing {target} (sym link directory)")
                    os.rmdir(target)

                else:
                    LOGGER.debug(f"Removing {target}")
                    os.unlink(target)

            else:
                LOGGER.info(f"{log_string} Skipping")
                continue

        LOGGER.info(f"Creating symlink {config} --> {target}")
        os.symlink(config, target)


def configure_symlinks(overwrite: bool = False):
    LOGGER.info("Creating symlinks")

    home_dot_dir = os.path.join(DOTFILE_DIR, "home")
    config_dot_dir = os.path.join(DOTFILE_DIR, "config")
    
    generate_symlinks_for(home_dot_dir, HOME, dot_prefix=True, overwrite=overwrite)
    generate_symlinks_for(config_dot_dir, CONFIG, overwrite=overwrite)


def homebrew_installed() -> bool:
    return shutil.which(BREW_FULL_PATH) is not None


def nvim_installed() -> bool:
    return shutil.which("nvim") is not None


def install_homebrew() -> None:
    # TODO!! this is a bit tricky I think...we will see tho!
    LOGGER.info("Installing Homebrew...")
    LOGGER.error("NOT IMPLEMENTED! CANNOT INSTALL HOMEBREW")


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

    update_cmd = "nvim --headless +PackerSync +q"
    LOGGER.info(f"Running PackerSync ")
    LOGGER.debug(f"Running command: {update_cmd}")
    subprocess.check_call(update_cmd, shell=True)


def main() -> None:
    init_logger()

    parser = argparse.ArgumentParser(
        prog = "install.py",
        description = "Installs config files, system packages, and setup nvim",
        epilog = "Currently only for MacOS, though I will work on porting to Linux over time...")

    parser.add_argument("-v", "--verbose", action="store_true")
    parser.add_argument("-o", "--overwrite", action="store_true", help="Overwrite existing symlinks and files for config files")

    LOGGER.debug("Parsing command line arguments")
    args = parser.parse_args()

    if args.verbose:
        LOGGER.setLevel(logging.INFO)
        LOGGER.debug("Setting logger level to INFO")
    
    configure_symlinks(overwrite=args.overwrite)
    configure_pkgmanager()
    configure_nvim()


if __name__ == "__main__":
    main()


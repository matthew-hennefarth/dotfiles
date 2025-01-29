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
    LOGGER.setLevel(logging.INFO)
    LOGGER.debug("Set logger level to WARNING")


def rm_old(dst: str):
    if os.path.islink(dst):
        LOGGER.debug(f"Removing {dst} (sym link)")
        os.unlink(dst)

    elif os.path.isdir(dst):
        LOGGER.debug(f"Removing {dst} (pure directory)")
        shutil.rmtree(dst)

    elif os.path.isfile(dst):
        LOGGER.debug(f"Removing {dst} (pure file)")
        os.remove(dst)


def copy_dir(src: str, dst: str, overwrite: bool = False) -> None:
    assert os.path.isdir(src)
    if os.path.exists(dst) or os.path.islink(dst):
        log_string = f"{dst} already exists..."
        if overwrite:
            LOGGER.debug(f"{log_string} Overwriting")
            try:
                rm_old(dst)
            except PermissionError as e:
                LOGGER.error(e) 
                LOGGER.error("Failed to remove directory: Permission denied")
                raise e

        else:
            LOGGER.debug(f"{log_string} Skipping")
            return

    LOGGER.info(f"Copying directory {src} --> {dst}")
    shutil.copytree(src, dst)


def generate_symlink(src: str, dst: str, overwrite: bool = False) -> None:
    if os.path.exists(dst) or os.path.islink(dst):
        log_string = f"{dst} already exists..."
        if overwrite:
            LOGGER.debug(f"{log_string} Overwriting")
            try:
                rm_old(dst)
            except PermissionError as e:
                LOGGER.error(e)
                LOGGER.error("Failed to remove old: Permission denied")
                raise e

        else:
            LOGGER.debug(f"{log_string} Skipping")
            return

    LOGGER.info(f"Creating symlink {src} --> {dst}")
    os.symlink(src, dst)


def generate_symlinks_for(
    src: str, dst: str, dot_prefix: bool = False, overwrite: bool = False
) -> None:
    LOGGER.debug(f"Installing to {dst}")

    configs = [f for f in os.listdir(src) if f != ".DS_Store"]
    for config in configs:
        target = os.path.join(dst, f"{'.' if dot_prefix else ''}{config}")
        config = os.path.join(src, config)

        generate_symlink(config, target, overwrite=overwrite)


def configure_symlinks(overwrite: bool = False) -> None:
    LOGGER.debug("Creating symlinks")

    home_dot_dir = os.path.join(DOTFILE_DIR, "home")
    config_dot_dir = os.path.join(DOTFILE_DIR, "config")

    LOGGER.info("Installing config files")
    generate_symlinks_for(home_dot_dir, HOME, dot_prefix=True, overwrite=overwrite)
   
    if not os.path.isdir(CONFIG):
        LOGGER.debug("Creating .config directory")
        os.mkdir(CONFIG)

    generate_symlinks_for(config_dot_dir, CONFIG, overwrite=overwrite)
    
    LOGGER.info("\nInstalling scripts")
    scripts_dir = os.path.join(DOTFILE_DIR, "scripts")
    USER_BIN = os.path.join(HOME, ".local/bin")
    if not os.path.exists(USER_BIN):
        LOGGER.debug("Creating .local/bin directory")
        os.makedirs(USER_BIN)

    target = os.path.join(USER_BIN, "scripts")
    generate_symlink(scripts_dir, target, overwrite=overwrite)


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
    LOGGER.debug("Configuring package manager")
    if sys.platform == "darwin":
        configure_homebrew()

    else:
        LOGGER.error(f"Unknown package manager for {sys.platform}")


def configure_nvim() -> None:
    LOGGER.info("\nConfiguring NeoVim")
    if not nvim_installed():
        LOGGER.error("Neovim is not installed!")
        return

    update_cmd = (
        "nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'"
    )
    LOGGER.info("Running PackerSync")
    LOGGER.debug(f"Running command: {update_cmd}")
    subprocess.check_call(update_cmd, shell=True)

    ts_cmd = "nvim -c 'TSInstallSync maintained' -c q"
    LOGGER.info("Running TSInstallSync")
    LOGGER.debug(f"Running command: {ts_cmd}")
    subprocess.check_call(ts_cmd, shell=True)

def configure_root_runit(overwrite: bool = False) -> None:
    LOGGER.debug("Installing global runit services...")
    INSTALL_SV = os.path.join(DOTFILE_DIR, "etc/sv")
    ROOT_SV_DIR = "/etc/sv"
    ROOT_SERVICE_DIR = "/var/service"

    with os.scandir(INSTALL_SV) as file_it:
        for fd in file_it:
            if not fd.is_dir():
                continue
            LOGGER.info(f"Installing service {fd.name}")
            src = fd.path
            dst = os.path.join(ROOT_SV_DIR, fd.name)
            try:
                copy_dir(src, dst, overwrite=overwrite)
                src = dst 
                dst = os.path.join(ROOT_SERVICE_DIR, fd.name) 
                generate_symlink(src, dst, overwrite=overwrite)
            
            except PermissionError:
                LOGGER.warning("Installing root runit services requires sudo privilege")

def configure_user_runit(overwrite: bool = False) -> None:
    LOGGER.debug("Installing personal runit services...")
    SERVICE_DIR = os.path.join(HOME, ".service")
    SV_DIR = os.path.join(HOME, ".config/sv")
    if not os.path.isdir(SERVICE_DIR):
        LOGGER.info("Creating .service directory")
        os.mkdir(SERVICE_DIR)

    generate_symlinks_for(SV_DIR, SERVICE_DIR, dot_prefix=False, overwrite=overwrite)


def configure_runit_services(overwrite: bool = False) -> None:
    if sys.platform == "darwin":
        LOGGER.debug("No runit services to install on macos")
        return

    LOGGER.info("\nInstalling runit services")
    configure_root_runit(overwrite=overwrite)            
    configure_user_runit(overwrite=overwrite)


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
        LOGGER.setLevel(logging.DEBUG)
        LOGGER.debug("Setting logger level to DEBUG")

    configure_symlinks(overwrite=args.overwrite)
    configure_pkgmanager()
    configure_nvim()
    configure_runit_services(overwrite=args.overwrite)

    # other things to do:
    # 1) ensure ~/.local/share/gnupg exists
    # 3) install the DinaRemasterII
    #   https://github.com/zshoals/Dina-Font-TTF-Remastered/tree/master to
    #   /usr/share/fonts (on linux) unsure where for MacOS
    # 4) symlink ~/.gnupg to ~/.local/share/gnupg (and maybe also include the conf files in this repo?)


if __name__ == "__main__":
    main()

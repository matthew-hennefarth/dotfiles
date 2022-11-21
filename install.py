#!/usr/bin/env python

import os, sys, shutil
import argparse
import logging
import shutil

LOGGER = logging.getLogger(__name__)

DOTFILE_DIR = os.path.dirname(__file__)

HOME = os.path.expanduser("~")
CONFIG = os.path.join(HOME, ".config")

def init_logger():
    LOGGER.debug("Changing logger format")
    format = "%(message)s"
    logging.basicConfig(format=format)
    LOGGER.setLevel(logging.WARNING)
    LOGGER.debug("Set logger level to WARNING")


def generate_symlinks_for(src, dst, dot_prefix=False, overwrite=False):
    LOGGER.info(f"Installing to {dst}")
    
    configs = [f for f in os.listdir(src) if f != ".DS_Store"]
    for config in configs:
        target = os.path.join(dst, f"{'.' if dot_prefix else ''}{config}")
        config = os.path.join(src, config)

        if os.path.exists(target):
            log_string = f"{target} already exists..."
            if overwrite:
                LOGGER.info(f"{log_string} Overwriting")
                if os.path.isdir(target) and not os.path.islink(target):
                    LOGGER.info("PURE DIRECTORY!!")
                    shutil.rmtree(target)

                else:
                    os.remove(target)

            else:
                LOGGER.info(f"{log_string} Skipping")
                continue

        LOGGER.info(f"Creating symlink {config} --> {target}")
        os.symlink(config, target)


def configure_symlinks(overwrite=False):
    LOGGER.info("Creating symlinks")

    home_dot_dir = os.path.join(DOTFILE_DIR, "home")
    config_dot_dir = os.path.join(DOTFILE_DIR, "config")
    
    generate_symlinks_for(home_dot_dir, HOME, dot_prefix=True, overwrite=overwrite)
    generate_symlinks_for(config_dot_dir, CONFIG, overwrite=overwrite)


def configure_homebrew():
    LOGGER.error("HOMEBREW SETUP NOT IMPLEMENTED!")


def configure_pkgmanager():
    if sys.platform == "darwin":
        configure_homebrew()
    
    else:
        LOGGER.error(f"Unknown package manager for {sys.platform}")


def configure_nvim():
    LOGGER.error("NVIM CONFIGURATION NOT IMPLEMENTED!")


def main():
    init_logger()

    parser = argparse.ArgumentParser(
        prog = "install.py",
        description = "Installs config files, system pacakges, and setup nvim",
        epilog = "Currently only for MacOS, though I will work on porting to Linux over time...")

    parser.add_argument("-v", "--verbose", action="store_true")
    parser.add_argument("-o", "--overwrite", action="store_true", help="Overwrite existing symlinks and files for config files")

    LOGGER.debug("Parsing command line arguments")
    args = parser.parse_args()

    if args.verbose:
        LOGGER.setLevel(logging.INFO)
        LOGGER.debug("Setting logger level to INFO")
        LOGGER.setLevel(logging.DEBUG)
        LOGGER.debug("Setting logger level to DEBUG")
    
    configure_symlinks(overwrite=args.overwrite)
    configure_pkgmanager()
    configure_nvim()


if __name__ == "__main__":
    main()


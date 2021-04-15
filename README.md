# arch-scripts

Backups of shell scripts used to manage personal Arch Linux
installation(s).

* `scripts/aur-checkupdates`: Check availability of updates for any installed
foreign (AUR) packages. Runs without root.
* `scripts/aur-update`: Update a single package. A wrapper script for
running `git` and `makepkg` commands.
* `scripts/checkupdates-notify-send`: Check available pacman package updates script and send a notification if updates are available.

## Dependencies

* `jq`
* `pacman-contrib`
* `libnotify`
* `git`
* `curl`

## Installing

Run `make install`. This sets up the scripts to `$HOME/.local/bin` directory.
Alternatively, contents of `scripts/` can be moved to a location of your choice.

### Used Environment Variables

* `AUR_PACKAGES_PATH` (required): Location of cloned AUR package git repositories.
* `PATH`: Path where scripts are located in. Defaults to `$PATH:$HOME/.local/bin`.

## Usage

### aur-checkupdates

```bash
$ aur-checkupdates
spotify 1:1.1.55.498-2 -> 1:1.1.56.595-1
...
```

Script can be used e.g. together with `notify-send` command to send you notifications
on your desktop in case updates are available. For instance, you could schedule following
to your `cron`:

```bash
aur-checkupdates > /dev/null; \
    if [[ $? = 0 ]]; \
        then notify-send "aur-checkupdates" "Updates available for AUR package(s)"; \
    fi
```

### aur-update

Run the script with the package name to update. Supports also passing few
additional command line parameters to `makepkg`.

```bash
$ aur-update -ri spotify
```

### checkupdates-notify-send

Running the script runs `checkupdates` script, and in case
updates are available, it simply sends a desktop notification
using [`notify-send`](https://wiki.archlinux.org/index.php/Desktop_notifications#Bash).

#### Scheduling Using systemd

```
~/.config/systemd/user/checkupdates-notify.service
---
[Unit]
Description=Check and notify on available package updates

[Service]
Type=simple
ExecStart=%h/.local/bin/checkupdates-notify-send
```


```
~/.config/systemd/user/checkupdates-notify.timer
---
[Unit]
Description=Run checkupdates-notify service once per x hours

[Timer]
# Run 5 minutes after booting up
OnBootSec=5min
OnUnitActiveSec=<hours>h
Unit=checkupdates-notify.service

[Install]
WantedBy=timers.target
```

After this, enable service by running

```bash
systemctl enable --user checkupdates-notify.timer
systemctl start --user checkupdates-notify.timer
```

## Known Limitations

* `aur-checkupdates` unfortunately makes no distinction between AUR and non-AUR packages.
It works only for AUR packages but still checks all foreign packages from AUR API.
* `aur-update` only supports `-risc` options (for now). Might change if
more are needed or change so that all extra opts are passed to `makepkg`.

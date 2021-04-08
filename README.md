# arch-scripts

Backups of shell scripts used to manage personal Arch Linux
installation(s).

* `scripts/aur-checkupdates`: Check availability of updates for any installed
foreign (AUR) packages. Runs without root.

## Dependencies

* `jq`

## Installing

Run `make install`. This sets up the scripts to `$HOME/.local/bin` directory.
Alternatively, contents of `scripts/` can be moved to a location of your choice.

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

## Known Limitations

* `aur-checkupdates` unfortunately makes no distinction between AUR and non-AUR packages.
It works only for AUR packages but still checks all foreign packages from AUR API.

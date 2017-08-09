# tmux-loadavg

Display load average in [`tmux`](https://tmux.github.io/) status bar.

Supports:

- macOS
- Linux
- FreeBSD

## Installing

### Via TPM (recommended)

The easiest way to install `tmux-loadavg` is via the [Tmux Plugin
Manager](https://github.com/tmux-plugins/tpm).

1. Add plugin to the list of TPM plugins in `.tmux.conf`:

    ``` tmux
    set -g @plugin 'jamesoff/tmux-loadavg'
    ```

2. Use <kbd>prefix</kbd>–<kbd>I</kbd> to install `tmux-loadavg`.

3. When you want to update `tmux-loadavg` use <kbd>prefix</kbd>–<kbd>U</kbd>.

### Manual Installation

1. Clone the repository

    ``` sh
    $ git clone https://github.com/jamesoff/tmux-loadavg ~/clone/path
    ```

2. Add this line to the bottom of `.tmux.conf`

    ``` tmux
    run-shell ~/clone/path/tmux-loadavg.tmux
    ```

3. Reload the `tmux` environment

    ``` sh
    # type this inside tmux
    $ tmux source-file ~/.tmux.conf
    ```

## Use

Edit your `status-left` or `status-right` setting to include one of:

- `#{load_short}` - display the 1min load average
- `#{load_full}` - display the 1min, 5min and 15min load averages

The values are coloured green, orange or red depending on how they compare to
the number of CPUs you have.

For example in `.tmux.conf`:

```
# display 1min load average and hostname on right of status bar
set -g status-right " #{load_short} #h"
```

Reload your configuration for it to take effect: <kbd>prefix</kbd>-<kbd>R</kbd> with TPM, or

``` sh
$ tmux source-file ~/.tmux.conf
```


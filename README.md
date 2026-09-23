# CD4AI — Monograph

English MAC0499 capstone monograph at IME/USP, using the IME LaTeX template
in undergraduate (`tcc`) mode. The Portuguese resumo is in a separate file.
The current text is a writing scaffold, not a completed thesis.

## Start writing

From this directory:

```sh
./write
```

This creates or reuses the `monografia` tmux session, with a `thesis` window
running Neovim and a `shell` window in the project directory. New sessions start
continuous compilation and open Zathura automatically. It also works
from inside an existing tmux session. To write without tmux, use `nvim main.tex`.

In Normal mode, **Space l l** toggles continuous compilation; use it to start
when opening Neovim directly, or to restart a stopped compiler in a reused
session. Zathura opens the PDF after a successful build. Keep it beside Alacritty;
saving any included chapter rebuilds the PDF.

The watcher checks saved files every 200 ms (`$sleep_time` in `.latexmkrc`).
Rendering still takes time: on the initial scaffold, save-to-completed-PDF tests
took about 2.7 seconds, down from about 4.3 seconds with the default polling delay.
Updates happen on save, not on every keystroke. Restart compilation after changing
`.latexmkrc` so the running watcher picks up the new settings.

For a split writing workspace on GNOME, focus Alacritty and press **Super+Left**,
then focus Zathura and press **Super+Right** (Super is usually the Windows key).
These are two tiled desktop windows: Zathura is a graphical PDF viewer and
does not run inside a tmux pane.

| Action | Shortcut |
| --- | --- |
| Save | `:w` |
| Start/stop compilation | `Space l l` |
| Jump from source to PDF | `Space l v` |
| Jump from PDF to source | Ctrl + left-click in Zathura opened by VimTeX |
| Show compilation errors | `Space l e` |
| Table of contents / chapter navigation | `Space l t` |
| VimTeX diagnostic information | `Space l i` |
| Citation/label completion | Type `\cite{` or `\ref{`, then `Ctrl-Space` |
| Native VimTeX completion | `Ctrl-x Ctrl-o` in Insert mode |
| Next / previous completion | `Ctrl-n` / `Ctrl-p` |
| Accept completion | Enter |
| Expand snippet / next field | `Ctrl-j` in Insert or Select mode |
| Previous snippet field | `Ctrl-k` in Insert or Select mode |
| Next misspelling / suggestions | `]s` / `z=` |
| Add word to personal dictionary | `zg` |

Snippet triggers: `sec`, `cite`, `ref`, `fig`, and `itemize`.
English spelling is enabled in `.tex` files; a file named `resumo.tex` uses
Brazilian Portuguese. Change the current buffer with `:setlocal spelllang=en_us`
or `:setlocal spelllang=pt_br`. Soft wrapping does not insert newlines into prose.

PDF-to-source navigation also selects the editor's tmux window and pane.
On Wayland, the desktop may leave keyboard focus in the PDF window; switch
back to Alacritty if needed.

## Tmux workflow

Your current tmux prefix is **Ctrl-a**. Press and release it before the next key.

| Action | Keys |
| --- | --- |
| Choose thesis/shell window | `Ctrl-a w` |
| Return to previous window | `Ctrl-a Tab` |
| Split with a shell below | `Ctrl-a -` |
| Split with a shell beside the editor | `Ctrl-a _` |
| Move between editor splits and tmux panes | `Ctrl-h/j/k/l` in Normal mode |
| Detach, keeping editor and compilation running | `Ctrl-a d` |
| Resume | Run `./write` again |

Your existing vim-tmux-navigator bindings are retained. In Insert mode,
`Ctrl-j` and `Ctrl-k` move through snippet fields. Zathura remains a separate
desktop window; tmux does not render the PDF. Detached sessions survive terminal
closure, but not a reboot. Save your text before detaching.

## Build without Neovim

```sh
make          # or: latexmk
make watch    # continuous build; Ctrl-C stops it
make clean    # remove intermediate files, keeping the PDF
```

The output is `build/main.pdf`. `.latexmkrc` configures pdfLaTeX, SyncTeX,
the output directory, and automatic bibliography processing with Biber.
Run these commands from the project root. Avoid running `make watch` and
VimTeX compilation simultaneously for the same document.

## Files to edit

- `metadata.tex`: title, author, advisors, keywords, and draft date.
- `chapters/*.tex`: chapter text; their root directives let VimTeX compile the
  whole thesis even when you open a chapter directly.
- `frontmatter/abstract.tex` and `frontmatter/resumo.tex`: bilingual abstracts.
- `references.bib`: bibliography copied from the existing work plan.
- `figures/`: figures and their editable source files.
- `main.tex`: chapter order and front/back matter.

The date is a draft placeholder. Confirm the final title, advisor designations,
submission date, cataloging information, and publication license before submission.
The starter chapter outline is editable. Comments point to existing material in
`../plano-de-trabalho`, `../miniplop`, and `../tcc-docs`; these sibling directories
are not required to build the monograph.

The root `.sty`, `.bbx`, `.cbx`, and `.dbx` files belong to the template.
Its original guide is `docs/ime-template-guide.pdf`; attribution, version,
and license information are in `docs/template-source.md`.

## Machine setup

On this Fedora machine, the system-package installer is:

```sh
bash setup/install-system.sh
```

It uses Fedora's repositories only and requires your sudo password.
The editor additions are stored under `setup/nvim/`. `python3 setup/install-editor.py`
installs them into the existing `jppaulo` Neovim configuration, backing up the
complete configuration first. Then `nvim --headless '+Lazy! install' +qa` installs
missing plugins. This installer is specific to this machine's configuration.

VimTeX is pinned to v2.17 for Neovim 0.10.4. Keep the Neovim `lazy-lock.json`
under backup/version control; `:Lazy restore` restores its recorded plugin versions.

For bibliography management, Zotero + Better BibTeX can be added later.
Until then, edit `references.bib` directly. If switching to automatic export,
import the existing references first, retain their citation keys, and use
Better BibLaTeX export; avoid hand-editing a file managed by automatic export.

## Version history

Git ignores the build directory. Commit the chapter sources, bibliography,
figures, build configuration, and template files as the text develops.
No remote repository or publication is configured.

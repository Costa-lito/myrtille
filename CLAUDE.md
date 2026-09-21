# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project overview

Myrtille is a LaTeX class library, not an application: `myrtille.cls` (a general-purpose document class), `myrtillecv.cls` (a derived CV class), and `myrtillebook.cls` (a derived twoside `book` class for long-form documents), all themeable. There is no interpreter/build system beyond LaTeX itself — no test suite, linter, or package manager. `Exemples/source/*.tex` holds demo/example documents that double as the de facto documentation and regression check (if they don't compile, something is broken).

None of the three classes load `babel` — don't use babel shorthands like `\og`/`\fg` for French guillemets (undefined control sequence), use literal `«`/`»` characters instead, consistent with existing examples.

## Compiling documents

Compilation is routed through `.latexmkrc` at the repo root, which is required (see "Root-detection gotcha" below) — don't invoke `pdflatex`/`latexmk` directly without `-r`.

```bash
latexmk -r .latexmkrc -synctex=1 -interaction=nonstopmode -file-line-error -pdf Exemples/source/<file>.tex
```

Output is split: the final PDF + `.synctex.gz` land in `Exemples/`, all other auxiliary files (`.aux`, `.log`, `.toc`, `.out`, `.fls`, `.fdb_latexmk`, `.listing`) land in `Exemples/source/build/`. This works for any `.tex` file placed in `Exemples/source/`, regardless of name.

In VS Code, the LaTeX Workshop extension is preconfigured via `.vscode/settings.json` (a custom `latexmk` tool/recipe passing `-r %WORKSPACE_FOLDER%/.latexmkrc`) — the green-arrow build button just works, no per-user setup needed. That file must stay a flat JSON object (top-level `latex-workshop.*` keys), not a `{"folders": [...], "settings": {...}}` workspace-style wrapper — LaTeX Workshop silently ignores settings nested under a `"settings"` key.

## Architecture

### `myrtille.cls` — single unified class, theme selected at load time

One file (~900 lines, numbered sections e.g. `% 6. PALETTE DE COULEURS`, `% 20. ENCADRÉS D'IMAGES`, `% 21. PAGE DE GARDE`), not one class per theme. Theme is chosen via a `kvoptions` key:

```latex
\documentclass[theme=pringlea]{myrtille}
```

Valid themes: `myrtille` (default, alias `blue`), `pringlea` (alias `green`), `acerola` (alias `red`), `betula` (alias `bw`/`noir`/`print`/`grayscale`). Internally this is a chain of `\ifdefstring{\myrtille@theme}{<name>}{...}{...}` blocks, each defining the same ~20 color names (`accent`, `accentDark`, `accentPale`, `dark`, `coverBg`, `mid`, `light`, `border`, `tableHdr`, `sidebarBg`, plus `code*` and semantic colors like `success`/`warn`/`infoGreen`). Adding a theme means duplicating one of these blocks with new hex values and, if desired, adding a short alias to the normalization block just above it — there's no external palette file or generator script.

The cover page (`\makecover` / `\makecoversimple`) background is pure TikZ drawn at compile time — no external image asset involved.

### `myrtillecv.cls` — independent theme system, not derived from `myrtille.cls`

This is a separate class, not sourced from or synced with `myrtille.cls`. Its own `\ifdefstring{\myrtillecvr@theme}{...}` palette chain defines only 5 colors (`accent`, `accentDark`, `dark`, `mid`, `border`) and only supports 3 themes — `myrtille`, `pringlea`, `acerola` (**no `betula`**). When changing a theme's colors, check whether the change should apply to CVs too — it must be edited separately in this file, nothing is shared between the two classes.

### `myrtillebook.cls` — independent theme system, derived from `book` not `article`

Same duplication approach as `myrtillecv.cls` (a fully separate, self-contained file, not sourced from `myrtille.cls`) but, unlike `myrtillecv.cls`, it duplicates the **full** ~20-color palette and supports all 4 themes including `betula`. Its own kvoptions family/prefix is `myrtillebk`/`myrtillebk@` (not `myrtille@`) and its palette-override command is `\setmyrtillebookpalette`. When a color changes in `myrtille.cls`, mirror it here too if it should apply to books — same caveat as for the CV class.

Structural differences from `myrtille.cls` worth knowing before touching this file:
- Loaded as `\LoadClass[a4paper,10pt,twoside,openright]{book}` — every `\chapter` starts on an odd (recto) page; `book.cls` inserts a blank page automatically when needed.
- `emptypage` is required and loaded in section 8: without it, those auto-inserted blank pages keep rendering the running header/footer (a well-known plain-LaTeX `\cleardoublepage` gotcha) instead of being visually blank.
- Headers alternate by page parity via `fancyhdr`'s `E`/`O` selectors: outer corner (`[LE]`/`[RO]`) shows page number + running mark (chapter on even pages, section on odd), inner corner (`[RE]`/`[LO]`) shows the fixed `\headerleft` text. Geometry uses mirrored `inner`/`outer` margins instead of `left`/`right`.
- `myrthm`/`myrdef` (and figures, natively via `book.cls`) are numbered *within chapter* (e.g. "Théorème 3.2"), not within section like in `myrtille.cls` — intentional, matches book conventions.
- `\frontmatter`/`\mainmatter`/`\backmatter` are the stock `book.cls` ones (roman → arabic pagination, chapter numbering reset) — not reimplemented here.

### `.latexmkrc` — root-detection gotcha

Do not "simplify" this to `dirname(__FILE__)` or `dirname(abs_path(__FILE__))` — both are broken here, and it's not obvious why: `latexmk` loads files passed via `-r` by reading their contents and running `eval $code`, not via Perl's `do`/`require`. `__FILE__` therefore never reflects the `.latexmkrc` path (it evaluates to something like `(eval N)`), and `dirname(__FILE__)` silently collapses to the current working directory at runtime — which differs depending on whether latexmk was launched from the repo root or from `Exemples/source/` (the latter is what LaTeX Workshop does). The rc file instead finds the project root by walking up from `getcwd()` until it finds `myrtille.cls`; this is intentional and covered in comments in the file itself.

### `Exemples/source/*.tex` — demos and real-world usage examples

- `betula.tex`, `pringlea.tex`, `acerola.tex`, `myrtille.tex` — one full component-catalogue demo per theme (badges, code blocks, math boxes, image environments, etc.). These are the closest thing to a manual for the class.
- `cours_pringlea.tex` — realistic lecture-notes document using `myrtille.cls`.
- `cv_pringlea.tex` — realistic CV using `myrtillecv.cls`.
- `livre_pringlea.tex` — realistic book using `myrtillebook.cls` (frontmatter/mainmatter/backmatter, multiple chapters, a long filler chapter to exercise pagination over many pages).
- Images live in `Exemples/source/pictures/` and must be referenced with the `pictures/` prefix (e.g. `pictures/acerola.jpg`) — bare filenames fail to compile since the class does not add that directory to the image search path.
- `Exemples/*.pdf` are intentionally version-controlled (kept as rendered previews so the repo is browsable without recompiling); `Exemples/*.synctex.gz` and `Exemples/source/build/` are build artifacts and are gitignored.

## Licensing notes

Code (`.cls`/`.tex`) is MIT. Each theme's demo image has its own, different license (credited in that demo's "Licences et Crédits" section and in `README.md`) — notably `birch.jpg` (used by `betula.tex`) is CC-BY-NC-SA, which is why `betula.pdf` itself is distributed under a NonCommercial license unlike the other examples. Keep author credits intact when touching these sections.

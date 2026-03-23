# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build Commands

```bash
# Compile (requires -shell-escape for minted/Pygments code highlighting)
pdflatex -shell-escape -interaction=nonstopmode main.tex

# Using Makefile
make          # Build main.pdf (runs pdflatex twice for cross-refs)
make clean    # Remove PDF + auxiliary files
make watch    # Live preview with latexmk
```

**Prerequisites**: pdflatex, Pygments (`pip3 install Pygments`), Roboto font package (`roboto.sty`).

## Architecture

**Entry point**: `main.tex` — loads `style/cheatsheet` package, sets metadata, wraps content in `multicols*{5}` (5-column landscape A4).

**Style layer** (`style/`):
- `cheatsheet.sty` — core layout, typography (5.5pt base), all custom commands, tcolorbox definitions, algorithm2e config, minted config. This is the main file to edit for layout/command changes.
- `colors.sty` — Nord Frost color palette. All colors defined here: `heading`, `primary`, `secondary`, `accent`, `codeBg`, etc. Swap this file to re-theme.
- `minted.sty` — thin wrapper for Pygments code highlighting setup.

**Content** (`sections/`): modular `.tex` files using commands from cheatsheet.sty. Currently three example sections (math, algorithms, ML). Add new sections by creating a file and adding `\input{sections/filename}` in main.tex.

## Key Custom Commands

| Command | Usage | Purpose |
|---------|-------|---------|
| `\formula{Name}{$eq$}` | `\formula{Bayes}{$P(A|B)=...$}` | Label + right-aligned equation |
| `\algo{Name}{O(...)}{desc}` | `\algo{BFS}{$O(V+E)$}{Queue-based}` | Algorithm entry with complexity badge |
| `\defn{term}{meaning}` | `\defn{BST}{Balanced tree}` | Inline definition |
| `\bigO{expr}` | `\bigO{n \log n}` | Colored complexity badge |
| `\comptable{spec}{rows}` | `\comptable{@{}lX@{}}{A & B \\}` | Compact tabularx wrapper |

**Environments**: `defbox[title]`, `thmbox[title]`, `notebox[title]`, `warnbox[title]`, `successbox[title]`, `infobox[title]`, `algobox[title]` — left-bordered boxes derived from a shared `accentbox` base style. `deflist` — compact description list for key-value definitions.

## Color Hierarchy

Headers use `heading` (Nord Blue #5E81AC), subsections use `secondary` (#4C566A), formula/algo labels use `primary` (#2E3440), complexity badges use `accent` (Aurora Red #BF616A). Maintain this 3-level visual hierarchy when modifying colors.

## Constraints

- Everything must fit on 1 landscape A4 page in 5 narrow columns.
- No `\toprule`/`\midrule`/`\bottomrule` in tables — booktabs is not loaded; they add too much vertical space.
- `\thinrule` has been removed — `\section` headings provide enough separation.
- Column separator rules are disabled (`\columnseprule=0pt`).
- Content flows vertically within columns via `multicols*` — avoid large non-breakable blocks that force content to overflow to page 2.

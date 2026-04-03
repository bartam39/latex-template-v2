# CLAUDE.md — Cheatsheet Template Reference

This file is the complete reference for building cheatsheets with this LaTeX template. An AI agent can use this file alone — without reading the `.sty` sources — to produce a fully styled, single-page cheatsheet.

---

## Build Commands

```bash
# Compile (requires -shell-escape for Pygments code highlighting)
pdflatex -shell-escape -interaction=nonstopmode main.tex

# Using Makefile
make          # Build main.pdf (runs pdflatex twice for cross-refs)
make clean    # Remove PDF + auxiliary files
make watch    # Live preview with latexmk
```

**Prerequisites**: pdflatex, Pygments (`pip3 install Pygments`), Roboto font package (`roboto.sty`).

---

## Architecture

```
main.tex              ← Entry point: metadata + \input{sections/...}
style/
  cheatsheet.sty      ← Core layout, typography, all custom commands
  colors.sty          ← Nord color palette (swap to re-theme)
  minted.sty          ← Pygments code highlighting wrapper
sections/
  example-math.tex    ← Example: math formulas
  example-algorithms.tex ← Example: algo complexity + pseudocode
  example-ml.tex      ← Example: ML/AI reference
```

**Adding a new section**: create `sections/my-topic.tex`, then add `\input{sections/my-topic}` inside the `multicols*` block in `main.tex`.

---

## Document Skeleton

Every cheatsheet follows this structure:

```latex
\documentclass[10pt]{article}
\usepackage{style/cheatsheet}

\title{My Cheat Sheet Title}
\author{Author Name}
\date{\today}

\begin{document}
\begin{multicols*}{5}

\input{sections/topic-one}
\input{sections/topic-two}

\end{multicols*}
\end{document}
```

The header automatically displays: title (left) and author | date (right).

---

## Heading Hierarchy

Three levels of headings, each with its own visual style:

### Section (H1) — tinted blue strip

```latex
\section{Linear Algebra}
```

Full-width light blue background strip (`heading!12`) with bold blue text. Use for major topic divisions.

### Subsection (H2) — tinted grey strip

```latex
\subsection{Vector Operations}
```

Full-width lighter grey background strip (`secondary!8`) with bold grey text. Use for sub-topics within a section.

### Subsubsection (H3) — bold italic

```latex
\subsubsection{Properties}
```

Bold italic text, no background decoration. Use sparingly for fine-grained grouping.

---

## Custom Commands — Core

### `\formula{Name}{$equation$}`

Label on the left, equation on the right, connected by dotted leaders.

```latex
\formula{Bayes' Theorem}{$P(A|B) = \frac{P(B|A)\,P(A)}{P(B)}$}
\formula{Chain Rule}{$\frac{d}{dx}f(g(x)) = f'(g(x))\,g'(x)$}
\formula{Gradient}{$\nabla f = \left(\pd{f}{x_1}, \ldots, \pd{f}{x_n}\right)$}
```

### `\algo{Name}{Complexity}{Description}`

Algorithm entry with name, a rounded complexity badge (accent color), and a one-line description. Entries are separated by thin horizontal rules.

```latex
\algo{Merge Sort}{$O(n \log n)$}{Stable, divide\&conquer. Space $O(n)$.}
\algo{Quick Sort}{$O(n \log n)$ avg}{In-place, unstable. Worst $O(n^2)$.}
\algo{Dijkstra}{$O((V{+}E) \log V)$}{Shortest path, no negative weights.}
```

### `\defn{term}{meaning}`

Inline definition — bold term followed by meaning text.

```latex
\defn{BST}{Binary search tree: left $<$ root $<$ right.}
\defn{Epoch}{One full pass through the training dataset.}
```

### `\code{text}`

Inline monospace code in blue (`codeKeyword` color).

```latex
Use \code{np.linalg.svd()} for SVD decomposition.
```

### `\kv{key}{value}`

Key-value pair with bold key.

```latex
\kv{Time}{$O(n \log n)$}
\kv{Space}{$O(n)$}
```

### `\bigO{expression}`

Rounded complexity badge pill in accent color.

```latex
This runs in \bigO{n \log n} time and \bigO{n} space.
```

### `\vs{A}{B}`

Quick comparison label.

```latex
\vs{BFS}{DFS} — BFS uses queue, DFS uses stack.
```

### `\step{number}{text}`

Numbered step for procedures.

```latex
\step{1}{Initialize weights randomly}
\step{2}{Forward pass: compute predictions}
\step{3}{Backward pass: compute gradients}
```

### `\labeledsep{text}`

Horizontal divider with a small italic label centered below it.

```latex
\labeledsep{continued}
```

---

## Custom Commands — Tables

### `\comptable{col-spec}{rows}`

Compact table with alternating row shading. Uses `tabularx` for auto-width columns.

```latex
\comptable{@{}lX@{}}{
  $f(x)$ & $f'(x)$ \\
  $x^n$ & $nx^{n-1}$ \\
  $e^x$ & $e^x$ \\
  $\ln x$ & $1/x$ \\
  $\sin x$ & $\cos x$ \\
}
```

**Column spec patterns**:
- `@{}lX@{}` — left-aligned label + auto-fill column (most common)
- `@{}llll@{}` — four fixed left-aligned columns
- `@{}lXX@{}` — label + two auto-fill columns

**Important**: Do NOT use `\toprule`, `\midrule`, `\bottomrule` — the `booktabs` package is not loaded (too much vertical space). Use plain `\\` row separators.

### `\minitable{rows}`

Compact 2-column mini-table (fixed `@{}lX@{}`).

```latex
\minitable{
  Stable & Merge, Insertion, Counting \\
  Unstable & Quick, Heap \\
  In-place & Quick, Heap, Insertion \\
}
```

---

## Custom Commands — Tags & Badges

### `\tagc{color}{text}`

TikZ-rendered colored tag with rounded corners and light background tint.

```latex
\tagc{success}{Stable} \tagc{accent}{$O(n^2)$} \tagc{info}{GPU}
```

### `\tagprimary{text}`, `\tagsecondary{text}`, `\tagaccent{text}`

Pre-colored tag shortcuts using `\hlbox`.

```latex
\tagprimary{Required} \tagsecondary{Optional} \tagaccent{Deprecated}
```

### `\hlbox[color]{text}`

Inline highlight box with rounded border. Defaults to `primary`.

```latex
\hlbox{important} \hlbox[accent]{warning} \hlbox[success]{done}
```

---

## Environments — Accent Boxes

All accent boxes have: 2pt colored left border, faint tinted background (4% of accent color), rounded corners (1.5pt), and an optional bold title in the accent color.

### `defbox` — Definition (primary / dark blue)

```latex
\begin{defbox}[Eigenvalue Equation]
$A\mathbf{v} = \lambda\mathbf{v}$, \; $\det(A - \lambda I) = 0$
\end{defbox}
```

### `thmbox` — Theorem (secondary / grey)

```latex
\begin{thmbox}[Bias-Variance Decomposition]
$\E[\text{Err}] = \text{Bias}^2 + \text{Var} + \text{Noise}$

High bias $\to$ underfit. High var $\to$ overfit.
\end{thmbox}
```

### `notebox` — Note (accent / red)

```latex
\begin{notebox}[Learning Rate]
High $\to$ diverge. Low $\to$ slow.
Schedulers: step, cosine, warmup.
\end{notebox}
```

### `warnbox` — Warning (warning / yellow)

```latex
\begin{warnbox}[Memory]
Recursive solutions may cause stack overflow for large inputs.
\end{warnbox}
```

### `successbox` — Success (success / green)

```latex
\begin{successbox}[Tip]
Use batch normalization to stabilize training.
\end{successbox}
```

### `infobox` — Info (info / blue)

```latex
\begin{infobox}[Note]
Transformers have $O(n^2)$ attention complexity.
\end{infobox}
```

### `algobox` — Algorithm/Code (codeBg / grey border)

Specialized box for pseudocode and code blocks. Uses `codeBg` background.

```latex
\begin{algobox}[Merge Sort]
{\tiny\SetAlgoNoLine
\SetKwFunction{FMerge}{MSort}
\KwIn{$A$, $lo$, $hi$}
\If{$lo < hi$}{
  $mid \gets \lfloor(lo{+}hi)/2\rfloor$\;
  \FMerge{$A, lo, mid$}\;
  \FMerge{$A, mid{+}1, hi$}\;
  Merge($A, lo, mid, hi$)\;
}}
\end{algobox}
```

---

## Environments — Lists

### `deflist` — Definition List

Compact key-value description list with bold primary-colored labels.

```latex
\begin{deflist}
  \item[Transpose] $(AB)^T = B^T A^T$
  \item[Inverse] $(AB)^{-1} = B^{-1}A^{-1}$
  \item[Trace] $\tr(ABC) = \tr(CAB)$
  \item[Det] $\det(AB) = \det(A)\det(B)$
\end{deflist}
```

### Standard `itemize` and `enumerate`

Pre-configured for ultra-compact spacing.

```latex
\begin{itemize}
  \item First point with colored bullet
  \item Second point
  \begin{itemize}
    \item Nested with en-dash marker
  \end{itemize}
\end{itemize}

\begin{enumerate}
  \item Numbered step one
  \item Numbered step two
\end{enumerate}
```

---

## Code Blocks

### Inline minted block

```latex
\begin{minted}{python}
def merge_sort(arr):
    if len(arr) <= 1:
        return arr
    mid = len(arr) // 2
    return merge(merge_sort(arr[:mid]),
                 merge_sort(arr[mid:]))
\end{minted}
```

### `\codeblock{language}{code}`

Shortcut wrapper with consistent spacing.

```latex
\codeblock{python}{
def relu(x):
    return max(0, x)
}
```

**Supported languages**: `python`, `java`, `c`, `cpp`, `javascript`, `sql`, `bash`, `latex`, and any language Pygments supports.

**Minted configuration**: `\tiny` font, line breaking enabled, `codeBg` background, left-line frame in `codeBorder` color.

---

## Math Shortcuts

### Operators

| Command | Renders | Command | Renders |
|---------|---------|---------|---------|
| `\argmin` | arg min | `\argmax` | arg max |
| `\sign` | sign | `\softmax` | softmax |
| `\relu` | ReLU | `\sigmoid` | sigmoid |
| `\diag` | diag | `\rank` | rank |
| `\tr` | tr | | |

### Number Sets

| Command | Renders | Command | Renders |
|---------|---------|---------|---------|
| `\R` | R (reals) | `\N` | N (naturals) |
| `\Z` | Z (integers) | `\E` | E (expectation) |
| `\Prob` | P (probability) | | |

### Statistics

| Command | Renders |
|---------|---------|
| `\Var` | Var (variance) |
| `\Cov` | Cov (covariance) |
| `\KL` | KL (Kullback-Leibler) |

### Norms & Brackets

```latex
\norm{\mathbf{x}}        % ||x|| with auto-sizing
\abs{x}                   % |x| with auto-sizing
\inner{\mathbf{a}}{\mathbf{b}}  % <a, b>
```

### Calculus

```latex
\pd{f}{x}    % ∂f/∂x (partial derivative)
\dd{f}{x}    % df/dx (ordinary derivative)
```

### Matrix Helper

```latex
$\mat{a & b \\ c & d}$   % renders as a pmatrix
```

---

## Color Palette

### Primary Colors

| Name | Hex | Usage |
|------|-----|-------|
| `primary` | #2E3440 | Body text, formula/algo labels, definition terms |
| `primaryLight` | #3B4252 | URL links |
| `primaryDark` | #242933 | Deeper contrast (rarely used) |
| `heading` | #5E81AC | Section headers (H1), top accent bar, info boxes |
| `secondary` | #4C566A | Subsection headers (H2), theorem boxes, algo borders |
| `secondaryLight` | #616E88 | Code comments |
| `accent` | #BF616A | Complexity badges, note boxes, warnings |
| `accentLight` | #D08770 | Aurora Orange (available for custom use) |

### Semantic Colors

| Name | Hex | Usage |
|------|-----|-------|
| `success` | #A3BE8C | Success boxes, positive tags |
| `warning` | #EBCB8B | Warning boxes |
| `info` | (= heading) | Info boxes |

### UI Colors

| Name | Hex | Usage |
|------|-----|-------|
| `divider` | #D8DEE9 | Horizontal rules, column separators, formula leaders |
| `surface` | #ECEFF4 | Box backgrounds (base) |
| `background` | #FFFFFF | Page background |
| `codeBg` | #E5E9F0 | Code block background |
| `codeBorder` | #D8DEE9 | Code frame border |
| `rowShade` | heading!5 | Alternating table row tint |

### Code Highlighting

| Name | Hex | Usage |
|------|-----|-------|
| `codeKeyword` | #5E81AC | Keywords, inline `\code{}` |
| `codeString` | #A3BE8C | String literals |
| `codeComment` | #616E88 | Comments |
| `codeNumber` | #B48EAD | Numbers |

---

## Full Section Example

This is a complete, realistic section file that an AI can use as a template:

```latex
% =============================================================================
% NETWORKING — TCP/IP, HTTP, DNS
% =============================================================================

\section{Networking}

\subsection{OSI Model}
\comptable{@{}lX@{}}{
  Layer & Protocol \\
  7 Application & HTTP, FTP, DNS \\
  4 Transport & TCP, UDP \\
  3 Network & IP, ICMP \\
  2 Data Link & Ethernet, Wi-Fi \\
  1 Physical & Cables, signals \\
}

\subsection{TCP vs UDP}
\begin{deflist}
  \item[TCP] Reliable, ordered, connection-oriented. 3-way handshake.
  \item[UDP] Unreliable, fast, connectionless. Streaming, DNS.
\end{deflist}

\subsection{HTTP Methods}
\algo{GET}{$O(1)$}{Retrieve resource. Idempotent, cacheable.}
\algo{POST}{$O(1)$}{Create resource. Not idempotent.}
\algo{PUT}{$O(1)$}{Replace resource. Idempotent.}
\algo{DELETE}{$O(1)$}{Remove resource. Idempotent.}

\subsection{DNS Resolution}
\begin{infobox}[Lookup Order]
Browser cache $\to$ OS cache $\to$ Resolver $\to$ Root $\to$ TLD $\to$ Authoritative
\end{infobox}

\formula{TTL}{Time-to-live in seconds for DNS cache entry}

\subsubsection{Record Types}
\begin{deflist}
  \item[A] IPv4 address
  \item[AAAA] IPv6 address
  \item[CNAME] Alias to another domain
  \item[MX] Mail exchange server
\end{deflist}

\subsection{TCP Handshake}
\step{1}{Client sends SYN}
\step{2}{Server responds SYN-ACK}
\step{3}{Client sends ACK}

\begin{notebox}[Connection Teardown]
4-way: FIN $\to$ ACK $\to$ FIN $\to$ ACK. TIME\_WAIT prevents stale packets.
\end{notebox}

\begin{minted}{python}
import socket
s = socket.socket(socket.AF_INET,
                  socket.SOCK_STREAM)
s.connect(("example.com", 80))
s.send(b"GET / HTTP/1.1\r\n\r\n")
\end{minted}
```

---

## Constraints & Rules

1. **Single page**: Everything must fit on 1 landscape A4 page in 5 narrow columns. If content overflows to page 2, remove or condense material.
2. **No booktabs**: `\toprule`, `\midrule`, `\bottomrule` are not available. They add too much vertical space.
3. **No `\columnbreak`**: Let `multicols*` flow content vertically. Forced breaks cause uneven columns.
4. **Avoid large blocks**: Boxes, tables, and code blocks that are too tall will not break across columns. Keep them short (5-8 lines max).
5. **Column separators**: Thin 0.15pt divider rules are enabled between columns.
6. **Top accent bar**: A 1.5pt colored strip appears at the top of the page automatically.
7. **Font sizes**: Base text is 5.5pt. Everything is tiny — do not add `\large` or `\Large` in content (headings handle their own sizing).
8. **Spacing**: All spacing is pre-configured to be ultra-compact. Do not add manual `\vspace` unless absolutely necessary.
9. **Math in narrow columns**: Use `{+}`, `{-}` for binary operators that should not break across lines (e.g., `$1{-}\sigma(x)$`).
10. **Escaping**: Remember to escape `&` as `\&` in text (not in tables where `&` is the column separator).

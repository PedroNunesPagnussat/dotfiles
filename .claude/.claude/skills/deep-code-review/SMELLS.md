# Smell pass

Easier To Change (ETC, *The Pragmatic Programmer*) governs this pass: code left harder to change is a finding even when no row below names it; the rows are the named ways that happens.

Weigh every smell below against every file in scope: one you cleared counts, one you never looked at doesn't.

Run the repo's configured linters and formatters first, in check mode (`--check`, `--dry-run`, `--no-fix`) so nothing gets rewritten; they own the mechanical violations. Then walk the baseline below for what tooling can't see.

When a smell recurs past the scope, sweep it: follow that one smell as far as it goes, stopping at the edge of its module or layer. One finding for the sweep, anchored at the worst site and naming the rest.

| Smell | Signal | Fix |
|---|---|---|
| **Duplicated Knowledge (DRY)** | one fact written down in more than one place: two functions, code and config, code and a comment. Look-alike code that encodes different facts belongs apart. | keep the fact in one authoritative place, derive the rest from it |
| **Needless Complexity (KISS)** | anything harder to read than the problem demands: a clever one-liner, deep nesting or a high branch count, a construct where a plainer one would do | simplify: unroll the one-liner, flatten with guard clauses or an extracted function, use the boring construct |
| **Shotgun Surgery** | one logical change forces scattered edits across many files | gather what changes together into one module |
| **Tight Coupling** | a module that breaks or shifts behaviour when a neighbour changes, without itself being edited: reaching into internals, shared mutable or global state, a unit you can't test without standing up the other (orthogonality, *The Pragmatic Programmer*) | sever the link: pass what's needed in, talk through one narrow interface, own state in one place |
| **Dead Code** | unreachable branches, unused params, leftover debug output | remove it |
| **Mysterious Name** | a name that doesn't reveal what it does or holds | rename it; if no honest name comes, the design's murky |
| **Comment as Deodorant** | a comment that narrates what the code does, or covers for a bad name or a long block (Fowler); the code is the documentation | make the code say it: rename, extract; keep only the comments that carry a business rule or a reason the code can't express |
| **Middle Man / Shallow Module** | a unit that mostly delegates onward, or whose interface is nearly as complex as what it hides (Ousterhout, *A Philosophy of Software Design*) | cut it and call the real target, or deepen it behind a simpler interface |
| **Data Clumps** | the same few fields or params keep travelling together | bundle them into one type, pass that |
| **Refused Bequest** | a subclass that ignores most of what it inherits | drop the inheritance, use composition |

For each finding: `file:line`, a one-sentence problem, and a concrete fix. Separate confirmed smells from lower-confidence suggestions: confirmed means the fix leaves the code easier to change, a suggestion is one where that's arguable.

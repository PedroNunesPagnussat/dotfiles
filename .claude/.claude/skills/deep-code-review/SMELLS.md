# Smell pass

Weigh every smell below against every file in scope: one you cleared counts, one you never looked at doesn't.

Run the repo's configured linters and formatters first, in check mode (`--check`, `--dry-run`, `--no-fix`) so nothing gets rewritten; they own the mechanical violations. Then walk the baseline below for what tooling can't see.

When a smell recurs past the scope, sweep it: follow that one smell as far as it goes, stopping at the edge of its module or layer. One finding for the sweep, anchored at the worst site and naming the rest.

- **Duplicated Code** — the same logic shape in more than one hunk or file. → extract the shared shape, call it from both.
- **Dead Code** — unreachable branches, unused params, leftover debug output. → remove it.
- **Mysterious Name** — a name that doesn't reveal what it does or holds. → rename it; if no honest name comes, the design's murky.
- **Shotgun Surgery** — one logical change forces scattered edits across many files. → gather what changes together into one module.
- **Data Clumps** — the same few fields or params keep travelling together. → bundle them into one type, pass that.
- **Speculative Generality** — abstraction or hooks added for needs the spec doesn't have. → delete it; inline back until a real need shows.
- **Divergent Change** — one module edited for several unrelated reasons. → split so each changes for one reason.
- **Repeated Switches** — the same switch/if-cascade on the same type recurs. → replace with polymorphism, or one shared map.
- **Feature Envy** — a method that reaches into another object's data more than its own. → move it onto the data it envies.
- **Primitive Obsession** — a primitive or string standing in for a domain concept. → give the concept its own small type.
- **Message Chains** — long a.b().c().d() navigation the caller shouldn't depend on. → hide the walk behind one method on the first object.
- **Middle Man / Shallow Module** — a unit that mostly delegates onward, or whose interface is nearly as complex as what it hides (Ousterhout, *A Philosophy of Software Design*). → cut it and call the real target, or deepen it behind a simpler interface.
- **Refused Bequest** — a subclass that ignores most of what it inherits. → drop the inheritance, use composition.

For each finding: `file:line`, a one-sentence problem, and a concrete fix. Separate confirmed smells from lower-confidence suggestions.

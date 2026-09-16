---
name: implementation-guidelines
description: Design rules for the code you write. Always use before writing or changing code.
---

- **Easier To Change** (ETC, *The Pragmatic Programmer*) comes first: of two designs that both work, take the one cheaper to change later.
- **Simple** (KISS) comes second: the plainest design that solves the problem in front of you. Boring constructs, flat control flow (guard clauses over nesting), generality only once a second real need shows (YAGNI). When the two pull apart, ETC wins.

The rules below serve those two:

- **DRY is about knowledge, not text**: each fact lives in one authoritative place and the rest derives from it. Look-alike code that encodes different facts stays apart.
- **Orthogonal modules**: each owns its state and talks to neighbours through one narrow interface, so it can be tested without standing the neighbour up.
- **Fail fast** (*The Pragmatic Programmer*, "Dead Programs Tell No Lies"): a state that can't happen raises where it's detected. A `try/except` sits only where the handler recovers, retries, or adds context before re-raising; everything else propagates. A crash does less damage than a run that continues on bad data.
- **The code is the documentation**: names say what a thing does or holds, and units are short enough to read whole. A comment carries only what code can't: a business rule, or the reason behind a choice.
- **Everything is replaceable**: existing code, including what you wrote a moment ago, is a draft. When it stops fitting the problem, rewrite it.
- **Ship only live code**: by the time you finish, every parameter is read, every branch reachable, debug output gone.

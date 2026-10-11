---
name: implementation-guidelines
description: Design rules for the code you write. Always use before writing or changing code.
---

- **Reduce complexity** (Ousterhout, *A Philosophy of Software Design*): complexity is whatever makes the system hard to understand and modify, summed across the whole system. Take the design that leaves fewer dependencies and less for a reader to hold in mind to make a change.
- **Keep it simple** (KISS): the plainest code that solves the problem in front of you. Boring constructs, flat control flow (guard clauses over nesting), generality only once a second real need shows (YAGNI).
- **Easy to change** (ETC, *The Pragmatic Programmer*): take the design cheaper to change later.

The rules below serve those priorities:

- **DRY is about knowledge, not text**: each fact lives in one authoritative place and the rest derives from it. Look-alike code that encodes different facts stays apart.
- **Deep, orthogonal modules**: each owns its state and hides a lot of work behind one narrow interface, so it can be tested without standing its neighbours up.
- **Fail fast** (*The Pragmatic Programmer*, "Dead Programs Tell No Lies"): a state that can't happen raises where it's detected. A `try/except` sits only where the handler recovers, retries, or adds context before re-raising; everything else propagates. A crash does less damage than a run that continues on bad data.
- **The code is the documentation**: names say what a thing does or holds, and units are short enough to read whole. A comment carries only what code can't: a business rule, or the reason behind a choice.
- **Everything is replaceable**: existing code, including what you wrote a moment ago, is a draft. When it stops fitting the problem, rewrite it.
- **Ship only live code**: by the time you finish, every parameter is read, every branch reachable, debug output gone.

# Correctness pass

Weigh every item below against every file in scope: an item you cleared counts, one you never looked at doesn't.

Check the function's contract first. An input its preconditions (types, asserts, validators, docstring) exclude is the caller's bug and stays out. A path inside the contract that returns without meeting the postcondition or invariant is a bug on its own, no caller evidence needed. Any other input-shape finding needs evidence the bad input occurs: a caller that produces it, a test that feeds it, or a stated requirement that permits it. Without that you invented the input, and the finding is speculative. Speculative findings stay out of the report. Security is the exception, kept to what is cheap to see: injection, unsanitized input reaching a sink, committed secrets.

Stay inside the scope and its blast radius. Walk each changed function end to end, asking what input or state makes it do the wrong thing.

- Logic errors: off-by-one, wrong operator, inverted condition
- Unhandled errors, nil/None/undefined, empty-collection and boundary cases
- Concurrency issues and resource leaks (unclosed files/connections)
- Broken, missing, or implementation-coupled tests for the behaviour in scope

For each finding: `file:line`, a one-sentence problem, and a concrete failure scenario or fix. Separate confirmed bugs from lower-confidence suggestions.

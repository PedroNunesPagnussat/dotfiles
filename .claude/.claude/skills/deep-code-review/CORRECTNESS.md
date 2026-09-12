# Correctness pass

Stay inside the scope and its blast radius. Walk each changed function end to end, asking what input or state makes it do the wrong thing.

- Logic errors: off-by-one, wrong operator, inverted condition
- Unhandled errors, nil/None/undefined, empty-collection and boundary cases
- Concurrency issues and resource leaks (unclosed files/connections)
- Broken, missing, or implementation-coupled tests for the behaviour in scope
- Security, kept to what is cheap to see: injection, unsanitized input reaching a sink, committed secrets

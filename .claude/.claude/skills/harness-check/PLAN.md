# SessionParser plan

- Bundle the per-session state threaded through `record_*` (`path, meta, result, last_tool, shapes, shape_local`) into a `SessionParser` object; the `record_*` helpers become its methods.
- `parse_session(path, result)` builds one `SessionParser`, runs it, returns its `SessionMeta`.
- Keep the digest byte-identical: same insertion order into every Counter, same post-loop bigram/perm folds.
- Done when the digest diffs empty vs the pre-refactor capture across days=7/30.

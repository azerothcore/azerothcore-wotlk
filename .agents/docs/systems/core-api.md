# Core API and headers

## Headers

- Keep widely included headers (`ObjectGuid.h`, `IWorld.h`, …) lean. No include dragging heavy or feature-specific
  dependencies into every translation unit: move the inline code needing it out-of-line into the `.cpp` and drop the
  include. No unscoped `#define` constants there (they can collide with modules); use `constexpr`.
- A type only one subsystem uses belongs in that subsystem's header. A header you add or move a type into includes
  what that type needs directly.
- **Getters**: `const` member functions, so they're callable through a const pointer or reference; `[[nodiscard]]`
  when neighbouring getters have it. Return a stored container or struct member as `Type const&`, not by value (a
  deliberate converted snapshot such as `std::vector<Roll const*>` is fine). No leading `const` on a by-value return.

## Module-facing API

- Core stays module-agnostic: no module names in core identifiers, strings, comments or compile flags (`IsBot`,
  `"bot"`, `MOD_PLAYERBOTS`, "accessor for the playerbots module"). Name things by what core cares about
  (`IsHeadless`), derived from state core already has (`!sock`) rather than a new flag or parameter. A constant or enum
  value core never reads belongs in the module. A generic API, or a definition core needs to handle module traffic
  (e.g. a link tag core validates), is fine and always compiled in, never behind a module flag.
- Don't break APIs modules use: public functions they call (DB/updater layer, managers, helpers) and base classes or
  script hooks they implement. Before changing a public signature, grep the modules CI clones
  (`apps/ci/ci-install-modules.sh`) and watch the `*-modules` build.
  - Non-virtual: existing call sites must keep compiling. An appended defaulted parameter already does; otherwise keep
    the old signature as an overload forwarding to the new one.
  - Virtual: a changed signature, a defaulted parameter included, stops module overrides matching. Prefer a new
    virtual with a default body, not pure; otherwise flag the change for module authors in the PR.
  - An unavoidable break ships with a companion module PR opened alongside.
- No API that duplicates or nearly duplicates an existing function, or only forwards to an already exported store or
  function: add a defaulted parameter to the existing (non-virtual) function, or make it public. Accessors a module
  needs are fine without an in-tree caller when the PR names that module.
- To expose a nested type or typedef, move it to `public:` where it is; never rename it or move it out of the class
  (renames its members, can clash with other headers). If that makes `_`-named fields public, still don't rename them.
- Validate before indexing or allocating, in new public functions for modules or external callers and wherever a hook
  return value or FFI/sidecar input becomes an index, count or id: bounds-check indices against the array size, reject
  signed lengths <= 0, null-check store/DBC `LookupEntry` results and object lookups. Copy the guards sibling setters or
  overloads already have (`SetTargetIcon`'s `id >= TARGETICONCOUNT`).
- The header comment is the module author's only documentation of module-facing API (accessors, base classes, hooks
  without in-tree callers): state what the signature doesn't show — returned pointers invalidated sooner than expected
  (e.g. freed at the end of the current call or tick), required call order or flags, who owns and deletes a passed
  pointer, return value and error code meanings, misuse that asserts. Comment trims keep these notes.

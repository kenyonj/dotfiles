# Personal Global Style Guide

Loaded by Copilot CLI from `~/.copilot/copilot-instructions.md` in **every session, every repo**. It is symlinked here from my public dotfiles (`config/copilot/copilot-instructions.md`), so it never gets checked into individual project repositories.

Scope and rules:

- This holds my **personal, cross-repo** style preferences only. Repo-specific conventions belong in that repo's own config, not here.
- **Living document:** when I state a style preference in any session, record it here with a short code example. Don't just remember it for the session; write it down so it travels.
- **Keep it public-safe:** this file lives in a public repo. Never add private, internal, or employer-confidential details, identifiers, or code. Use generic, illustrative examples.
- **Precedence:** if a repository's own enforced tooling (rubocop, prettier, gofmt, eslint, etc.) conflicts with a rule here, the repo's tooling wins. These are preferences, not overrides.

---

## Ruby

### Multi-line method calls

Opening paren ends the first line. Each argument gets its own line, never multiple args on one line. Trailing comma on the last argument. Closing paren on its own line, aligned with the method name.

```ruby
# correct
create_subscription(
  account,
  plan,
  features: { "metadata" => :read, "contents" => :read },
  trial_days: 14,
)

# wrong - closing paren on the last arg's line
create_subscription(
  account,
  plan,
  trial_days: 14)

# wrong - multiple args on one line
create_subscription(
  account, plan,
  trial_days: 14,
)
```

### Keyword-argument value omission (Ruby 3.1+)

When a keyword argument name matches the variable name, omit the value.

```ruby
# correct
enqueue(queue:, priority:)

# wrong
enqueue(queue: queue, priority: priority)
```

---

## Go

*(No preferences captured yet, will be added as they come up.)*

---

## Writing (prose, reviews, docs, comments)

### No em dashes

Never use em dashes (`—`) or en dashes (`–`); they read as AI-generated. Use commas, periods, semicolons, colons, or parentheses instead, depending on what fits. The only exception is quoted content where the source literally used one.

```
# correct
The starting point was genuinely ambiguous. Nobody had a clear answer.
The approach was solid on three fronts: framing, decomposition, and testing.

# wrong
The starting point was genuinely ambiguous—nobody had a clear answer.
The approach was solid on three fronts—framing, decomposition, testing.
```

---

## General

*(Cross-language preferences will be added here as they come up.)*

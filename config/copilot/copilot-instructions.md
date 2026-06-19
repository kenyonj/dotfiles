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

### Multi-line arrays and hashes

Same rules as multi-line calls: one element per line, trailing comma on the last element, closing bracket on its own line. The trailing comma keeps diffs clean when elements are added or reordered.

```ruby
# correct
post path, params: {
  owner: owner.login,
  repo: repo.name,
  issue_number: issue.number,
}

# wrong - no trailing comma on the last element
post path, params: {
  owner: owner.login,
  repo: repo.name,
  issue_number: issue.number
}
```

### Keyword-argument value omission (Ruby 3.1+)

When a keyword argument name matches the variable name, omit the value.

```ruby
# correct
enqueue(queue:, priority:)

# wrong
enqueue(queue: queue, priority: priority)
```

### View components

In ViewComponent classes, keep only the constructor (`def initialize`) public. Everything else goes under `private`: `attr_reader`s, `delegate`s, predicate methods like `render?`, memoized helpers, and any other methods. Constants stay public, above the constructor.

The template still reaches private methods (ViewComponent calls them via implicit `self`), and `render?` works fine when private.

```ruby
# correct
class WorkstreamComponent < ApplicationComponent
  MAX_ITEMS = 50

  def initialize(repository:, stream:)
    @repository = repository
    @stream = stream
  end

  private

  attr_reader :repository, :stream

  delegate :items, to: :stream

  def render?
    items.any?
  end

  memoize def issues
    items.select(&:issue?)
  end
end

# wrong - readers and helpers left in the public scope
class WorkstreamComponent < ApplicationComponent
  attr_reader :repository, :stream

  def initialize(repository:, stream:)
    @repository = repository
    @stream = stream
  end

  def render?
    stream.items.any?
  end
end
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

## Commits

- Don't add a `Co-authored-by: Copilot` trailer (or any AI/agent co-author attribution) to commit messages. Author commits as me, with no agent bumper line.

---

## General

*(Cross-language preferences will be added here as they come up.)*

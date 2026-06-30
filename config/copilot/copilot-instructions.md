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

### Endless (one-line) method definitions

For a method whose body is a single expression, use the endless definition form
(`def name = expression`) instead of the multi-line `def`/`end`. Reserve it for
genuinely short one-liners; anything needing multiple statements, a multi-line
literal, or line wrapping stays a regular `def`/`end`.

```ruby
# correct
def title = project.display_title
def number = project.number
def page_title = "#{workstream.title} · Workstreams"

# wrong - multi-line def/end for a single-expression body
def title
  project.display_title
end
```

### View components

In ViewComponent classes, keep only the constructor (`def initialize`) public. Everything else goes under `private`: `attr_reader`s, `delegate`s, predicate methods like `render?`, memoized helpers, and any other methods. Constants stay public, above the constructor.

The template still reaches private methods (ViewComponent calls them via implicit `self`), and `render?` works fine when private.

Prefer rendering ViewComponents directly from the controller (`render(MyComponent.new(...))`) over ERB views. In a packaged Rails app, an ERB view lives under `app/views` outside the package and breaks the package's consistency story; a ViewComponent keeps the markup in the package. When a component's body is trivial (e.g. it just renders a `render_react_partial`), define a public `call` method that returns the markup and skip the `.html.erb` sidecar entirely.

```ruby
# correct - a packaged controller renders a component directly
def show
  render(Workstreams::ProjectViewerComponent.new(workstream:))
end

# correct - trivial component uses `call`, no .html.erb sidecar
class ProjectViewerComponent < ApplicationComponent
  def initialize(workstream:)
    @workstream = workstream
  end

  def call
    render_react_partial(name: "workstreams-viewer", props: workstream.react_props)
  end

  private

  attr_reader :workstream
end
```


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

### Rails routes

**Always** use `resources`/`resource` in route files; **never** hand-write `get`/`post`/`put`/`patch`/`delete` for anything that maps to a REST resource. Map endpoints to the standard REST actions and scope down with `only:`/`except:`. For non-CRUD endpoints, nest a `member`/`collection` block inside the `resources` block rather than adding a standalone verb route. Reach for a bare `get`/`post` only for the rare endpoint that genuinely has no resource to hang off of (e.g. a health check or a redirect), and even then scope it inside the relevant `resources` block where possible.

```ruby
# correct
resources :workstreams, only: [:index, :show], param: :slug do
  post :assign_copilot, on: :collection
end

# wrong - standalone verb routes for what is a REST resource
get  "workstreams",       to: "workstreams#index"
get  "workstreams/:slug", to: "workstreams#show"
post "workstreams/assign_copilot", to: "workstreams#assign_copilot"
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
- Don't use Conventional Commits. Write commit subjects in the same short, present-tense headline style as PR titles (e.g. "Adds…", "Fixes…"), with no `type(scope):` prefix.

---

## Pull requests

- **Title**: a short, headline-style summary of what the PR introduces. Start with a present-tense verb ("Adds", "Enables", "Fixes", "Removes", "Refactors"), use no Conventional Commit `type(scope):` prefix, omit a trailing period, and keep it to ~70 characters. Example: `Adds project-backed workstreams behind a feature flag`.
- When opening a pull request, fill out the repository's PR template if one exists (commonly `.github/PULL_REQUEST_TEMPLATE.md`, or a file under `.github/PULL_REQUEST_TEMPLATE/`). Follow its sections rather than writing a freeform body.
- Keep the template's option markers intact: delete the bullets that don't apply, but preserve the exact `<!-- (`label`) -->` comment on the ones that do, and never modify version lines like `pull_request_template_version=N`. Repos often parse these to auto-apply labels (e.g. `risk:low`, `environment:production-dotcom`).
- If the repo has no template, write a clear, structured body anyway: what/why, risk, and how it was validated.

---

## General

*(Cross-language preferences will be added here as they come up.)*

# AgentKit Dev Skills: 12 Agent Skills for coding agents

Twelve ready-to-use `SKILL.md` skills for everyday developer work: review your own diff, debug from a reproduction, write PR descriptions, upgrade dependencies, refactor safely, hand a session off, and audit your own AGENTS.md or CLAUDE.md. MIT licensed. Free.

Each skill is a folder with a `SKILL.md` that follows the open [Agent Skills specification](https://agentskills.io/specification) (only spec fields: `name`, `description`, `license`, `metadata`), so the same files load in Claude Code and in other tools that read the format. All 12 pass `agentskills validate` (the `skills-ref` reference validator, version 0.1.x).

| Skill | Use it when |
|---|---|
| `agents-md-audit` | You want to check an AGENTS.md / CLAUDE.md / Cursor / Copilot file for stale commands, broken paths, vague rules and secrets. Ships a tested Python checker. |
| `write-agents-md` | A repo has no agent instructions, or they need a rewrite from evidence. |
| `review-my-diff` | You want a ranked self-review before opening a PR. |
| `repro-first-debugging` | A bug or failing test needs a cause, not a guess. |
| `pr-description` | You need a PR title and body a reviewer can use. |
| `safe-refactor` | You want structure changes with behavior locked by tests. |
| `dependency-upgrade` | You are bumping one package or framework and want the breakage read in advance. |
| `explain-codebase` | You are new to a repo and want a map with file references. |
| `security-quick-review` | A change touches input, auth, files or money and you want a fast triage. |
| `brag-doc-from-git` | Review season: collect merged PRs into a brag document, with visible gaps for results. |
| `session-handoff` | A long session is ending and a fresh one must continue. |
| `prove-it-ran` | Before anyone says "done", verify the checks ran and covered the change. |

## Install

**Claude Code** (project skills, shared with your team through git):

```bash
./install.sh --claude            # copies all 12 into ./.claude/skills/
./install.sh --claude --global   # or into ~/.claude/skills/
./install.sh --claude review-my-diff prove-it-ran   # or pick some
```

Or copy a folder by hand into `.claude/skills/<skill-name>/`. In a running session, `/reload-skills` picks up a new top-level skills folder.

**Codex, Cursor, Gemini CLI, GitHub Copilot and other tools that read `.agents/skills/`:**

```bash
./install.sh --agents
```

Some tools use their own folder instead (for example `.windsurf/skills/` or `.kiro/skills/`). Check your tool's documentation, and copy the folders there.

**claude.ai upload:** run `python3 build_dist.py` to make one ZIP per skill in `dist/` (or take them from the Releases page). In Claude, open Settings, then Capabilities, then Skills, and upload a ZIP. Skills that run a script (`agents-md-audit`) need an environment where code can run.

**With the skills CLI:** if you publish this folder as a public Git repository, `npx skills add <owner>/<repo>` can install from it (`npx skills add <owner>/<repo> --list` shows what it finds).

Invoke a skill by name (`/review-my-diff` in Claude Code) or just ask for the task; tools that load skills automatically match your request to each skill's `description`.

## What these are, and are not

- They are instructions for an AI agent. Quality of results depends on the agent and model you use. Skills guide an agent; they do not enforce anything.
- They were written with AI assistance and edited for consistency. The frontmatter was validated with the reference validator, and the audit script was run against sample repositories. The skills themselves have not been through a formal evaluation suite, so test them on a throwaway branch first and edit them to fit your team.
- `security-quick-review` is a triage aid, not a security audit.
- No telemetry, no network calls, no hidden files. The only script is `skills/agents-md-audit/scripts/audit_instructions.py` (Python 3.8+, standard library only, read-only).
- Not affiliated with Anthropic, OpenAI, Cursor, GitHub, Microsoft or Google.

## Make them yours

Edit the `description` first. It decides when an agent loads a skill, so name your own terms in it ("PR", "MR", "change request"). Then trim any step your team does differently. Keep each `SKILL.md` under 500 lines.

## More from AgentKit Co

- Free AGENTS.md / CLAUDE.md / Cursor / Copilot generator: https://agentkitco.com/tools/agents-md-generator/
- Guides on instruction files and agent settings: https://agentkitco.com/blog/
- The AI Coding Agent Config Kit (paid, $14): AGENTS.md templates for 12 stacks, scoped rules and prompts: https://agentkitco.com/products/agent-config-kit/

License: MIT (see `LICENSE`).

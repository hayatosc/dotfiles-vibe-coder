---
title: 'Git Commit'
read_only: true
type: 'command'
---

# Create new git commit task

- Takes all staged changes, suggests a commit message, ALWAYS asks for confirmation, and creates the commit ONLY after explicit approval
- This task is one of ONLY two places where committing is allowed (the other being commit-fast)
- Format of commit message depends on the affected files:
  - For module/package changes: `[module-name] description of changes`
  - For configuration files in root or specialized directories:
    - Configuration directories: `[config] description of changes`
    - Linting/formatting config: `[lint] description of changes`
    - Language-specific config: `[lang-config] description of changes`
    - Git-related files: `[git] description of changes`
    - Claude related files (e.g. CLAUDE.md or changes in .claude folder): `[claude] description of changes`
    - Docker/containerization: `[docker] description of changes`
    - CI/CD files: `[ci] description of changes`
    - Documentation: `[docs] description of changes`
    - Build/deployment configs: `[build] description of changes`
    - Other root configs: use appropriate descriptor in square brackets
  - For functionality spanning multiple modules: use the functionality name as scope
  - Golden rule: Use module names for module changes, otherwise use functionality/directory scope
  - If 80% or more changes are focused on a single feature/functionality, mention only the main module(s) and ignore minor related changes
  - Description should start with lowercase letter
  - Description should be concise and explain what was changed
  - Commit messages should be based only on staged files
- Always provide at least 5 message options in a numbered list; I will choose one or request a different option
- The scope in square brackets should be consistent across all suggested message options - it's a fixed rule based on the files changed, not something to vary between options
- When suggesting commit messages, use `git log -n 10 --oneline` to review the most recent commit messages for inspiration on format and style
- If there are no staged changes, automatically run `git add .` to stage all changes and proceed with commit message suggestions
- After staging files, continue with the normal commit workflow
- Format the suggested commit messages in orange text to make them more readable in the terminal
- NEVER proceed with `git commit -m` without explicit confirmation from me first
- Only after I explicitly confirm or modify the commit message, proceed with `git commit -m "message"`
- After successful commit, check if push is needed:
  - Use `git status` to check if local branch is ahead of remote
  - If changes need to be pushed (ahead of remote), prompt: "The commit was successful. Would you like me to push these changes to the remote repository?"
  - Only push after explicit confirmation
- If I tell you that you can push the changes, you can run `git push` directly without asking for permission
- ALWAYS add Claude co-authorship footer to commits:
  ```
  🤖 Generated with [Claude Code](https://claude.ai/code)
  
  Co-Authored-By: Claude <noreply@anthropic.com>
  ```
- Read ONLY staged files

## Examples of Good Commit Messages

- `[ui] fix user display issues in header component on initial render`
- `[notifications] add new notification system for alerts and messages`
- `[auth] improve authentication validation and session management`
- `[typescript] change tsconfig.json`
- `[config] update development environment settings`
- `[docs] add setup instructions for new development workflow`
- `[api] implement data validation for user input endpoints`
- `[database] optimize query performance for user data retrieval`
- `[build] update deployment configuration for production environment`
# Create Pull Request Command

## Overview

This command creates pull requests using the GitHub CLI (`gh pr`) command. It automates the process of creating, formatting, and linking pull requests to issues when needed.

## Usage

Use the `gh pr create` command to create pull requests with proper formatting and linking.

### Basic PR Creation

```bash
gh pr create --title "Title" --body "Description"
```

### When Closing Issues

When instructed to "close #12" or similar issue references:

1. **List available issues** to understand the current state:
   ```bash
   gh issue list
   ```

2. **Check the specific issue** using:
   ```bash
   gh issue view 12
   ```

3. **Review issue details** to understand:
   - Issue description and requirements
   - Any discussion or context in comments
   - Labels, assignees, and related information

4. **Write PR comment** that:
   - References the issue being closed
   - Summarizes what was implemented/fixed
   - Explains how the changes address the issue
   - Uses closing keywords: "close #12"

### PR Body Template

When creating PRs that close issues, use this format:

```markdown
close #[issue_number]

## Summary
Brief description of the changes made.

## Changes
- List of specific changes
- What was implemented/fixed
- Any notable technical decisions
```
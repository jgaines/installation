# AI Assistant Instructions

## CRITICAL: Source Control Protocol

- ALWAYS create a new changeset BEFORE making any changes:
```bash
jj new -m "copilot: description of changes"
```

- ALWAYS verify the current changeset with:
```bash
jj log -n 3 --no-pager
jj show --no-pager
```

- After changes, ALWAYS update the changeset with my prompt and your response, by writing the text directly to a temp file then piping it into jj:

```bash
jj desc --stdin < file_with_updated_desc
```
- Don't forget to delete the temp file after use

- NEVER change files outside of this repository unless explicitly instructed.   

## Documentation Rules

- ALL documentation must be in Markdown format
- NEVER use notebook format
- README.md must describe repository purpose and use
- Use meaningful, descriptive file names. Examples: install_mise.sh, install_brew.sh, backup_brew.sh

## Scripting Requirements

- Scripts MUST be simple bash scripts
- Include only minimal error checking
- Use "#!/usr/bin/env bash" shebang.
- Use simple linear logic, small regex matches, and basic string manipulation
- Limit user choices to y/n only
- Scripts should include 'cd $(dirname $0) || exit 1' after setting flags to ensure they run in the correct directory

## File Organization

- Use clear, descriptive file names
- Follow existing naming patterns
- Group related files logically

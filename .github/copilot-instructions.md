# AI Assistant Instructions

## CRITICAL: Source Control Protocol

1. ALWAYS create a new changeset BEFORE making any changes:

   ```bash
   jj new -m "copilot: description of changes"
   ```

2. ALWAYS verify the current changeset with:

   ```bash
   jj log --no-pager
   jj show --no-pager
   ```

3. NEVER change files outside of this repository unless explicitly instructed.   

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

## AI Assistant Protocol

- ALWAYS check these instructions before making changes
- ALWAYS create a new changeset first
- ALWAYS verify changes before proceeding
- ALWAYS follow the documentation and scripting rules
- ALWAYS use Markdown for documentation
- NEVER use notebook format
- ALWAYS use descriptive file names
- ALWAYS keep scripts simple and linear

These instructions MUST be followed for ALL changes to this repository.

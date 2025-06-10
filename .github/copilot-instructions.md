# AI Assistant Instructions

**Source Control Protocol:** ALWAYS create new changeset with `jj new -m "copilot: description"`, verify with `jj log -n 3 --no-pager`, update changeset by writing to temp file then `jj desc --stdin < file_with_updated_desc`, delete temp file after use. NEVER change files outside repository unless instructed.

**Documentation:** Use Markdown format only, never notebook format. README.md describes repository purpose. Use meaningful file names (install_mise.sh, install_brew.sh, backup_brew.sh).

**Scripts:** Simple bash with `#!/usr/bin/env bash`, minimal error checking, simple linear logic, y/n choices only, include `cd $(dirname $0) || exit 1` after setting flags.

**Files:** Use clear descriptive names, follow existing patterns, group logically.

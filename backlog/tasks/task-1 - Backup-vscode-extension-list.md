---
id: task-1
title: Backup vscode extension list
status: To Do
assignee: []
created_date: '2025-07-13'
updated_date: '2025-07-13'
labels: []
dependencies: []
---

## Description

Extend backup_vscode_settings.sh to backup the list of installed VS Code extensions. This ensures that extension configurations are preserved along with settings and keybindings, allowing for complete environment restoration. The extension list should be saved as a text file that can be used with 'code --install-extension' commands for restoration.
## Acceptance Criteria

- [ ] Extension list is saved as extensions.txt in the backup directory
- [ ] Extensions from both VS Code and VS Code Insiders are backed up if available
- [ ] Extension files are only created when the respective VS Code installation is found
- [ ] Extension backup success/failure is tracked and reported in final output
- [ ] Script handles cases where code command is not available gracefully

## Implementation Plan

1. Create backup_extensions function that takes app name and command
2. Function checks if command exists using 'command -v'
3. If command exists, run --list-extensions and save to extensions.txt in backup dir
4. Return success/failure status for tracking
5. Call function for both 'code' and 'code-insiders' commands
6. Update final output to include extension backup status
7. Test with both VS Code present and absent scenarios

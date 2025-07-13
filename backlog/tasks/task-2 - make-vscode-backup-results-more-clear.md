---
id: task-2
title: make vscode backup results more clear
status: To Do
assignee: []
created_date: '2025-07-13'
labels: []
dependencies: []
---

## Description

The final output of the backup_vscode_settings.sh script is unclear when either of the backup folders is not found.  The current output is:

```shell
❯ ./backup_vscode_settings.sh home
Starting VS Code settings backup for location: home
Working copy  (@) now at: vtmtwtlt 2a86edee (empty) back up home vscode settings
Parent commit (@-)      : pxztvtys ea4528ff (empty) (no description set)
Backing up VS Code settings to: ./vscode_settings/home
  Copying: User/globalStorage/alefragnani.project-manager/projects.json
  Copying: User/keybindings.json
  Copying: User/settings.json
Warning: VS Code Insiders config directory not found: /home/jgaines/.config/Code - Insiders
Backup completed successfully!
Files backed up to:
  VS Code: ./vscode_settings/home
  VS Code Insiders: ./vscode_settings/ihome
```

The final block shouldn't indicate that it backed up ./vscode_settings/ihome, if in fact it did not.  Instead it should look more like this:

```text
Files backed up to:
  VS Code: ./vscode_settings/home
  VS Code Insiders: not found
```

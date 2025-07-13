---
id: task-4
title: Backup brew settings
status: Done
assignee:
  - '@copilot'
created_date: '2025-07-13'
updated_date: '2025-07-13'
labels: []
dependencies: []
---

## Description

Create a script to backup Homebrew package lists and settings. This ensures that all installed brew packages can be restored on a new system or after a fresh installation. The backup should use brew bundle dump to create a Brewfile that can restore all installed packages.

## Acceptance Criteria

- [ ] Script creates a Brewfile containing all installed brew packages
- [ ] Backup includes both regular packages and casks
- [ ] Brewfile is saved to a consistent location for version control
- [ ] Script handles cases where Homebrew is not installed
- [ ] Backup process is integrated with existing backup workflows

## Implementation Plan

1. Create backup_brew.sh script following existing script patterns
2. Check if brew command is available using 'command -v'
3. Use 'brew bundle dump' to generate Brewfile
4. Save Brewfile to consistent location (e.g., ./brew_settings/)
5. Add location parameter support (work/home) like other backup scripts
6. Include success/failure feedback and error handling
7. Test with and without Homebrew installed
8. Consider integration with main backup workflow

## Implementation Notes

Successfully created backup_brew.sh script following existing backup patterns. The script checks for brew command availability, uses 'brew bundle dump --force' to generate Brewfiles with all packages, casks, taps, and VS Code extensions. Added location parameter support (work/home), proper error handling for systems without Homebrew, and consistent output formatting. Testing shows 95 package entries backed up including regular packages, taps, and VS Code extensions. The script integrates well with existing backup workflows.

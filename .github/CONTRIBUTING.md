# Contributing Guidelines

This document outlines best practices for managing the documents in this
repository.

## Documentation

1. Use Markdown for all documents.
1. Do not use notebook format for any documents.
1. The top level README.md describes the purpose and use of this repository.

## File Naming Rules

1. Use meaningful names.
1. Use descriptive names, examples:
   - install_mise.sh
   - install_brew.sh
   - backup_brew.sh
   - backup_uv_tool.sh

## Scripting Style

1. Scripts should be simple bash scripts.
1. Scripts should have minimal error checking.
1. Scripts should have simple linear logic without any choices beyond y/n to
   continue.

## Source Control

1. The repository uses [Jujutsu](https://jj-vcs.github.io/jj/latest/) in
  colocated mode on top of a git repo.
1. Jujutsu maintains a list of changesets designated by alphabetic codes as
  opposed to the hexadecimal hashes of git.
1. To view the commit log, run: `jj log --no-pager`.
1. An example listing of changesets is:

  ```bash
  ❯ jj log
  @  tzswroox john.gaines@netscout.com 2025-06-06 17:04:20 1534ffcc
  │  agent contributing guide
  ○  stmkvpol john.gaines@netscout.com 2025-06-06 16:43:09 git_head() 269a50f5
  │  clean-bash for agent
  ○  wvwmpozs john.gaines@netscout.com 2025-06-06 12:53:32 35413652
  │  sort-vscode-settings
  ◆  ytunkuyz me@jgaines.com 2025-06-06 01:18:09 master master@git master@origin a5046053
  │  added some security checks to scripts using external files
  ~
  ```

1. The changeset with the @ in the first character is the current set, any
   changes made in the project folder will get automatically added to the
   current changeset.
1. A changeset with a ○ in the first column has not been commited to the remote
   repository yet so can be manipulated.
1. A changeset with a ◆ in the first column has been pushed to a remote so
   should not be changed.
1. Your current working set of changesets is the list of changesets from the one
   with the ◆ to the one with the @.
1. **CRITICAL**: Before making any changes to files, you MUST execute `jj new -m
   "description"` first, where you should replace "description" with a short
   description of the changes. This creates a new changeset from the current @
   changeset. Any file changes made after this command will be automatically
   added to the new changeset. If you make changes before creating the new
   changeset, those changes will be added to the parent changeset instead, which
   is usually not what you want.
1. If you see "(empty) (no description set)" in the `jj log` output, it means
   the changeset has no content and no description. If you see just "(no
   description set)" without "(empty)", the changeset has content but needs a
   description.
1. To view the changes in the current changeset, run: `jj show --no-pager`.
1. To add or change the description of any changeset, use: `jj desc -m "new
   description" changesetID`. Replace "new description" with your actual
   description. You can omit the changesetID to modify the current @ changeset,
   or specify a particular changeset ID to modify a different changeset.
1. You can examine the details of any changeset by running: `jj show --no-pager
   changesetID`

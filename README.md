# Dockerfile lint pre-commit

This project add hooks to run [hadolint](https://github.com/hadolint/hadolint) with the [pre-commit](https://pre-commit.com/) project.

```bash
- repo: https://github.com/petalmd/dockerfile-pre-commit
  rev: ''  # Use the revision rev you want to point at
  hooks:
  - id: dockerlint
````

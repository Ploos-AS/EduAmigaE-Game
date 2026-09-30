# CI and runtime qualification

Public CI validates everything that can be tested without proprietary Amiga
system material.

## Public CI

GitHub Actions runs:

- host runner tests;
- FS-UAE configuration generation tests;
- PASS/FAIL marker tests;
- Amiga Hunk verifier tests;
- student OCI image build;
- student OCI `doctor`.

No Kickstart ROM or AmigaOS files are stored in the repository, workflow,
artifacts, caches or container image.

## Runtime qualification

Q2/Q3 runtime qualification is intentionally separate. It requires a
legally obtained Kickstart ROM and Amiga system installation supplied by the
person or runner performing qualification.

A runtime qualification result may publish logs, hashes, tool versions and
the course-produced executable, but must not publish proprietary ROM/OS
material.

This split keeps ordinary course CI reproducible and public while allowing a
private or self-hosted qualification runner to provide stronger runtime
evidence later.

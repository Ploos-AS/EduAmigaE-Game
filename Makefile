.PHONY: help student-image student-doctor test test-host q3 q3-target-1x q3-target-a500 q3-target-a1200 q3-preflight-a500 q3-preflight-a1200

help:
	@echo "EduAmigaE-Game"
	@echo "  make student-image   Build the student OCI image"
	@echo "  make student-doctor  Check its base tools"
	@echo "  make test            Run host-side tests"
	@echo "  make q3              Build Q3 smoke fixture through configured runner"
	@echo "  make q3-target-a500  Execute Q3 artifact on A500/1.x in FS-UAE"
	@echo "  make q3-target-a1200 Execute Q3 artifact on A1200/3.x in FS-UAE"
	@echo "  make q3-preflight-a500  Validate A500/1.x inputs without execution"
	@echo "  make q3-preflight-a1200 Validate A1200/3.x inputs without execution"
	@echo "  make q3-target-1x    Legacy alias for A500/1.x preflight"

student-image:
	docker build -f student-oci/Dockerfile -t eduamigae-game:dev .

student-doctor: student-image
	docker run --rm eduamigae-game:dev doctor

test: test-host

test-host:
	sh tests/test-host-runner.sh
	sh tests/test-fsuae-config.sh
	sh tests/test-build-markers.sh
	sh tests/test-hunk-checker.sh
	sh tests/test-target-1x-gate.sh
	sh tests/test-target-runner.sh

q3:
	EDUAMIGAE_RUNNER='runtime/fs-uae/run-build.sh "$$1"' tools/eduamigae-game build tests/fixtures/q3-smoke.e

q3-target-1x:
	sh runtime/fs-uae/qualify-target-1x.sh build/out/q3-smoke

q3-target-a500:
	sh runtime/fs-uae/run-target.sh a500-1x build/out/q3-smoke

q3-target-a1200:
	sh runtime/fs-uae/run-target.sh a1200-3x build/out/q3-smoke

q3-preflight-a500:
	sh runtime/fs-uae/qualify-target.sh a500-1x build/out/q3-smoke

q3-preflight-a1200:
	sh runtime/fs-uae/qualify-target.sh a1200-3x build/out/q3-smoke

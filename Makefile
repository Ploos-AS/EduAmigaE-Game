.PHONY: help student-image student-doctor test test-host q3

help:
	@echo "EduAmigaE-Game"
	@echo "  make student-image   Build the student OCI image"
	@echo "  make student-doctor  Check its base tools"
	@echo "  make test            Run host-side tests"
	@echo "  make q3              Build Q3 smoke fixture through configured runner"

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

q3:
	EDUAMIGAE_RUNNER='runtime/fs-uae/run-build.sh "$$1"' tools/eduamigae-game build tests/fixtures/q3-smoke.e

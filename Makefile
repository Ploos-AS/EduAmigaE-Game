.PHONY: help student-image student-doctor

help:
	@echo "EduAmigaE-Game"
	@echo "  make student-image   Build the student OCI image"
	@echo "  make student-doctor  Check its base tools"

student-image:
	docker build -f student-oci/Dockerfile -t eduamigae-game:dev .

student-doctor: student-image
	docker run --rm eduamigae-game:dev doctor

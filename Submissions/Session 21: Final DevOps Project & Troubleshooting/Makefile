test:
	python -m pytest -q application
build:
	docker build -f docker/Dockerfile -t final-devops-api:local .
helm-lint:
	helm lint helm/final-devops
tf-validate:
	cd terraform && terraform init -backend=false && terraform validate

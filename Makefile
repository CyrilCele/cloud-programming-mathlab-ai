.PHONY: init fmt validate plan apply destroy test lint security clean deploy

init:
	./scripts/init.sh

fmt:
	./scripts/fmt.sh

validate:
	./scripts/validate.sh

plan:
	./scripts/plan.sh

apply:
	./scripts/apply.sh

destroy:
	./scripts/destroy.sh

test:
	./scripts/test.sh

lint:
	./scripts/lint.sh

security:
	./scripts/security.sh

deploy:
	./scripts/deploy.sh

clean:
	./scripts/clean.sh
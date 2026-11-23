
.PHONY: help sync run test lint format typecheck check \
        build docker-run clean

PYTHON := uv run python
MODEL := models/common/world.xml
STEPS ?= 1000
IMAGE := ek505-fruit-grasping

help:
	@echo "Available commands:"
	@echo "  make sync        Install project dependencies"
	@echo "  make run         Run headless simulation"
	@echo "  make test        Run pytest"
	@echo "  make lint        Run Ruff linting"
	@echo "  make format      Format Python source"
	@echo "  make typecheck   Run Pyright"
	@echo "  make check       Run all quality checks"
	@echo "  make build       Build Docker image"
	@echo "  make docker-run  Run simulation in Docker"
	@echo "  make clean       Remove local caches"

sync:
	uv sync --locked

run:
	$(PYTHON) -m adaptive_grasping \
		--model $(MODEL) \
		--steps $(STEPS)

test:
	uv run pytest tests/

lint:
	uv run ruff check .

format:
	uv run ruff format .

typecheck:
	uv run pyright

check: lint typecheck test

build:
	docker build -t $(IMAGE) .

docker-run:
	docker run --rm \
		-v "$(CURDIR)/results:/app/results" \
		$(IMAGE)

clean:
	rm -rf .pytest_cache .ruff_cache .mypy_cache
	find src tests -type d -name __pycache__ \
		-prune -exec rm -rf {} +

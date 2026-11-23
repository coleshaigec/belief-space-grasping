
FROM python:3.12-slim-bookworm

# Python and numerical-computing configuration
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_NO_CACHE=1 \
    UV_PROJECT_ENVIRONMENT=/app/.venv \
    MPLBACKEND=Agg \
    MUJOCO_GL=osmesa \
    OMP_NUM_THREADS=1 \
    OPENBLAS_NUM_THREADS=1

WORKDIR /app

# System libraries for MuJoCo and CPU-based rendering
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libgl1 \
        libosmesa6 \
        libglew2.2 \
        libglfw3 \
        libglib2.0-0 && \
    rm -rf /var/lib/apt/lists/*

# Install uv from a pinned release
COPY --from=ghcr.io/astral-sh/uv:0.9.0 \
    /uv /uvx /bin/

# Install dependencies separately for Docker caching
COPY pyproject.toml uv.lock ./

RUN uv sync --locked --no-install-project

# Install application source
COPY . .

RUN uv sync --locked

# Make the virtual environment available
ENV PATH="/app/.venv/bin:$PATH"

# Default: run the project entrypoint
CMD ["python", "-m", "adaptive_grasping"]

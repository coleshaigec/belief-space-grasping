
# src/adaptive_grasping/__main__.py

import argparse
from pathlib import Path

from adaptive_grasping.bootstrap import create_application


def main() -> None:
    parser = argparse.ArgumentParser(
        description="EK505 adaptive fruit grasping simulation"
    )

    parser.add_argument(
        "--model",
        type=Path,
        default=Path("models/common/world.xml"),
    )

    parser.add_argument(
        "--steps",
        type=int,
        default=1000,
    )

    args = parser.parse_args()

    if args.steps < 0:
        parser.error("--steps must be nonnegative")

    if not args.model.is_file():
        parser.error(f"Model not found: {args.model}")

    application = create_application(args.model)
    application.run(steps=args.steps)


if __name__ == "__main__":
    main()

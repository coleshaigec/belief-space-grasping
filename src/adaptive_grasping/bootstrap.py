
from pathlib import Path

from adaptive_grasping.app import Application
from adaptive_grasping.simulation.mujoco_adapter import MuJoCoAdapter


def create_application(model_path: Path) -> Application:
    """Construct the application and its dependencies."""

    simulator = MuJoCoAdapter(model_path=model_path)

    return Application(simulator=simulator)

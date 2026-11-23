
from dataclasses import dataclass

from adaptive_grasping.simulation.mujoco_adapter import MuJoCoAdapter


@dataclass
class Application:
    simulator: MuJoCoAdapter

    def run(self, steps: int = 1000) -> None:
        self.simulator.reset()

        for _ in range(steps):
            self.simulator.step()

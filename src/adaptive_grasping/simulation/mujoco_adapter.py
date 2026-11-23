# pyright: reportAttributeAccessIssue=false

from pathlib import Path

import mujoco


class MuJoCoAdapter:
    def __init__(self, model_path: Path) -> None:
        self.model = mujoco.MjModel.from_xml_path(str(model_path))
        self.data = mujoco.MjData(self.model)

    def reset(self) -> None:
        mujoco.mj_resetData(self.model, self.data)
        mujoco.mj_forward(self.model, self.data)

    def step(self) -> None:
        mujoco.mj_step(self.model, self.data)

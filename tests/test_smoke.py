# pyright: reportAttributeAccessIssue=false

from pathlib import Path

import mujoco

MODEL_PATH = Path("models/common/world.xml")


def test_world_loads() -> None:
    model = mujoco.MjModel.from_xml_path(str(MODEL_PATH))

    assert model.ngeom >= 1
    assert model.opt.timestep > 0


def test_world_steps() -> None:
    model = mujoco.MjModel.from_xml_path(str(MODEL_PATH))
    data = mujoco.MjData(model)

    mujoco.mj_step(model, data)

    assert data.time == model.opt.timestep

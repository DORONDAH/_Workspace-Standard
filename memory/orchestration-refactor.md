---
name: orchestration-refactor
description: Implementation of lifecycle state machine and orchestrator refactor.
metadata:
  type: project
---

# Orchestration Refactor

This memory marks the implementation of the governed lifecycle state machine and the refactoring of the orchestrator to use the Control Plane.

**Components:**
- `State-Machine.ps1`: Formal lifecycle state management.
- `orchestrator.ps1`: Refactored to require a Task Contract and enforce state transitions.

**Why:** To ensure that all task execution is governed by a deterministic state machine and verifiable contracts.
**How to apply:** All new tasks must be submitted to the orchestrator as a Task Contract (YAML), which will then be governed by the Control Plane.

# Lab Content Inspection Report

## 1. Total file count

**53 files**, excluding the .git directory and including all other repository files (including this report).

## 2. Directory tree diagram

~~~
platform-purpose-exploration\
  ├── .agent\
    ├── agent-operating-contract.md
    ├── context-adapter-architecture.md
    ├── core-vocabulary.md
    ├── decision-framework.md
    ├── domain-adapter.md
    ├── domain-context.md
    ├── implementation-construction-policy.md
    ├── professional-vocabulary.md
    ├── project-adapter.md
    ├── project-context.md
  ├── .continue\
    ├── rules\
      ├── new-rule.md
  ├── .vscode\
    ├── extensions.json
    ├── settings.json
    ├── tasks.json
  ├── agents\
    ├── commander-contract.yaml
    ├── lab-content-inspector-contract.yaml
    ├── lab-opinion-contract.yaml
  ├── control-plane\
    ├── control-plane.ps1
    ├── governance-enforcement.ps1
    ├── State-Machine.ps1
    ├── template-task.yaml
    ├── validation-engine.ps1
  ├── docs\
    ├── risk-assessment-report.md
  ├── FINAL-REPORT.md
  ├── lab-engine\
    ├── core\
      ├── engines\
        ├── reference_engine.ps1
      ├── orchestrator.ps1
      ├── orchestrator_fixed.ps1
      ├── orchestrator_new.ps1
      ├── registry.yaml
      ├── state.json
      ├── task-queue.ps1
    ├── governance\
      ├── ERROR-LOGS.md
      ├── LAB-POLICIES.yaml
    ├── reports\
      ├── LIVE-FEED.md
    ├── sandboxes\
      ├── templates\
        ├── jellyfin.yaml
    ├── tasks.queue
  ├── MASTER CONSTRUCTION PROMPT — Workspace Standard Final Architecture.md
  ├── memory\
    ├── adversarial-recovery-tests.md
    ├── architecture-truth.md
    ├── contracts-foundation.md
    ├── control-plane-foundation.md
    ├── implementation-completion.md
    ├── implementation-inventory.md
    ├── MEMORY.md
    ├── orchestration-refactor.md
    ├── project-truth.md
  ├── projects\
    ├── workspace-standard\
      ├── PROJECT-STATE.yaml
      ├── PROJECT-TRUTH.md
  ├── test_task_contract.yaml
  ├── tests\
    ├── Adversarial-Tests.ps1
    ├── Recovery-Tests.ps1
  ├── Workspace Standard — Final Architecture Truth.md
    └── lab-content-report.md
~~~

## 3. Task execution flow

1. **Task admission:** An agent first reads its role contract. The contract defines the goal, authority, allowed tools, forbidden actions, and required output. The task contract is then loaded and checked for required identity, authority, scope, task type, tools, and engine fields.
2. **Governance enforcement (control plane):** `control-plane/control-plane.ps1` is the governance boundary. The real enforcement script loads the task contract, Project Truth, and Project State, verifies agent identity and authority, checks scope and policy, confirms required tools, and resolves the engine through `lab-engine/core/registry.yaml`. A denied check stops admission.
3. **Execution (orchestrator):** After approval, the orchestrator acquires a project-state lock, advances task status, selects the registered engine, and executes the task. State transitions are constrained by `control-plane/State-Machine.ps1`, which allows canonical forward progress or terminal failure/rejection states.
4. **Validation:** `control-plane/validation-engine.ps1` independently checks that the task exists, evidence is present and matches the task, execution results are supplied and consistent, and the task state is valid for validation. Failure prevents completion.
5. **Evidence generation:** On successful validation, the orchestrator marks the task complete, records execution and validation details, writes an evidence record, updates the evidence registry, and releases the lock. The resulting state and evidence provide the audit trail.


# Execution Plan for Workspace Standard Project Files

## Overview
This plan outlines the steps to write the project files for the Workspace Standard repository, ensuring the architecture is implemented efficiently and correctly. The plan follows the Decision → Approval → Execution → Validation flow and uses sub-agents for specialized tasks with explicit authorization checkpoints. Each phase respects the separation of concerns and architectural invariants, particularly the principle that "Implementation אינה מקבלת סמכות אוטומטית מהגדרת הארכיטקטורה" (Implementation does not receive automatic authority from architecture definition).

## Phases

### Phase 1: Foundation and Inspection
- **Status**: Completed
- **Tasks**:
  - Inspect repository structure
  - Read PROJECT-TRUTH.md and Workspace Standard — Final Architecture Truth.md
  - Read Workspace Standard — Executive Summary.md
  - Read Workspace Standard — Project Truth Document - Executor Brief.md
  - Review existing files and documentation

### Phase 2: Architecture Definition and Decision Framework
- **Sub-agent**: Architect
- **Tasks**:
  - Extract architectural invariants from all truth documents (including Executive Summary and Executor Brief)
  - Define core vocabulary and professional vocabulary layers
  - Establish the Decision Framework that separates reasoning from authorization
  - Ensure the architecture prevents agents from becoming authority sources (Multi-Agent ≠ Multi-Authority)
  - Define the layered architecture: Core Vocabulary → Professional Vocabulary → Agent Operating Contract → Decision Framework → Context/Adapter Architecture
  - Output: Architecture specification document with explicit decision gate requirements

### Phase 3: Control Plane Implementation with Authorization Flow
- **Sub-agent**: Executor (with governance expertise)
- **Tasks**:
  - Implement `control-plane.ps1` as the central governance enforcer that manages the Decision → Approval → Execution → Validation flow
  - Implement `State-Machine.ps1` for lifecycle management that enforces the canonical lifecycle with explicit authorization gates
  - Implement `governance-enforcement.ps1` for policy enforcement that validates authorization before execution
  - Implement `validation-engine.ps1` for validation logic that operates independently of execution
  - Create `template-task.yaml` for task contracts that includes explicit authorization requirements
  - Ensure technical enforcement of governance (not just prompts) by making violations technically impossible
  - Implement the Supervisor role as part of the Control Plane that provides explicit authorization

### Phase 4: Agent Contracts and Roles with Supervisor/Executor Model
- **Sub-agent**: Architect (for contract design)
- **Tasks**:
  - Define agent roles based on the Supervisor/Executor model:
    - Supervisor (Managing Architect): Responsible for architectural decisions, authorization, and boundary enforcement
    - Executor (AI Agent): Responsible for context inspection, analysis, decision preparation, planning, execution after authorization, validation, and reporting
    - Additional roles: Researcher, Critic/Security Auditor, Validator (as specialized executors)
  - For each role, create a contract YAML file (e.g., in `agents/` directory) with:
    - id, role, goal, inputs, outputs, authority, forbidden actions, tools, tool permissions, dependencies, failure modes, escalation, validation requirements, delegation permissions
  - Explicitly define that the Executor role does NOT have authorization capabilities - authorization comes only from the Supervisor/Control Plane
  - Implement the Workspace Commander contract (already present as `agents/commander-contract.yaml`; verify and update if needed to reflect Supervisor responsibilities)
  - Ensure all contracts include the explicit authorization requirement: "Only execute after explicit Authorization from Supervisor/Control Plane"

### Phase 5: Lab Engine and Orchestration with Authorization Gates
- **Sub-agent**: Executor (for orchestration)
- **Tasks**:
  - Refactor `lab-engine/core/orchestrator.ps1` to integrate with Control Plane, State Machine, and Task Queue
  - Ensure the orchestrator implements the Decision → Approval → Execution → Validation flow with explicit authorization checkpoints
  - Implement `lab-engine/core/task-queue.ps1` for task management that respects authorization states
  - Ensure the orchestrator uses the Control Plane for task admission and validation, and only proceeds to execution after explicit authorization
  - Implement pre-flight checks that validate the execution is still within authorized bounds

### Phase 6: Project Truth and State with Context Layers
- **Sub-agent**: Researcher (for setting up a sample project)
- **Tasks**:
  - For a sample project (e.g., `projects/workspace-standard/`), create:
    - `PROJECT-TRUTH.md` with mission, objective, principles, constraints, success criteria (defining the "Meaning" layer)
    - `PROJECT-STATE.yaml` with metadata, lifecycle, active tasks, locks, evidence registry, unknowns (representing the concrete project state)
  - Ensure the project state is machine-readable and managed by the Control Plane
  - Implement the context layers: Project Context (concrete project reality) → Project Adapter (project-level adaptation) as defined in the architecture
  - Ensure that the Executor understands the distinction between Project Context (reality) and Project Adapter (adaptation layer)

### Phase 7: Testing Authorization and Decision Gates
- **Sub-agent**: Critic / Security Auditor
- **Tasks**:
  - Write adversarial tests (`tests/Adversarial-Tests.ps1`) to test:
    - Unauthorized access attempts
    - Policy violations
    - Attempts to bypass authorization gates
    - Confusion between decision and execution phases
  - Write recovery tests (`tests/Recovery-Tests.ps1`) to test state recovery after crashes
  - Ensure tests validate the governance boundaries and failure recovery
  - Test that the Executor cannot execute without explicit authorization
  - Test that validation is independent of execution and cannot be bypassed
  - Test the Decision → Approval → Execution → Validation flow is enforced

### Phase 8: Documentation and Validation
- **Sub-agent**: Architect (for documentation)
- **Tasks**:
  - Update `memory/` directory with canonical references:
    - `architecture-truth.md`
    - `project-truth.md`
    - `control-plane-foundation.md`
    - `contracts-foundation.md`
    - `orchestration-refactor.md`
    - `implementation-completion.md`
    - `adversarial-recovery-tests.md`
  - Update `memory/MEMORY.md` index
  - Ensure all documentation is synchronized with the implementation

### Phase 9: Final Review and Evidence Generation
- **Sub-agent**: Validator
- **Tasks**:
  - Run all tests to verify passes
  - Check that the canonical flow is implemented: Task Admission → Governance Enforcement → Execution → Validation → Evidence Generation
  - Verify persistent state via `PROJECT-STATE.yaml` and `tasks.queue`
  - Confirm lifecycle enforcement: `CREATED` → `EXECUTING` → `VALIDATING` → `COMPLETED`
  - Generate evidence of completion (e.g., test logs, state files)

## Checklist for Completion
- [ ] Architecture invariants defined and documented (including Meaning ≠ Behavior, Behavior ≠ Decision, Decision ≠ Implementation)
- [ ] Decision Framework implemented that separates reasoning from authorization
- [ ] Control Plane scripts implemented and technically enforce governance (Decision → Approval → Execution → Validation flow)
- [ ] Supervisor/Executor model implemented with explicit authorization gates
- [ ] Agent contracts created for all roles with explicit permissions, forbidden actions, and authorization requirements
- [ ] Lab engine orchestrator refactored to use Control Plane, State Machine, and Task Queue with authorization checkpoints
- [ ] Task queue implemented that respects authorization states
- [ ] Sample project has PROJECT-TRUTH.md (Meaning layer) and PROJECT-STATE.yaml (concrete project state)
- [ ] Context layers implemented: Project Context → Project Adapter as defined in architecture
- [ ] Adversarial and recovery tests written and passing (including authorization bypass tests)
- [ ] Memory documents updated and indexed with canonical references
- [ ] Final validation shows PASS on all tests
- [ ] Evidence generated and recorded showing explicit authorization before execution
- [ ] Verified that no agent can redefine project mission or bypass validation
- [ ] Verified that execution cannot occur without explicit authorization from Supervisor/Control Plane

## Use of Sub-agents
Each phase assigns a sub-agent with a specific role. The sub-agent should:
1. Receive the task description and objectives.
2. Have access to the necessary tools and permissions (as defined in their contract).
3. Report back with the results and any evidence.
4. Be validated by the Validator sub-agent (or the Workspace Commander) before moving to the next phase.

## Notes
- The plan assumes that the sub-agents are governed by the Workspace Control Plane.
- All actions must be authorized and validated.
- No agent may redefine the project mission or bypass validation.
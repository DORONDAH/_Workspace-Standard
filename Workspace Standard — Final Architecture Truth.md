# Workspace Standard
## Final Architecture Truth

**Status:** Canonical Architecture Definition  
**Authority:** Architecture Truth  
**Purpose:** Define the final target architecture that all implementation, agents, runtimes, projects, workflows and governance mechanisms must conform to.

---

## 1. Architectural Mission

Workspace Standard is a reusable, governed architecture for autonomous and semi-autonomous AI-driven workspaces.

Its purpose is to allow multiple AI agents, runtimes, tools, engines and execution environments to collaborate on real projects while preserving:

- one canonical project meaning;
- explicit authority;
- explicit scope;
- deterministic lifecycle;
- controlled delegation;
- controlled execution;
- security boundaries;
- validation;
- evidence;
- rollback;
- recovery;
- multi-agent coordination;
- separation between reasoning and authority;
- separation between runtime and governance.

The architecture must prevent an AI agent, model, runtime, prompt, tool or workflow from silently becoming the source of truth or authority.

---

# 2. Fundamental Architectural Principle

## Multi-Agent ≠ Multi-Authority

The system may contain:

- multiple Agents;
- multiple Sessions;
- multiple runtimes;
- multiple models;
- multiple IDE clients;
- multiple execution engines;
- multiple parallel analytical processes.

However, there must be **one governed authority model per Workspace/Project scope**.

Authority belongs to the **Workspace Control Plane**, not to an Agent.

Agents are participants.

Runtimes are execution mechanisms.

Tools are capabilities.

Engines perform external work.

The Control Plane governs what is permitted.

---

# 3. Architectural Hierarchy

The canonical architecture is:

```text
HUMAN / OPERATOR
        │
        ▼
PROJECT TRUTH
        │
        ▼
PROJECT STATE
        │
        ▼
WORKSPACE CONTROL PLANE
        │
        ├── Authority
        ├── Policy
        ├── Scope
        ├── State
        ├── Locks
        ├── Delegation
        ├── Approval
        ├── Evidence
        ├── Validation
        └── Lifecycle
        │
        ▼
TASK CONTRACT
        │
        ▼
AGENT RUNTIME
        │
        ├── VS Code Agent
        ├── Continue Agent
        ├── CrewAI
        └── Other governed runtimes
        │
        ▼
GOVERNED TOOLS
        │
        ▼
EXECUTION ENGINES
        │
        ├── Hyper-V
        ├── Docker
        ├── Cloud
        ├── NVIDIA
        └── Future Engines
        │
        ▼
ACTUAL STATE
        │
        ▼
VALIDATION
        │
        ▼
EVIDENCE
        │
        ▼
PROJECT STATE / CLOSURE
```

No lower layer may redefine the authority or semantic meaning of a higher layer.

---

# 4. Core Architectural Layers

## 4.1 Core Vocabulary

Defines universal meanings such as:

- Truth
- Live State
- Desired State
- Observed
- Declared
- Assumed
- Unknown
- Authority
- Source of Truth
- Evidence
- Proof
- Confidence
- Constraint
- Boundary
- Validation
- Conflict

Mandatory distinctions:

```text
Observed ≠ Declared
Declared ≠ Verified
Assumed ≠ Known
Desired State ≠ Live State
Evidence ≠ Proof
Truth ≠ Assumption
Reasoning ≠ Authority
Recommendation ≠ Decision
Proposal ≠ Approval
Approval ≠ Execution
Execution ≠ Validation
Validation ≠ Evidence
```

---

# 5. Project Truth

Every project MUST have a canonical:

```text
PROJECT-TRUTH.md
```

This is the semantic source of truth for the project.

It defines:

- Mission
- Purpose
- Primary Objective
- Desired Final Result
- Scope
- Explicit Non-Scope
- Non-Goals
- Principles
- Constraints
- Success Criteria
- Canonical Decisions
- Architectural Invariants

Project Truth must remain relatively stable.

It must NOT become a dump of every technical detail.

Dynamic information belongs in:

```text
PROJECT-STATE.yaml
```

Project Truth answers:

> What are we building, why are we building it, what counts as success, and what must never be violated?

Project State answers:

> Where are we now?

No Agent may redefine Project Mission.

An Agent may propose a change.

Only an authorized decision process may change canonical Project Truth.

---

# 6. Project State

Every project should maintain machine-readable dynamic state.

It records, as applicable:

- current lifecycle state;
- active objectives;
- active tasks;
- decisions;
- approvals;
- execution status;
- validation status;
- blockers;
- risks;
- assumptions;
- unknowns;
- locks;
- ownership;
- evidence references;
- recovery information.

Project State is mutable.

Project Truth is governed semantic authority.

---

# 7. Agent Definition

Every Agent MUST have an explicit contract.

Minimum:

```text
Role
Goal
Inputs
Outputs
Authority
Forbidden Actions
Tools
Tool Permissions
Dependencies
Failure Modes
Escalation
Validation Requirements
Delegation Permissions
```

An Agent's prompt is NOT sufficient security.

Tool permissions and Control Plane enforcement must technically constrain the Agent.

---

# 8. Agent Roles

The architecture supports roles such as:

### Workspace Commander

Responsible for:

- orchestration;
- planning;
- delegation;
- synthesis;
- coordination.

It does NOT own system authority.

### Architect

Responsible for:

- architecture analysis;
- design;
- consistency;
- architectural proposals.

### Researcher

Responsible for:

- evidence gathering;
- documentation research;
- factual investigation.

### Critic / Security Auditor

Responsible for:

- adversarial analysis;
- security review;
- architectural contradiction detection;
- failure analysis.

### Executor

Responsible for:

- executing approved changes;
- operating governed tools;
- performing implementation.

Executor MUST NOT redefine objectives or authorize itself.

### Validator

Responsible for:

- checking expected vs actual state;
- validating execution;
- producing validation evidence.

Validator should be independently scoped from the action it validates whenever practical.

---

# 9. Delegation

Delegation is governed.

An Agent may NOT arbitrarily create another Agent or grant authority.

Delegation must be evaluated by the Control Plane against:

- Agent identity;
- requested role;
- Task Contract;
- scope;
- authority;
- tools;
- model/runtime;
- resource limits;
- concurrency limits;
- project policy;
- approval requirements.

Preferred structure:

```text
Human
  ↓
Workspace Commander
  ↓
Control Plane
  ↓
Architect / Researcher / Critic / Validator
  ↓
Synthesis
  ↓
Approval
  ↓
Executor
```

---

# 10. Sessions and Runtimes

A Session is execution/context state.

It is NOT authority.

The architecture must support:

- multiple VS Code sessions;
- multiple Agents;
- multiple runtimes;
- Continue;
- CrewAI;
- future runtimes.

VS Code, Continue and CrewAI are runtime/client mechanisms.

They are NOT the canonical source of:

- Project Truth;
- Authority;
- Policy;
- State;
- Evidence semantics.

---

# 11. Control Plane

The Control Plane is the central governance boundary.

It must govern:

### Identity

Who is acting?

### Authority

What may they do?

### Scope

Where may they act?

### Policy

What rules apply?

### State

What lifecycle state is the task/project in?

### Locks

Who currently owns mutable resources?

### Delegation

May this Agent create/delegate this work?

### Approval

Is approval required?

### Execution

Is the requested action authorized?

### Validation

Was the expected state achieved?

### Evidence

Can completion be proven?

### Recovery

What happens after failure/crash/restart?

---

# 12. Decision Lifecycle

Canonical lifecycle:

```text
OBJECTIVE
→ CONTEXT / CURRENT STATE
→ REQUIREMENTS / CONSTRAINTS
→ EVIDENCE
→ ASSUMPTIONS / UNKNOWNS
→ OPTIONS
→ RISK / TRADE-OFFS
→ RECOMMENDATION
→ PROPOSAL
→ DECISION
→ APPROVAL
→ COMMIT
→ EXECUTION
→ VALIDATION
→ EVIDENCE
→ CLOSURE
```

No stage may be silently skipped where it is required by policy.

---

# 13. Task State Machine

Minimum states:

```text
CREATED
CLASSIFIED
PLANNED
RESEARCHED
CRITICIZED
APPROVED
EXECUTING
EXECUTED
VALIDATING
VALIDATED
COMPLETED
```

Failure states:

```text
FAILED
REJECTED
BLOCKED
ROLLBACK_REQUIRED
ROLLED_BACK
ESCALATED
```

Critical invariant:

```text
EXECUTED → VALIDATING → VALIDATED → COMPLETED
```

Never:

```text
EXECUTED → COMPLETED
```

Execution success does not mean task success.

---

# 14. Task Contract

Every executable task MUST have a machine-readable contract.

Minimum:

```yaml
task_id:
task_type:
objective:
scope:
inputs:
constraints:
authority:
assigned_agent:
required_tools:
expected_state:
success_criteria:
evidence_requirements:
failure_policy:
rollback_policy:
```

No executor should receive an ambiguous task.

---

# 15. Scope

Every operation must have explicit scope.

Scope must include, as applicable:

- workspace;
- project;
- files;
- directories;
- systems;
- resources;
- network;
- credentials/secrets;
- engines;
- permitted actions.

Silent scope expansion is prohibited.

If the requested operation exceeds scope:

```text
STOP
→ ESCALATE
```

---

# 16. Engine Registry

The Engine Registry is authoritative for execution capability.

Each engine must define:

```yaml
status:
adapter:
capabilities:
permissions:
isolation:
resource_limits:
task_patterns:
availability:
validation:
rollback:
version:
integrity:
```

Examples:

```text
Hyper-V
Docker
Cloud
NVIDIA
Media
Social
```

An engine that is declared but not implemented MUST NOT be used.

There must never be silent fallback such as:

```text
Azure unavailable
→ Docker
```

Instead:

```text
ENGINE_UNAVAILABLE
→ BLOCK / ESCALATE
```

---

# 17. Execution

Execution must be separated from reasoning.

Before execution:

- objective verified;
- scope verified;
- authority verified;
- approval verified;
- policy verified;
- tool permissions verified;
- engine selected;
- resource limits verified;
- expected state defined;
- validation defined;
- rollback strategy defined.

Execution must produce machine-observable evidence.

An LLM statement such as:

> "Task completed successfully"

is NOT evidence.

---

# 18. Validation

Validation must compare:

```text
EXPECTED STATE
        ↓
ACTUAL STATE
        ↓
EVIDENCE
        ↓
VALIDATION RESULT
```

Validation must be independent of the model's claim.

A task cannot be COMPLETED without successful validation.

---

# 19. Evidence

Evidence must be persistent and attributable.

Evidence should include:

- timestamp;
- task ID;
- actor;
- operation;
- target;
- expected result;
- actual result;
- command/tool execution;
- validation result;
- relevant hashes;
- errors;
- policy checks.

Evidence is not merely a textual summary.

---

# 20. Integrity

Where deterministic artifacts are governed by integrity policy:

```text
SHA256
```

must be calculated and compared against a trusted baseline.

Missing baseline:

```text
UNKNOWN
```

must NOT automatically mean:

```text
TRUSTED
```

Integrity mismatch must trigger the configured failure policy.

---

# 21. Security

Security is enforced structurally.

Required controls include, where applicable:

- least privilege;
- explicit tool permissions;
- isolation;
- sandboxing;
- network policy;
- secret handling;
- secret scrubbing;
- resource limits;
- integrity verification;
- audit logging;
- rollback;
- cleanup;
- concurrency control.

Prompts are behavioral guidance.

They are not sufficient enforcement.

---

# 22. Cyber Isolation

Cyber/security tasks default to isolated execution.

Default network policy:

```text
NETWORK = NONE
```

unless explicitly authorized.

Privileged operations require explicit authorization.

---

# 23. Resource Governance

Execution must enforce resource limits.

Examples:

```text
max memory
max CPU
max execution duration
max media resources
cloud quota
social rate limit
NVIDIA circuit breaker
```

Limits must be machine-enforced where practical.

---

# 24. Locks and Concurrency

Multiple Agents may analyze the same project concurrently.

Mutable execution must be coordinated.

Critical writes require:

```text
LOCK
or
WRITE ARBITRATION
```

Two Agents must never unknowingly modify the same protected state simultaneously.

Parallel analysis is allowed.

Uncoordinated mutation is not.

---

# 25. Idempotency

The system must prevent accidental duplicate execution.

Tasks should have stable identifiers and execution records.

The system must detect:

- duplicate task submission;
- duplicate execution;
- retry after partial execution;
- orchestrator restart;
- stale locks;
- already-completed operations.

---

# 26. Failure and Rollback

Failure policy must be explicit.

If execution fails:

```text
FAILED
→ determine recovery
→ ROLLBACK_REQUIRED where applicable
→ ROLLED_BACK
or
→ ESCALATED
```

Rollback must not be claimed unless actually executed and validated.

---

# 27. Crash Recovery

The system must recover from:

- Agent crash;
- Runtime crash;
- Orchestrator crash;
- machine restart;
- interrupted execution;
- lost session;
- partial execution.

State must be recoverable from persistent state and evidence.

Conversation history must NOT be the sole source of operational truth.

---

# 28. Cleanup

Temporary execution resources must be cleaned according to policy.

Cleanup must include, where applicable:

- containers;
- temporary files;
- credentials;
- checkpoints;
- temporary networks;
- transient resources.

Cleanup itself requires validation where important.

---

# 29. Architecture vs Runtime

Workspace Standard defines:

```text
MEANING
AUTHORITY
GOVERNANCE
STATE
CONTRACTS
LIFECYCLE
EVIDENCE
VALIDATION
SECURITY
```

Runtime frameworks implement execution mechanics.

CrewAI may provide:

```text
Agents
Crews
Flows
Tasks
Delegation
Runtime orchestration
```

but must remain downstream of Workspace Standard.

CrewAI must never redefine Workspace Truth.

For stateful/event-driven orchestration, Flow-oriented mechanisms are preferred where appropriate.

---

# 30. Existing Workspace Engine

The current `lab-engine` is an implementation target, not an authority source.

Existing files such as:

```text
lab-engine/core/orchestrator.ps1
lab-engine/core/registry.yaml
lab-engine/governance/LAB-POLICIES.yaml
```

must be brought into conformance.

Existing placeholder behavior must not survive merely because it exists.

In particular, the architecture must eliminate:

- fake success;
- placeholder execution;
- missing validation;
- missing rollback;
- missing queue consumption;
- missing state recovery;
- missing integrity enforcement;
- unsupported engine fallback;
- hardcoded execution paths where inappropriate.

---

# 31. Compatibility Principle

Existing useful architecture and documentation must be preserved where compatible.

However:

```text
existing implementation
```

does not override:

```text
canonical architecture
```

If existing components contradict the Architecture Truth:

1. identify contradiction;
2. classify it;
3. propose correction;
4. implement correction;
5. validate;
6. document migration.

Do not silently preserve architectural contradictions.

---

# 32. Canonical Project Structure

The exact directory structure may evolve during implementation, but the final system must provide clear separation for:

```text
.agent/
    core-vocabulary
    agent-operating-contract
    decision-framework
    project-truth contract
    architecture truth
    agent definitions
    task contracts
    governance
    policies

projects/
    <project>/
        PROJECT-TRUTH.md
        PROJECT-STATE.yaml
        tasks/
        evidence/
        decisions/
        artifacts/

control-plane/
    authority
    state
    delegation
    locks
    evidence
    validation

agents/
    commander
    architect
    researcher
    critic
    executor
    validator

runtime/
    vscode
    continue
    crewai

engines/
    hyperv
    docker
    cloud
    nvidia
```

The implementation may choose a better physical layout if it preserves these architectural boundaries.

---

# 33. Architectural Invariants

The following are NON-NEGOTIABLE:

1. No Agent owns global authority.
2. No Agent may redefine Project Truth.
3. No execution without authorized scope.
4. No completion without validation.
5. No validation without evidence.
6. No unsupported engine fallback.
7. No silent scope expansion.
8. No self-granted authority.
9. No fake execution success.
10. No LLM response treated as execution evidence.
11. No uncontrolled concurrent mutation.
12. No security boundary enforced solely by prompt.
13. No runtime framework becomes source of truth.
14. No hidden state stored only in conversation history.
15. No placeholder implementation presented as complete.
16. No rollback claim without actual rollback evidence.
17. No integrity claim without actual verification.
18. No architectural decision silently changed by implementation.
19. Unknown must remain Unknown until resolved.
20. Failure must be observable and recoverable.

---

# 34. Final Architectural Objective

The finished Workspace Standard must make it possible to start a new project/session/agent and reconstruct the relevant operational context without relying on previous conversation.

Minimum bootstrap:

```text
Workspace Standard
+
Project Truth
+
Project State
+
Agent Definition
+
Task Contract
+
Governance/Policy
+
Required Evidence
```

This is the foundation for a reliable multi-agent autonomous workspace.

The system must be understandable by:

- humans;
- Claude Code;
- VS Code Agents;
- Continue;
- CrewAI;
- future agents;
- future runtimes.

The architecture is successful only when the implementation itself enforces the architecture it claims to implement.

---

# 35. Definition of Done

Architecture is NOT complete when documents exist.

Architecture is complete only when:

```text
DESIGN
+
IMPLEMENTATION
+
ENFORCEMENT
+
VALIDATION
+
ADVERSARIAL TESTING
+
RECOVERY TESTING
+
SECURITY TESTING
+
CONCURRENCY TESTING
+
EVIDENCE
```

all pass.

Final acceptance requires executable proof that the architecture behaves according to this document.
---
name: phase-2-architecture-specification
description: Phase 2 architecture specification: vocabulary layers, authority separation, decision gates, and context boundaries.
metadata:
  type: architecture
  phase: 2
  status: proposed
---

# Phase 2 Architecture Specification

## 1. Purpose and authority boundary

This document records the Phase 2 architectural proposal for the Workspace Standard. It is a reasoning artifact, not an authorization to implement or change project truth. Implementation remains downstream of the Workspace Control Plane and requires an explicitly authorized task contract.

The specification consolidates the Final Architecture Truth, `projects/workspace-standard/PROJECT-TRUTH.md`, the construction prompt/execution plan, and the existing `.agent/` vocabulary, operating-contract, decision-framework, and context/adapter documents. The Executive Summary and Executor Brief named by the execution plan are not present in this checkout; their expected principles are represented by the available canonical sources and must be reconciled if those documents are later supplied.

## 2. Extracted architectural invariants

The following are non-negotiable constraints for every implementation, runtime, agent, tool, and adapter:

1. **Multi-Agent != Multi-Authority.** Multiple agents, sessions, models, and runtimes may reason in parallel, but one governed authority model exists per workspace/project scope.
2. The Control Plane owns authority, policy, scope, state, locks, delegation, approval, execution admission, validation, evidence, and recovery. Agents are participants; runtimes are mechanisms; tools are capabilities; engines execute.
3. Project Truth is semantic authority and relatively stable. Project State is mutable operational state. No agent, runtime, prompt, or implementation may redefine Project Truth or the project mission.
4. Reasoning, recommendation, proposal, decision, approval, commit, execution, validation, evidence, and closure are distinct states. Capability or access never implies permission.
5. Every state-changing operation requires an explicit, scope-bound, action-bound authority and a machine-readable task contract. Silent scope expansion and self-granted authority are prohibited.
6. Execution is never completion: `EXECUTED -> VALIDATING -> VALIDATED -> COMPLETED`. No completion without validation; no validation without attributable evidence.
7. Evidence must be persistent, machine-observable, attributable, and sufficient for the claim. An agent/LLM statement is not execution evidence.
8. Unknown remains Unknown; declared is not observed or verified; assumptions remain explicit; conflicts require resolution or escalation.
9. No unsupported engine fallback, fake success, placeholder completion, hidden operational state in conversation history, or rollback/integrity claim without actual evidence.
10. Security boundaries require structural enforcement (least privilege, isolation, network/secret policy, resource limits, locks, audit, and recovery), not prompts alone.
11. Parallel analysis is allowed; uncoordinated mutation is not. Protected writes require locks or write arbitration and idempotent execution records.
12. Context and adapters inform interpretation and validation but do not define meaning, authority, decision logic, procedures, or implementation. Domain Context and Project Context remain distinct.
13. Lower layers may not redefine the meaning or authority of higher layers. Runtime frameworks remain downstream of Workspace Standard.
14. Failure must be observable and recoverable. Unresolved authority, scope, conflict, or evidence gaps cause `STOP -> ESCALATE` (or `NO-DECISION` where appropriate), not inference.

## 3. Layered architecture and ownership

```text
Core Vocabulary
  -> universal meaning
Professional Vocabulary
  -> engineering/project interpretation
Agent Operating Contract
  -> behavior, authority boundary, safety, escalation
Decision Framework
  -> decision formation and lifecycle
Context / Adapter Architecture
  -> Standard-to-context contract
Domain Context -> reusable domain reality
Project Context -> concrete project reality
Control Plane / Implementation
  -> authorized state change, enforcement, validation, evidence
```

Ownership is exclusive by layer:

- **Core Vocabulary:** semantic meaning; universal distinctions.
- **Professional Vocabulary:** professional usage and interpretation; never universal replacement or procedure.
- **Agent Operating Contract:** permitted behavior, tool/scope boundaries, evidence, escalation, and validation obligations.
- **Decision Framework:** how observations and context become a recommendation, proposal, decision, and closure; it does not grant permission.
- **Context/Adapter Architecture:** admission and translation of domain/project facts while preserving ownership; adapters are not executors.
- **Control Plane:** actual authority, approval, admission, locks, state transitions, and recovery.
- **Implementation/engines:** state-changing work only after authorization.

### 3.1 Core Vocabulary

Core terms include Truth, Live State, Desired State, Observed, Declared, Assumed, Unknown, Authority, Source of Truth, Evidence, Proof, Confidence, Constraint, Boundary, Validation, and Conflict. Mandatory distinctions include:

```text
Observed != Declared; Declared != Verified; Assumed != Known;
Desired State != Live State; Evidence != Proof; Truth != Assumption;
Reasoning != Authority; Recommendation != Decision; Proposal != Approval;
Approval != Execution; Execution != Validation; Validation != Evidence.
```

### 3.2 Professional Vocabulary

Professional terms such as Project Truth, Change Boundary, Ownership, Dependency, Risk, Mitigation, Impact Assessment, Acceptance Criteria, Drift, and Validation Context describe engineering usage. They may clarify context, but must not become authority grants, behavior rules, approval logic, or execution procedures.

## 4. Reasoning versus authorization

The Agent may inspect, observe, analyze, compare options, identify assumptions/unknowns, assess risk, recommend, and formulate a proposal. These are reasoning activities. They do not alter authoritative state and do not authorize themselves.

Authorization is an external governance result established by the Control Plane (with the applicable human/operator or approved authority). It is explicit, identity-bound, scope-bound, action-bound, policy-bound, time/state-bound, and recorded. Only authorization permits a state-changing execution attempt.

```text
Observe -> Understand -> Analyze -> Recommend -> Propose
         -> Decision (process state; not permission)
         -> Approval (authority event)
         -> Commit (record approved decision, when required)
         -> Execute -> Validate -> Evidence -> Close
```

A decision framework can produce `NO-DECISION`; it cannot manufacture approval. An approval cannot substitute for validation. A commit records an approved decision; it is not authorization by itself.

## 5. Explicit decision-gate requirements

Every executable task MUST expose gate results in persistent state/evidence. A gate is passable only when its required inputs are known, attributable, and within the active authority boundary. Failure, ambiguity, conflict, or missing evidence blocks progression.

| Gate | Required proof before transition | Required outcome / blocker |
|---|---|---|
| G0 Task admission | `task_id`, objective, assigned identity, project, task type, contract version | Reject unknown/ambiguous task; no execution authority is implied by queue admission. |
| G1 Truth alignment | applicable Project Truth, current Project State, relevant policy, task scope; no unresolved contradiction | `STOP -> CONFLICT -> ESCALATE` on mission/scope/truth conflict. |
| G2 Context and evidence | relevant sources classified by authority/status; observed, declared, assumed, unknown, and conflicts separated | Unknown stays Unknown; insufficient evidence yields `NO-DECISION` or escalation. |
| G3 Decision formation | options, constraints, risks/trade-offs, expected outcome, impact/reversibility, recommendation/proposal record | Proposal remains provisional; no state change. |
| G4 Authorization | explicit approval from the authorized Control Plane authority; actor, action, targets, scope, policy, expiry/state, and approval record | Missing, stale, or out-of-scope approval blocks execution. |
| G5 Preflight admission | contract and approval still valid; tool/engine permissions, resource limits, locks, network/secret policy, idempotency, rollback and validation plans verified | Reject unsupported engine or scope expansion; acquire lock/arbitrate before protected write. |
| G6 Execution | only the approved action in the approved boundary; machine-observable command/tool/engine record | Partial or failed execution is `FAILED`, not completed; preserve actual state. |
| G7 Validation | expected state compared with actual state; result and scope validation independent of model claim | Validation failure blocks closure and triggers recovery/reassessment. |
| G8 Evidence and closure | persistent attributable evidence: task, actor, operation, target, expected/actual result, validation, hashes/errors/policy checks | Close only after successful validation and sufficient evidence; otherwise remain open/escalated. |

Reassessment is mandatory when assumptions, evidence, constraints, actual state, or scope changes materially. A changed decision requiring new action must repeat the affected gates; prior approval does not silently extend.

## 6. Anti-authority controls

- Agent definitions MUST list authority, forbidden actions, tools, tool permissions, escalation, validation, and delegation permissions.
- Delegation is a Control Plane decision; an agent cannot create an agent or grant authority arbitrarily.
- Session identity, model confidence, tool availability, runtime role, document recency, filename, README prominence, or technical capability are never authority sources.
- The Control Plane MUST technically enforce task admission, scope, approval, locks, lifecycle transitions, and validation; prompts are guidance only.
- Runtimes (VS Code, Continue, CrewAI, or future clients) MUST consume canonical artifacts and MUST NOT redefine truth, policy, authority, state, or evidence semantics.
- Validators should be independently scoped from the action where practical. The executor's claim cannot validate its own success.

## 7. Context and adapter constraints

Adapters translate contextual facts into standard-readable context. They MUST declare domain/project level, owned facts, applied standard concepts, reusable versus project-specific facts, validation expectations, and drift controls. They MUST NOT contain authority grants, decision logic, execution procedures, scripts, or state-changing instructions.

Universal facts belong in the Standard; reusable domain reality in Domain Context; one-project facts in Project Context. Context is input to the Decision Framework, not a replacement for it.

## 8. Conformance and implementation handoff

A downstream implementation proposal is conformant only if it can demonstrate: explicit contracts and scopes; Control Plane authorization; technical gate enforcement; persistent state/evidence; independent validation; lock/idempotency behavior; unsupported-engine blocking; recovery/rollback behavior; and adversarial proof that agents cannot self-authorize or silently expand scope.

This specification authorizes no implementation. Any implementation task must cite this document and the applicable canonical truth, define its own scope and success criteria, obtain Control Plane approval, and produce validation evidence before closure.

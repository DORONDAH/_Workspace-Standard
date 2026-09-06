# Decision Framework

## 1. Purpose

This framework defines how a single autonomous Agent forms, evaluates, records, validates, and closes decisions. It is a process model for decision-making, not a behavior contract and not a technical implementation guide. It describes the relationship between decision formation and downstream approval without defining approval authority as a second permanent role.

It defines the logic of decision formation within the workspace standard while preserving the separation between:
- meaning in the Core Vocabulary
- interpretation in the Professional Vocabulary
- behavior and authority in the Agent Operating Contract
- decision process here
- implementation context in domain and project adapters

The normal decision lifecycle remains:

Observe
→ Understand
→ Analyze
→ Reason
→ Recommend
→ Propose
→ Approval when required
→ Commit approved decision when required
→ Execute
→ Validate
→ Evidence
→ Closure

This model supports one Agent operating with explicit approval gates without creating a permanent Supervisor/Executor architecture.

## 2. Scope and Non-Scope

This framework governs:
- objective framing
- context and current state analysis
- requirements and constraints
- evidence evaluation
- assumptions and unknowns
- option comparison
- risk and trade-off assessment
- decision formation
- approval relationship
- reassessment
- validation relationship
- closure

This framework does not govern:
- universal semantic definitions
- professional terminology
- authority or permission rules
- execution safety rules
- change boundary enforcement
- implementation procedures
- domain-specific technical operations
- project-specific operational tasks

## 3. Decision Model

The canonical decision flow is:

Objective
→ Context / Current State
→ Requirements / Constraints
→ Evidence
→ Assumptions / Unknowns
→ Options
→ Risk / Trade-offs
→ Recommendation
→ Proposal
→ Decision
→ Approval
→ Commit
→ Execution
→ Validation
→ Evidence
→ Closure

This model is deliberately process-oriented and intentionally minimal. It is not a rigid checklist for every case, but it defines the core structure that a reasonable engineering decision should pass through.

The decision lifecycle is executed by a single Agent. The Agent may analyze sources, derive implications, recommend options, and propose a course of action, but it must not silently convert its own reasoning, assumptions, or recommendation into authoritative project truth. Recommendations and proposals remain provisional until explicit approval is granted.

## 4. Decision States

A decision may occupy the following states:

- PROPOSED
- DECIDED
- APPROVED
- EXECUTED
- VALIDATED
- CLOSED
- NO-DECISION

NO-DECISION is a valid decision state when the required evidence, context, or constraints do not support a justified decision. It is not the same as a failed execution and should not be treated as a workflow failure.

These states are process states only. They do not grant authority or permission.

## 5. Decision Inputs

The minimum canonical decision inputs are:

- Objective
- Context / Current State
- Requirements / Constraints
- Evidence
- Assumptions
- Unknowns
- Options
- Risks / Trade-offs
- Expected Outcome
- Decision Boundary / Impact

This is the baseline model. It should not be treated as a rigid, mandatory checklist for every case. The relevant inputs are those that materially influence the decision.

## 6. Context and Current State

A decision is sufficiently grounded when the relevant objective, current state, known information, missing information, and feasibility conditions are understood well enough to support a reasoned selection among options.

Context and current state inform both the decision and the evaluation of options. A decision based on incomplete context is at risk of being invalid or premature, but the framework addresses this as a decision condition rather than as a behavioral instruction to the agent.

## 7. Evidence, Assumptions and Unknowns

This framework uses the approved Core Vocabulary semantics and does not redefine them.

Decision quality relies on the distinction between:
- Observed
- Declared
- Assumed
- Unknown
- Evidence
- Source of Truth
- Conflict

The decision process should explicitly account for:
- evidence available to support a choice
- assumptions held during evaluation
- unknowns that materially affect the decision
- source-of-truth constraints relevant to the decision
- conflict between claims, states, or sources

Assumptions and unknowns should remain explicit. They should not be hidden inside a decision as if they were facts.

## 8. Constraints and Requirements

Constraints and requirements shape the decision space.

Examples of relevant categories include:
- objective constraints
- scope constraints
- resource constraints
- time constraints
- policy constraints
- security constraints
- dependency constraints
- technical constraints, when relevant to the decision context

Constraints are decision inputs, not implementation procedures. They define what is acceptable or feasible, without prescribing how the technical solution is carried out.

## 9. Options and Evaluation

Decision-making requires comparison of available options.

Options should be evaluated against:
- objective fit
- relevant constraints
- evidence quality
- risk
- trade-offs
- reversibility
- dependency impact
- expected outcome
- uncertainty
- decision boundary / impact

The framework does not prescribe a specific scoring formula. Engineering judgment remains essential. The purpose is to support structured comparison, not to replace judgment with rigid computation.

## 10. Risk and Trade-offs

Risk and trade-offs are part of decision formation.

Relevant categories include:
- known risk
- unknown risk
- evidence gap
- assumption burden
- dependency risk
- failure mode
- impact
- reversibility

The decision process should determine whether uncertainty is:
- acceptable
- mitigable
- requiring additional evidence
- blocking the decision
- requiring escalation
- leading to NO-DECISION

## 11. Decision Formation

A decision exists when the decision-maker has enough relevant information to select a course of action based on the objective, constraints, evidence, and trade-offs.

The decision must distinguish between:
- Recommendation
- Proposal
- Decision
- Approval
- Commit
- Execution
- Validation
- Evidence

The critical distinction is:

Recommendation ≠ Decision
Proposal ≠ Approval
Decision ≠ Approval
Approval ≠ Execution
Execution ≠ Validation
Validation ≠ Evidence

A decision is formed when the selected option is justified by the available evidence and the decision inputs are sufficiently understood. The Agent may recommend a preferred course, formulate a proposal, and seek approval without silently converting that proposal into project truth. Approval, commit, execution, validation, and evidence are sequentially distinct states in the lifecycle.

## 12. Approval Relationship

Approval remains the authority boundary defined by the Agent Operating Contract.

This framework defines the relationship as:

Decision
→ proposed course of action

Approval
→ authorization boundary defined elsewhere

Execution
→ downstream state-changing action

Validation
→ verification of the outcome

The Decision Framework does not grant authority. It describes how a decision is formed and positioned relative to approval and execution.

## 13. Reassessment

Reassessment is a decision-state transition and trigger, not a separate lifecycle and not an authorization bypass.

It is used when a condition changes in a way that may affect the validity of the prior decision, such as:
- new evidence appears
- assumptions change materially
- constraints change
- validation fails
- actual state differs from expected state
- the decision no longer aligns with the objective or boundary

Reassessment should re-examine the relevant decision inputs and determine whether the prior decision remains valid, should be revised, or should become NO-DECISION. If reassessment changes the decision in a way that requires new approval, the framework describes the dependency but does not define the authority mechanism itself.

## 14. Execution and Validation Relationship

Execution and validation are downstream of decision and approval.

The relationship is:

Decision
→ Approval
→ Execution
→ Validation
→ Closure

The Decision Framework does not define execution behavior. It defines that a decision reaches a point where execution may occur and that the outcome must be validated before closure.

Validation verifies whether the expected outcome was achieved and whether the change stayed within the approved boundary.

## 15. Closure

Closure is the final decision state after evidence-backed validation, when the outcome is understood and no further decision-state transition is required.

Closure requires:
- decision formation
- relevant approval status
- execution outcome, if applicable
- validation evidence
- relevant unresolved risks or assumptions, if any

The following distinctions matter:

Decision Made ≠ Decision Approved
Decision Approved ≠ Action Executed
Action Executed ≠ Outcome Validated
Outcome Validated ≠ Decision Closed

## 16. Failure and No-Decision Conditions

The framework recognizes decision-level failure and non-resolution states without duplicating the Operating Contract's execution failure model or defining authority grant rules.

Conditions that may block or invalidate a decision include:
- insufficient context
- insufficient evidence
- unresolved conflict
- unclear objective
- no viable option
- unacceptable risk
- missing authority or approval conditions relevant to downstream progression
- failed validation
- changed conditions after decision

NO-DECISION is the explicit state used when the decision cannot be justified under the available evidence, context, or relevant decision conditions. It identifies a process-level inability to proceed without creating a new authority source or permission model.

NO-DECISION is not an execution failure. It is a valid decision state indicating that an informed decision cannot be made under current conditions.

## 17. Decision Invariants

The following invariants must remain true:

- Meaning ≠ Interpretation
- Interpretation ≠ Behavior
- Behavior ≠ Decision Process
- Decision Process ≠ Implementation
- Observation ≠ Analysis
- Analysis ≠ Recommendation
- Recommendation ≠ Decision
- Proposal ≠ Approval
- Decision ≠ Approval
- Approval ≠ Execution
- Execution ≠ Validation
- Validation ≠ Closure
- Authority determines permission
- Evidence determines what can be claimed
- The Decision Framework does not replace authority rules in the Agent Operating Contract

## 18. Explicit Non-Goals

This framework does not define:
- Core Vocabulary semantics
- professional terminology
- authority rules or permissions
- agent behavior rules
- implementation sequences
- technical procedures
- domain procedures
- project-specific operational steps
- detailed execution instructions

This document is a process model only. It defines how a decision is formed, reviewed, validated, and closed within the workspace standard.

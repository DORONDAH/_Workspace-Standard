# Professional Vocabulary

## 1. Purpose and Scope

This document defines the professional and engineering interpretation of terms used within the workspace standard. It explains how these concepts are used in project and engineering contexts without redefining the universal meaning layer defined in the Core Vocabulary.

This layer is intentionally not a behavior contract, not a decision framework, and not an implementation guide. It describes professional usage, not mandatory procedure.

## 2. Relationship to Workspace Vocabulary Layers

- Core Vocabulary defines universal meaning.
- Professional Vocabulary explains how meaning is used in engineering and project work.
- Agent Operating Contract defines how the agent must behave.
- Decision Framework defines the lifecycle and logic of decision-making.
- Domain and Project Adapters provide context-specific interpretation and implementation boundaries.

The professional layer must remain descriptive and contextual. It should answer: "How is this term used professionally in project work?" It must not answer: "What must the agent do?" or "What is the universal definition of the concept?"

## 3. Professional Interpretation Principles

1. Professional vocabulary is interpretation, not semantic replacement.
2. Core definitions remain authoritative for meaning.
3. Professional terms may explain how a concept applies to engineering, operations, and project work.
4. The professional layer must not prescribe workflow, approval logic, or execution sequence.
5. Terms should be framed as usage patterns, context, and project understanding rather than as mandatory operating rules.

## 4. Project and State Interpretation

### Project Truth
**Professional meaning:** The approved project-level interpretation of the intended objective, scope, constraints, requirements, and decisions that define the project as it is understood and accepted for execution.

**Why this belongs here:** It describes how a project team treats an approved target state in a working context, without redefining the universal meaning of Truth or Desired State.

**Relationship to Core Vocabulary:**
- It is not a replacement for Truth.
- It is not the same as Source of Truth.
- It is not identical to Desired State.
- It is an approved project interpretation used inside a governed project context.

**What it does not mean:**
- a universal truth statement
- a semantic replacement for Authority
- a standalone source of fact
- a project-wide declaration without approval

### Change Boundary
**Professional meaning:** The practical project-level scope of artifacts, systems, files, or environments that are considered in-scope for a defined change or decision context.

**Why this belongs here:** It provides project interpretation of Boundary and scope without acting as approval logic or execution policy.

**Relationship to Core Vocabulary:**
- It does not redefine Boundary as a universal semantic concept.
- It explains how boundaries are understood in a project environment.

**What it does not mean:**
- execution permission
- operational authorization
- agent behavior rule
- approval procedure

### Drift
**Professional meaning:** A measurable or observed deviation between the approved project expectation and the current or actual state.

**Why this belongs here:** It is a project and engineering concept used to describe differences between expected and observed conditions.

**Relationship to Core Vocabulary:**
- It is related to Desired State and Live State.
- It is not a replacement for them.

**What it does not mean:**
- a remediation process
- a required action
- a universal state category

## 5. Ownership, Scope, and Change Concepts

### Ownership
**Professional meaning:** The responsibility, accountability, or authority association that explains who or what is considered responsible for an artifact, system, or domain within a project or operating context.

**Why this belongs here:** Ownership is a project and engineering concept used to reason about accountability, responsibility, and scope.

**Relationship to Core Vocabulary:**
- It builds on the idea of Boundary and Authority.
- It does not replace either concept.

**What it does not mean:**
- a mandatory agent rule
- a requirement to modify or restrict access
- an instruction about execution behavior

## 6. Risk, Dependency, and Impact Concepts

### Dependency
**Professional meaning:** A relationship in which one element, task, state, requirement, or system depends on another element or condition to be valid, complete, or usable.

**Why this belongs here:** Dependencies are a standard engineering concept used in planning, design, and reliability analysis.

**Relationship to Core Vocabulary:**
- It relates to Constraint and Boundary concepts but does not replace them.
- It is not an implementation orchestration model.

**What it does not mean:**
- a workflow engine
- an execution sequence
- a technical orchestration specification

### Risk
**Professional meaning:** The potential for a project, system, or decision to experience negative impact, uncertainty, or failure based on known conditions or assumptions.

**Why this belongs here:** Risk is a project and engineering concept used to assess consequences and uncertainty.

**Relationship to Core Vocabulary:**
- It is related to Unknown, Assumed, Confidence, and Conflict.
- It does not replace them.

**What it does not mean:**
- a mandatory risk process
- a scoring procedure
- a required execution step

### Mitigation
**Professional meaning:** A planned action, design choice, or control intended to reduce exposure, uncertainty, or negative impact associated with a risk or constraint.

**Why this belongs here:** Mitigation is a professional engineering concept used in planning and design.

**Relationship to Core Vocabulary:**
- It relates to Constraint and Risk.
- It does not govern behavior or execute actions by itself.

**What it does not mean:**
- a procedural instruction
- a universal required response
- an implementation sequence

### Impact Assessment
**Professional meaning:** The assessment of likely consequences, trade-offs, or downstream effects of a change, decision, or condition.

**Why this belongs here:** This is a core project and engineering interpretation concept used in governance and planning.

**Relationship to Core Vocabulary:**
- It relates to Risk, Boundary, and Decision context.
- It does not define the decision lifecycle.

**What it does not mean:**
- a decision process by itself
- a replacement for the Decision Framework
- an approval action

## 7. Validation and Acceptance Concepts

### Acceptance Criteria
**Professional meaning:** The conditions, thresholds, or criteria that define whether a result, deliverable, or state is considered acceptable for a given purpose or standard.

**Why this belongs here:** It is a professional project concept used to define success conditions and review outcomes.

**Relationship to Core Vocabulary:**
- It relates to Validation and Proof but does not redefine either concept.
- It does not replace Truth or evidence semantics.

**What it does not mean:**
- a universal truth statement
- a synonym for Proof
- a validation procedure in itself

### Validation Context
**Professional meaning:** The project-specific framing used to understand what is being validated, against which expectation, and with what standard or evidence.

**Why this belongs here:** It is valuable as a professional interpretation concept when the standard is applied in engineering work.

**Relationship to Core Vocabulary:**
- It relies on Validation and Evidence.
- It does not redefine the universal semantics of validation.

**What it does not mean:**
- a procedural workflow
- a validation mandate
- a replacement for the Core definition

## 8. Glossary / Quick Reference

- Project Truth — approved project-level interpretation of the intended state and decisions
- Ownership — responsibility and accountability for artifacts or systems
- Dependency — relationship between elements, states, or requirements
- Risk — potential for negative consequence or uncertainty
- Mitigation — action or design response intended to reduce exposure
- Acceptance Criteria — conditions for deciding whether a result is acceptable
- Drift — deviation between expected state and actual state
- Impact Assessment — evaluation of likely consequences
- Change Boundary — project scope of what falls within a defined change context
- Validation Context — the project framing used to validate against a defined standard

## 9. Explicit Non-Goals and Exclusions

This document does not define:

- universal meaning of Truth, Authority, Evidence, Proof, Validation, Boundary, or Source of Truth
- mandatory agent behavior
- must / must not operating rules
- approval workflow
- execution sequence
- decision lifecycle
- implementation architecture
- domain-specific engineering requirements
- project-specific factual claims
- project adapter behavior
- domain adapter semantics

This file is therefore a professional vocabulary layer, not a behavioral, architectural, or implementation specification.

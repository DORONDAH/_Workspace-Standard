# Project Adapter

## 1. Purpose

The Project Adapter is the minimal architectural layer that adapts and structures concrete project reality for project-specific architectural realization.

Its purpose is to occupy the narrow boundary between:

```text
Project Context
→ what is true about the project

Project Adapter
→ how that project reality is structurally adapted toward realization

Implementation
→ how the adapted structure is actually realized
```

The Project Adapter does not redefine project facts, domain meaning, authority, or execution. It preserves the project reality described by Project Context and structures that reality into a project-aligned form for downstream realization.

## 2. Role

The Project Adapter defines the project-level adaptation boundary between concrete project reality and downstream realization.

It is the minimal architectural layer that:
- receives the concrete project reality described by Project Context
- adapts that reality into a project-aligned structural form
- preserves project boundaries and project-specific context
- prepares the reality for downstream realization without becoming implementation

The Project Adapter is not a generic connector, system integration layer, workflow engine, execution bridge, deployment layer, orchestration layer, or technical integration abstraction.

## 3. Project-Level Adaptation

The Project Adapter adapts concrete project reality in a structural way.

This adaptation includes:
- project-reality framing
- project-specific boundary preservation
- project-level structural alignment
- adaptation of concrete project conditions toward realization
- project-specific structural preparation for downstream realization

This is not domain-level adaptation. It is project-level structural adaptation of project reality.

## 4. Input Boundary

The Project Adapter receives the concrete project reality that is recorded by Project Context.

```text
Project Context
→ records and relates concrete project reality

Project Adapter
→ adapts and structures that project reality for project-specific architectural realization
```

Project Context is the source of project facts and conditions. The Project Adapter does not absorb those facts, own them, or redefine them.

It takes project reality as input and structures it for subsequent realization.

## 5. Output Boundary

The Project Adapter outputs a project-aligned structural representation for downstream realization.

```text
Project Adapter
→ project-level adaptation / structural realization framing

Implementation
→ realizes the resulting project-aligned structure
```

The output is architectural and structural, not operational.

It does not include:
- commands
- scripts
- APIs
- deployment instructions
- operational workflows
- execution logic
- automation logic

## 6. Relationship to Domain Adapter

The Domain Adapter and Project Adapter are distinct layers.

```text
Domain Adapter
→ adapts reusable domain reality

Project Adapter
→ adapts concrete project reality
```

The Domain Adapter preserves reusable domain reality and provides domain-level structural framing.

The Project Adapter preserves concrete project reality and provides project-level structural realization framing.

The Project Adapter does not redefine Domain Context, duplicate the Domain Adapter, or interpret domain meaning in a new way.

## 7. Relationship to Project Context

Project Context records and relates concrete project reality.

Project Adapter adapts and structures that reality for project-specific architectural realization.

```text
Project Context
→ what is true about the project

Project Adapter
→ how that project reality is structurally adapted toward realization
```

The Project Adapter must not:
- own project facts
- redefine project facts
- become a Project Context repository
- absorb Project Context
- modify Project Context meaning

## 8. Relationship to Implementation

Project Adapter is not Implementation.

```text
Project Adapter
→ structural realization framing

Implementation
→ downstream realization
```

Implementation represents the actual realization of the adapted structure.

The Project Adapter remains upstream of that realization and does not perform or define implementation behavior.

## 9. Decision / Authority Boundary

Project Adapter must not become:
- Decision Framework
- authority mechanism
- approval mechanism
- permission mechanism
- governance layer
- policy engine

```text
Decision Framework
→ decision process

Agent Operating Contract
→ behavior / authority / boundaries

Project Adapter
→ project-level adaptation / structural realization framing
```

Project Adapter does not decide, authorize, approve, or establish governance. It only adapts project reality into a realizable project-aligned structure.

## 10. Minimum Responsibility

The minimum valid responsibility of the Project Adapter is:

```text
project-level adaptation and structural framing of concrete project reality for downstream architectural realization
```

This responsibility exists because:

```text
Project Context
→ records reality

Project Adapter
→ structurally adapts that reality toward realization

Implementation
→ realizes it
```

No responsibility broader than this is justified for the Project Adapter. A broader abstraction would drift into technical integration, procedure, execution, or implementation.

## 11. Non-Responsibilities

The Project Adapter does not own or perform:
- decision
- authority
- approval
- procedure
- execution
- implementation
- deployment
- automation
- technical integration
- API behavior
- command generation
- script generation
- operational orchestration
- governance
- project fact ownership
- domain meaning redefinition

The Project Adapter is not a generic connector, technical integration layer, execution bridge, workflow engine, orchestration engine, or deployment bridge.

## 12. Architectural Invariants

```text
Domain Adapter ≠ Project Adapter
Project Context ≠ Project Adapter
Project Adapter ≠ Implementation

Context ≠ Authority
Context ≠ Decision
Context ≠ Procedure

Adapter ≠ Execution

Meaning ≠ Structural Framing
Structural Framing ≠ Meaning Redefinition
```

These invariants preserve the distinction between:
- meaning
- context
- project reality
- project-level adaptation
- implementation

## 13. Boundary Risks

The Project Adapter risks drifting toward an overly generic or operational abstraction if it is described as:
- a generic connector
- an integration mechanism
- a technical integration layer
- a workflow engine
- a deployment bridge
- an execution bridge
- a translation engine between arbitrary systems

These risks are resolved by keeping Project Adapter narrowly focused on:
- project reality adaptation
- project-level structural framing
- project-specific architectural realization alignment
- boundary preservation

## 14. Minimal Architectural Form

The minimal valid architectural form is:

```text
Project Context
      ↓
Project Adapter
      ↓
Implementation
```

with the following responsibility:

```text
Project Adapter =
project reality adaptation
+ project-level structural framing
+ project-specific architectural realization alignment
+ boundary preservation
```

This form remains minimal and does not introduce a new layer, contract layer, mapping layer, execution layer, or deployment layer.

## 15. Summary

The Project Adapter is the minimal architectural layer that adapts and structures concrete project reality for project-specific architectural realization.

It is distinct from:
- Project Context, which records what is true about the project
- Domain Adapter, which adapts reusable domain reality
- Implementation, which realizes the adapted structure

It does not own project facts, does not define decisions or authority, does not define procedure, and does not perform execution or implementation.

It remains a structurally bounded layer for project-level adaptation and realization framing only.

## 16. Project Target Mechanism

Project Target is a project-level specification mechanism, not a new architectural layer.

It exists to define a bounded realization unit that is downstream of Project Context and Project Adapter, but upstream of Implementation.

```text
Project Objective
    ↓
Project Target
    ↓
Implementation
    ↓
Validation
    ↓
Evidence
```

The Target mechanism must remain generic and project-agnostic at the Standard level.

### 16.1 Universal Contract

A Target defines the minimum reusable contract for a project-bounded realization unit without forcing domain-specific structure into the Standard.

At minimum, the Target may contain:
- target identity
- purpose
- target boundary / scope
- explicit exclusions
- intended / expected resulting state
- target-specific success criteria
- dependencies / prerequisites
- implementation constraints when explicitly defined
- approval state
- traceability to validation and evidence

A Target must describe:
- what is being realized
- what is not being realized
- what resulting state is intended
- what evidence will establish completion

It must not become an implementation procedure.

### 16.2 Universal vs Project-Specific Content

The Standard defines the universal Target contract.

The project defines the project-specific content associated with that Target.

This distinction is:

```text
Universal Contract
→ generic structure and required fields

Project-Specific Content
→ actual objective, bounds, evidence, and validation conditions
```

The Universal Contract may be reused across project types without forcing a fixed taxonomy.

### 16.3 Target Boundaries

The Target must be narrow enough that the Executor can determine:
- what is being realized
- what is not being realized
- what state is intended
- what evidence proves completion

The Target boundary comes from the project specification and the approved project context. It must not be expanded by assumption.

### 16.4 Target vs Implementation

The Target is the upstream specification for implementation.

```text
Target
→ WHAT must be achieved

Implementation
→ HOW it is technically realized
```

A Target must not become a command list, execution recipe, deployment procedure, or technical implementation guide.

### 16.5 Validation and Evidence Traceability

A valid Target links:

```text
Target
→ Validation Criteria
→ Validation Result
→ Evidence
```

Validation proves the Target's intended state. Evidence supports the validation claim.

The Target must not be considered complete merely because a command succeeded or an action occurred. Completion requires evidence aligned to the target's validation criteria.

### 16.6 Dependency Model

Targets may declare dependency relationships when required.

The minimal model is simple and declarative:

```text
Target A
→ prerequisite
→ Target B
```

This allows bounded ordering without forcing a full workflow engine or task-management taxonomy.

### 16.7 Approval and Authorization Model

Approval applies to individual Target realization.

The required distinction remains:

```text
Project approval
≠
Target implementation approval
```

A Target may be defined without being immediately authorized for implementation.

### 16.8 Anti-Invention Controls

The Target mechanism must preserve:
- no unstated requirement
- no inferred scope expansion
- no invented acceptance criteria
- no invented dependencies
- no invented success conditions

Unknown remains unknown. Ambiguous remains ambiguous.

### 16.9 Implementation Safety

The Target mechanism remains a specification boundary, not an execution mechanism.

The invariant remains:

```text
Project Target ≠ Implementation
Target ≠ Procedure
Specification ≠ Implementation
```

This preserves the approved architecture while enabling bounded, reusable project-level definitions.

### 16.10 DNS-Lab-001 Status

The generic Target mechanism is available for use by projects, but a concrete Target for DNS-Lab-001 remains dependent on a specific, approved first realization step. The existing project materials define the objective and validation intent, but they do not yet specify a single first concrete target without invention.

Therefore the mechanism is engineering-ready, while the concrete DNS-Lab-001 target remains pending explicit specification.

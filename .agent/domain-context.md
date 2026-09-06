# Domain Context

## 1. Purpose

This document defines the minimum reusable domain contextual model for the workspace standard.

It defines the reusable domain reality that is intrinsic to a domain and independent of a specific project instance. Its purpose is to represent the contextual facts, constraints, assumptions, and validation expectations that are relevant to a domain without turning the architecture into a knowledge base, authority layer, decision framework, or implementation guide.

The domain context layer exists to make domain reality reusable without absorbing project reality or operational execution.

## 2. Architectural Role

The approved architecture is:

```text
Context / Adapter Architecture
        ↓
Domain Context
        ↓
Domain Adapter
        ↓
Project Context
        ↓
Project Adapter
        ↓
Implementation
```

Domain Context is the first reusable contextual layer beneath the approved boundary contract.

It is intentionally not:
- a general domain knowledge base
- authority or permission logic
- a decision framework
- a procedure specification
- an implementation guide
- a project context model
- a domain adapter
- a project adapter

A formal contract or specification may exist inside Domain Context when required, but it remains part of this layer and not a separate architectural layer.

## 3. Definition

Domain Context is the minimum reusable domain contextual model.

It is the reusable representation of domain reality that is:
- reusable
- intrinsic to the domain
- independent of a specific project

It can represent the contextual structure and constraints that remain valid across multiple projects within the same domain, without binding those facts to a particular project environment, implementation, or operational procedure.

Domain Context is not a catch-all repository of every possible domain fact. It is restricted to the minimal domain context needed to reason about the domain in a reusable and structurally correct way.

## 4. Scope

This document may define:
- what Domain Context is
- what makes information domain-level rather than project-level
- domain boundaries
- reusable domain facts
- reusable domain assumptions
- reusable domain constraints
- domain entities / concepts
- domain relationships
- domain dependencies
- domain validation expectations
- domain evidence expectations
- mapping between Standard concepts and domain reality
- relationship between Domain Context and Project Context
- internal contract/specification requirements for Domain Context
- drift controls
- conditions for domain-context validity

## 5. Non-Scope

This document does not define:
- Authority
- Permissions
- Approval Rules
- Agent Behavior
- Decision Lifecycle
- Implementation Procedures
- Commands
- Scripts
- APIs
- Automation
- Deployment Steps
- Infrastructure Configuration
- DNS Configuration
- Validation Procedures
- Execution Sequences
- Project Configuration
- Project-specific Facts
- Concrete Domain Adapter
- Concrete Project Adapter

Domain Context is:
- CONTEXTUAL + STRUCTURAL
not:
- OPERATIONAL + EXECUTIONAL

## 6. Relationship to Existing Layers

### Core Vocabulary
Domain Context uses the approved meaning defined in the Core Vocabulary. It does not redefine universal meaning.

### Professional Vocabulary
Domain Context may use approved professional interpretation. It must not create an alternate professional vocabulary.

### Agent Operating Contract
Domain Context does not grant authority or permission. It does not define:
- what the agent may do
- when the agent may act
- who may approve

### Decision Framework
Domain Context may provide:
- facts
- constraints
- dependencies
- evidence context
- decision-relevant conditions

It does not own:
- decision process
- decision authority
- approval
- execution gate
- validation procedure as a process

### Context / Adapter Architecture
This remains the governing boundary contract between the Standard and contextual information.

Domain Context is the first reusable contextual layer within that contract.

## 7. Domain Context Boundary

The Domain Context boundary is defined by the following rule:

Domain Context =
Reusable
+
Intrinsic to the Domain
+
Independent of a Specific Project

This means that a piece of information qualifies as Domain Context only when all three are true:

1. It is reusable across multiple project instances within the same domain.
2. It is intrinsic to the domain, not merely convenient to one project.
3. It is not dependent on one specific project environment or implementation structure.

If a fact is merely reusable because it is an implementation pattern, a deployment arrangement, or a project structure, it does not qualify as Domain Context by default.

## 8. Domain vs Project Boundary

The distinction is:

```text
Domain Context
= reusable domain reality

Project Context
= concrete project reality
```

A domain-level fact is one that remains structurally relevant across multiple projects in the same domain.

A project-level fact is one that is only true because of a specific project, environment, deployment, or current instance.

The classification rule is:
- if it is reusable and intrinsic to the domain, it belongs to Domain Context
- if it is specific to one project instance, it belongs to Project Context
- if it is universal and foundational, it belongs to the Standard

## 9. Domain Information Model

The minimum reusable domain information model is:

- domain identity
- domain scope
- domain assumptions
- domain constraints
- domain entities / concepts
- domain relationships
- domain dependencies
- domain validation expectations
- domain evidence expectations
- domain boundary conditions
- domain-to-standard mapping

This model is intentionally minimal. It does not expand into a general domain knowledge base.

## 10. Domain Fact / Assumption / Constraint Model

Domain Context may distinguish between:
- domain facts
- domain assumptions
- domain constraints
- domain dependencies
- domain evidence
- domain unknowns
- domain relevance boundaries

This distinction is contextual and structural. It is not a replacement for the Core Vocabulary or a restatement of it.

The purpose is to specify how domain-level reality is represented without redefining the universal meaning layer.

## 11. Evidence and Validation Model

Domain Context may define:
- what evidence is relevant to the domain
- what makes a domain claim sufficiently supported
- what kinds of evidence are acceptable for a domain-level fact
- what domain validation expectations apply broadly to domain claims

Domain Context may not define:
- commands
- tools
- scripts
- APIs
- automation
- execution sequences
- validation procedures
- operational workflows

Validation procedure and execution are outside the domain-context layer.

## 12. Standard-to-Domain Mapping

The mapping is:

```text
Standard
    ↓
Context / Adapter Architecture
    ↓
Domain Context
    ↓
Project Context
```

The Standard remains authoritative for meaning and governance.

Domain Context applies that meaning to a reusable domain reality.

Project Context applies the domain context to a concrete project reality.

The mapping must remain structural and contextual. It must not become operational guidance or execution logic.

## 13. Internal Contract / Specification

A formal contract or specification may exist inside Domain Context when required for clarity, but it is not an independent architectural layer.

The contract may define:
- Purpose
- Scope
- Inputs
- Outputs
- Ownership
- Boundaries
- Required Context
- Allowed Context
- Forbidden Content
- Domain Facts
- Domain Assumptions
- Domain Constraints
- Evidence Expectations
- Validation Expectations
- Mapping Rules
- Drift Controls
- Non-Goals
- Invariants

This is a specification for the Domain Context layer, not a new layer above it.

## 14. Domain Context vs Domain Adapter

The required distinction is:

```text
Domain Context
→ reusable domain reality

Domain Adapter
→ domain adaptation / connection mechanism
```

Domain Context describes what the domain consists of at a reusable contextual level.

Domain Adapter describes how that domain context is adapted or connected to the approved architecture.

Domain Adapter does not:
- absorb Project Context
- become a project-specific connector
- define implementation logic
- define project execution
- become a project adapter

At this stage, Domain Adapter is conceptual only and not implemented.

## 15. Domain Context vs Project Context

The distinction is:

```text
Domain Context
→ reusable and intrinsic to the domain

Project Context
→ concrete and specific to the project
```

Project Context is not the same as Domain Context and must not be absorbed into it.

Rules:
- if the fact is intrinsically domain-level and reusable, it belongs to Domain Context
- if the fact is specific to one project or environment, it belongs to Project Context
- if the fact is universal and foundational, it belongs to the Standard

## 16. Reusability Rules

The reusability test is:

```text
Reusable
+
Intrinsic to the Domain
+
Independent of a Specific Project
```

Only content meeting all three conditions belongs in Domain Context.

Content that is merely reusable because of:
- project structure
- deployment arrangement
- environment-specific layout
- implementation pattern
- current operational choices

does not automatically qualify as Domain Context.

## 17. Drift Controls

This layer must maintain contextual governance only.

Drift controls include:
- no semantic redefinition
- no authority creation
- no decision process duplication
- no implementation guidance
- no project contamination
- no adapter contamination
- no execution procedure leakage
- no validation procedure leakage

The goal is to keep Domain Context informative and structurally reusable, not operational.

## 18. Alternatives

### Option A — Single Domain Context Document
This is the simplest and most minimal option.

Advantages:
- clear ownership
- minimal abstraction cost
- low complexity
- easy to maintain

Disadvantages:
- may become dense if the domain is broad

### Option B — Domain Context plus formal internal specification section
This remains within the same layer and is the preferred model if stronger structure is needed.

Advantages:
- keeps contract within the layer
- avoids creating an independent architectural layer
- preserves minimal abstraction

Disadvantages:
- requires careful documentation discipline

### Option C — Independent Domain Context Contract layer
Not approved.

This would create a separate architectural layer without a verified unique responsibility.

The approved model is not to create a new layer named Domain Context Contract.

## 19. Risks

The main risks are:
- over-expanding Domain Context into a general domain knowledge base
- project-specific facts being treated as reusable domain facts
- validation expectations being converted into procedural validation steps
- accidental authority or decision logic leakage
- accidental project contamination
- accidental adapter contamination
- premature domain-model complexity before a concrete domain case is approved

## 20. Proposed Artifact Structure

Approved artifact to be created:

```text
.agent/domain-context.md
```

This artifact is the approved future structure.

Not approved at this stage:
- .agent/domain-context-spec.md
- .agent/domain-adapter-contract.md
- domain-adapter
- project-context
- project-adapter

## 21. Architectural Invariants

The following invariants remain mandatory:

```text
Meaning ≠ Interpretation
Interpretation ≠ Behavior
Behavior ≠ Decision Process
Decision Process ≠ Implementation

Context ≠ Authority
Context ≠ Decision
Context ≠ Procedure
Context ≠ Implementation

Domain Context ≠ Project Context
Domain Adapter ≠ Project Adapter

Contract ≠ Architectural Layer
Specification ≠ Implementation

Observation ≠ Analysis
Analysis ≠ Recommendation
Recommendation ≠ Decision
Decision ≠ Approval
Approval ≠ Execution
Execution ≠ Validation
Validation ≠ Closure

Permission to reason ≠ Permission to change state
```

## 22. Open Design Decisions

The following design decisions remain open and must not be prematurely resolved:
- Single Artifact vs Multiple Artifacts
- Embedded Contract vs Separate Specification Artifact
- Single Domain Family vs Multiple Domains
- Minimal Contract Structure vs Formal Contract Structure

These remain open unless an explicit architectural dependency later justifies a specific choice.

## 23. Execution Status

Execution Status:
NOT AUTHORIZED

## 24. Executor Recommendation

RECOMMENDATION:
READY FOR SUPERVISOR APPROVAL

This recommendation applies only to the approved design of the Domain Context artifact itself, not to execution authorization beyond the approved artifact creation step. The design remains within the approved architectural boundary and does not authorize downstream implementation work.

# Context / Adapter Architecture

## 1. Purpose

This document defines the architectural contract between the reusable Workspace Standard and contextual information.

The completed standard layers define universal meaning, professional interpretation, agent behavior and authority boundaries, and the decision process. They do not define how contextual facts are admitted into the system, how domain reality is separated from project reality, or how future adapters are expected to interface with the Standard.

This phase establishes the missing boundary layer:

```text
Standard
    ↓
Context / Adapter Architecture
    ↓
Domain Context
    ↓
Project Context
```

The purpose of this architecture is to preserve ownership and boundary integrity while allowing contextual information to inform project work without redefining the standard itself.

## 2. Architectural Position

The approved architecture remains:

```text
Core Vocabulary
→ Universal Meaning

Professional Vocabulary
→ Professional / Engineering Interpretation

Agent Operating Contract
→ Agent Behavior / Authority / Boundaries

Decision Framework
→ Decision Process

Context / Adapter Architecture
→ Standard ↔ Context Contract

Domain Context
→ Reusable Domain Context

Project Context
→ Concrete Project Context

Implementation
→ Downstream execution
```

This phase is not an implementation layer. It is a structural, contractual boundary layer that defines how contextual information is represented and connected to the reusable standard.

## 3. Context Definition

Within this architecture, Context means the set of relevant facts, conditions, constraints, assumptions, and relationships that shape interpretation of a problem, environment, domain, or project without changing the universal meaning of the standard.

Context is not:
- authority
- permission
- execution procedure
- implementation behavior
- a replacement for the Decision Framework
- a redefinition of meaning

Context provides the situation in which the standard is applied.

## 4. Domain Context

Domain Context contains reusable reality specific to a domain or field of work, but not to a specific project instance.

Examples of domain-level content include:
- domain concepts and terminology usage
- domain constraints and boundaries
- standard domain assumptions
- domain-level validation expectations
- domain artifacts that are reusable across multiple projects
- common risk and dependency patterns within the domain

Domain Context is reusable across multiple projects operating within the same domain. It must remain general enough to avoid becoming project-specific execution guidance.

## 5. Project Context

Project Context contains concrete information that is specific to an individual project, environment, or instance.

Examples of project-level content include:
- project objective
- project scope
- project-specific facts and constraints
- environment characteristics
- concrete system or service boundaries
- project-specific validation criteria
- project ownership and responsibility boundaries

Project Context is narrower than Domain Context. It does not redefine the standard or the domain model. It applies the generic context to a concrete project situation.

## 6. Standard-to-Context Contract

The contract between the Standard and contextual information is:

```text
Standard
    ↓
Context / Adapter Architecture
    ↓
Domain Context
    ↓
Project Context
```

This contract establishes the following rules:

1. The Standard remains authoritative for universal meaning, interpretation boundaries, behavior boundaries, and decision process.
2. Context does not redefine the Standard.
3. Domain Context may shape interpretation and decision conditions, but it does not define authority or implementation.
4. Project Context may apply domain context to a concrete environment, but it does not own the standard and does not create new semantics.
5. Context provides input to decision-making and validation, but it does not replace decision logic.
6. Context may inform the project reality, but it is not a procedural or operational execution model.

## 7. Context Ownership

The ownership model is:

- Core Vocabulary owns meaning
- Professional Vocabulary owns professional interpretation
- Agent Operating Contract owns behavior and authority boundaries
- Decision Framework owns decision process
- Context / Adapter Architecture owns the contract for structural contextual integration
- Domain Context owns reusable domain reality
- Project Context owns concrete project reality
- Implementation owns state-changing action

No layer may silently assume ownership of another layer.

## 8. Context Boundaries

Context MUST NOT contain:
- semantic definitions that replace Core Vocabulary
- professional terminology definitions that replace Professional Vocabulary
- behavior rules that replace the Agent Operating Contract
- decision process that replaces the Decision Framework
- authority grants or permission logic
- implementation steps, procedures, scripts, or task sequences
- execution instructions
- technical operations or automation design
- project-specific procedural workflows

The purpose of context is to describe reality and constraints, not to command action.

## 9. Domain / Project Boundary

The boundary between Domain Context and Project Context is:

```text
Domain Context
= reusable domain reality

Project Context
= concrete project reality
```

Domain Context is broader, reusable, and shared across multiple project instances. Project Context is narrower, concrete, and specific to a single project or environment.

The allocation rule is:
- if the fact is reusable across multiple projects in the same domain, it belongs to Domain Context
- if the fact is specific to one project instance, it belongs to Project Context
- if the fact is universal, it belongs to the Standard

## 10. Adapter Concept

An Adapter is an architectural connector, not an execution mechanism.

Architecturally, an Adapter:
- translates contextual information into a form the standard can reason about
- preserves layer ownership
- keeps contextual facts distinct from authority and implementation
- supports reuse without creating duplicate standard semantics
- provides boundaries for domain- and project-specific interpretation

An Adapter does not:
- define meaning
- define behavior
- define authority
- define decision process
- define implementation steps
- replace the standard

## 11. Future Adapter Contract

Future adapters must satisfy the minimum contract below:

1. Preserve the Standard as authoritative
2. Declare whether the adapter is domain-level or project-level
3. Identify the contextual facts it owns
4. Distinguish context from implementation
5. Distinguish context from authority
6. Distinguish context from decision logic
7. Declare which standard concepts it applies
8. Declare which facts are reusable versus project-specific
9. Provide validation expectations, not execution procedures
10. Preserve drift controls and non-goal boundaries

Future adapters are not to be created as part of this phase. This section defines the contract they must satisfy when they are later designed.

## 12. Decision Context

Context may inform decisions by providing relevant factual input, but it does not become decision logic.

Decision Context may include:
- objective framing
- current state information
- constraints and dependencies
- known facts and assumptions
- relevant unknowns
- risk exposure and impact conditions
- evidence quality and source-of-truth constraints

Decision Context must not:
- convert a recommendation into a decision
- bypass the Decision Framework
- substitute for approval
- define execution authority

Decision Context is an input to the Decision Framework, not a replacement for it.

## 13. Validation Context

Validation Context defines what evidence and conditions are relevant to verifying that a state, outcome, or decision remains valid within a project or domain.

It may include:
- expected outcome conditions
- comparison criteria
- relevant evidence sources
- decision boundary expectations
- technical and domain relevance for validation

It does not define:
- execution steps
- operational procedures
- automation workflows
- implementation logic

Validation Context supports evidence-based assessment without becoming a procedural execution model.

## 14. Drift Controls

The architecture includes explicit controls to prevent drift across layers.

### Semantic drift
Context must not redefine the meaning layer.

### Professional interpretation drift
Context must not replace Professional Vocabulary interpretation.

### Behavior drift
Context must not define what the agent may or may not do beyond contextual relevance.

### Authority drift
Context must not create authority or permission rules.

### Decision-process duplication
Context must not reproduce the decision lifecycle or decision logic.

### Implementation drift
Context must not contain technical execution procedures, commands, workflows, or state changes.

### Project contamination
Project Context must not silently redefine domain or standard behavior.

### Domain contamination
Domain Context must not absorb project-specific operational logic.

## 15. Pre-Existing / Unapproved Artifact Note

The workspace currently contains a file:

```text
.agent/project-adapter.md
```

This file is treated as:

```text
PRE-EXISTING / UNAPPROVED
```

It may be inspected for architectural relevance, but it does not establish an approved Project Adapter layer. It does not authorize a downstream adapter architecture, and it does not change the boundaries established by the closed Phase 1 documents.

If this file conflicts with the architecture defined here, the conflict is documented in this phase rather than silently adopted.

## 16. Non-Goals

This architecture does not own:
- meaning definitions
- professional terminology definitions
- behavior rules
- authority rules
- decision logic
- execution procedures
- implementation plans
- infrastructure configuration
- automation design
- project execution
- detailed operational workflows
- concrete Domain Adapters
- concrete Project Adapters

This document is intentionally minimal. It defines the structural contract that future contextual layers must satisfy, without creating those layers prematurely.

## 17. Architectural Invariants

The following invariants remain mandatory:

```text
Meaning ≠ Interpretation
Interpretation ≠ Behavior
Behavior ≠ Decision Process
Decision Process ≠ Implementation

Observation ≠ Analysis
Analysis ≠ Recommendation
Recommendation ≠ Decision
Decision ≠ Approval
Approval ≠ Execution
Execution ≠ Validation
Validation ≠ Closure

Authority determines permission.
Evidence determines what can be claimed.
Permission to reason ≠ permission to change state.

Context ≠ Authority
Context ≠ Decision
Context ≠ Procedure
Context ≠ Implementation

Domain Context ≠ Project Context
Domain Adapter ≠ Project Adapter

Context must not redefine the Standard.
Adapters must not redefine the Standard.
```

## 18. Minimum Future Outcome

The minimum acceptable outcome of this phase is a clear architectural contract that makes future domain and project adapter design possible without ambiguity.

This phase does not create those adapters. It creates the contract they must satisfy.

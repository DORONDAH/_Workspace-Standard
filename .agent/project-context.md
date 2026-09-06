# Project Context

## 1. Purpose

Project Context exists as the concrete project reality layer in the approved workspace standard.

Its purpose is to represent the project-specific facts, conditions, constraints, dependencies, environment characteristics, and instance-bound state that apply to a specific project without redefining the reusable domain model, without becoming a decision framework, and without becoming an implementation layer.

Project Context is the project-bound contextual layer between the reusable Domain layer and the downstream Project Adapter.

## 2. Role

Project Context represents the concrete reality of a specific project instance.

It records what is true for this project in its actual environment, boundaries, scope, state, dependencies, assumptions, and project-specific constraints.

Project Context is not a domain model, not a decision system, not an authority layer, and not an execution model.

## 3. Project Reality

Project Reality is the concrete set of project-bound facts, conditions, constraints, dependencies, environment characteristics, ownership and responsibility facts, boundaries, and instance-specific state that apply to a single project.

Project Reality may include:
- project objective
- project scope
- project-specific facts
- project-specific constraints
- project environment characteristics
- project boundaries
- concrete system or service boundaries
- current project state
- project-specific dependencies
- project-specific risk conditions
- ownership and responsibility facts
- project-specific assumptions
- project-specific validation conditions or acceptance facts
- project-specific dates, milestones, or operational frame when those facts are specific to the project instance

Project Reality is distinct from Domain Reality.

## 4. Scope

Project Context may record project-specific information that is concrete and instance-bound.

This includes:
- the project objective and current scope
- concrete project constraints and dependencies
- environment characteristics relevant to the project
- project-local assumptions and known facts
- concrete boundaries and ownership/responsibility facts
- project-specific validation conditions or acceptance facts
- present state as project reality, not as universal meaning

Project Context does not define the domain or the standard. It describes the project as it exists in context.

## 5. Relationship to Domain Context

Project Context records and relates concrete project reality to the relevant Domain Context without redefining Domain Context.

This means:

```text
Domain Context
→ reusable domain reality

Project Context
→ concrete project reality
```

Project Context does not own Domain Context meaning. It does not consume, transform, modify, or redefine the meaning of Domain Context.

It relates project reality to the relevant domain reality while preserving the boundary between reusable domain meaning and concrete project state.

## 6. Relationship to Domain Adapter

The Domain Adapter remains the domain-level adaptation and structural framing layer.

```text
Domain Adapter
→ domain adaptation / structural framing / mapping

Project Context
→ concrete project reality
```

Project Context must not become the Domain Adapter. It does not define domain framing, structural adaptation, or reusable domain-level mapping.

## 7. Relationship to Project Adapter

```text
Project Context
      ↓
Project Adapter
```

Project Context provides the concrete project reality that the Project Adapter may relate to as part of project-specific adaptation and connection.

Project Context remains a contextual layer. It does not define Project Adapter behavior, project mapping logic, implementation behavior, or downstream execution.

## 8. Ownership vs Authority Boundary

Project Context may record:
- ownership
- responsibility
- organizational facts
- project-bound accountability information

only as project facts.

It must not determine, grant, enforce, or define:
- who is authorized to decide
- who may approve
- who may permit
- who may act

That remains outside Project Context.

```text
Project Context
→ records ownership / responsibility as project facts

Authority
→ determines who is authorized to decide, approve, permit, or act
```

## 9. Validation Boundary

Project Context may record project-specific validation conditions or acceptance facts.

This is distinct from:

```text
Project Context
→ records project-specific validation conditions / acceptance facts

Decision Framework
→ defines decision process

Procedure
→ defines operational steps
```

Project Context does not define validation procedures, test procedures, execution methods, or operational workflows.

## 10. Mandatory Non-Responsibilities

Project Context must not own:
- Domain Context
- Domain Adapter
- Project Adapter
- Decision Framework
- Agent authority
- permissions
- decision logic
- procedures
- operational workflows
- execution mechanisms
- implementation logic
- automation design
- commands
- scripts
- APIs
- deployment logic
- domain semantics
- professional vocabulary
- universal meaning

## 11. Architectural Invariants

```text
Domain Reality ≠ Project Reality
Domain Context ≠ Project Context
Domain Adapter ≠ Project Context
Project Context ≠ Project Adapter
Project Context ≠ Implementation

Context ≠ Authority
Context ≠ Decision
Context ≠ Procedure

Adapter ≠ Execution

Meaning ≠ Structural Framing
Structural Framing ≠ Meaning Redefinition
```

## 12. Minimal Architectural Form

The minimal valid form of Project Context is:

```text
Project Context
=
concrete project reality
+ project-specific facts
+ project-specific constraints
+ project-local state/boundaries
+ project-specific contextual relevance
```

This form remains conceptually minimal and project-bound. It does not introduce a new layer, specification model, mapping layer, or implementation model.

## 13. Summary

Project Context is the concrete project reality layer.

It preserves the boundary between:
- reusable domain reality
- concrete project reality
- project-specific adaptation and connection
- downstream execution and implementation

It is intentionally descriptive and contextual, not procedural, not authoritative, and not operational.

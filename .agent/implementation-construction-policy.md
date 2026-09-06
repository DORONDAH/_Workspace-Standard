# Implementation Construction Policy

## 1. Purpose

This policy defines the minimum rules governing future Implementation construction within the approved workspace standard.

Its purpose is to preserve the approved architecture and ensure that Implementation remains a downstream realization layer, not a redesign mechanism, authority layer, decision layer, or new architectural abstraction.

This policy is a policy artifact only. It does not define implementation instructions, commands, scripts, deployment behavior, automation, or technical recipes.

## 2. Definition

Implementation is the downstream realization layer.

It is the point at which an already approved and structurally prepared outcome is realized in actual form under explicit authorization.

The architectural distinction is:

```text
Project Context
→ What is true about this project

Project Adapter
→ How that project reality is structurally adapted toward realization

Implementation
→ How the adapted structure is actually realized
```

Implementation must remain downstream of Project Adapter.

## 3. Construction Preconditions

Implementation may begin only when all required conditions are satisfied:

```text
Approved architecture
+
Project-aligned realization framing
+
Explicit scope
+
Explicit target
+
Explicit authority
+
Defined expected result
+
Validation criteria
+
Stop conditions
+
Evidence expectations
```

No implicit authorization is permitted.

Approval of the architecture or the policy does not, by itself, authorize implementation.

## 4. Input Requirements

Implementation may accept only the realization-ready output produced by the Project Adapter, within the approved scope and under explicit authorization.

The input to Implementation must be:
- structurally prepared
- project-aligned
- architecture-consistent
- previously approved in design
- explicitly scoped
- explicitly authorized

Implementation may not receive:
- redesigned architecture
- new architectural interpretation
- project facts in place of prepared structure
- decision logic
- authority logic
- arbitrary technical integration requirements disguised as architectural needs

## 5. Scope Authorization

Implementation operates only within an explicitly defined scope.

The policy requires:
- an explicit objective
- an explicit target or result
- an explicit boundary
- an explicit authorization source
- a clear validation standard
- a stopping condition if the required conditions are not satisfied

If scope, authority, target, or validation conditions become unclear, Implementation must stop.

## 6. Construction Boundary

The construction boundary is the boundary between:

```text
Project Adapter
→ project-level adaptation / structural realization framing

Implementation
→ downstream realization
```

Implementation must not:
- redefine the architecture
- redefine Project Context
- redefine Project Adapter
- redefine Domain Adapter
- create a new architectural layer
- create a new adapter abstraction
- create a deployment layer
- create a workflow layer
- create an orchestration layer
- create an execution layer
- create an integration layer

The construction boundary is narrow and must remain unchanged.

## 7. Realization Rules

Implementation realizes only an already approved and structurally prepared outcome.

It must:
- remain within explicit scope
- remain within explicit authority
- remain within defined validation conditions
- preserve architectural boundaries
- operate only after approval and authorization

It must not:
- reinterpret Project Context
- replace Project Adapter
- redesign the approved architecture
- make decisions on behalf of the Decision Framework
- establish authority or permission on behalf of the Agent Operating Contract
- invent procedures as architectural policy
- become a generic integration mechanism

## 8. Validation Requirements

Implementation is permitted only if validation criteria are defined before realization begins.

Validation must confirm:
- the outcome matches the approved target
- the realization remains within scope
- the architecture has not been changed
- the adapted structure remains valid
- the result remains downstream of the approved design
- no unauthorized expansion occurred

Validation is required prior to completion, not after the fact as an implied assumption.

## 9. Evidence Requirements

Implementation must be supported by the evidence needed to confirm the outcome and boundary compliance.

Required evidence includes:
- scope confirmation
- authorization confirmation
- target/result confirmation
- validation criteria
- observed or measured results
- evidence that the realized output remains within the approved scope

Evidence does not replace authorization. It verifies the outcome of an authorized realization.

## 10. Stop Conditions

Implementation must stop immediately when any of the following occur:
- authorization is unclear
- scope is unclear
- target is unclear
- expected result is unclear
- validation standard is unclear
- authority is absent or disputed
- the realization would modify approved architecture
- the outcome would exceed the authorized boundary
- evidence is insufficient to support the claim of completion
- the adapted structure is no longer valid or is ambiguous

Stop conditions are mandatory and may not be bypassed by convenience, urgency, or assumption.

## 11. Relationship to Project Adapter

The Project Adapter remains the structural preparation layer.

```text
Project Context
→ what is true about the project

Project Adapter
→ how that project reality is structurally adapted toward realization

Implementation
→ how the adapted structure is actually realized
```

Implementation must not consume Project Context directly as a substitute for project-aligned realization framing.

Implementation must not absorb the Project Adapter responsibility or reinterpret the prepared structure.

## 12. Relationship to Decision Framework

The Decision Framework defines the decision process.

Implementation must not:
- define decision logic
- make project decisions by itself
- replace the Decision Framework
- convert a recommendation into execution without authorization

Implementation is downstream of the decision process and must remain within the approved scope of that decision.

## 13. Relationship to Agent Operating Contract

The Agent Operating Contract establishes scope, behavior, authority, and boundaries.

Implementation must:
- operate only within explicit authorization
- respect scope boundaries
- stop when authority is unclear or missing
- not expand beyond the approved object or target

Implementation does not define authority, grant permission, or replace the behavioral boundary.

## 14. Non-Responsibilities

Implementation is explicitly not responsible for:
- design of architecture
- design of new layers
- redesign of approved artifacts
- policy creation
- decision logic
- authority logic
- procedure creation
- execution planning as a substitute for design
- workflow design
- automation design
- scripts, commands, or APIs
- deployment or orchestration design
- integration design outside explicitly authorized scope
- technical recipes as architectural policy

Implementation is not a governance mechanism, design mechanism, or architecture-generation mechanism.

## 15. Architectural Invariants

The following invariants remain mandatory:

```text
Project Context ≠ Project Adapter
Project Adapter ≠ Implementation
Project Adapter ≠ Decision Framework
Project Adapter ≠ Authority
Project Adapter ≠ Procedure

Context ≠ Authority
Context ≠ Decision
Context ≠ Procedure

Adapter ≠ Execution

Meaning ≠ Structural Framing
Structural Framing ≠ Meaning Redefinition
```

Implementation must remain downstream, bounded, and non-architectural.

## 16. Boundary Risks

The most significant risks are:

1. Implementation becoming a new architectural layer
2. Implementation absorbing Project Adapter responsibilities
3. Implementation creating authority or policy rules
4. Implementation replacing decision logic
5. Implementation becoming technical integration or workflow design
6. Implementation expanding scope without approval
7. Implementation drifting into generic automation or procedure design

These risks are prevented by the authoritative boundary and the mandatory approval gate.

## 17. Authorization Gate

The approval gate is:

```text
Design
→ Review
→ Approval
→ Explicit Implementation Authorization
→ Construction
→ Validation
→ Completion
```

Architecture approval does not equal implementation authorization.

Construction policy approval does not equal implementation authorization.

Only explicit implementation authorization permits the realization phase to begin.

## 18. Minimal Construction Model

The minimum valid construction model is:

```text
Approved architecture
+
project-aligned realization framing
+
explicit scope
+
explicit authority
+
defined expected result
+
validation criteria
+
stop condition
+
proof/evidence requirement
```

This model is sufficient to authorize Implementation without allowing the architecture to be redefined, expanded, or drifted into operational design.

## 19. Summary

This policy formalizes the construction boundary for Implementation.

It preserves the approved architecture and ensures that Implementation remains the downstream realization layer only.

It does not permit:
- architecture redesign
- new layers
- decision or authority logic
- procedure creation
- generic technical integration
- execution without explicit authority
- implicit authorization

Implementation may begin only after approved design, explicit scope, explicit authority, validation conditions, and evidence expectations are all in place.

Implementation Construction Policy
→ CONSTRUCTED

Artifact
→ .agent/implementation-construction-policy.md

Validation
→ PASS

Implementation
→ NOT AUTHORIZED

STOP

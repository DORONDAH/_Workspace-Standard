---
name: architecture-truth
description: Canonical definition of the Workspace Standard architecture components and invariants.
metadata:
  type: reference
---

# Architecture Truth

This memory serves as the canonical reference for the Workspace Standard architecture invariants as defined in the Final Architecture Truth document.

**Core Invariants:**
1. No Agent owns global authority.
2. The Control Plane governs authority, not agents.
3. Every operation must have explicit scope and authorization.
4. Execution must be separated from reasoning.
5. No completion without validation; no validation without evidence.
6. Failure must be observable and recoverable.
7. No silent fallback (e.g., engine mismatch).
8. No security boundary enforced solely by prompt.
9. No hidden state in conversation history.
10. Integrity must be verified (SHA256).

**Why:** To ensure deterministic, governed, and secure autonomous workspaces.
**How to apply:** Use as the source of truth for architectural reviews, tool development, and agent contract definitions.

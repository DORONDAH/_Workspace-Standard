---
name: adversarial-recovery-tests
description: Implementation of adversarial security tests and failure recovery tests.
metadata:
  type: project
---

# Adversarial & Recovery Tests

This memory marks the implementation of the security and robustness test suites.

**Components:**
- `Adversarial-Tests.ps1`: Automated tests for unauthorized access, unknown tasks, and policy violations.
- `Recovery-Tests.ps1`: Automated tests for orchestrator crashes and state recovery.

**Why:** To ensure the system satisfies the "Adversarial Testing" and "Recovery Testing" invariants required for final acceptance.
**How to apply:** Execute these test suites during every CI/CD or architectural audit.

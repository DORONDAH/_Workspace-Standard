# PROJECT-TRUTH.md

## Mission
To provide a reusable, governed architecture for autonomous and semi-autonomous AI-driven workspaces.

## Primary Objective
Enable multiple AI agents, runtimes, and tools to collaborate on projects while preserving deterministic lifecycle, security boundaries, and validation.

## Principles
1. **Multi-Agent ≠ Multi-Authority**: The Workspace Control Plane holds authority, not the agents.
2. **Separation**: Reasoning (Agents) is separate from Authority (Control Plane).
3. **Evidence-Based**: No completion without validation; no validation without evidence.
4. **Deterministic**: Every action must be defined, authorized, executed, validated, and recorded.

## Constraints
- No Agent may redefine Project Mission.
- No silent fallback of execution engines.
- No secret handling in ordinary logs.
- No network access by default.

## Success Criteria
- Reconstruction of operational context without prior chat logs.
- All actions validated against machine-readable contracts.
- Integrity verification (SHA256) of critical artifacts.

## Context Layers
The Workspace Standard implements a layered architecture to ensure proper separation of concerns:

1. **Core Vocabulary**: Foundational definitions and concepts that are immutable and shared across all contexts.
2. **Professional Vocabulary**: Domain-specific terms and practices that extend the core vocabulary for specific professional contexts.
3. **Agent Operating Contract**: Explicitly defined capabilities, permissions, and limitations for each agent role.
4. **Decision Framework**: The governance structure that separates reasoning from authorization, ensuring agents cannot authorize their own actions.
5. **Context/Adapter Architecture**: The dynamic layer that binds the static architecture to specific project realities through PROJECT-STATE.yaml and environment-specific adaptations.

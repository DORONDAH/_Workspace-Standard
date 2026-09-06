# Core Vocabulary

## Purpose

This document defines the universal semantic foundation for the workspace standard.

It is intentionally domain-agnostic and project-agnostic. It explains what concepts mean, not how the agent must behave or how a specific project must be implemented.

## Semantic ownership

- Core vocabulary defines meaning.
- Professional vocabulary explains how meaning is used in engineering and project contexts.
- Agent operating contract defines behavior.
- Decision framework defines decision process.

## State semantics

### Truth
**Definition:** A statement, condition, or claim that is factually valid according to the best available evidence and relevant facts.

**Purpose:** Establishes the normative meaning of correctness for a claim or condition.

**Semantic meaning:** Truth is a property of a claim relative to evidence, relevant facts, and the current context. It is not merely a preferred option or a strong opinion.

**What it does NOT mean:**
- a guess
- a preference
- a subjective conclusion
- a claim that is accepted only because it is repeated

**Relationship to other concepts:**
- Truth may be supported by Evidence.
- Truth is distinct from Authority.
- Authority can determine precedence between competing claims, but authority alone does not make a claim true.

### Live State
**Definition:** The current actual state of a project, environment, artifact, or system as it exists at a given point in time.

**Purpose:** Provides the current baseline for comparison and assessment.

**Semantic meaning:** Live State is the real state and may be observed, measured, inspected, or otherwise directly verified.

**What it does NOT mean:**
- desired future state
- planned state
- unverified assumption
- generic theoretical model

**Relationship to other concepts:**
- Live State may be compared against Desired State.
- Live State is separate from Project Truth and from assumptions.

### Desired State
**Definition:** The intended target state for a project, system, or artifact.

**Purpose:** Defines the state that is intended to exist after a change is made or a plan is executed.

**Semantic meaning:** Desired State expresses an intentional target and may be reflected in an approved project definition or specification.

**What it does NOT mean:**
- current reality
- a confirmed observed state
- an assumption that has not been approved

**Relationship to other concepts:**
- Desired State may be represented in Project Truth.
- A gap exists when Desired State differs from Live State.

### Observed
**Definition:** Information directly obtained through observation, inspection, measurement, or equivalent direct verification.

**Purpose:** Establishes what is concretely known from direct evidence.

**Semantic meaning:** Observation is a direct form of evidence, but it can still be partial, limited, or mistaken. It is not automatically complete or infallible.

**What it does NOT mean:**
- a guess
- a declared fact without verification
- a theoretical inference without direct support

**Relationship to other concepts:**
- Observed differs from Declared.
- Observed may be used as evidence, but it is not automatically identical to Truth.

### Declared
**Definition:** A fact, requirement, definition, expectation, or instruction that has been explicitly stated by a source.

**Purpose:** Captures what has been stated or documented.

**Semantic meaning:** Declaration is a representation of a statement or requirement. It may be correct, incomplete, outdated, or unverified.

**What it does NOT mean:**
- observed fact
- verified fact
- proven fact

**Relationship to other concepts:**
- Declared may differ from Observed.
- Declared may contribute to Desired State or Project Truth when approved.

### Assumed
**Definition:** A condition, fact, or interpretation accepted as provisional without direct verification.

**Purpose:** Allows reasoning while evidence is still pending.

**Semantic meaning:** Assumption is a tentative interpretation and must remain clearly separate from verified fact.

**What it does NOT mean:**
- verified fact
- proven truth
- observed state

**Relationship to other concepts:**
- Assumed differs from Known and from Observed.
- Assumption may be refined when Evidence becomes available.

### Unknown
**Definition:** A state, fact, or condition that is not known, not observed, not verified, or not available from a reliable source.

**Purpose:** Prevents false certainty and fabricated state.

**Semantic meaning:** Unknown is explicit uncertainty and must not be treated as a value or as a negative conclusion without evidence.

**What it does NOT mean:**
- false
- negative
- impossible
- a confirmed absence

**Relationship to other concepts:**
- Unknown differs from Assumed because it is not a tentative value.
- Unknown may become Observed, Declared, or Verified when evidence appears.

## Authority

### Authority
**Definition:** The recognized source, standard, or decision maker whose judgment or precedence is accepted for a given fact, claim, or context.

**Purpose:** Resolves conflicts between competing claims or interpretations.

**Semantic meaning:** Authority determines precedence or validity within a defined context. It is not the same as Truth itself.

**What it does NOT mean:**
- force of personality
- arbitrary preference
- generic knowledge without context

**Relationship to other concepts:**
- Authority may influence which source is considered higher priority when claims conflict.
- Authority does not automatically convert a claim into Truth.

### Source of Truth
**Definition:** An authoritative reference for a fact, state, requirement, definition, policy, or specification.

**Purpose:** Provides a stable and trusted basis for determining what is valid within a defined scope.

**Semantic meaning:** Source of Truth is a trusted reference point. It may be a specification, approved project definition, authoritative document, or accepted standard.

**What it does NOT mean:**
- a draft document
- a brainstorm note
- a guessed configuration
- a generic recommendation

**Relationship to other concepts:**
- Source of Truth may be used to define Desired State or Project Truth.
- Source of Truth is distinct from a mere declaration or an assumption.

## Evidence and confidence

### Evidence
**Definition:** Information that supports or relates to a claim, statement, observation, or conclusion.

**Purpose:** Serves as the basis for evaluating whether a claim is plausible or supported.

**Semantic meaning:** Evidence may include observations, records, measurements, documentation, or other information relevant to a claim.

**What it does NOT mean:**
- an opinion
- a guess
- a general assumption

**Relationship to other concepts:**
- Evidence may support a claim or a hypothesis.
- Evidence can relate to Truth and to Validated State.

### Proof
**Definition:** Evidence sufficient to demonstrate a claim or condition under a defined criterion or purpose.

**Purpose:** Establishes sufficient support to justify a claim for a defined task, requirement, or standard.

**Semantic meaning:** Proof is not simply the presence of evidence. It is evidence that meets the relevant standard of demonstration for a claim.

**What it does NOT mean:**
- a statement of intent
- a repeated assertion
- a generic claim without defined standard

**Relationship to other concepts:**
- Proof is a form of Evidence used for a defined demonstration purpose.
- Proof may be used to support the validity of a claim or a condition.

### Confidence
**Definition:** The degree to which a claim is likely to be correct based on available evidence, context, and certainty.

**Purpose:** Communicates the strength of support for a claim without replacing evidence.

**Semantic meaning:** Confidence is a signal of how strongly the available information supports a conclusion. It does not equal certainty.

**What it does NOT mean:**
- certainty without evidence
- a replacement for fact
- an excuse to ignore uncertainty

**Relationship to other concepts:**
- Confidence is influenced by Evidence, Proof, and the state of uncertainty.
- Confidence is lower when the state is Unknown or Assumed.

## Control and safety

### Constraint
**Definition:** A limit, rule, or boundary that restricts what is allowed, possible, required, or valid.

**Purpose:** Defines the practical or policy-driven limits of a context, state, or claim.

**Semantic meaning:** Constraints shape what states are acceptable and what conditions are considered within or outside scope.

**What it does NOT mean:**
- a goal
- a wish
- a preference
- a generic preference

**Relationship to other concepts:**
- Constraints relate to Boundary and to the definition of valid conditions.

### Boundary
**Definition:** The formal or practical limit of scope, ownership, or action.

**Purpose:** Establishes where actions, responsibilities, or trust domains begin and end.

**Semantic meaning:** Boundary defines the limits of what is considered in-scope, controlled, or authoritative.

**What it does NOT mean:**
- a vague notion of nearby context
- an implied project area
- an unrestricted workspace

**Relationship to other concepts:**
- Boundary is related to Ownership and Scope.
- Boundary is a safety concept, but it is not a behavior rule itself.

## Verification

### Validation
**Definition:** The process of evaluating whether a condition, state, claim, or result satisfies a relevant expected criterion or standard.

**Purpose:** Assesses whether actual outcomes align with expectations or requirements.

**Semantic meaning:** Validation compares expected and actual outcomes in a way that allows a condition to be evaluated against a criterion.

**What it does NOT mean:**
- a successful command exit code by itself
- a partial inspection without a criterion
- an assumption that appears reasonable

**Relationship to other concepts:**
- Validation relates to Evidence, Proof, Expected State, and Actual State.
- Validation may evaluate whether Desired State aligns with Live State.

## Conflict and uncertainty

### Conflict
**Definition:** A condition in which two or more claims, states, interpretations, or sources cannot all be true within the same context.

**Purpose:** Identifies that a resolution process is required.

**Semantic meaning:** Conflict indicates an incompatibility between claims or states, not necessarily that one source is malicious or invalid.

**What it does NOT mean:**
- a simple difference of opinion
- a minor wording variation
- automatic proof that one side is wrong

**Relationship to other concepts:**
- Conflict may be resolved using Authority and Source of Truth.
- Conflict is distinct from Unknown because it represents incompatible known or declared states.

## Critical distinctions

### Observed ≠ Declared
Observed is directly obtained through inspection, measurement, or similar direct verification. Declared is a statement or description that may or may not be verified.

### Declared ≠ Verified
A declaration is not automatically the same as a verified fact.

### Assumed ≠ Known
An assumption may be reasonable, but it is not the same as known fact.

### Desired State ≠ Live State
The intended state and the actual current state are different concepts and should not be conflated.

### Evidence ≠ Proof
Evidence is information relevant to a claim. Proof is evidence sufficient to demonstrate a claim for a defined purpose.

### Truth ≠ Assumption
Truth is a valid factual status supported by relevant evidence and context; assumption is a provisional interpretation without direct verification.

## Minimal semantic rules

1. Unknown remains explicit uncertainty and should not be treated as a value.
2. Declared statements may differ from Observed states and should not automatically be treated as verified fact.
3. Desired State may differ from Live State without contradiction if the state is not yet realized.
4. Evidence may support or fail to support a claim.
5. Proof is evidence sufficient to demonstrate a claim under a defined criterion.
6. Conflict indicates incompatible claims or states that require resolution by relevant authority or standard.
7. Core vocabulary defines meaning; it does not define behavior.

## Final note

This document is the semantic foundation of the workspace standard. It is intentionally universal and domain-agnostic. It does not define agent behavior, project implementation, or specific engineering protocols. Those belong to the professional vocabulary, the operating contract, and the decision framework.

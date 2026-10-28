# Feature: Throwaway Space

Status: **withdrawn** (patch 0055). Nothing in the browser opens a throwaway Space.

A throwaway Space would have been an in-memory partition, forgotten when its last tab closed or the browser quit. What was built came back after a restart with an empty jar, and its tabs would have been restored into the shared jar. A persistent agent that holds a Space's cookies is a separate rule, and was never built (ADR 0020).

## Behaviours

| Id | Behaviour | Test | State |
|---|---|---|---|
| T1 | A throwaway Space would be an isolated in-memory partition. | none | withdrawn |
| T2 | Closing the last throwaway tab, or quitting, forgets the Space and its jar. It is not session-restored. | none | withdrawn |
| T3 | Peek and little windows that are not routed would load in a throwaway jar; promote would rebind into the destination Space. | none | withdrawn |
| T4 | Password autofill would not fill in a throwaway, peek guest, or little guest jar. | none | withdrawn |

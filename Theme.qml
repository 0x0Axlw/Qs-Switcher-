pragma Singleton

import Quickshell

// Visual constants that are NOT user-facing config (yet).
// Today these are hard-coded magic numbers scattered across the UI.
// Centralizing them here is the seed of the Phase 3 theme system:
// later, swapping themes just means swapping what this singleton returns.
Singleton {
    id: root

    property int windowHeight: 500
    property int tileHeight: 500
    property int spacing: 4

    // The carousel's signature skew. Currently applied in 3 places;
    // pulling it to one constant is step 1 toward the proper
    // single-skew tile we'll build in Phase 2.
    property real shearFactor: -0.25

    // --- carousel selection feel ------------------------------------
    property real activeScale: 1.18    // centered tile grows
    property real inactiveScale: 0.82  // others shrink back
    property real inactiveOpacity: 0.5 // others dim
    property int highlightMoveDuration: 260 // world-scroll on select change
    property int tileTransitionDuration: 180 // per-tile scale/opacity ease
}

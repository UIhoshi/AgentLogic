# Plan — img2threejs 3D Web Integration

## Approach

1. Add Module 52 as the sole policy owner for optional img2threejs use in interactive 3D web work.
2. Cross-link it from the reference-to-interface, skill-routing, and affordance-first modules
   without creating a mandatory registry route or declaring a host skill available.
3. Register the module in all relevant manifest profiles and optional-module metadata, the stable
   V6.8.4 narrative, README external sources, candidate registry, and project/code maps.
4. Rebuild `dist/` only through `scripts/build-profile.ps1`, then run the prescribed checks.

## Load-Bearing Assumptions / Red-Team Results

| Assumption | Steelman | Fails if | Mitigation / test |
| --- | --- | --- | --- |
| The trigger separates model reconstruction from generic 3D effects | img2threejs is built for reference-image-to-procedural-model work, not all WebGL output | "3D effect image" causes unnecessary or wrong skill activation | State the three routing outcomes and explicit non-triggers in the policy and router. |
| Policy-only registration preserves safety | A source record allows later deliberate adoption while no executable content enters the package | Readers infer it is installed, trusted, or security-audited | Include non-import, pin, explicit-consent, and missing-audit statements; do not add a host capability alias. |
| Existing UI and verification rules remain sufficient | Modules 29, 39, 47, and 51 already cover mockup approval, browser proof, and layout validation | Model review is treated as proof of final page usability/performance | Require final in-page browser/runtime, visual, performance, and accessibility validation. |
| Bundle membership is consistent | `manifest.json` drives all generated default host bundles | A host omits the new policy or generated output drifts | Add the module to each applicable profile and run build plus package/maintainer verification. |

## Design Decision

Use a source-specific policy module, not a bundled third-party skill and not a mandatory canonical
skill route. This keeps the default context lean while exposing a precise opt-in path.

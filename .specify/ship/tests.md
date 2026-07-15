# Derived Verification Map

| Intent | Verification | Result |
| --- | --- | --- |
| Startup gate is mechanically present and ordered | `node scripts/check-logic-entry.js` | Passed |
| Package manifest and all generated outputs are current | `scripts/validate-package.ps1` | Passed |
| All four host bundles build from the current profile | `scripts/maintainer-check.ps1` | Passed |
| PowerShell scripts parse | PowerShell parser over repository scripts | Passed |
| Generated bundles contain no absolute machine URIs | `Select-String` plus package validation | Passed |
| Generated bundles contain V6.7.2 headers | package validation and header inspection | Passed |
| Host mutation flow preserves legacy files on adapter failure | static inspection; requires a disposable host fixture for runtime proof | Partially verified |
| Host-local skill archive moves are not implicit | adapter and installer static inspection | Partially verified |

The two partially verified items require an isolated disposable user-home integration fixture before
being treated as runtime-verified.

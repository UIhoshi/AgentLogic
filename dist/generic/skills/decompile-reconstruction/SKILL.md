---
name: decompile-reconstruction
description: Autonomous binary/bytecode/bundle decompilation and clean-room source code reconstruction. Triggered automatically when the user provides or asks to analyze, decompile, deobfuscate, or recover readable/compilable source code or algorithms from compiled binaries (PE/ELF/Mach-O/DLL/SO), Android APKs/JARs, .NET assemblies, Python bytecode (.pyc), WASM, or bundled/minified/obfuscated JS/Electron apps.
---

# Engineering Decompilation & Clean-Room Source Reconstruction (`decompile-reconstruction`)

This skill turns compiled binaries, bytecode packages, and obfuscated bundles into **structured architectural maps and clean, readable, compilable source code**. It synthesizes the engineering-first workflow of [`morluto/rea`](https://github.com/morluto/rea) (Reverse Engineer Anything) and [`LaurieWired/GhidraMCP`](https://github.com/LaurieWired/GhidraMCP), orchestrated alongside AgentLogic's existing `ida-reverse`, `apk-reverse`, `dotnet-reverse`, `js-reverse`, and `radare2` capabilities.

## Automatic Trigger Contract (Encounter -> Auto-Use)

Do NOT wait for the user to specify a skill name. Activate this workflow automatically whenever:

1. The user provides or points to a compiled or packaged artifact (`.exe`, `.dll`, `.so`, `.dylib`, `.elf`, `.sys`, `.apk`, `.jar`, `.dex`, `.pyc`, `.wasm`, `.asar`, or minified/obfuscated `.js`) and asks:
   - what it does, how a feature/algorithm/protocol inside it works, or
   - to decompile, deobfuscate, port, or reconstruct it into clean source code.
2. **Scope Boundary (Engineering vs. Offensive Security)**:
   - **Engineering Reconstruction (Automatic)**: Analyzing program logic, recovering data structures/types, deobfuscating bundles, and reconstructing clean-room source code in the local workspace runs automatically under this route.
   - **Offensive Exploitation / Live Malware Execution (Restricted Manual)**: Never execute unknown/untrusted binaries directly on the host OS. If the task shifts to live exploitation (`pwn-chain`) or active penetration testing, defer to the restricted security confirmation boundary.

---

## The 5-Stage Clean-Room Reconstruction Pipeline

### Stage 1: Non-Destructive Format Triage & Toolchain Selection

Never guess the target format from the file extension alone, and never run an unknown binary to see what it does. First inspect headers/metadata read-only and select the highest-fidelity available decompiler:

| Target Artifact Class | Identification Signal | Ordered Toolchain Priority (Use First Available) |
| :--- | :--- | :--- |
| **1. Native Binary** (`PE`/`ELF`/`Mach-O`: `.exe`, `.dll`, `.so`, `.dylib`, `.sys`) | Native headers without CLR metadata | 1. **IDA Pro MCP** (`idapro_*` via `skills/reverse-skill/skills/ida-reverse/SKILL.md`)<br>2. **Ghidra MCP / Headless** (`ghidra-mcp` or `analyzeHeadless` + DecompInterface)<br>3. **Radare2 + Ghidra Decompiler** (`r2 -qc "aaa; pdg @ <func>"`)<br>4. **LLVM/Binutils Native Triage** (`llvm-objdump -d`, `nm -C`, `readelf`, `strings`) |
| **2. .NET / C# Managed Assembly** (`.exe`, `.dll` with CLR header) | PE Data Directory[14] (CLR header) / `mscoree.dll` / `#Strings` | 1. **`de4dot`** (if obfuscated with ConfuserEx/SmartAssembly/etc.)<br>2. **`ilspycmd`** (headless C# project export: `ilspycmd -p -o <out_dir> <target.dll>`) or **dnSpyEx / dnSpy MCP** (`skills/reverse-skill/skills/dotnet-reverse/SKILL.md`) |
| **3. Android APK / JVM Bytecode** (`.apk`, `.jar`, `.dex`, `.class`) | ZIP magic + `classes.dex` or `0xCAFEBABE` | 1. **`jadx`** (`jadx -d <out_dir> --deobf <target.apk/jar>`, see `skills/reverse-skill/skills/apk-reverse/SKILL.md`)<br>2. **`apktool`** (resources/Manifest/smali) + **CFR / Vineflower** (Java `.jar`) |
| **4. Python Bytecode / Frozen App** (`.pyc`, PyInstaller `.exe`) | Python magic header or `MEI` / `PYZ` archive | 1. **`pyinstxtractor`** / `pyinstxtractor-ng` (for PyInstaller containers)<br>2. **`pycdc` (Decompyle++)** or **`uncompyle6`** (`.pyc` -> `.py`) + `dis` module disassembly |
| **5. Electron / Bundled / Obfuscated JS & WASM** (`.asar`, `.js`, `.wasm`) | Electron `app.asar`, Webpack/Vite bundle, or `\0asm` | 1. **`npx @electron/asar extract`** (for `.asar`)<br>2. **`webcrack`** / SourceMap recovery / `ast-grep` structural deobfuscation<br>3. **`wasm2wat` / `wasm-decompile`** (WABT) or `ghidra` WASM loader |

*Missing Tool Handling*: If the optimal decompiler (e.g., Ghidra, `ilspycmd`, `jadx`, `pycdc`, `webcrack`) is not installed on the host, follow Module 49's single-consent prerequisite bundle (or use the highest available native fallback with explicit disclosure of the fidelity gap).

### Stage 2: Structural & Symbol Survey (Map Before Deep-Dive)

Before decompiling individual routines, build a concise evidence map of the target:

1. **Exports, Entrypoints & High-Fan-In Functions**: Identify `main`/`DllMain`/`JNI_OnLoad`, exported APIs, and functions with the highest cross-reference (`xref`) counts.
2. **Strings, Constants & Import Classification**: Group imports and strings by domain capability (file I/O, network/HTTP, cryptography/hashing, serialization, UI/IPC).
3. **Architecture & Call Graph Summary**: Record the module's subsystem layout before translating any function.

### Stage 3: Evidence-Backed Pseudocode & IR Extraction

Extract raw decompiler output (`C` pseudocode, `C#`, `Java`, `Python`, or `WAT`) for the target call chain:

- **Zero Hallucination Rule**: Every reconstructed function MUST cite its original binary address, symbol name, or bytecode offset (e.g., `// Reconstructed from sub_140002A10 (0x140002A10)`). Never invent functions or algorithm steps that are not backed by extracted pseudocode or disassembly.
- Save raw extracted pseudocode or decompiler dumps into a dedicated working directory (e.g., `.specify/<task>/decompiled-raw/` or project scratch directory) so raw evidence remains separate from clean reconstructed code.

### Stage 4: Type, Struct & Control-Flow Recovery (Clean-Room Refinement)

Raw decompiler output is full of compiler artifacts (`v1`, `a1`, `*(DWORD *)(v2 + 0x18)`, `goto LABEL_14`, state-machine switches). Transform raw pseudocode into idiomatic, maintainable source code:

1. **Struct, Enum & Type Recovery**:
   - Replace raw pointer offsets (`*(uint32_t *)(ctx + 0x10)`) with explicit `struct` field definitions and typed pointers.
   - Replace magic numbers and bitwise flags with named `enum` or `const` definitions.
2. **Control-Flow Structuring (Eliminate `goto` & Flattened Switches)**:
   - Convert decompiler `goto` labels and while-true break cascades back into structured `for`/`while` loops, early returns, and guard clauses.
   - Unroll compiler-generated async/coroutine/iterator state machines back into readable `async/await` or generator functions.
3. **Semantic Renaming & Code Simplification**:
   - Rename `sub_xxx`, `v1`, `arg_0` to domain-meaningful identifiers based on string xrefs, API calls, and data flow.
   - Run the **`code-simplifier`** pass on the reconstructed source to remove dead decompiler temporaries and redundant casts.

### Stage 5: Equivalence Verification & Closure

1. **Compilation / Static Check**: Compile or typecheck the reconstructed source code (`gcc`/`clang`/`cargo`/`tsc`/`dotnet build`/`javac`/`python -m py_compile`) to prove it is valid, self-contained code rather than broken pseudocode.
2. **Input-Output Equivalence Proof**: Where known test vectors, protocol payloads, or constants exist in the binary, run a unit test or verification script proving the reconstructed function produces identical outputs to the original binary logic.
3. **Closure Evidence**: Record `target_format_and_toolchain_triage` and `decompiled_or_reconstructed_artifact`.

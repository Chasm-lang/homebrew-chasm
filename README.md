# homebrew-chasm

Homebrew tap for [Chasm](https://github.com/Chasm-lang/Chasm).

## Install

```bash
brew tap Chasm-lang/chasm
brew install chasm
```

Bottles (pre-built binaries) are available for macOS arm64 and x86_64 — no Go toolchain required on your machine.

## Usage

```bash
chasm run hello.chasm
chasm run --engine raylib examples/game/example.chasm
chasm fmt myfile.chasm
chasm compile myfile.chasm
chasm watch myfile.chasm
chasm version
```

## VS Code / Cursor extension

```bash
code --install-extension $(brew --prefix chasm)/libexec/editors/vscode/chasm-language-0.3.0.vsix
```

## Upgrade

```bash
brew upgrade chasm
```

## Uninstall

```bash
brew uninstall chasm
brew untap Chasm-lang/chasm
```

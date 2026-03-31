# vcpkg overlay ports (Backtesting-Engine)

This repository contains overlay ports for use with vcpkg, without requiring the curated registry.

## Install

```bash
git clone https://github.com/Vins-z/vcpkg-overlay-ports.git
vcpkg install --overlay-ports=./vcpkg-overlay-ports/ports backtesting-engine
```

## Notes

- This is an **overlay**; it does not require a vcpkg registry.
- If you want versioning/baselines, convert this to a Git registry later.


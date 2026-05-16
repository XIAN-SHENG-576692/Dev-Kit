# Dev-Kit

Chen-Xian-Sheng Development Kit.

## Install

```bash
git clone --filter=tree:0 --depth=1 --no-tags \
https://github.com/XIAN-SHENG-576692/Dev-Kit.git \
&& chmod -R +x Dev-Kit/*
```

## Initialize

```bash
Dev-Kit/init/gen_env.sh
Dev-Kit/init/gen_env_install.sh ...
Dev-Kit/init/setup.sh
```

## File Structure

- `.devcontainer/`: The configuration files for `ms-vscode-remote.remote-containers` extension in VS Code to build the container for testing.
- `env/`: Some environment variables.
- `init/`: Some scripts for initialize.
- `tools/`: Some scripts for developer. 


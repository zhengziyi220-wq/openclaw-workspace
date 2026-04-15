# 工作空间目录结构

## 主目录
- `/home/zy/hermes/` - Hermes 工作空间
- `/home/zy/openclaw/` - OpenClaw 工作空间

## 目录结构
```
hermes/
├── projects/          # 项目目录
│   └── scrcpy-car/    # 车载投屏项目
├── scripts/           # 脚本目录
│   ├── check-nous-auth.py
│   ├── check-nous-auth.sh
│   ├── check-nous-status.py
│   ├── configure-github-cli.sh
│   ├── github-cli-auth.sh
│   └── setup-github.sh
├── configs/           # 配置目录
└── logs/              # 日志目录
```

## 使用说明
1. **项目文件**: 放在 `projects/` 目录下
2. **脚本文件**: 放在 `scripts/` 目录下
3. **配置文件**: 放在 `configs/` 目录下
4. **日志文件**: 放在 `logs/` 目录下

## 自动推送
- 每次提交后会自动推送到 GitHub
- 仓库地址:
  - Hermes: https://github.com/zhengziyi220-wq/hermes-workspace
  - OpenClaw: https://github.com/zhengziyi220-wq/openclaw-workspace
  - ScrcpyCar: https://github.com/zhengziyi220-wq/scrcpy-car

## 同步配置
使用同步脚本在 hermes 和 openclaw 之间同步配置:
```bash
# 从 hermes 同步到 openclaw
/home/zy/scripts/sync-config.sh hermes-to-openclaw

# 从 openclaw 同步到 hermes
/home/zy/scripts/sync-config.sh openclaw-to-hermes
```

#!/bin/bash
# GitHub 配置脚本

echo "=== GitHub 配置脚本 ==="
echo ""

# 1. 检查 SSH 连接
echo "1. 检查 SSH 连接..."
ssh -T git@github.com 2>&1 | head -1
echo ""

# 2. 检查 GitHub CLI 认证
echo "2. 检查 GitHub CLI 认证..."
if gh auth status 2>/dev/null | grep -q "logged in"; then
    echo "✓ GitHub CLI 已认证"
else
    echo "✗ GitHub CLI 未认证"
    echo "请运行: gh auth login"
fi
echo ""

# 3. 检查 GitHub 用户名配置
echo "3. 检查 GitHub 用户名配置..."
GITHUB_USER=$(git config --global github.user)
if [ -n "$GITHUB_USER" ]; then
    echo "✓ GitHub 用户名: $GITHUB_USER"
else
    echo "✗ GitHub 用户名未配置"
    echo "请运行: git config --global github.user <username>"
fi
echo ""

# 4. 检查远程仓库
echo "4. 检查远程仓库..."
if git remote -v | grep -q origin; then
    echo "✓ 远程仓库已配置:"
    git remote -v
else
    echo "✗ 远程仓库未配置"
fi
echo ""

# 5. 提供下一步操作
echo "=== 下一步操作 ==="
echo ""
echo "如果 GitHub 仓库不存在，请："
echo "1. 访问 https://github.com/new"
echo "2. 创建仓库: scrcpy-car (Public)"
echo "3. 不要初始化 README、.gitignore 或 License"
echo ""
echo "然后运行以下命令："
echo "git push -u origin main"
echo ""
echo "或者使用 GitHub CLI（如果已认证）："
echo "gh repo create scrcpy-car --public --source=. --remote=origin"

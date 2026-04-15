#!/bin/bash
# GitHub CLI 完整配置脚本

echo "=== GitHub CLI 配置脚本 ==="
echo ""

# 检查 gh 是否安装
if ! command -v gh &> /dev/null; then
    echo "错误：GitHub CLI 未安装"
    echo "请运行: sudo apt install gh"
    exit 1
fi

echo "1. 检查 GitHub CLI 版本..."
gh --version
echo ""

# 检查认证状态
echo "2. 检查认证状态..."
if gh auth status 2>/dev/null | grep -q "logged in"; then
    echo "✓ 已登录到 GitHub"
    gh auth status
else
    echo "✗ 未登录到 GitHub"
    echo ""
    echo "需要登录到 GitHub..."
    echo ""
    echo "请选择登录方式："
    echo "1. 浏览器登录（推荐）"
    echo "2. Token 登录"
    echo ""
    read -p "请选择 (1/2): " choice
    
    if [ "$choice" = "1" ]; then
        echo ""
        echo "正在启动浏览器登录..."
        echo "请按照提示操作："
        echo "1. 选择 GitHub.com"
        echo "2. 选择 HTTPS"
        echo "3. 选择 'Login with a web browser'"
        echo "4. 复制一次性代码"
        echo "5. 在浏览器中打开链接并输入代码"
        echo ""
        gh auth login
    elif [ "$choice" = "2" ]; then
        echo ""
        echo "请输入 GitHub Personal Access Token:"
        echo "(可以在 https://github.com/settings/tokens 创建)"
        read -s token
        echo ""
        echo "$token" | gh auth login --with-token
    else
        echo "无效选择"
        exit 1
    fi
fi

echo ""
echo "3. 配置 GitHub 用户信息..."
# 检查是否已配置
if ! git config --global github.user &>/dev/null; then
    echo "请输入 GitHub 用户名:"
    read username
    git config --global github.user "$username"
fi

echo ""
echo "4. 测试 GitHub CLI..."
echo "测试创建仓库..."
if gh repo view &>/dev/null; then
    echo "✓ GitHub CLI 工作正常"
else
    echo "⚠️  可能需要创建仓库"
fi

echo ""
echo "=== 配置完成 ==="
echo ""
echo "常用命令："
echo "gh auth status          - 检查认证状态"
echo "gh repo create          - 创建仓库"
echo "gh repo clone           - 克隆仓库"
echo "gh issue list           - 列出问题"
echo "gh pr list              - 列出拉取请求"
echo ""

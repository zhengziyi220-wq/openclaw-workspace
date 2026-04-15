#!/bin/bash
# GitHub CLI 认证脚本

echo "=== GitHub CLI 认证 ==="
echo ""

# 检查当前状态
if gh auth status 2>/dev/null | grep -q "logged in"; then
    echo "✓ 已经登录到 GitHub"
    gh auth status
else
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
echo "=== 认证完成 ==="

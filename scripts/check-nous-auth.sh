#!/bin/bash
# 自动检查并刷新 Nous 认证令牌

AUTH_FILE="$HOME/.hermes/auth.json"
if [ ! -f "$AUTH_FILE" ]; then
    echo "认证文件不存在: $AUTH_FILE"
    exit 1
fi

# 检查令牌过期时间
EXPIRES_AT=$(jq -r '.providers.nous.expires_at' "$AUTH_FILE" 2>/dev/null)
if [ -z "$EXPIRES_AT" ] || [ "$EXPIRES_AT" = "null" ]; then
    echo "无法获取令牌过期时间"
    exit 1
fi

# 转换为时间戳
EXPIRES_TS=$(date -d "$EXPIRES_AT" +%s 2>/dev/null)
CURRENT_TS=$(date +%s)

# 如果令牌在1小时内过期，刷新它
if [ $((EXPIRES_TS - CURRENT_TS)) -lt 3600 ]; then
    echo "令牌即将过期，正在刷新..."
    hermes model --no-browser
    if [ $? -eq 0 ]; then
        echo "令牌刷新成功"
    else
        echo "令牌刷新失败"
        exit 1
    fi
else
    echo "令牌仍然有效，过期时间: $EXPIRES_AT"
fi

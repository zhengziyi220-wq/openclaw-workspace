#!/usr/bin/env python3
# 自动检查并刷新 Nous 认证令牌

import json
import os
import subprocess
import sys
from datetime import datetime, timezone

AUTH_FILE = os.path.expanduser("~/.hermes/auth.json")
if not os.path.exists(AUTH_FILE):
    print(f"认证文件不存在: {AUTH_FILE}")
    sys.exit(1)

try:
    with open(AUTH_FILE, 'r') as f:
        auth_data = json.load(f)
    
    nous_data = auth_data.get('providers', {}).get('nous', {})
    expires_at_str = nous_data.get('expires_at')
    
    if not expires_at_str:
        print("无法获取令牌过期时间")
        sys.exit(1)
    
    # 解析过期时间
    expires_at = datetime.fromisoformat(expires_at_str.replace('Z', '+00:00'))
    current_time = datetime.now(timezone.utc)
    
    # 如果令牌在1小时内过期，刷新它
    time_until_expiry = expires_at - current_time
    if time_until_expiry.total_seconds() < 3600:
        print(f"令牌即将过期，剩余时间: {time_until_expiry}")
        print("正在刷新令牌...")
        
        # 运行 hermes model 命令
        result = subprocess.run(['hermes', 'model', '--no-browser'], 
                              capture_output=True, text=True)
        
        if result.returncode == 0:
            print("令牌刷新成功")
            print(result.stdout)
        else:
            print("令牌刷新失败")
            print(result.stderr)
            sys.exit(1)
    else:
        print(f"令牌仍然有效，过期时间: {expires_at_str}")
        print(f"剩余时间: {time_until_expiry}")
        
except Exception as e:
    print(f"错误: {e}")
    sys.exit(1)

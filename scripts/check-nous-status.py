#!/usr/bin/env python3
# Nous 认证令牌过期提醒脚本

import json
import os
from datetime import datetime, timezone

AUTH_FILE = os.path.expanduser("~/.hermes/auth.json")
if not os.path.exists(AUTH_FILE):
    print("认证文件不存在")
    exit(1)

try:
    with open(AUTH_FILE, 'r') as f:
        auth_data = json.load(f)
    
    nous_data = auth_data.get('providers', {}).get('nous', {})
    expires_at_str = nous_data.get('expires_at')
    agent_key_expires_at_str = nous_data.get('agent_key_expires_at')
    
    if not expires_at_str:
        print("无法获取令牌过期时间")
        exit(1)
    
    # 解析过期时间
    expires_at = datetime.fromisoformat(expires_at_str.replace('Z', '+00:00'))
    current_time = datetime.now(timezone.utc)
    
    # 计算剩余时间
    time_until_expiry = expires_at - current_time
    hours_until_expiry = time_until_expiry.total_seconds() / 3600
    
    print(f"Nous 认证状态:")
    print(f"访问令牌过期时间: {expires_at_str}")
    print(f"剩余时间: {hours_until_expiry:.1f} 小时")
    
    if agent_key_expires_at_str:
        agent_key_expires_at = datetime.fromisoformat(agent_key_expires_at_str.replace('Z', '+00:00'))
        agent_key_hours = (agent_key_expires_at - current_time).total_seconds() / 3600
        print(f"代理密钥过期时间: {agent_key_expires_at_str}")
        print(f"代理密钥剩余时间: {agent_key_hours:.1f} 小时")
    
    if hours_until_expiry < 1:
        print("\n⚠️  警告: 访问令牌已过期或即将过期！")
        print("请运行: hermes model")
    elif hours_until_expiry < 24:
        print(f"\n⚠️  注意: 访问令牌将在 {hours_until_expiry:.1f} 小时后过期")
        print("建议尽快运行: hermes model")
    else:
        print("\n✓ 访问令牌仍然有效")
        
except Exception as e:
    print(f"错误: {e}")
    exit(1)

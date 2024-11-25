#!/bin/bash

# 备份原始 rsyslog 配置文件
cp /etc/rsyslog.conf /etc/rsyslog.conf_default

# 检查备份是否成功
if [ $? -ne 0 ]; then
    echo "备份失败，请检查权限或路径。"
    exit 1
fi

# 修改 rsyslog 配置文件
echo "*.* @172.16.53.103:514" >> /etc/rsyslog.conf

# 检查配置文件是否修改成功
if [ $? -ne 0 ]; then
    echo "修改配置文件失败，请检查权限。"
    exit 1
fi

# 重启 rsyslog 服务
systemctl restart rsyslog

# 检查 rsyslog 服务是否重启成功
if [ $? -ne 0 ]; then
    echo "rsyslog 服务重启失败，请检查服务状态。"
    exit 1
fi

echo "rsyslog 配置已更新并重启成功。"

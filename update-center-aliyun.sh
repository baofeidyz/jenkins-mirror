#!/bin/bash

# 自动更新 Jenkins 镜像脚本
# 功能：下载 Jenkins 更新中心配置，替换插件下载地址为阿里云镜像

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOWNLOAD_URL="https://updates.jenkins.io/update-center.json"
TEMP_FILE="${SCRIPT_DIR}/update-center-temp.json"
OUTPUT_FILE="${SCRIPT_DIR}/update-center-aliyun.json"

echo "开始下载 Jenkins 更新中心配置..."
curl -sL -o "${TEMP_FILE}" "${DOWNLOAD_URL}"

if [ ! -f "${TEMP_FILE}" ]; then
    echo "错误：下载失败"
    exit 1
fi

echo "处理文件：替换插件下载地址..."
# 移除 JSONP 包装（updateCenter.post( 和 末尾的 )）
sed '1s/^updateCenter.post(//' "${TEMP_FILE}" | sed '$ s/.$//' > "${OUTPUT_FILE}.tmp"

# 替换阿里云镜像地址
sed 's|https://updates.jenkins.io/download/plugins/|https://mirrors.aliyun.com/jenkins/plugins/|g' "${OUTPUT_FILE}.tmp" > "${OUTPUT_FILE}"

# 清理临时文件
rm -f "${TEMP_FILE}" "${OUTPUT_FILE}.tmp"

echo "完成！文件已保存到：${OUTPUT_FILE}"
echo "文件大小：$(du -h "${OUTPUT_FILE}" | cut -f1)"

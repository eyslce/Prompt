#!/usr/bin/env bash
# ---------------------------------------------
# LangGPT 模板快速应用脚本（Bash 版）
# 说明：
# 1. 从 code/ 目录加载模板
# 2. 替换变量 {LANG}, {AUTHOR}, {PROJECT}
# 3. 输出填充后的提示到控制台（可复制到 Cursor）
# ---------------------------------------------


set -e


TEMPLATE_DIR="$(dirname "$0")/code"


usage() {
echo "用法: $0 <template_name> <lang> [author]"
echo "例如: $0 role_codegen.md Go 'Tian Nan'"
exit 1
}


if [ $# -lt 2 ]; then
usage
fi


TEMPLATE_NAME=$1
LANG=$2
AUTHOR=${3:-$(whoami)}
PROJECT=$(basename $(pwd))


TEMPLATE_PATH="$TEMPLATE_DIR/$TEMPLATE_NAME"


if [ ! -f "$TEMPLATE_PATH" ]; then
echo "❌ 模板不存在: $TEMPLATE_PATH"
exit 1
fi


# 读取模板并进行变量替换
FILLED=$(<"$TEMPLATE_PATH")
FILLED=${FILLED//\{LANG\}/$LANG}
FILLED=${FILLED//\{AUTHOR\}/$AUTHOR}
FILLED=${FILLED//\{PROJECT\}/$PROJECT}


# 输出结果
echo "========================================"
echo "$FILLED"
echo "========================================"
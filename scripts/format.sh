#!/bin/sh -e
set -x

autoflake --remove-all-unused-imports --recursive --in-place msaSignal docs_src --exclude=__init__.py
black msaSignal docs_src
isort msaSignal docs_src

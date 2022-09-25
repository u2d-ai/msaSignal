#!/usr/bin/env bash

set -e
set -x

mypy msaSignal
flake8 msaSignal docs_src
black msaSignal docs_src --check
isort msaSignal docs_src scripts --check-only


#!/bin/bash

PYTHON_FILES="../src/*.py"
PROJECT=lliuwin
WRKF=$PROJECT/$PROJECT.pot

mkdir -p $PROJECT

xgettext $PYTHON_FILES -o $WRKF


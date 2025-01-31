#!/usr/bin/env bash

shellcheck --shell=bash --external-sources \
  bin/* \
  lib/* \
  scripts/*

shfmt --language-dialect bash -i 2 --diff \
  ./**/*

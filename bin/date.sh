#!/bin/bash

                 date '+Bay Area: %T %Z'
              date -u '+     UTC: %T %Z'
TZ=Europe/London date '+  London: %T %Z'
TZ=Europe/Oslo   date '+    Oslo: %T %Z'
TZ=Asia/Calcutta date '+   Delhi: %T %Z'
TZ=Asia/Shanghai date '+Shanghai: %T %Z'

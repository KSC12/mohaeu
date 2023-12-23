#!/bin/bash
export NLS_LANG=KOREAN_KOREA.AL32UTF8 && sqlplus system/gtcha6 @/tmp/startup.sql && rm -rf /tmp/startup.sql

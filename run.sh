#!/usr/bin/env bash

#----------------------------------------------------------
# 
# Startovanje programa kada je kompajliran sa dinamickim
# bibliotekama, tako se rucno pokrene loader, sa 
# definisanom putanjom do biblioteke i programa
#
#----------------------------------------------------------

/lib64/ld-linux-x86-64.so.2 --library-path ./lib/bin ./bin/run


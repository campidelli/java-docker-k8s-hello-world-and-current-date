#!/usr/bin/env bash
printf "\n\n******** Bulding current-date ********\n\n"
cd current-date/
./k8s_build_push_run.sh

printf "\n\n******** Bulding hello-world ********\n\n"
cd ../hello-world/
./k8s_build_push_run.sh

cd ..

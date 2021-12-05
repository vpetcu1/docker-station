#!/bin/bash

cd /work/Abatech20/tools/eclipse
mkdir disabled
mkdir disabled/features disabled/plugins
mv plugins/org.eclipse.jpt.* disabled/plugins
mv features/org.eclipse.jpt.* disabled/features
cd "$OLDPWD"

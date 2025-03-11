#!/bin/bash

set +e

# --------For the DR site-------------
oc project mqdr
oc delete QueueManager melqm
oc delete secret mqkey melkey tls-syd
oc delete configMap mq1-mqsc
oc delete route melroute

set -e
oc apply -f melRoute.yaml

oc create secret tls mqkey --cert=./tls/tls.crt --key=./tls/tls.key
# Key and cert for CRR
oc create secret tls melkey --cert=./tls/tls.crt --key=./tls/tls.key
oc create secret generic tls-syd --from-file ./tls/tls.crt

oc create -f mqsc/mqsc.yaml
oc apply -f melCrr.yaml
# ----------------------------------



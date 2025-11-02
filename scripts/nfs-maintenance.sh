#!/bin/bash
# Helper script for TrueNAS/NFS maintenance
# Usage: ./nfs-maintenance.sh [pre|post]

set -e

ACTION=${1:-help}

if [ "$ACTION" = "pre" ]; then
    echo "=== Pre-Maintenance: Scaling down pods using NFS ==="
    
    # Find all PVCs using nfs-truenas storage class
    echo "Finding PVCs using nfs-truenas storage class..."
    PVC_NAMESPACES=$(kubectl get pvc --all-namespaces -o json | \
        jq -r '.items[] | select(.spec.storageClassName=="nfs-truenas") | "\(.metadata.namespace)/\(.metadata.name)"')
    
    if [ -z "$PVC_NAMESPACES" ]; then
        echo "No PVCs found using nfs-truenas storage class."
        exit 0
    fi
    
    echo "Found PVCs:"
    echo "$PVC_NAMESPACES"
    
    # Scale down deployments using these PVCs
    for NS_PVC in $PVC_NAMESPACES; do
        NS=$(echo $NS_PVC | cut -d'/' -f1)
        PVC=$(echo $NS_PVC | cut -d'/' -f2)
        
        echo "Finding deployments using PVC $PVC in namespace $NS..."
        DEPLOYMENTS=$(kubectl get deployments -n $NS -o json | \
            jq -r ".items[] | select(.spec.template.spec.volumes[]?.persistentVolumeClaim.claimName==\"$PVC\") | .metadata.name")
        
        for DEPLOYMENT in $DEPLOYMENTS; do
            echo "Scaling down deployment $DEPLOYMENT in namespace $NS..."
            kubectl scale deployment $DEPLOYMENT -n $NS --replicas=0
        done
    done
    
    echo "=== Pre-maintenance complete. Safe to reboot TrueNAS. ==="
    
elif [ "$ACTION" = "post" ]; then
    echo "=== Post-Maintenance: Scaling up pods using NFS ==="
    
    # Find all PVCs using nfs-truenas storage class
    PVC_NAMESPACES=$(kubectl get pvc --all-namespaces -o json | \
        jq -r '.items[] | select(.spec.storageClassName=="nfs-truenas") | "\(.metadata.namespace)/\(.metadata.name)"')
    
    if [ -z "$PVC_NAMESPACES" ]; then
        echo "No PVCs found using nfs-truenas storage class."
        exit 0
    fi
    
    # Scale up deployments using these PVCs
    for NS_PVC in $PVC_NAMESPACES; do
        NS=$(echo $NS_PVC | cut -d'/' -f1)
        PVC=$(echo $NS_PVC | cut -d'/' -f2)
        
        DEPLOYMENTS=$(kubectl get deployments -n $NS -o json | \
            jq -r ".items[] | select(.spec.template.spec.volumes[]?.persistentVolumeClaim.claimName==\"$PVC\") | .metadata.name")
        
        for DEPLOYMENT in $DEPLOYMENTS; do
            echo "Scaling up deployment $DEPLOYMENT in namespace $NS..."
            # Get original replica count from deployment (assume 1 if not found)
            REPLICAS=$(kubectl get deployment $DEPLOYMENT -n $NS -o jsonpath='{.spec.replicas}' 2>/dev/null || echo "1")
            kubectl scale deployment $DEPLOYMENT -n $NS --replicas=$REPLICAS
        done
    done
    
    echo "=== Post-maintenance complete. Checking pod status... ==="
    sleep 5
    kubectl get pods --all-namespaces -o wide | grep -E "NAMESPACE|nfs|truenas" || true
    
elif [ "$ACTION" = "check" ]; then
    echo "=== Checking NFS mount status ==="
    kubectl get pvc --all-namespaces | grep nfs-truenas || echo "No NFS PVCs found"
    echo ""
    echo "=== Checking pods using NFS ==="
    kubectl get pods --all-namespaces -o json | \
        jq -r '.items[] | select(.spec.volumes[]?.persistentVolumeClaim) | "\(.metadata.namespace)/\(.metadata.name)"' | \
        while read NS_POD; do
            NS=$(echo $NS_POD | cut -d'/' -f1)
            POD=$(echo $NS_POD | cut -d'/' -f2)
            PVC=$(kubectl get pod $POD -n $NS -o jsonpath='{.spec.volumes[?(@.persistentVolumeClaim)].persistentVolumeClaim.claimName}')
            SC=$(kubectl get pvc $PVC -n $NS -o jsonpath='{.spec.storageClassName}' 2>/dev/null || echo "")
            if [ "$SC" = "nfs-truenas" ]; then
                STATUS=$(kubectl get pod $POD -n $NS -o jsonpath='{.status.phase}')
                echo "$NS/$POD: $STATUS (PVC: $PVC)"
            fi
        done
    
else
    echo "Usage: $0 [pre|post|check]"
    echo ""
    echo "  pre   - Scale down pods before TrueNAS maintenance"
    echo "  post  - Scale up pods after TrueNAS maintenance"
    echo "  check - Check status of pods using NFS storage"
    exit 1
fi


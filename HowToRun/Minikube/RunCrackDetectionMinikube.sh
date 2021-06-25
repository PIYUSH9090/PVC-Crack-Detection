#!/bin/sh
abort()
{
    echo >&2 '
***************
*** ABORTED RunCrackDetectionMinikube.sh ***
***************
'
    echo "An error occurred in RunCrackDetectionMinikube.sh . Exiting..." >&2
    exit 1
}

trap 'abort' 0

set -e

LEVEL=NONDEBUG
if [ "$LEVEL" == "DEBUG" ]; then
	echo "Level is DEBUG.Press Enter"
else
	echo "Level is NOT DEBUG. There will be no wait"	
fi

#kubernatesDeployments.sh
# NOTE:INFO:
# you would have to delete minikube if you face an error.
# install java again by downloading from oracle. if system extension are blocked.
# After that restart the system.
# Switch to root folder and run.


cd ../../
minikube start --memory 10240 --cpus=4 
echo '1/5: Is Minikube running ?'
minikube status
unset DOCKER_HOST
unset DOCKER_TLS_VERIFY
unset DOCKER_TLS_PATH
docker ps

# It will switch to the CrackDetection-logic folder to run that shell file
cd CrackDetection-logic
# TODO move it to how to run the directories.
sh BuildCrackDetection-logicDocker.sh > ../logs/CrackDetection-logic.log

# Come again root folder
cd ../

CURRENT_DATE=`date +%b-%d-%y_%I_%M_%p`
echo "Starting At "$CURRENT_DATE

echo "2/5 Deleting previous deployments."
#TODO: invoke delete.
kubectl get deployments
kubectl delete deployments --all --ignore-not-found
kubectl get deployments
# TODO: invoke delete
kubectl get services
kubectl delete services --all --ignore-not-found
kubectl get services

# This will deploy the deployment .yaml
echo "3/5 Deploying CrackDetection-logic deployments."
kubectl apply -f resource-manifests/deployment.yaml --record
kubectl get deployments
kubectl get pods

# It will deploy the service of sentiment-analyse-logic container
echo "4/5 Deploying service-CrackDetection-logic services."
kubectl apply -f resource-manifests/CrackDetection-logic.yaml --record
kubectl get services
kubectl get pods
# This command will deploy this container to server we will redirect in browser 
echo "5/5 Lets check it in browser"
minikube service api-service


trap : 0

echo >&2 '
************
*** DONE RunCrackDetectionMinikube ***
************'
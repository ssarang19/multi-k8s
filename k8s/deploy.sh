docker build -t ssarang19/multi-client-k8s:latest -t ssarang19/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t ssarang19/multi-server-k8s-pgfix:latest -t ssarang19/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t ssarang19/multi-worker-k8s:latest -t ssarang19/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push ssarang19/multi-client-k8s:latest
docker push ssarang19/multi-server-k8s-pgfix:latest
docker push ssarang19/multi-worker-k8s:latest

docker push ssarang19/multi-client-k8s:$SHA
docker push ssarang19/multi-server-k8s-pgfix:$SHA
docker push ssarang19/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ssarang19/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=ssarang19/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=ssarang19/multi-worker-k8s:$SHA
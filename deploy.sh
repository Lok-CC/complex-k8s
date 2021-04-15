docker build -t lokcc/multi-client:latest -t lokcc/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lokcc/multi-server:latest -t lokcc/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lokcc/multi-worker:latest -t lokcc/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lokcc/multi-client:latest
docker push lokcc/multi-server:latest
docker push lokcc/multi-worker:latest

docker push lokcc/multi-client:$SHA
docker push lokcc/multi-server:$SHA
docker push lokcc/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=lokcc/multi-client:$SHA
kubectl set image deployments/server-deployment server=lokcc/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=lokcc/multi-worker:$SHA
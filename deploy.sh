docker build -t nabetse28/multi-client:latest -t nabetse28/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nabetse28/multi-server:latest -t nabetse28/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nabetse28/multi-worker:latest -t nabetse28/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push nabetse28/multi-client:latest
docker push nabetse28/multi-server:latest
docker push nabetse28/multi-worker:latest

docker push nabetse28/multi-client:$SHA
docker push nabetse28/multi-server:$SHA
docker push nabetse28/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nabetse28/multi-server:$SHA
kubectl set image deployments/client-deployment client=nabetse28/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nabetse28/multi-worker:$SHA

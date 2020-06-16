docker build -t orange29/multi-client:latest -t orange29/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t orange29/multi-server:latest -t orange29/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t orange29/multi-worker:latest -t orange29/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push orange29/multi-client:latest
docker push orange29/multi-server:latest
docker push orange29/multi-worker:latest

docker push orange29/multi-client:$SHA
docker push orange29/multi-server:$SHA
docker push orange29/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=orange29/multi-server:$SHA
kubectl set image deployments/client-deployment client=orange29/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=worker=orange29/multi-worker:$SHA

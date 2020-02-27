docker build -t mariustudor/multi-client:latest -t mariustudor/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t mariustudor/multi-server:latest -t mariustudor/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t mariustudor/multi-worker:latest -t mariustudor/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mariustudor/multi-client:latest
docker push mariustudor/multi-server:latest
docker push mariustudor/multi-worker:latest

docker push mariustudor/multi-client:$SHA
docker push mariustudor/multi-server:$SHA
docker push mariustudor/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=mariustudor/multi-server:$SHA
kubectl set image deployments/client-deployment client=mariustudor/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=mariustudor/multi-worker:$SHA
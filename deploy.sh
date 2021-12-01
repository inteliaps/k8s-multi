docker build -t inteliaps/multi-client:latest -t inteliaps/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t inteliaps/multi-server-test:latest -t inteliaps/multi-server-test:$SHA -f ./server/Dockerfile ./server
docker build -t inteliaps/multi-worker-test:latest -t inteliaps/multi-worker-test:$SHA -f ./worker/Dockerfile ./worker
docker push inteliaps/multi-client:latest
docker push inteliaps/multi-server:latest
docker push inteliaps/multi-worker:latest

docker push inteliaps/multi-client:$SHA
docker push inteliaps/multi-server:$SHA
docker push inteliaps/multi-worker:$SHA

kubectl apply -f K8s
kubectl set image deployments/server-deployment server=inteliaps/multi-server:$SHA
kubectl set image deployments/client-deployment client=inteliaps/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=inteliaps/multi-worker:$SHA
docker build -t mahosind95/multi-client:latest -t mahosind95/multi-client:$SHA -f ./client /Dockerfile ./client
docker build -t mahosind95/multi-server:latest -t mahosind95/multi-server:$SHA -f ./server /Dockerfile ./server
docker build -t mahosind95/multi-worker:latest -t mahosind95/multi-worker:$SHA -f ./worker /Dockerfile ./worker

docker push mahosind95/multi-server:latest
docker push mahosind95/multi-client:latest
docker push mahosind95/multi-worker:latest

docker push mahosind95/multi-server:$SHA
docker push mahosind95/multi-client:$SHA
docker push mahosind95/multi-worker:$SHA
kubectl apply -f k8s

kubectl set image deployements/server-deployment server=mahosind95/multi-server:$SHA
kubectl set image deployements/client-deployment client=mahosind95/multi-client:$SHA
kubectl set image deployements/worker-deployment worker=mahosind95/multi-worker:$SHA
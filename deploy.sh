docker build -t katiebvogel/multi-client:latest -t katiebvogel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t katiebvogel/multi-server:latest -t katiebvogel/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t katiebvogel/multi-worker:latest -t katiebvogel/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push katiebvogel/multi-client:latest
docker push katiebvogel/multi-server:latest
docker push katiebvogel/multi-worker:latest

docker push katiebvogel/multi-client:$SHA
docker push katiebvogel/multi-server:$SHA
docker push katiebvogel/multi-worker:$SHA 

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=katiebvogel/multi-server:$SHA 
kubectl set image deployments/client-deployment client=katiebvogel/multi-client:$SHA 
kubectl set image deployments/worker-deployment worker=katiebvogel/multi-worker:$SHA 

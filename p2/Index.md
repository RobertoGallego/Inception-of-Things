cat << ENDL > app1-deploy.yaml
  apiVersion: apps/v1
  kind: Deployment
  metadata:
    name: app-one
  spec:
    replicas: 1
    selector:
      matchLabels:
        app: app-one
    template:
      metadata:
        labels:
          app: app-one
      spec:
        containers:
        - name: app1
          image: paulbouwer/hello-kubernetes:1.10
          ports:
          - containerPort: 8080
          env:
          - name: MESSAGE
            value: "Hello from app1."
ENDL

kubectl create -f app1-deploy.yaml
kubectl apply -f app1-deploy.yaml -n kube-system

cat << ENDL > app1-service.yaml
  apiVersion: v1
  kind: Service
  metadata:
    name: app-one-svc
  spec:
    ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
    selector:
      app: app-one
ENDL

- name: http

kubectl create -f app1-service.yaml
kubectl apply -f app1-service.yaml -n kube-system

cat << ENDL > app1-ingress.yaml
  apiVersion: networking.k8s.io/v1
  kind: Ingress
  metadata:
    name: app-ingress
    annotations:
      kubernetes.io/ingress.class: traefik
  spec:
    rules:
    - host: app1.com
      http:
        paths:
        - path: /
          pathType: Prefix
          backend:
            service:
              name: app-one-svc
              port: 
                number: 80
ENDL

kubectl create -f app1-ingress.yaml
kubectl apply -f app1-ingress.yaml -n kube-system

---------------------------

kubectl get all --all-namespaces
kubectl delete namespaces <NAME>
kubectl delete -f  <FILE>
curl -H "Host:app1.com" 192.168.42.110
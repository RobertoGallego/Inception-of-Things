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

---------------------------
synced_folder

mkdir share
mount -t vboxsf vagrant share <------
mount -t vboxsf vagrant /home/vagrant

sudo firewall-cmd --state

kubectl apply -f deployment.yaml -n kube-system
kubectl apply -f service.yaml -n kube-system
kubectl apply -f ingress.yaml -n kube-system

kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
curl -H "Host:app1.com" 192.168.42.110

--------------------------

https://kubernetes.io/docs/concepts/configuration/overview/
https://dwdraju.medium.com/how-deployment-service-ingress-are-related-in-their-manifest-a2e553cf0ffb
https://levelup.gitconnected.com/a-guide-to-k3s-ingress-using-traefik-with-nodeport-6eb29add0b4b
https://itnext.io/setup-your-own-kubernetes-cluster-with-k3s-b527bf48e36a
https://platform9.com/blog/kubernetes-service-discovery-principles-in-practice/
https://hpe-container-platform-community.github.io/learn-kubedirector/docs/kd-img-dev/customdockerimage2/
https://github.com/paulbouwer/hello-kubernetes
https://kubernetes.io/docs/concepts/cluster-administration/manage-deployment/
https://kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/
https://kubernetes.io/docs/concepts/services-networking/ingress/
https://www.youtube.com/watch?v=fXQbkW1RNhE&list=PLxNYxgaZ8Rscf-XJ5VfXgbDAk1vL4xaMl&t=142s

protocol
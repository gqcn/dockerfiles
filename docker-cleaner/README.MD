用以解决`Kubernetes`集群节点的`docker`镜像资源占用问题，执行自动清理，可通过`CRONTAB`环境变量自定义定时任务脚本。
在`Kubernetes`集群中务必需要使用`daemonset`类型，并且挂载宿主机的以下两个路径作为共享卷：
- `/usr/bin/docker`
- `/var/run/docker.sock`

参考`yaml`配置：
```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  name     : docker-cleaner
  namespace: infra
spec:
  selector:
    matchLabels:
      app: docker-cleaner
  template:
    metadata:
      labels:
        app: docker-cleaner
    spec:
      nodeSelector:
        nodezone: b
      imagePullSecrets:
        - name: regsecret
      containers:
      - name : docker-cleaner
        image: "registry-vpc.cn-hangzhou.aliyuncs.com/medlinker/docker-cleaner"
        imagePullPolicy: Always
        env:
        - name : CRONTAB
          value: "0 1 * * * root docker system prune -a -f > /dev/null 2>&1 &"
        volumeMounts:
        - name     : docker-bin
          mountPath: /usr/bin/docker
        - name     : docker-sock
          mountPath: /var/run/docker.sock
      volumes:
      - name    : docker-bin
        hostPath:
          path: /usr/bin/docker
      - name    : docker-sock
        hostPath:
          path: /var/run/docker.sock
```



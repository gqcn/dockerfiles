# Repository Guidelines

## 项目结构与模块组织

本仓库按 Docker 镜像名称和版本组织内容。一级目录是镜像或组件名称，如 `ubuntu/`、`php/`、`kafka/`、`zookeeper/`、`docker-cleaner/`；二级目录通常是版本号或镜像变体，如 `ubuntu/24.04-npm/`、`php/7.2/`。每个镜像目录以 `Dockerfile` 为入口，配套文件放在同级 `dockerfiles/`、配置文件或 README 中。Kubernetes 示例清单位于对应组件目录内，例如 `elasticsearch/k8s-example-statefulset.yaml`、`zookeeper/3.4/k8s-example-*.yaml`。

## 构建、测试与开发命令

- `docker build -t loads/ubuntu:24.04-npm -f ubuntu/24.04-npm/Dockerfile ubuntu/24.04-npm`：本地构建指定镜像。
- `docker buildx build --platform linux/amd64,linux/arm64 -t loads/ubuntu:24.04-npm -f ubuntu/24.04-npm/Dockerfile ubuntu/24.04-npm --push`：构建并推送多架构镜像。
- `make up tool=codex`：将当前变更加入暂存区，自动生成提交信息，提交并推送；执行前请确认 diff。
- GitHub Actions 当前只覆盖 `ubuntu/24.04-npm/**`，推送到 `main` 或 `master` 时构建并发布 `loads/ubuntu:24.04-npm`。

## 编码风格与命名约定

Dockerfile 使用 4 段式注释风格：镜像标签、`INSTALLATION`、可选配置、`START`。保持指令清晰，相关包安装尽量合并到同一个 `RUN`，并在结尾执行必要清理，例如 `apt-get clean`。目录命名使用小写组件名和明确版本号，如 `kafka/2.2/`、`php-composer/7.2/`。新增镜像时，首行注释写明目标标签，例如 `# loads/kafka:2.2`。

## 测试与验证指南

仓库没有统一测试框架；每次修改 Dockerfile 后至少执行一次本地构建。涉及服务启动脚本时，应额外运行容器验证关键命令或健康检查，例如 `zookeeper/3.4/zkOk.sh`。修改 Kubernetes YAML 时，用 `kubectl apply --dry-run=client -f <file>` 做语法验证。

## 提交与 Pull Request 规范

历史提交多为简短英文小写信息，例如 `add ci workflow and makefile`、`add grpcurl for devops`；避免只写 `up`，尽量说明变更对象和目的。PR 应包含变更的镜像路径、目标标签、构建命令和验证结果。若变更会发布镜像，请说明 Docker Hub 标签和所需 secrets，例如 `DOCKERHUB_USERNAME`、`DOCKERHUB_TOKEN`。

## 安全与配置提示

不要在 Dockerfile、YAML 或 README 中提交账号、token、私有 registry 密码。CI 凭据统一放在 GitHub Secrets。引入外部仓库、PPA 或下载地址时，优先固定版本，并说明用途，避免无意升级基础镜像或运行时依赖。

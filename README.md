# Codyssey 개발 환경 구축 및 Docker 실습

## 1. 프로젝트 소개

Codyssey 개발 환경을 구축하고 Git, Linux, Docker의 기본 사용법을 실습한 프로젝트입니다.

Ubuntu 컨테이너 실행부터 Nginx 웹 서버 구축, 포트 매핑, Bind Mount, Docker Volume까지 실습했습니다. 또한 GitHub와 VS Code를 연동하여 프로젝트를 관리하고, 실행 결과와 오류 해결 과정을 기록했습니다.

## 2. 개발 환경

| 항목 | 사양 |
|---|---|
| 운영체제 | macOS |
| 개발 장비 | MacBook Pro (Apple Silicon) |
| 아키텍처 | ARM64 |
| 터미널 | zsh |
| Docker Desktop | 4.97.0 |
| Docker CLI | 29.9.2 |
| Docker Engine | 29.9.2 |
| Docker Context | desktop-linux |
| Git | 2.50.0 |
| 에디터 | Visual Studio Code |

## 3. 프로젝트 구조

```text
practice/
├── Dockerfile
├── README.md
├── logs/
│   ├── terminal.log
│   ├── docker.log
│   └── mission-evidence.log
├── evidence/
│   ├── terminal/
│   └── docker/
├── terminal/
│   ├── backup/
│   ├── files/
│   └── scripts/
│       └── hello.txt
└── web/
    └── index.html
```

- `terminal/`: Linux 터미널 및 파일 관리 실습
- `web/`: Nginx 웹 서버에서 제공할 HTML 파일
- `logs/`: 환경 정보 및 실습 명령어 실행 결과
- `evidence/`: 실습 화면 캡처 자료
- `Dockerfile`: Docker 이미지 빌드 설정
- `README.md`: 프로젝트 설명 및 실습 과정

## 4. 주요 실습

### 4-1. Linux 파일 및 디렉터리 관리

파일 생성, 이동, 삭제 및 권한 변경을 실습했습니다.

| 명령어 | 기능 |
|---|---|
| `pwd` | 현재 작업 디렉터리 확인 |
| `ls -la` | 파일 및 디렉터리 상세 정보 확인 |
| `touch` | 파일 생성 |
| `mkdir` | 디렉터리 생성 |
| `mv` | 파일 이동 및 이름 변경 |
| `rm` | 파일 삭제 |
| `chmod` | 파일 권한 변경 |
| `ls -l` | 파일 권한 및 상세 정보 확인 |

### 4-2. Linux 파일 권한

Linux 파일 권한은 읽기(r), 쓰기(w), 실행(x)으로 구분됩니다.

| 권한 | 숫자 | 의미 |
|---|---:|---|
| r | 4 | 읽기 |
| w | 2 | 쓰기 |
| x | 1 | 실행 |
| rwx | 7 | 읽기, 쓰기, 실행 |
| r-x | 5 | 읽기, 실행 |

예를 들어 `chmod 755 파일명`은 소유자에게 읽기·쓰기·실행 권한을 부여하고, 그룹과 다른 사용자에게 읽기·실행 권한을 부여합니다.

### 4-3. Ubuntu 컨테이너 실행

Ubuntu 이미지를 이용해 컨테이너를 실행했습니다.

```bash
docker run -it --name ubuntu-practice ubuntu bash
```

컨테이너 내부에서 다음 명령어를 실행했습니다.

```bash
pwd
ls -la
echo "Hello from Ubuntu!"
cat /etc/os-release
```

컨테이너 내부의 디렉터리 구조와 운영체제 정보를 확인했습니다.

### 4-4. Docker 기본 명령어

| 명령어 | 기능 |
|---|---|
| `docker --version` | Docker 버전 확인 |
| `docker info` | Docker 엔진 정보 확인 |
| `docker run hello-world` | Docker 실행 테스트 |
| `docker ps -a` | 전체 컨테이너 목록 확인 |
| `docker images` | 이미지 목록 확인 |
| `docker exec` | 실행 중인 컨테이너에서 명령어 실행 |
| `docker attach` | 컨테이너의 메인 프로세스에 연결 |
| `docker logs` | 컨테이너 로그 확인 |
| `docker stats` | 컨테이너 리소스 사용량 확인 |

### 4-5. Nginx 웹 서버 구축

Nginx 기반 웹 서버 이미지를 생성하기 위해 Dockerfile을 작성했습니다.

**Dockerfile**

```dockerfile
FROM nginx:alpine

LABEL maintainer="Codyssey Practice"

COPY web/ /usr/share/nginx/html/

EXPOSE 80
```

**이미지 빌드**

```bash
docker build -t codyssey-web:1.0 .
```

**컨테이너 실행**

```bash
docker run -d --name codyssey-web \
  -p 8080:80 codyssey-web:1.0
```

Dockerfile을 이용해 이미지를 빌드하고, 생성한 이미지로 컨테이너를 실행했습니다.

### 4-6. 포트 매핑

호스트와 컨테이너의 포트를 연결하여 외부에서 웹 서버에 접근했습니다.

| 호스트 포트 | 컨테이너 포트 |
|---|---|
| 8080 | 80 |
| 8081 | 80 |
| 8082 | 80 |

브라우저 접속 주소:

- http://localhost:8080/
- http://localhost:8081/
- http://localhost:8082/

Docker 컨테이너는 네트워크 네임스페이스를 통해 독립적인 네트워크 환경을 가집니다. 포트 매핑은 호스트의 포트와 컨테이너의 포트를 연결하는 기능입니다.

예를 들어 `-p 8080:80`은 호스트의 8080번 포트를 컨테이너의 80번 포트에 연결합니다.

### 4-7. Bind Mount

호스트의 `web` 디렉터리를 컨테이너 내부의 Nginx 웹 문서 디렉터리와 연결했습니다.

```bash
docker run -d --name web-bind \
  -p 8082:80 \
  -v "$PWD/web:/usr/share/nginx/html:ro" \
  nginx:alpine
```

호스트에서 HTML 파일을 수정하면 컨테이너를 다시 빌드하지 않아도 변경 사항이 반영되는 것을 확인했습니다.

- 상대 경로: 현재 작업 디렉터리를 기준으로 지정합니다.
- 절대 경로: 전체 경로를 지정하므로 실행 위치에 영향을 덜 받습니다.
- `:ro`: 컨테이너에서 읽기 전용으로 마운트합니다.

실습에서는 `$PWD/web`을 사용하여 프로젝트의 웹 디렉터리를 연결했습니다.

### 4-8. Docker Volume

Docker Volume을 생성하고 컨테이너의 `/data` 디렉터리에 연결했습니다.

**Volume 생성**

```bash
docker volume create codyssey-data
```

**Volume 연결**

```bash
docker run -it --name volume-test \
  -v codyssey-data:/data ubuntu bash
```

Volume에 데이터를 저장한 후 컨테이너와 별개로 데이터가 유지되는지 확인했습니다.

**데이터 유지 확인**

```bash
docker run --rm \
  -v codyssey-data:/data \
  ubuntu cat /data/test.txt
```

확인 결과:

```text
Docker Volume Persistence Test
```

컨테이너가 종료되거나 삭제되어도 Volume에 저장된 데이터는 별도로 유지될 수 있습니다.

### 4-9. Volume 백업 및 복구

Volume 데이터 손실을 방지하기 위해 tar를 이용한 백업 및 복구 방법을 정리했습니다.

**백업**

```bash
docker run --rm \
  -v codyssey-data:/data \
  -v "$PWD":/backup \
  ubuntu \
  tar -czf /backup/codyssey-data-backup.tar.gz -C /data .
```

**복구**

```bash
docker run --rm \
  -v codyssey-data:/data \
  -v "$PWD":/backup \
  ubuntu \
  tar -xzf /backup/codyssey-data-backup.tar.gz -C /data
```

백업 파일은 원본 Volume과 다른 안전한 위치에도 보관하는 것이 좋습니다.

## 5. 포트 충돌 및 문제 해결

### 포트 충돌 확인

macOS에서 특정 포트를 사용 중인 프로세스를 확인할 수 있습니다.

```bash
lsof -i :8080
```

이미 다른 프로세스가 포트를 사용하고 있다면 해당 프로그램을 확인하고 정상 종료하거나 다른 호스트 포트를 지정합니다.

### Docker 데몬 연결 오류

Docker 명령어 실행 중 다음과 같은 오류가 발생했습니다.

```text
failed to connect to the docker API
docker.sock: no such file or directory
```

**문제 해결 과정**

1. 가설: Docker Desktop 엔진이 실행되지 않은 상태라고 판단했습니다.
2. 검증: `docker info`를 실행하여 Docker Server 연결 실패를 확인했습니다.
3. 조치: Docker Desktop을 다시 실행하고 엔진이 시작될 때까지 기다렸습니다.
4. 결과: `docker info`, `docker ps -a`가 정상적으로 실행되었고 기존 컨테이너를 다시 시작할 수 있었습니다.

오류와 해결 과정은 `logs/mission-evidence.log`에 기록했습니다.

## 6. Git 및 GitHub 연동

Git을 이용해 프로젝트의 버전을 관리하고 GitHub 원격 저장소에 업로드했습니다.

주요 작업:

- Git 사용자 정보 설정
- 기본 브랜치 `main` 설정
- 로컬 저장소 생성
- GitHub 원격 저장소 연결
- 커밋 및 Push
- VS Code에서 GitHub 로그인 및 저장소 연동

**원격 저장소 확인**

```bash
git remote -v
```

**커밋 기록 확인**

```bash
git log --oneline
```

GitHub 저장소:

https://github.com/minhee04/ai-codyssey

## 7. 실습 결과 및 증거 자료

실습 과정에서 생성한 로그와 화면 캡처를 별도로 보관했습니다.

| 자료 | 내용 |
|---|---|
| `logs/terminal.log` | 터미널 및 개발 환경 정보 |
| `logs/docker.log` | Docker 엔진, 컨테이너, 이미지, Volume 정보 |
| `logs/mission-evidence.log` | 추가 실습 및 실행 과정 기록 |
| `evidence/terminal/` | 터미널 실습 화면 |
| `evidence/docker/` | Docker 및 웹 서버 실습 화면 |

## 8. 주요 개념 정리

| 개념 | 설명 |
|---|---|
| Image | 컨테이너 실행에 필요한 파일과 설정을 포함한 템플릿 |
| Container | 이미지를 기반으로 실행되는 독립적인 환경 |
| Dockerfile | Docker 이미지를 만들기 위한 설정 파일 |
| Port Mapping | 호스트와 컨테이너의 포트를 연결하는 기능 |
| Bind Mount | 호스트의 특정 디렉터리를 컨테이너와 연결 |
| Volume | Docker가 관리하는 영구 데이터 저장 공간 |
| Network Namespace | 컨테이너별 네트워크 환경을 분리하는 기능 |

## 9. 참고 사항

- Docker 명령어를 실행하려면 Docker Desktop과 Docker 엔진이 실행 중이어야 합니다.
- 포트 번호가 이미 사용 중이면 다른 호스트 포트를 지정해야 합니다.
- Bind Mount의 호스트 경로는 프로젝트 디렉터리 위치에 따라 달라질 수 있습니다.
- GitHub 인증 정보와 개인 액세스 토큰은 저장소에 포함하지 않습니다.

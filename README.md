# Codyssey 개발 환경 구축 및 Docker 실습

## 1. 프로젝트 소개

Codyssey 개발 환경을 구축하고 Git과 Docker의 기본 사용법을 실습한 프로젝트입니다.

Docker를 활용하여 Ubuntu 컨테이너 실행, Nginx 웹 서버 구축, 포트 매핑, Bind Mount 및 Volume을 실습했습니다. GitHub와 VS Code를 연동하여 프로젝트를 관리했습니다.

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
├── terminal/
│   └── scripts/
│       └── hello.txt
└── web/
    └── index.html
```

## 4. 실습 내용

### 4-1. Ubuntu 컨테이너 실행

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

컨테이너의 디렉터리 구조와 운영체제 정보를 확인했습니다.

### 4-2. 컨테이너 관리 명령어

- `docker ps -a`: 전체 컨테이너 목록 확인
- `docker exec`: 실행 중인 컨테이너에서 추가 명령어 실행
- `docker attach`: 컨테이너의 메인 프로세스에 연결
- `docker logs`: 컨테이너 로그 확인
- `docker stats`: 컨테이너의 CPU, 메모리 등 리소스 사용량 확인
- `--no-stream`: 리소스 사용량을 한 번만 출력

### 4-3. Nginx 웹 서버 구축

Dockerfile을 작성하여 Nginx 기반 웹 서버 이미지를 생성했습니다.

```dockerfile
FROM nginx:alpine

LABEL maintainer="Codyssey Practice"

COPY web/ /usr/share/nginx/html/

EXPOSE 80
```

이미지 빌드:

```bash
docker build -t codyssey-web:1.0 .
```

컨테이너 실행:

```bash
docker run -d --name codyssey-web -p 8080:80 codyssey-web:1.0
```

### 4-4. 포트 매핑

호스트 포트와 컨테이너 포트를 연결하여 웹 서버에 접속했습니다.

| 호스트 포트 | 컨테이너 포트 |
|---|---|
| 8080 | 80 |
| 8081 | 80 |
| 8082 | 80 |

브라우저에서 다음 주소로 접속했습니다.

- http://localhost:8080/
- http://localhost:8081/
- http://localhost:8082/

### 4-5. Bind Mount

호스트의 web 디렉터리를 컨테이너 내부의 Nginx 웹 문서 디렉터리와 연결했습니다.

```bash
docker run -d --name web-bind \
  -p 8082:80 \
  -v "$PWD/web:/usr/share/nginx/html:ro" \
  nginx:alpine
```

호스트에서 HTML 파일을 수정한 후 컨테이너를 재생성하거나 이미지를 다시 빌드하지 않아도 변경 사항이 웹 페이지에 반영되는 것을 확인했습니다.

`:ro` 옵션을 사용하여 컨테이너에서 읽기 전용으로 연결했습니다.

### 4-6. Docker Volume

Docker Volume을 생성하고 컨테이너의 `/data` 디렉터리에 연결했습니다.

```bash
docker volume create codyssey-data
```

Volume을 연결한 컨테이너에서 데이터를 저장하고 컨테이너 삭제 후에도 데이터가 유지되는지 확인하는 실습을 진행했습니다.

```bash
docker run -it --name volume-test \
  -v codyssey-data:/data ubuntu bash
```

### 4-7. Git 및 GitHub 연동

- Git 사용자 정보 설정
- 기본 브랜치 `main` 설정
- 로컬 저장소 생성
- GitHub 원격 저장소 연결
- 커밋 및 Push
- VS Code에서 GitHub 로그인 및 기존 저장소 연동 확인

GitHub 저장소: https://github.com/minhee04/ai-codyssey

## 5. 실습 결과

- Ubuntu 컨테이너 실행 및 기본 명령어 실습
- Docker 이미지 빌드 및 컨테이너 실행
- Nginx 웹 서버 구축 및 브라우저 접속 확인
- 포트 매핑을 통한 외부 접속 확인
- Bind Mount를 통한 호스트 파일 변경 사항 반영 확인
- Docker Volume을 이용한 데이터 저장 실습
- GitHub 및 VS Code 저장소 연동

## 6. 주요 개념 정리

| 개념 | 설명 |
|---|---|
| Image | 컨테이너 실행에 필요한 파일과 설정을 포함한 템플릿 |
| Container | 이미지를 기반으로 실행되는 독립적인 환경 |
| Port Mapping | 호스트와 컨테이너의 포트를 연결하는 기능 |
| Bind Mount | 호스트의 특정 디렉터리를 컨테이너와 연결 |
| Volume | Docker가 관리하는 영구 데이터 저장 공간 |
| Dockerfile | Docker 이미지를 만들기 위한 설정 파일 |

## 7. 참고 사항

- Docker Desktop이 실행 중이어야 Docker 명령어를 사용할 수 있습니다.
- 포트 번호가 이미 사용 중이면 다른 호스트 포트를 지정해야 합니다.
- Bind Mount의 호스트 경로는 프로젝트 디렉터리 위치에 따라 달라질 수 있습니다.
- GitHub 인증 정보와 개인 액세스 토큰은 저장소에 포함하지 않습니다.

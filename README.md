# Codyssey Linux & Docker Practice

## 1. 프로젝트 소개

본 프로젝트는 Codyssey 입학연수 과정에서 학습한 Linux 터미널 및 Docker의 기본 개념과 사용 방법을 실습하고 정리한 프로젝트이다.

Linux 환경에서 파일과 디렉터리를 관리하는 방법부터 Docker 컨테이너 실행, 이미지 생성, 데이터 저장 및 백업, 네트워크 설정, 오류 해결까지 학습하였다.

단순히 명령어를 실행하는 것에 그치지 않고 각 명령어의 역할과 옵션, 실행 결과의 의미를 이해하는 것을 목표로 한다.

---

## 2. 개발 환경

| 항목 | 환경 |
|---|---|
| OS | macOS |
| Device | MacBook Pro (Apple Silicon, ARM64) |
| Shell | zsh |
| Docker Desktop | 4.97.0 |
| Docker CLI / Engine | 29.9.2 |
| Docker Context | desktop-linux |
| Git | 2.50.0 |
| Editor | Visual Studio Code |

### 2-1. Docker란?

Docker는 애플리케이션과 실행에 필요한 환경을 하나의 이미지로 패키징하고, 이를 컨테이너라는 격리된 환경에서 실행할 수 있도록 하는 플랫폼이다.

개발 환경이 달라져도 동일한 이미지로 일관된 실행 환경을 구성할 수 있다는 장점이 있다.

### 2-2. Docker의 주요 구성 요소

- **Docker Client:** 사용자가 Docker 명령어를 입력하는 인터페이스이다.
- **Docker Daemon:** 이미지, 컨테이너, 네트워크, 볼륨 등을 실제로 관리하는 백그라운드 프로세스이다.
- **Docker Image:** 컨테이너를 생성하기 위한 읽기 전용 템플릿이다.
- **Docker Container:** 이미지를 기반으로 실행되는 격리된 환경이다.

Docker CLI가 명령을 전달하면 Docker Daemon이 해당 작업을 처리한다.

---

## 3. 프로젝트 디렉터리 구조

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

### 디렉터리별 역할

| 경로 | 역할 |
|---|---|
| `logs/` | 실습 과정에서 발생한 터미널 및 Docker 로그 저장 |
| `evidence/` | 실습 결과를 확인할 수 있는 스크린샷 저장 |
| `terminal/` | Linux 터미널 명령어 실습 파일 |
| `terminal/backup/` | 백업 파일 저장 |
| `terminal/files/` | 파일 및 디렉터리 관리 실습 |
| `terminal/scripts/` | 스크립트 파일 저장 |
| `web/` | Nginx 웹 서버에서 제공할 HTML 파일 |

---

# 4. 주요 실습 내용

## 4-1. Linux 파일 및 디렉터리 관리

Linux에서는 터미널 명령어를 사용하여 파일과 디렉터리를 생성하고 이동하거나 삭제할 수 있다.

### 주요 명령어

| 명령어 | 기능 |
|---|---|
| `pwd` | 현재 작업 디렉터리 확인 |
| `ls` | 파일 및 디렉터리 목록 확인 |
| `cd` | 디렉터리 이동 |
| `mkdir` | 디렉터리 생성 |
| `touch` | 파일 생성 |
| `cp` | 파일 또는 디렉터리 복사 |
| `mv` | 파일 또는 디렉터리 이동 및 이름 변경 |
| `rm` | 파일 삭제 |
| `rmdir` | 비어 있는 디렉터리 삭제 |
| `rm -r` | 디렉터리와 내부 내용 삭제 |

### 명령어 사용 예시

```bash
pwd
ls -la
mkdir practice
cd practice
touch hello.txt
cp hello.txt hello-copy.txt
mv hello-copy.txt backup.txt
rm backup.txt
```

### 주요 옵션

- `-l`: 파일의 상세 정보 표시
- `-a`: 숨김 파일까지 표시
- `-r`: 디렉터리 내부까지 재귀적으로 처리
- `-f`: 삭제 확인 등의 메시지를 생략하고 강제로 처리

### 실행 결과 이해

`pwd`는 현재 작업 위치를 출력한다. `mkdir`과 `touch`는 새로운 디렉터리와 파일을 만들며, `cp`와 `mv`는 기존 파일을 복사하거나 이동한다.

`rm -r`은 디렉터리 내부의 파일까지 삭제할 수 있으므로 사용할 때 주의해야 한다.

**발표 설명**

Linux 터미널에서 파일과 디렉터리를 생성하고 복사, 이동, 삭제하는 기본 명령어를 실습했다. 각 명령어의 역할과 옵션에 따라 파일 시스템을 관리하는 방법을 학습했다.

---

## 4-2. 파일 권한과 chmod

Linux에서는 파일과 디렉터리에 접근할 수 있는 권한을 설정할 수 있다.

권한은 읽기(r), 쓰기(w), 실행(x)으로 구분된다.

### 권한의 종류

| 권한 | 의미 | 숫자 |
|---|---|---|
| r | Read: 읽기 | 4 |
| w | Write: 쓰기 | 2 |
| x | Execute: 실행 | 1 |

### 권한의 대상

- `u`: 소유자(User)
- `g`: 그룹(Group)
- `o`: 기타 사용자(Other)

### 숫자형 권한 표기

권한 숫자는 r, w, x의 값을 더하여 표현한다.

| 숫자 | 권한 | 의미 |
|---|---|---|
| 7 | rwx | 읽기, 쓰기, 실행 |
| 6 | rw- | 읽기, 쓰기 |
| 5 | r-x | 읽기, 실행 |
| 4 | r-- | 읽기 |
| 0 | --- | 권한 없음 |

예를 들어 `755`는 다음과 같은 의미이다.

- 소유자: 7 = rwx
- 그룹: 5 = r-x
- 기타 사용자: 5 = r-x

즉, 소유자는 모든 권한을 가지며 그룹과 기타 사용자는 읽기와 실행만 가능하다.

### 주요 명령어

```bash
ls -l
chmod 755 hello.txt
chmod 644 hello.txt
```

- `ls -l`: 파일 권한 및 상세 정보 확인
- `chmod`: 파일 또는 디렉터리의 권한 변경
- `755`: 소유자는 읽기, 쓰기, 실행 가능하며 나머지는 읽기와 실행 가능
- `644`: 소유자는 읽기와 쓰기 가능하며 나머지는 읽기만 가능

**발표 설명**

Linux에서는 파일마다 접근 권한이 존재한다. chmod 명령어를 사용하면 소유자, 그룹, 기타 사용자의 권한을 변경할 수 있다. 755와 644는 권한을 숫자로 표현한 대표적인 표기 방식이다.

---

## 4-3. 절대 경로와 상대 경로

파일이나 디렉터리에 접근할 때 사용하는 경로는 절대 경로와 상대 경로로 구분된다.

### 절대 경로(Absolute Path)

루트 디렉터리(`/`)를 기준으로 파일이나 디렉터리의 위치를 처음부터 지정하는 경로이다.

```bash
cd /Users/minhee/codyssey/practice
```

현재 위치와 관계없이 동일한 위치를 가리킨다.

### 상대 경로(Relative Path)

현재 작업 중인 디렉터리를 기준으로 목적지의 위치를 지정하는 경로이다.

```bash
cd ../
cd ./terminal
```

- `.`: 현재 디렉터리
- `..`: 상위 디렉터리

### 차이점

| 구분 | 절대 경로 | 상대 경로 |
|---|---|---|
| 기준 | 루트 디렉터리 | 현재 작업 디렉터리 |
| 시작 형태 | `/` | `./`, `../` 또는 디렉터리명 |
| 특징 | 위치가 명확함 | 현재 위치에 따라 달라짐 |

**발표 설명**

절대 경로는 루트 디렉터리부터 전체 경로를 지정하는 방식이고, 상대 경로는 현재 작업 위치를 기준으로 경로를 지정하는 방식이다.

---

## 4-4. Docker 실행 환경과 Daemon

Docker 명령어를 실행하려면 Docker Daemon이 정상적으로 작동해야 한다.

Docker Desktop은 macOS에서 Docker Engine을 실행하고 관리하는 프로그램이다.

### 주요 명령어

```bash
docker version
docker info
docker context ls
docker context show
```

| 명령어 | 기능 |
|---|---|
| `docker version` | Docker Client와 Server 버전 확인 |
| `docker info` | Docker Engine의 상세 정보 확인 |
| `docker context ls` | Docker Context 목록 확인 |
| `docker context show` | 현재 사용 중인 Context 확인 |

### Docker Client와 Daemon의 관계

1. 사용자가 터미널에서 Docker 명령어를 입력한다.
2. Docker CLI가 Docker Daemon에 명령을 전달한다.
3. Docker Daemon이 요청한 작업을 수행한다.
4. 실행 결과가 터미널에 출력된다.

### Docker Daemon 연결 오류

Docker Desktop이 실행되지 않았거나 Daemon에 연결할 수 없는 경우 Docker 명령어가 실패할 수 있다.

예를 들어 Docker Socket 연결 오류가 발생하면 Docker Desktop의 실행 상태를 먼저 확인해야 한다.

**해결 방법**

1. Docker Desktop 실행
2. Docker Engine이 정상적으로 시작될 때까지 대기
3. `docker info`로 연결 확인

**발표 설명**

Docker CLI는 사용자의 명령을 전달하는 역할을 하고 Docker Daemon은 실제 컨테이너와 이미지를 관리한다. 따라서 Daemon이 실행되지 않으면 Docker 명령어를 정상적으로 수행할 수 없다.

---

## 4-5. Docker Image와 Container

### Docker Image

컨테이너를 생성하기 위한 읽기 전용 템플릿이다.

애플리케이션 실행에 필요한 파일, 라이브러리, 설정 등이 포함된다.

### Docker Container

Docker Image를 기반으로 생성되어 실행되는 격리된 환경이다.

컨테이너는 이미지의 내용을 기반으로 실행되며 실행 과정에서 변경되는 데이터는 컨테이너의 쓰기 계층 등에 기록된다.

### Image와 Container 비교

| 구분 | Image | Container |
|---|---|---|
| 의미 | 실행 환경의 템플릿 | 실행되는 인스턴스 |
| 상태 | 읽기 전용 기반 | 실행 및 종료 상태 존재 |
| 관계 | 컨테이너 생성의 기반 | 이미지로부터 생성 |

### 주요 명령어

```bash
docker images
docker ps
docker ps -a
docker pull nginx:alpine
docker run hello-world
```

- `docker images`: 로컬에 저장된 이미지 목록 확인
- `docker ps`: 실행 중인 컨테이너 확인
- `docker ps -a`: 종료된 컨테이너까지 확인
- `docker pull`: Docker Hub 등에서 이미지 다운로드
- `docker run`: 이미지를 기반으로 컨테이너 생성 및 실행

**발표 설명**

이미지는 컨테이너를 만들기 위한 템플릿이고 컨테이너는 그 이미지를 기반으로 실제 실행되는 환경이다. 하나의 이미지로 여러 컨테이너를 생성할 수 있다.

---

## 4-6. Docker 컨테이너 실행과 포트 매핑

컨테이너 내부에서 실행되는 서비스에 외부에서 접근하려면 포트 매핑이 필요하다.

### 포트 매핑이란?

호스트 컴퓨터의 포트와 컨테이너의 포트를 연결하는 기능이다.

예를 들어 다음 명령어를 실행하면 호스트의 8080번 포트와 컨테이너의 80번 포트가 연결된다.

```bash
docker run -d --name codyssey-web -p 8080:80 nginx:alpine
```

### 명령어 분석

- `run`: 컨테이너 생성 및 실행
- `-d`: 백그라운드 모드로 실행
- `--name`: 컨테이너 이름 지정
- `-p 8080:80`: 호스트 포트 8080을 컨테이너 포트 80에 연결
- `nginx:alpine`: 사용할 이미지와 태그

### 포트 매핑 구조

```text
Mac Host
  |
  | localhost:8080
  |
  v
Docker Container
  |
  | Port 80
  |
  v
Nginx Web Server
```

### 실습에서 사용한 포트

| 호스트 포트 | 컨테이너 포트 |
|---|---|
| 8080 | 80 |
| 8081 | 80 |
| 8082 | 80 |

서로 다른 호스트 포트를 사용하면 여러 컨테이너의 웹 서비스에 접근할 수 있다.

브라우저에서 다음 주소로 접속할 수 있다.

- `http://localhost:8080`
- `http://localhost:8081`
- `http://localhost:8082`

**발표 설명**

포트 매핑은 호스트와 컨테이너의 포트를 연결하는 기능이다. 컨테이너 내부의 웹 서버가 80번 포트를 사용하더라도 호스트의 서로 다른 포트와 연결하여 여러 웹 서비스를 실행할 수 있다.

---

## 4-7. Docker Bind Mount

Bind Mount는 호스트 컴퓨터의 특정 파일이나 디렉터리를 컨테이너 내부에 연결하는 기능이다.

### 사용하는 이유

호스트에서 파일을 수정했을 때 컨테이너 내부에서도 변경된 내용을 바로 확인할 수 있다.

개발 과정에서 소스 코드를 수정할 때 유용하다.

### 실습 명령어

```bash
docker run -d \
  --name web-bind \
  -p 8080:80 \
  -v "$PWD/web:/usr/share/nginx/html:ro" \
  nginx:alpine
```

### 명령어 분석

- `-v`: 볼륨 또는 호스트 디렉터리 마운트 설정
- `$PWD`: 현재 작업 디렉터리의 절대 경로
- `web`: 호스트의 웹 파일 디렉터리
- `/usr/share/nginx/html`: Nginx가 기본 HTML 파일을 읽는 컨테이너 내부 경로
- `:ro`: 읽기 전용(Read Only) 설정

### 동작 구조

```text
Mac Host
practice/web/
    |
    | Bind Mount
    v
Container
/usr/share/nginx/html/
```

호스트의 `index.html`을 수정하면 컨테이너에서 제공하는 웹 페이지에도 변경 사항이 반영된다.

### Bind Mount와 Volume의 차이

| 구분 | Bind Mount | Volume |
|---|---|---|
| 저장 위치 | 호스트가 지정한 경로 | Docker가 관리하는 저장 공간 |
| 주요 목적 | 개발 파일 공유 | 컨테이너 데이터 보존 |
| 관리 방식 | 사용자가 경로 지정 | Docker가 관리 |

**발표 설명**

Bind Mount는 호스트의 특정 디렉터리를 컨테이너 내부에 연결하는 기능이다. 웹 개발 실습에서는 HTML 파일을 호스트에서 수정하고 컨테이너의 Nginx 웹 서버에서 변경 사항을 확인하기 위해 사용했다.

---

## 4-8. Docker Volume을 이용한 데이터 영속성

Docker Volume은 컨테이너와 별도로 데이터를 저장하는 기능이다.

컨테이너가 삭제되더라도 Volume은 별도로 유지되기 때문에 데이터를 보존할 수 있다.

### 데이터 영속성이란?

데이터 영속성(Persistence)은 프로그램이나 컨테이너가 종료되거나 삭제된 이후에도 데이터가 유지되는 특성이다.

### 주요 명령어

```bash
docker volume create codyssey-data
docker volume ls
docker volume inspect codyssey-data
```

- `create`: 새로운 Volume 생성
- `ls`: Volume 목록 확인
- `inspect`: 특정 Volume의 상세 정보 확인

### Volume을 컨테이너에 연결하기

```bash
docker run --rm \
  -v codyssey-data:/data \
  ubuntu \
  sh -c 'echo "Docker Volume Persistence Test" > /data/test.txt'
```

- `--rm`: 컨테이너 종료 후 컨테이너 자동 삭제
- `-v codyssey-data:/data`: Volume을 컨테이너의 `/data` 경로에 연결
- `sh -c`: 셸을 통해 명령어 실행
- `>`: 명령어의 출력을 파일에 기록

### 데이터 확인하기

```bash
docker run --rm \
  -v codyssey-data:/data \
  ubuntu cat /data/test.txt
```

출력 결과:

```text
Docker Volume Persistence Test
```

임시 컨테이너를 삭제한 후에도 Volume에 저장된 파일을 확인할 수 있다.

**발표 설명**

Docker Volume은 컨테이너와 독립적으로 데이터를 저장하는 기능이다. 컨테이너가 삭제되어도 Volume은 유지되기 때문에 데이터를 보존할 수 있다. 실제 실습에서는 파일을 Volume에 저장하고 새로운 임시 컨테이너에서 데이터를 다시 읽어 확인했다.

---

## 4-9. Docker Volume 백업 및 복원

Volume에 저장된 데이터를 백업 파일로 만들고 필요할 때 다시 복원할 수 있다.

### 1. 원본 데이터 확인

```bash
docker run --rm \
  -v codyssey-data:/data \
  ubuntu cat /data/test.txt
```

### 2. Volume 백업

```bash
docker run --rm \
  -v codyssey-data:/data \
  -v "$PWD":/backup \
  ubuntu \
  tar -czf /backup/codyssey-data-backup.tar.gz -C /data .
```

### 명령어 분석

- `tar`: 여러 파일을 하나의 아카이브로 묶는 명령어
- `-c`: 새로운 아카이브 생성
- `-z`: gzip 압축 사용
- `-f`: 결과 파일 이름 지정
- `/backup/codyssey-data-backup.tar.gz`: 백업 파일 경로
- `-C /data`: `/data` 디렉터리로 이동한 뒤 백업할 내용 지정
- `.`: 현재 디렉터리의 전체 내용

### 3. 백업 파일 확인

```bash
ls -lh codyssey-data-backup.tar.gz
```

### 4. 복원용 Volume 생성

```bash
docker volume create codyssey-restore
```

### 5. 백업 데이터 복원

```bash
docker run --rm \
  -v codyssey-restore:/data \
  -v "$PWD":/backup \
  ubuntu \
  tar -xzf /backup/codyssey-data-backup.tar.gz -C /data
```

- `-x`: 아카이브 압축 해제 및 추출
- `-z`: gzip 압축 해제
- `-f`: 읽어올 백업 파일 지정

### 6. 복원 결과 확인

```bash
docker run --rm \
  -v codyssey-restore:/data \
  ubuntu cat /data/test.txt
```

출력 결과:

```text
Docker Volume Persistence Test
```

원본 Volume은 그대로 유지하고 별도의 Volume에 백업 데이터를 복원하여 정상적으로 복구되었는지 확인했다.

**발표 설명**

Docker Volume의 데이터를 tar 명령어를 이용해 TAR.GZ 파일로 백업했다. 이후 별도의 Volume을 생성하고 백업 파일을 복원했다. 마지막으로 파일 내용을 확인하여 백업과 복원이 정상적으로 이루어졌음을 검증했다.

---

## 4-10. Docker Image 백업 및 복원

Docker Image는 파일로 저장하고 나중에 다시 불러올 수 있다.

이미지 백업은 컨테이너의 실행 상태가 아니라 이미지 자체를 보관하는 작업이다.

### 이미지 백업

```bash
docker save -o codyssey-web.tar codyssey-web:1.0
```

- `save`: Docker 이미지를 TAR 파일로 저장
- `-o`: 출력 파일 이름 지정
- `codyssey-web:1.0`: 백업할 이미지 이름과 태그

### 백업 파일 확인

```bash
ls -lh codyssey-web.tar
```

### 이미지 복원

```bash
docker load -i codyssey-web.tar
```

- `load`: TAR 파일에 저장된 Docker 이미지 불러오기
- `-i`: 입력 파일 지정

### 복원 결과 확인

```bash
docker images
```

목록에 `codyssey-web:1.0`이 표시되면 이미지가 정상적으로 불러와진 것이다.

### save와 load의 차이

| 명령어 | 기능 |
|---|---|
| `docker save` | 이미지를 파일로 저장 |
| `docker load` | 파일에서 이미지를 불러오기 |

**발표 설명**

Docker Image를 TAR 파일로 백업하고 docker load 명령어로 다시 불러오는 실습을 진행했다. 이를 통해 이미지를 파일 형태로 보관하고 복원할 수 있음을 확인했다.

---

## 4-11. Docker 컨테이너 로그 확인

컨테이너 로그는 컨테이너 내부에서 실행되는 애플리케이션의 출력 내용을 확인할 수 있는 기능이다.

오류 원인을 파악하거나 애플리케이션이 정상적으로 실행되는지 확인할 때 사용한다.

### 실습 명령어

```bash
docker run -d --name logs-test nginx:alpine
```

Nginx 컨테이너를 백그라운드에서 실행한다.

### 로그 확인

```bash
docker logs logs-test
```

컨테이너에서 출력한 전체 로그를 확인한다.

### 주요 옵션

```bash
docker logs --tail 10 logs-test
docker logs -t logs-test
docker logs -f logs-test
```

| 옵션 | 의미 |
|---|---|
| `--tail 10` | 마지막 10줄만 출력 |
| `-t` | 로그에 타임스탬프 표시 |
| `-f` | 새로운 로그가 발생할 때까지 실시간으로 출력 |

`-f`는 실시간 로그 확인 모드이므로 종료하려면 `Ctrl + C`를 누른다.

**발표 설명**

Docker logs 명령어를 사용하면 컨테이너에서 출력한 로그를 확인할 수 있다. tail 옵션으로 최근 로그만 확인하거나 f 옵션으로 새로운 로그를 실시간으로 확인할 수 있다.

---

## 4-12. Docker 컨테이너 상태와 종료 코드

컨테이너는 실행 중이거나 종료된 상태일 수 있다.

컨테이너가 종료되었다고 반드시 오류가 발생한 것은 아니다. 실행한 작업이 정상적으로 끝나도 컨테이너는 종료될 수 있다.

### 주요 명령어

```bash
docker ps
docker ps -a
docker inspect -f '{{.State.ExitCode}}' test-exit
```

- `docker ps`: 실행 중인 컨테이너 확인
- `docker ps -a`: 종료된 컨테이너까지 확인
- `docker inspect`: 컨테이너의 상세 정보 확인
- `.State.ExitCode`: 컨테이너의 종료 코드 확인

### 종료 코드란?

종료 코드는 프로그램이나 프로세스가 종료될 때 결과를 나타내는 숫자이다.

| 종료 코드 | 의미 |
|---|---|
| `0` | 일반적으로 정상 종료 |
| `0`이 아닌 값 | 일반적으로 오류 또는 비정상 종료 |

### 실습

```bash
docker run --name test-exit ubuntu echo "Hello Docker"
```

출력:

```text
Hello Docker
```

종료 코드 확인:

```bash
docker inspect -f '{{.State.ExitCode}}' test-exit
```

출력:

```text
0
```

정상적으로 명령어가 실행되었기 때문에 종료 코드가 0으로 표시되었다.

**발표 설명**

컨테이너의 상태는 docker ps 명령어로 확인할 수 있다. 컨테이너가 종료된 경우에도 종료 코드가 0이라면 일반적으로 정상적으로 작업이 완료된 것이다.

---

## 4-13. Docker Network

Docker Network는 컨테이너 간 또는 컨테이너와 외부 네트워크 간의 통신을 관리하는 기능이다.

### 주요 네트워크 종류

| 네트워크 | 특징 |
|---|---|
| bridge | 기본적인 컨테이너 간 네트워크 연결 |
| host | 호스트의 네트워크 환경을 직접 사용 |
| none | 네트워크 연결을 제공하지 않음 |

### 주요 명령어

```bash
docker network ls
docker network create codyssey-network
docker network inspect codyssey-network
```

- `docker network ls`: 네트워크 목록 확인
- `create`: 새로운 네트워크 생성
- `inspect`: 네트워크 상세 정보 확인

### Bridge Network

Bridge 네트워크는 Docker에서 일반적으로 사용하는 네트워크 방식이다.

컨테이너가 같은 사용자 정의 Bridge 네트워크에 연결되면 서로 통신할 수 있다.

### 네트워크 상세 정보

`docker network inspect`를 사용하면 다음과 같은 정보를 확인할 수 있다.

- 네트워크 이름
- 네트워크 드라이버
- IP 대역(Subnet)
- 게이트웨이(Gateway)
- 연결된 컨테이너

실습에서는 `codyssey-network`를 생성하고 네트워크 드라이버 및 IP 정보를 확인했다.

**발표 설명**

Docker Network는 컨테이너 간 통신을 관리하는 기능이다. Bridge 네트워크는 컨테이너들이 서로 통신할 수 있도록 연결하는 대표적인 네트워크 방식이다.

---

## 4-14. Dockerfile과 이미지 빌드

Dockerfile은 Docker Image를 만들기 위한 설정 파일이다.

이미지를 생성할 때 필요한 기반 이미지, 파일 복사, 포트 정보 등을 작성한다.

### 실습 Dockerfile

```dockerfile
FROM nginx:alpine
LABEL maintainer="Codyssey Practice"
COPY web/ /usr/share/nginx/html/
EXPOSE 80
```

### 명령어 분석

| 명령어 | 기능 |
|---|---|
| `FROM` | 기반이 되는 이미지 지정 |
| `LABEL` | 이미지에 메타데이터 추가 |
| `COPY` | 호스트의 파일을 이미지 내부로 복사 |
| `EXPOSE` | 컨테이너가 사용할 포트 정보 표시 |

### Docker Image 빌드

```bash
docker build -t codyssey-web:1.0 .
```

- `build`: Dockerfile을 기반으로 이미지 생성
- `-t`: 이미지 이름과 태그 지정
- `codyssey-web:1.0`: 이미지 이름과 버전
- `.`: 현재 디렉터리를 빌드 컨텍스트로 지정

### 컨테이너 실행

```bash
docker run -d --name codyssey-web -p 8080:80 codyssey-web:1.0
```

브라우저에서 `http://localhost:8080`에 접속하여 웹 페이지를 확인할 수 있다.

### Dockerfile과 Image의 관계

Dockerfile에 이미지 생성 방법을 작성하고 docker build 명령어를 실행하면 Docker Image가 만들어진다. 생성된 이미지를 docker run 명령어로 실행하면 컨테이너가 생성된다.

**발표 설명**

Dockerfile은 이미지를 만들기 위한 설정 파일이다. 이번 실습에서는 Nginx 기반 이미지를 사용하고 웹 파일을 컨테이너 내부에 복사하도록 설정했다. 이후 docker build 명령어로 사용자 정의 이미지를 생성했다.

---

## 4-15. Docker 리소스 모니터링

Docker 컨테이너가 사용하는 시스템 자원을 확인할 수 있다.

### 주요 명령어

```bash
docker stats
docker stats stats-test
docker stats --no-stream stats-test
```

### 확인 가능한 항목

| 항목 | 의미 |
|---|---|
| CPU % | 컨테이너의 CPU 사용률 |
| MEM USAGE / LIMIT | 메모리 사용량과 제한 |
| MEM % | 메모리 사용률 |
| NET I/O | 네트워크 송수신량 |
| BLOCK I/O | 블록 장치 읽기 및 쓰기량 |
| PIDS | 컨테이너 내부 프로세스 및 스레드 수 |

### 주요 옵션

- `docker stats`: 실행 중인 컨테이너의 자원 사용량을 실시간으로 확인
- `--no-stream`: 실시간 갱신 없이 한 번만 출력
- 컨테이너 이름을 지정하면 해당 컨테이너의 자원 사용량만 확인 가능

**발표 설명**

Docker stats 명령어를 사용하여 컨테이너의 CPU, 메모리, 네트워크, 디스크 입출력 등의 사용량을 확인했다. 이를 통해 컨테이너가 시스템 자원을 얼마나 사용하는지 모니터링할 수 있다.

---

## 4-16. 포트 충돌과 프로세스 진단

하나의 포트를 여러 서비스가 동시에 사용하려고 하면 포트 충돌이 발생할 수 있다.

예를 들어 이미 8080번 포트를 사용하는 프로세스가 존재하면 다른 컨테이너가 같은 호스트 포트를 사용하지 못할 수 있다.

### 주요 명령어

```bash
lsof -i :8080
docker ps
docker stop codyssey-web
docker start codyssey-web
```

### 명령어 분석

- `lsof`: 열려 있는 파일과 네트워크 연결 정보를 확인하는 명령어
- `-i`: 네트워크 관련 정보를 조회하는 옵션
- `:8080`: 8080번 포트를 대상으로 지정
- `docker ps`: 실행 중인 컨테이너 확인
- `docker stop`: 컨테이너 중지
- `docker start`: 중지된 컨테이너 다시 실행

### 실습 결과

`lsof -i :8080` 명령어로 포트를 사용하는 프로세스를 확인했다.

컨테이너를 중지한 상태에서는 해당 포트의 리스닝 프로세스가 확인되지 않았으며, 컨테이너를 다시 실행한 후에는 Docker 관련 프로세스가 8080번 포트를 사용하고 있는 것을 확인했다.

이번 실습은 포트 사용 상태를 진단하고 컨테이너의 중지 및 재시작에 따른 변화를 확인한 것이다. 두 서비스가 실제로 충돌하는 상황을 재현한 것은 아니다.

**발표 설명**

lsof 명령어를 사용하면 특정 포트를 사용 중인 프로세스를 확인할 수 있다. Docker 컨테이너를 중지하고 다시 실행하면서 8080번 포트의 사용 상태가 어떻게 변하는지 확인했다.

---

## 4-17. Docker Volume 백업 및 복원 실습 정리

4-9에서 진행한 Volume 백업 및 복원 과정을 별도의 실습 결과로 정리한다.

### 백업과 복원의 흐름

```text
Original Volume
      |
      | tar -czf
      v
Backup TAR.GZ File
      |
      | tar -xzf
      v
Restore Volume
      |
      | cat test.txt
      v
Data Verification
```

### 사용한 명령어 옵션 정리

| 옵션 | 의미 |
|---|---|
| `-c` | 아카이브 생성 |
| `-x` | 아카이브 추출 |
| `-z` | gzip 압축 사용 |
| `-f` | 파일 이름 지정 |

### 실습 결과

- 원본 Volume에 저장된 파일 확인
- `codyssey-data-backup.tar.gz` 파일 생성
- `codyssey-restore` Volume 생성
- 백업 파일을 별도의 Volume에 복원
- 복원된 파일의 내용을 확인하여 데이터 일치 검증

**발표 설명**

Volume 백업은 컨테이너가 아닌 Volume에 저장된 데이터를 별도로 보관하기 위한 작업이다. 백업 파일을 다른 Volume에 복원함으로써 데이터 복구가 가능한지 확인했다.

---

## 4-18. Docker 문제 해결 및 트러블슈팅

실습 중 발생한 오류를 확인하고 원인을 파악하여 해결하는 과정도 중요하다.

### 1. Docker Daemon 연결 오류

**발생 원인**

Docker Desktop이 실행되지 않았거나 Docker Daemon에 연결할 수 없는 상태일 수 있다.

**해결 방법**

- Docker Desktop 실행 여부 확인
- Docker Engine 실행 상태 확인
- `docker info` 명령어로 연결 상태 확인

### 2. 포트 충돌

**발생 원인**

이미 다른 프로세스나 컨테이너가 동일한 호스트 포트를 사용하고 있을 수 있다.

**확인 방법**

```bash
lsof -i :8080
docker ps
```

**해결 방법**

기존 프로세스 또는 컨테이너의 포트 사용 상태를 확인하고, 필요에 따라 서비스를 중지하거나 다른 호스트 포트를 지정한다.

### 3. 컨테이너 상태 확인

```bash
docker ps -a
docker logs 컨테이너이름
docker inspect 컨테이너이름
```

컨테이너가 실행되지 않거나 예상과 다르게 동작하면 상태, 로그, 상세 설정을 순서대로 확인한다.

### 문제 해결 과정의 기본 순서

1. 오류 메시지 확인
2. 문제가 발생한 명령어와 환경 확인
3. 컨테이너 및 Docker Engine 상태 확인
4. 로그와 상세 정보 확인
5. 원인에 맞는 해결 방법 적용
6. 명령어를 다시 실행하여 정상 동작 여부 확인

**발표 설명**

Docker 실습 중 발생한 오류는 단순히 명령어를 다시 입력하는 것이 아니라 오류 메시지와 실행 환경을 확인하여 원인을 파악하는 방식으로 해결했다. 특히 Docker Daemon 연결 오류와 포트 사용 상태를 확인하는 방법을 학습했다.

---

# 5. Git 및 GitHub 버전 관리

Git은 파일의 변경 이력을 관리하는 분산 버전 관리 시스템이다.

GitHub는 Git 저장소를 온라인에서 관리하고 다른 사람과 공유할 수 있는 플랫폼이다.

### 주요 명령어

```bash
git status
git add .
git commit -m "commit message"
git log --oneline
git remote -v
git push
```

| 명령어 | 기능 |
|---|---|
| `git status` | 파일 변경 상태 확인 |
| `git add` | 변경 파일을 스테이징 영역에 추가 |
| `git commit` | 변경 사항을 로컬 저장소에 기록 |
| `git log --oneline` | 커밋 이력을 한 줄로 확인 |
| `git remote -v` | 원격 저장소 주소 확인 |
| `git push` | 로컬 커밋을 원격 저장소에 업로드 |

### Git의 기본 작업 흐름

```text
Working Directory
      |
      | git add
      v
Staging Area
      |
      | git commit
      v
Local Repository
      |
      | git push
      v
Remote Repository (GitHub)
```

### 프로젝트 저장소

GitHub Repository:

https://github.com/minhee04/ai-codyssey

**발표 설명**

Git을 이용하여 프로젝트의 변경 이력을 관리하고 GitHub 원격 저장소에 코드를 업로드했다. 이를 통해 작업 내용을 기록하고 이전 변경 사항을 확인할 수 있다.

---

# 6. 주요 용어 정리

| 용어 | 설명 |
|---|---|
| Linux | 오픈 소스 운영체제 커널을 기반으로 한 운영체제 환경 |
| Terminal | 명령어를 입력하고 실행 결과를 확인하는 인터페이스 |
| Shell | 사용자의 명령어를 해석하고 실행하는 프로그램 |
| Absolute Path | 루트 디렉터리부터 시작하는 전체 경로 |
| Relative Path | 현재 디렉터리를 기준으로 지정하는 경로 |
| Permission | 파일 및 디렉터리에 대한 접근 권한 |
| chmod | 파일 및 디렉터리의 권한을 변경하는 명령어 |
| Docker | 컨테이너 기반 애플리케이션 실행 플랫폼 |
| Docker Client | Docker 명령어를 전달하는 클라이언트 |
| Docker Daemon | Docker 리소스를 관리하고 명령을 처리하는 백그라운드 프로세스 |
| Docker Image | 컨테이너를 생성하기 위한 읽기 전용 템플릿 |
| Docker Container | 이미지를 기반으로 실행되는 격리된 환경 |
| Dockerfile | Docker Image를 만들기 위한 설정 파일 |
| Port Mapping | 호스트와 컨테이너의 포트를 연결하는 기능 |
| Bind Mount | 호스트의 특정 파일 또는 디렉터리를 컨테이너에 연결하는 방식 |
| Volume | 컨테이너와 독립적으로 데이터를 저장하는 Docker 관리 저장 공간 |
| Persistence | 프로그램이나 컨테이너가 종료되어도 데이터가 유지되는 특성 |
| Bridge Network | Docker 컨테이너 간 통신을 위한 네트워크 방식 |
| Daemon | 백그라운드에서 특정 서비스를 관리하는 프로세스 |
| TAR | 여러 파일을 하나의 아카이브로 묶는 파일 형식 |
| gzip | 파일을 압축하거나 압축 해제하는 방식 |
| lsof | 열려 있는 파일 및 네트워크 연결 정보를 확인하는 명령어 |
| Git | 파일의 변경 이력을 관리하는 분산 버전 관리 시스템 |
| GitHub | Git 저장소를 온라인에서 관리하는 플랫폼 |

---

# 7. 실습 증거 자료

실습 과정과 결과를 확인할 수 있도록 스크린샷을 분류하여 저장하였다.

```text
evidence/
├── terminal/
│   ├── 파일 및 디렉터리 관리
│   ├── 경로 및 권한 설정
│   └── 터미널 명령어 실습
└── docker/
    ├── Docker 환경 확인
    ├── Image 및 Container
    ├── Dockerfile 및 이미지 빌드
    ├── Port Mapping
    ├── Bind Mount
    ├── Volume Persistence
    ├── Volume Backup Restore
    ├── Docker Image Backup Restore
    ├── Docker Logs
    ├── Container State Exit Code
    ├── Docker Network
    ├── Docker Resource Monitoring
    └── Docker Port Diagnostic
```

※ 증거 자료의 파일명과 실제 저장된 이미지가 일치하도록 관리한다.

---

# 8. 학습 결과 및 느낀 점

이번 실습을 통해 Linux 터미널에서 파일과 디렉터리를 관리하는 기본 명령어부터 Docker를 이용한 컨테이너 실행 및 관리까지 학습하였다.

특히 Docker Image와 Container의 차이, 포트 매핑, Bind Mount와 Volume의 차이를 이해할 수 있었다.

또한 Volume에 데이터를 저장하고 백업 및 복원하는 과정을 직접 수행하면서 컨테이너와 데이터의 생명주기를 분리하는 것이 중요하다는 점을 알게 되었다.

Docker logs, stats, inspect 등의 명령어를 이용해 컨테이너의 상태와 자원 사용량을 확인하는 방법도 학습하였다.

실습 중 발생한 Docker Daemon 연결 오류와 포트 사용 상태를 확인하면서 문제 해결을 위해서는 명령어의 결과와 실행 환경을 함께 살펴봐야 한다는 점을 배웠다.

앞으로는 단순히 명령어를 실행하는 데 그치지 않고 각 명령어의 동작 원리와 옵션을 이해하며 실제 개발 환경에서도 활용할 수 있도록 학습을 이어가고자 한다.

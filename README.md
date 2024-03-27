# 소개
귀여운땃쥐 커뮤니티 웹앱&AOS/IOS앱 프로젝트

## 빌드
### AOS
### IOS
### WEB
`enhanced_html_editor` 패키지 떄문에 `flutter build web --web-renderer html`로 빌드해야한다.

flutter build web --no-tree-shake-icons

폰트 에러 해결
#### 자동배포
.\deploy.ps1 -RemoteUser "user" -RemoteHost "1.1.1.1" -RemotePath "/static/files/static_files/web"

deploy.ps1 스크립트는 ssh-keygen으로 등록한 키가 원격 PC에 등록이 되어있다는 가정하에 루트 유저로 접속하여 명령어를 실행합니다

일반 유저, 혹은 .pub 키를 등록하지 않았다면 비밀번호 요구로 인해 정상동작하지 않을 수 있습니다.

### 2.0.0

### 알려진 버그
- https://github.com/flutter/flutter/issues/63500
    - flutter.js 가 캐싱되서 과거 어플리케이션이 보이는 문제
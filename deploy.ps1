param(
    [string]$RemoteUser,
    [string]$RemoteHost,
    [string]$RemotePath
)

# Flutter 빌드
# flutter build web --release --no-tree-shake-icons

ssh ${RemoteUser}@${RemoteHost} "rm -r ${RemotePath}/web"

# 빌드된 파일을 원격 서버로 전송
scp -r .\build\web\ ${RemoteUser}@${RemoteHost}:${RemotePath}

# 원격 서버에서 파일 이동 및 Nginx 리스타트
ssh ${RemoteUser}@${RemoteHost} "systemctl restart nginx"

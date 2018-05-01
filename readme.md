
# ソースのコンパイル
## javaのコンパイル
./gradlew build

# dockerの準備
## dockerのbuildを行う（このコマンドもgradleの中でやってしまいたい）
docker build --tag=jboss/wildfly-admin2 .

# dockerの実行
## フル指定
docker run -p 8080:8080 -p 9990:9990 -it jboss/wildfly-admin2:latest /opt/jboss/wildfly/bin/standalone.sh -bmanagement 0.0.0.0 -b 0.0.0.0

## 最低限の指定
docker run -p 8080:8080 -p 9990:9990 -it jboss/wildfly-admin2:latest

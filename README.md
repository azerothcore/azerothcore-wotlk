# Guia Rápido: Subir o servidor AzerothCore (WotLK) + Módulos + Site de Registro com ngrok

Este guia explica como subir o servidor novamente, importar os módulos que configuramos, disponibilizar o site de registro via ngrok e, opcionalmente, expor o servidor de jogo pela internet usando túneis TCP.

O guia assume que você está no macOS e trabalhando neste diretório:
`/Users/micaeldouglassilvasantana/wowserver/azerothcore-wotlk`

## Pré-requisitos

- Docker e Docker Compose instalados
- PHP 8+ com GMP habilitado (para o site de registro)
- ngrok com token configurado na sua conta
- WoW WotLK cliente 3.3.5a (para testes)

## Subir o stack Docker (Auth + World + DB)

- Este repositório inclui `docker-compose.yml`. Para subir os serviços:

```bash
docker compose up -d
```

- Para verificar containers ativos:

```bash
docker ps
```

- Containers típicos:
  - `ac-database`: MySQL
  - `ac-authserver`: authserver
  - `ac-worldserver`: worldserver

Se você limpou os containers anteriormente, este comando os recriará.

## Importar SQL do mod-assistant (itens grátis)

O script `mod_assistant.sql` cria o NPC Assistant (entry `9000000`) e define vários itens como gratuitos (`BuyPrice=0`, `SellPrice=0`). Importação (ajuste o caminho do arquivo conforme sua organização):

```bash
docker exec -i ac-database mysql -uroot -p"password" acore_world < modules/mod-assistant/data/sql/db-world/base/mod_assistant.sql
```

- Verificar se o NPC foi criado:

```bash
docker exec -it ac-database mysql -uroot -p"password" -e "SELECT entry,name,subname FROM acore_world.creature_template WHERE entry=9000000;"
```

- Observação: por padrão, o SQL apenas define o template. O spawn pode ser feito via GM:
  - No jogo com GM: `.npc add 9000000`

### Tornar serviços do Assistant gratuitos (opcional)

Itens já são grátis via SQL. Serviços (utilitários, profissões, voos, resets) são cobrados por configuração. Para torná-los grátis, ajuste `mod_assistant.conf.dist` e reinicie o servidor:

```bash
# exemplo de opções (arquivo de distribuição)
# modules/mod-assistant/conf/mod_assistant.conf.dist
Assistant.Cost.Utility.NameChange = 0
Assistant.Cost.Utility.AppearanceChange = 0
Assistant.Cost.Utility.RaceChange = 0
Assistant.Cost.Utility.FactionChange = 0
Assistant.Cost.FlightPath.Vanilla = 0
Assistant.Cost.FlightPath.BurningCrusade = 0
Assistant.Cost.FlightPath.WrathOfTheLichKing = 0
Assistant.Cost.Profession.Apprentice = 0
Assistant.Cost.Profession.Journeyman = 0
Assistant.Cost.Profession.Expert = 0
Assistant.Cost.Profession.Artisan = 0
Assistant.Cost.Profession.Master = 0
Assistant.Cost.Profession.GrandMaster = 0
Assistant.Cost.Instance.Heroic = 0
Assistant.Cost.Instance.Raid = 0
```

Após alterar, reinicie o `ac-worldserver`:

```bash
docker restart ac-worldserver
```

## Instalar e importar o módulo mod-npc-free-professions

Este módulo adiciona o NPC “Kaylub” (`entry 199999`) que dá duas profissões grátis com todas as receitas.

- Importar o SQL base do módulo:

```bash
docker exec -i ac-database mysql -uroot -p"password" acore_world < modules/mod-npc-free-professions/data/sql/db-world/base/mod_npc_free_professions_01.sql
```

- Verificar template do NPC:

```bash
docker exec -it ac-database mysql -uroot -p"password" -e "SELECT entry,name,subname FROM acore_world.creature_template WHERE entry=199999;"
```

- Spawn manual via GM (se não houver spawn em DB):
  - No jogo com GM: `.npc add 199999`

- Reiniciar worldserver para refletir scripts:

```bash
docker restart ac-worldserver
```

## Site de Registro: rodar localmente e expor com ngrok

O site está em `site/` e usa `register.php` com validações e SRP6. Ele já tem lógica para pular o aviso do ngrok via header.

### 1) Configurar usuário de DB para o site (se necessário)

Crie um usuário `webreg` com permissões básicas no `acore_auth`:

```bash
docker exec -it ac-database mysql -uroot -p"password" -e "CREATE USER IF NOT EXISTS 'webreg'@'%' IDENTIFIED BY 'webreg_local_01!'; GRANT SELECT,INSERT,UPDATE ON acore_auth.* TO 'webreg'@'%'; FLUSH PRIVILEGES;"
```

### 2) Exportar variáveis de ambiente esperadas por `register.php`

```bash
export DB_HOST=ac-database
```

```bash
export DB_PORT=3306
```

```bash
export DB_NAME=acore_auth
```

```bash
export DB_USER=webreg
```

```bash
export DB_PASS=webreg_local_01!
```

```bash
export DEFAULT_EXPANSION=2
```

### 3) Subir o site com o servidor embutido do PHP

```bash
php -S 0.0.0.0:8000 -t site
```

Abra `http://localhost:8000` para testar localmente.

### 4) Expor o site com ngrok (HTTP)

- Instalar e configurar ngrok:

```bash
brew install --cask ngrok
```

```bash
ngrok config add-authtoken SEU_TOKEN_NGROK
```

- Abrir túnel HTTP para o site:

```bash
ngrok http 8000
```

Você verá uma URL pública `https://...ngrok.io`. Use essa URL para acesso externo ao formulário de registro. O `index.html` e o `register.php` já adicionam o header `ngrok-skip-browser-warning`.

## (Opcional/Avançado) Expor o servidor de jogo com ngrok (TCP)

Para permitir que jogadores externos conectem no seu authserver (`3724`) e worldserver (`8085`), você pode criar túneis TCP:

- Túnel authserver (TCP 3724):

```bash
ngrok tcp 3724
```

- Túnel worldserver (TCP 8085):

```bash
ngrok tcp 8085
```

O ngrok mostrará hosts/ports, por exemplo `tcp://x.tcp.ngrok.io:XXXXX`. Anote-os.

### Atualizar endereço do realm no banco

Defina o endereço público do auth na tabela `realmlist` (ajuste `id` se necessário):

```bash
docker exec -it ac-database mysql -uroot -p"password" -e "UPDATE acore_auth.realmlist SET address='x.tcp.ngrok.io', port=3724 WHERE id=1;"
```

Observações importantes:
- Clientes do WoW devem apontar `realmlist.wtf` para o host/porta do auth (ex.: `set realmlist x.tcp.ngrok.io`).
- O world (`8085`) é usado após o login; o redirecionamento é automático, mas o túnel precisa estar ativo.
- Em planos gratuitos do ngrok, há limitações de túneis simultâneos e estabilidade — considere port forwarding do seu roteador como alternativa caso encontre problemas.

## Testes rápidos

- Verificar NPCs no DB:

```bash
docker exec -it ac-database mysql -uroot -p"password" -e "SELECT entry,name,subname FROM acore_world.creature_template WHERE entry IN (9000000,199999);"
```

- Reiniciar serviços quando necessário:

```bash
docker restart ac-authserver
```

```bash
docker restart ac-worldserver
```

- Ver logs:

```bash
docker logs -f ac-worldserver
```

## Dicas e Solução de Problemas

- “No such file or directory” ao importar SQL
  - Certifique-se de usar redirecionamento local com `docker exec -i ... < /caminho/do/arquivo.sql`. O arquivo precisa existir no host.
- “Access denied” no MySQL
  - Verifique usuário/senha (`-uroot -p"password"`) e privilégios do `webreg`.
- Mod-assistant com serviços ainda pagos
  - Confirme valores `Assistant.Cost.* = 0` no `mod_assistant.conf.dist` e reinicie o worldserver.
- Site retorna erro GMP
  - O `register.php` exige extensão GMP. Instale/ative o GMP na sua instalação PHP.
- Rate limit no registro
  - O `register.php` tem limitador “5 req/min”. Aguarde um minuto ou limpe os arquivos temporários em `sys_get_temp_dir()/reg_rl`.

## Comandos úteis

- Subir tudo:

```bash
docker compose up -d
```

- Derrubar tudo:

```bash
docker compose down
```

- Importar mod_assistant.sql:

```bash
docker exec -i ac-database mysql -uroot -p"password" acore_world < modules/mod-assistant/data/sql/db-world/base/mod_assistant.sql
```

- Importar mod_npc_free_professions_01.sql:

```bash
docker exec -i ac-database mysql -uroot -p"password" acore_world < modules/mod-npc-free-professions/data/sql/db-world/base/mod_npc_free_professions_01.sql
```

- Reiniciar worldserver:

```bash
docker restart ac-worldserver
```

- Site local:

```bash
php -S 0.0.0.0:8000 -t site
```

- ngrok HTTP (site):

```bash
ngrok http 8000
```

- ngrok TCP (auth):

```bash
ngrok tcp 3724
```

- ngrok TCP (world):

```bash
ngrok tcp 8085
```

## MySQL 8.4: Usuários, Conexões (DBeaver + CLI) e Troubleshooting

Este capítulo consolida a configuração de usuários no MySQL 8.4, como conectar pelo DBeaver e pelo terminal no macOS, e como resolver erros comuns (ex.: “Access denied”, 1064).

### Verificações rápidas do container e versão

- Confirmar porta publicada:
```bash
docker port ac-database
```

- Listar containers com nome/portas:
```bash
docker ps --format '{{.Names}}\t{{.Ports}}'
```

- Conferir versão e host direto no servidor:
```bash
docker exec -it ac-database mysql -uroot -p"password" -e "SELECT @@version, @@version_comment, @@hostname AS host, @@port AS port;"
```

### Criar e ajustar usuários e privilégios

Execute no DBeaver (driver MySQL) ou dentro do container. Rode cada instrução individualmente.

- Definir senha do `root` local (se necessário):
```sql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```

- Opcional: alinhar ou remover `root` remoto:
```sql
ALTER USER 'root'@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```

```sql
DROP USER IF EXISTS 'root'@'%';
FLUSH PRIVILEGES;
```

- Criar `webreg` em `localhost` e `%` com senha e conceder privilégios no `acore_auth`:
```sql
CREATE USER IF NOT EXISTS 'webreg'@'localhost' IDENTIFIED BY 'webreg_local_01!';
```

```sql
GRANT SELECT, INSERT, UPDATE ON `acore_auth`.* TO 'webreg'@'localhost';
```

```sql
CREATE USER IF NOT EXISTS 'webreg'@'%' IDENTIFIED BY 'webreg_local_01!';
```

```sql
GRANT SELECT, INSERT, UPDATE ON `acore_auth`.* TO 'webreg'@'%';
```

```sql
FLUSH PRIVILEGES;
```

- Verificar usuários e plugins:
```sql
SELECT user, host, plugin, LENGTH(authentication_string) AS auth_len
FROM mysql.user
WHERE user IN ('root','webreg')
ORDER BY user, host;
```

- Conferir GRANTS:
```sql
SHOW GRANTS FOR 'webreg'@'localhost';
```

```sql
SHOW GRANTS FOR 'webreg'@'%';
```

### DBeaver: conexão com MySQL 8.4

- Driver: escolha “MySQL” (não use MariaDB).
- Conexão `webreg`:
  - Host: `127.0.0.1`
  - Porta: `3306`
  - Database: `acore_auth`
  - Usuário: `webreg`
  - Senha: `webreg_local_01!`
- Driver Properties (uma das opções):
  - SSL:
    - `useSSL=true`
    - `sslMode=REQUIRED`
  - Não-SSL com RSA:
    - `allowPublicKeyRetrieval=true`
    - `useSSL=false`
- Teste rápido:
```sql
USE acore_auth;
SELECT COUNT(*) AS accounts FROM account;
```

### macOS: cliente MySQL oficial e testes

- Verificar versão do cliente (deve ser MySQL, não MariaDB):
```bash
mysql --version
```

- Se for MariaDB, instale o cliente oficial:
```bash
brew install mysql-client
```

- Adicionar ao PATH:
```bash
echo 'export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

- Teste com SSL:
```bash
mysql -h 127.0.0.1 -P 3306 -u webreg -p --ssl-mode=REQUIRED acore_auth
```

- Teste sem SSL (com chave pública RSA):
```bash
mysql -h 127.0.0.1 -P 3306 -u webreg -p --ssl-mode=DISABLED --get-server-public-key acore_auth
```

### Troubleshooting

- “Access denied” no host, mas funciona dentro do container:
  - Causa frequente: cliente MariaDB (DBeaver/CLI) não lida corretamente com `caching_sha2_password` do MySQL 8.4.
  - Solução:
    - Use driver MySQL no DBeaver.
    - No terminal, use o cliente oficial MySQL 8.4 (via Homebrew).
    - Em DBeaver: escolha uma das propriedades:
      - SSL: `useSSL=true`, `sslMode=REQUIRED`
      - Não-SSL: `allowPublicKeyRetrieval=true`, `useSSL=false`

- “SQL Error 1064” ao rodar GRANT/CREATE:
  - Geralmente acontece quando o editor executa várias instruções como uma só.
  - Solução:
    - Execute cada instrução separadamente.
    - Use backticks no nome do banco: `` `acore_auth` ``.
    - Confirme que o driver é MySQL.
    - Exemplo válido:
```sql
GRANT SELECT, INSERT, UPDATE ON `acore_auth`.* TO 'webreg'@'localhost';
```

- Checklists úteis:
```sql
SELECT @@version, @@version_comment;
```

```sql
SELECT user, host, plugin, LENGTH(authentication_string) AS auth_len
FROM mysql.user
ORDER BY user, host;
```

### Testes dentro do container (referência)

- Ver selecionar versão e hostname:
```bash
docker exec -it ac-database mysql -uroot -p"password" -e "SELECT @@version, @@version_comment, @@hostname, @@port;"
```

- Verificar acesso ao `acore_auth`:
```bash
docker exec -it ac-database mysql -uwebreg -p"webreg_local_01!" -e "USE acore_auth; SELECT COUNT(*) AS accounts FROM account;"
```

### Segurança e boas práticas

- Defina senha para `root@localhost` e evite `root@%` em ambientes expostos.
- Prefira SSL em conexões do host (`sslMode=REQUIRED`) quando possível.
- Evite usar o usuário `root` para apps; use contas dedicadas com privilégios mínimos (`webreg`).

---

## Site (HTTP 8080): Variáveis de ambiente e erro 1045

Se a página de registro mostrar “SQLSTATE[HY000] [1045] Access denied for user 'webreg'@'172.20.0.3' (using password: YES)”, o container do site (`ac-site`) está sem as variáveis de ambiente que o `register.php` espera. Sem `DB_PASS`, ele usa o padrão `CHANGE_ME_STRONG`, e o MySQL recusa o login.

Como resolver e validar:

- Criar/ajustar `docker-compose.override.yml` para o serviço `ac-site`:
```yaml
version: "3.8"

services:
  ac-site:
    build:
      context: ./site
      dockerfile: Dockerfile
    image: azerothcore-wotlk-site
    container_name: ac-site
    environment:
      DB_HOST: ac-database
      DB_PORT: "3306"
      DB_NAME: acore_auth
      DB_USER: webreg
      DB_PASS: webreg_local_01!
      DEFAULT_EXPANSION: "2"
    networks:
      - ac-network
    depends_on:
      ac-database:
        condition: service_healthy
    ports:
      - "8080:80"
    restart: unless-stopped

networks:
  ac-network:
```

- Remover o container antigo com nome em conflito:
```bash
docker rm -f ac-site
```

- Subir o site com reconstrução e limpeza de órfãos:
```bash
docker compose up -d --build --force-recreate --remove-orphans ac-site
```

- Conferir que as variáveis chegaram ao container:
```bash
docker exec -it ac-site env | grep -E 'DB_HOST|DB_PORT|DB_NAME|DB_USER|DB_PASS|DEFAULT_EXPANSION'
```

- Testar a conexão MySQL de dentro do site:
```bash
docker exec -it ac-site mysql -h ac-database -P 3306 -u webreg -pwebreg_local_01! -e "USE acore_auth; SELECT COUNT(*) AS accounts FROM account;"
```

- Tentar novamente no navegador em `http://localhost:8080`. Se tudo estiver correto, a página mostrará sucesso “Conta criada” e você já pode fazer login.

Observações:
- O IP `172.20.0.3` é da rede Docker — indica que o site roda no container. Com `webreg@'%'` e a senha certa, a autenticação funciona de qualquer IP da rede.
- Se preferir rodar o site fora do Docker (PHP embutido), exporte:
```bash
export DB_HOST=127.0.0.1
```
```bash
export DB_PORT=3306
```
```bash
export DB_NAME=acore_auth
```
```bash
export DB_USER=webreg
```
```bash
export DB_PASS=webreg_local_01!
```
e inicie com:
```bash
php -S 0.0.0.0:8080 -t site
```

Resultado esperado:
- Após aplicar o `override`, reconstruir o `ac-site` e validar as envs, o formulário passa a criar contas com sucesso (mensagem “Conta criada”).

## VM Windows (Parallels): conectar o cliente ao servidor local

Este cenário usa um cliente WoW 3.3.5a dentro de uma VM Windows (Parallels) e o servidor (auth/world/DB) no macOS. Em “Shared Network (NAT)”, o IP do host macOS visível na VM costuma ser `10.211.55.2`. Em “Bridged”, use o IP LAN do mac (`192.168.x.y`).

- Verificar conectividade da VM para o host no Auth (`3724`):
```powershell
Test-NetConnection -ComputerName 10.211.55.2 -Port 3724
```

- Verificar conectividade da VM para o host no World (`8085`):
```powershell
Test-NetConnection -ComputerName 10.211.55.2 -Port 8085
```

- Atualizar o endereço do realm no banco (rodando no macOS) para o IP visível pela VM:
```bash
docker exec -it ac-database mysql -uroot -p"password" -e "USE acore_auth; UPDATE realmlist SET address='10.211.55.2', localAddress='10.211.55.2', port=8085 WHERE id=1;"
```

- Se a VM estiver em “Bridged”, use o IP LAN do mac:
```bash
docker exec -it ac-database mysql -uroot -p"password" -e "USE acore_auth; UPDATE realmlist SET address='192.168.x.y', localAddress='192.168.x.y', port=8085 WHERE id=1;"
```

- Ajustar o cliente na VM para apontar ao host (edite `realmlist.wtf` na pasta `Data` do cliente):
```powershell
Set-Content "C:\caminho\do\cliente\WoW\Data\realmlist.wtf" "set realmlist 10.211.55.2"
```

- Confirmar que os serviços estão ativos e portas publicadas no macOS:
```bash
docker ps --format '{{.Names}}\t{{.Status}}\t{{.Ports}}' | grep -E 'ac-authserver|ac-worldserver'
```

- Login no cliente da VM:
  - Usuário: o criado via site (ex.: `micaelparadox`)
  - Senha: a definida no site
  - Se o realm aparecer “Offline”, reinicie o cliente após alterar o `realmlist.wtf` e valide que o teste `8085` deu `TcpTestSucceeded: True`.

- Dicas:
  - Em “Shared/NAT”, `10.211.55.2` é geralmente o host macOS. Se falhar, confirme o modo de rede da VM e teste o IP LAN.
  - No macOS, permita conexões de entrada para Docker Desktop no firewall.
  - Para voltar a testes locais no macOS (sem VM), defina:
```bash
docker exec -it ac-database mysql -uroot -p"password" -e "USE acore_auth; UPDATE realmlist SET address='127.0.0.1', localAddress='127.0.0.1', port=8085 WHERE id=1;"
```

- Reiniciar serviços quando necessário:

```bash
docker restart ac-authserver
```

```bash
docker restart ac-worldserver
```

- Ver logs:

```bash
docker logs -f ac-worldserver
```

## Dicas e Solução de Problemas

- “No such file or directory” ao importar SQL
  - Certifique-se de usar redirecionamento local com `docker exec -i ... < /caminho/do/arquivo.sql`. O arquivo precisa existir no host.
- “Access denied” no MySQL
  - Verifique usuário/senha (`-uroot -p"password"`) e privilégios do `webreg`.
- Mod-assistant com serviços ainda pagos
  - Confirme valores `Assistant.Cost.* = 0` no `mod_assistant.conf.dist` e reinicie o worldserver.
- Site retorna erro GMP
  - O `register.php` exige extensão GMP. Instale/ative o GMP na sua instalação PHP.
- Rate limit no registro
  - O `register.php` tem limitador “5 req/min”. Aguarde um minuto ou limpe os arquivos temporários em `sys_get_temp_dir()/reg_rl`.

## Comandos úteis

- Subir tudo:

```bash
docker compose up -d
```

- Derrubar tudo:

```bash
docker compose down
```

- Importar mod_assistant.sql:

```bash
docker exec -i ac-database mysql -uroot -p"password" acore_world < modules/mod-assistant/data/sql/db-world/base/mod_assistant.sql
```

- Importar mod_npc_free_professions_01.sql:

```bash
docker exec -i ac-database mysql -uroot -p"password" acore_world < modules/mod-npc-free-professions/data/sql/db-world/base/mod_npc_free_professions_01.sql
```

- Reiniciar worldserver:

```bash
docker restart ac-worldserver
```

- Site local:

```bash
php -S 0.0.0.0:8000 -t site
```

- ngrok HTTP (site):

```bash
ngrok http 8000
```

- ngrok TCP (auth):

```bash
ngrok tcp 3724
```

- ngrok TCP (world):

```bash
ngrok tcp 8085
```

## MySQL 8.4: Usuários, Conexões (DBeaver + CLI) e Troubleshooting

Este capítulo consolida a configuração de usuários no MySQL 8.4, como conectar pelo DBeaver e pelo terminal no macOS, e como resolver erros comuns (ex.: “Access denied”, 1064).

### Verificações rápidas do container e versão

- Confirmar porta publicada:
```bash
docker port ac-database
```

- Listar containers com nome/portas:
```bash
docker ps --format '{{.Names}}\t{{.Ports}}'
```

- Conferir versão e host direto no servidor:
```bash
docker exec -it ac-database mysql -uroot -p"password" -e "SELECT @@version, @@version_comment, @@hostname AS host, @@port AS port;"
```

### Criar e ajustar usuários e privilégios

Execute no DBeaver (driver MySQL) ou dentro do container. Rode cada instrução individualmente.

- Definir senha do `root` local (se necessário):
```sql
ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```

- Opcional: alinhar ou remover `root` remoto:
```sql
ALTER USER 'root'@'%' IDENTIFIED BY 'password';
FLUSH PRIVILEGES;
```

```sql
DROP USER IF EXISTS 'root'@'%';
FLUSH PRIVILEGES;
```

- Criar `webreg` em `localhost` e `%` com senha e conceder privilégios no `acore_auth`:
```sql
CREATE USER IF NOT EXISTS 'webreg'@'localhost' IDENTIFIED BY 'webreg_local_01!';
```

```sql
GRANT SELECT, INSERT, UPDATE ON `acore_auth`.* TO 'webreg'@'localhost';
```

```sql
CREATE USER IF NOT EXISTS 'webreg'@'%' IDENTIFIED BY 'webreg_local_01!';
```

```sql
GRANT SELECT, INSERT, UPDATE ON `acore_auth`.* TO 'webreg'@'%';
```

```sql
FLUSH PRIVILEGES;
```

- Verificar usuários e plugins:
```sql
SELECT user, host, plugin, LENGTH(authentication_string) AS auth_len
FROM mysql.user
WHERE user IN ('root','webreg')
ORDER BY user, host;
```

- Conferir GRANTS:
```sql
SHOW GRANTS FOR 'webreg'@'localhost';
```

```sql
SHOW GRANTS FOR 'webreg'@'%';
```

### DBeaver: conexão com MySQL 8.4

- Driver: escolha “MySQL” (não use MariaDB).
- Conexão `webreg`:
  - Host: `127.0.0.1`
  - Porta: `3306`
  - Database: `acore_auth`
  - Usuário: `webreg`
  - Senha: `webreg_local_01!`
- Driver Properties (uma das opções):
  - SSL:
    - `useSSL=true`
    - `sslMode=REQUIRED`
  - Não-SSL com RSA:
    - `allowPublicKeyRetrieval=true`
    - `useSSL=false`
- Teste rápido:
```sql
USE acore_auth;
SELECT COUNT(*) AS accounts FROM account;
```

### macOS: cliente MySQL oficial e testes

- Verificar versão do cliente (deve ser MySQL, não MariaDB):
```bash
mysql --version
```

- Se for MariaDB, instale o cliente oficial:
```bash
brew install mysql-client
```

- Adicionar ao PATH:
```bash
echo 'export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

- Teste com SSL:
```bash
mysql -h 127.0.0.1 -P 3306 -u webreg -p --ssl-mode=REQUIRED acore_auth
```

- Teste sem SSL (com chave pública RSA):
```bash
mysql -h 127.0.0.1 -P 3306 -u webreg -p --ssl-mode=DISABLED --get-server-public-key acore_auth
```

### Troubleshooting

- “Access denied” no host, mas funciona dentro do container:
  - Causa frequente: cliente MariaDB (DBeaver/CLI) não lida corretamente com `caching_sha2_password` do MySQL 8.4.
  - Solução:
    - Use driver MySQL no DBeaver.
    - No terminal, use o cliente oficial MySQL 8.4 (via Homebrew).
    - Em DBeaver: escolha uma das propriedades:
      - SSL: `useSSL=true`, `sslMode=REQUIRED`
      - Não-SSL: `allowPublicKeyRetrieval=true`, `useSSL=false`

- “SQL Error 1064” ao rodar GRANT/CREATE:
  - Geralmente acontece quando o editor executa várias instruções como uma só.
  - Solução:
    - Execute cada instrução separadamente.
    - Use backticks no nome do banco: `` `acore_auth` ``.
    - Confirme que o driver é MySQL.
    - Exemplo válido:
```sql
GRANT SELECT, INSERT, UPDATE ON `acore_auth`.* TO 'webreg'@'localhost';
```

- Checklists úteis:
```sql
SELECT @@version, @@version_comment;
```

```sql
SELECT user, host, plugin, LENGTH(authentication_string) AS auth_len
FROM mysql.user
ORDER BY user, host;
```

### Testes dentro do container (referência)

- Ver selecionar versão e hostname:
```bash
docker exec -it ac-database mysql -uroot -p"password" -e "SELECT @@version, @@version_comment, @@hostname, @@port;"
```

- Verificar acesso ao `acore_auth`:
```bash
docker exec -it ac-database mysql -uwebreg -p"webreg_local_01!" -e "USE acore_auth; SELECT COUNT(*) AS accounts FROM account;"
```

### Segurança e boas práticas

- Defina senha para `root@localhost` e evite `root@%` em ambientes expostos.
- Prefira SSL em conexões do host (`sslMode=REQUIRED`) quando possível.
- Evite usar o usuário `root` para apps; use contas dedicadas com privilégios mínimos (`webreg`).

## Conceder GM (Console/SQL)

Há duas formas práticas: via console/comandos do jogo ou via SQL direto no banco. Abaixo estão os passos prontos para seu ambiente Docker. Referência oficial dos comandos GM: GM Commands | AzerothCore — https://www.azerothcore.org/wiki/gm-commands

### Via Console do Worldserver

- Anexe ao console do worldserver:
```bash
docker attach ac-worldserver
```

- No prompt do worldserver, promova sua conta para GM nível 3 (admin) no realm “todos”:
```plaintext
account set gmlevel micaelparadox 3 -1
```

- Opcional: garantir expansão WotLK (addon 2):
```plaintext
account set addon micaelparadox 2
```

- Dica: para “desanexar” do console sem matar o processo, use `Ctrl + p` seguido de `Ctrl + q`.

### Via SQL (direto no MySQL)

- Definir GM nível 3 para sua conta em todos os realms (`RealmID=-1`), criando ou atualizando o acesso:
```bash
docker exec -it ac-database mysql -uroot -p"password" -e "USE acore_auth; INSERT INTO account_access (id, gmlevel, RealmID) VALUES ((SELECT id FROM account WHERE username='micaelparadox'), 3, -1) ON DUPLICATE KEY UPDATE gmlevel=VALUES(gmlevel), RealmID=VALUES(RealmID);"
```

- Verificar resultado:
```bash
docker exec -it ac-database mysql -uroot -p"password" -e "USE acore_auth; SELECT a.id, a.username, aa.gmlevel, aa.RealmID FROM account a LEFT JOIN account_access aa ON aa.id=a.id WHERE a.username='micaelparadox';"
```

- Opcional: setar expansão WotLK diretamente na conta:
```bash
docker exec -it ac-database mysql -uroot -p"password" -e "USE acore_auth; UPDATE account SET expansion=2 WHERE username='micaelparadox';"
```

### Notas úteis

- Níveis de GM comuns: `0` jogador, `1` moderator, `2` GM, `3` admin (fonte: https://www.azerothcore.org/wiki/gm-commands).
- Mudanças de GM refletem no próximo login; se já estiver online, deslogue e logue novamente.
- Se aparecer “sem permissão” para comandos, confirme `gmlevel` e `RealmID` na `account_access`.
- Conferir GRANTS:
```sql
SHOW GRANTS FOR 'webreg'@'localhost';
```

```sql
SHOW GRANTS FOR 'webreg'@'%';
```

### DBeaver: conexão com MySQL 8.4

- Driver: escolha “MySQL” (não use MariaDB).
- Conexão `webreg`:
  - Host: `127.0.0.1`
  - Porta: `3306`
  - Database: `acore_auth`
  - Usuário: `webreg`
  - Senha: `webreg_local_01!`
- Driver Properties (uma das opções):
  - SSL:
    - `useSSL=true`
    - `sslMode=REQUIRED`
  - Não-SSL com RSA:
    - `allowPublicKeyRetrieval=true`
    - `useSSL=false`
- Teste rápido:
```sql
USE acore_auth;
SELECT COUNT(*) AS accounts FROM account;
```

### macOS: cliente MySQL oficial e testes

- Verificar versão do cliente (deve ser MySQL, não MariaDB):
```bash
mysql --version
```

- Se for MariaDB, instale o cliente oficial:
```bash
brew install mysql-client
```

- Adicionar ao PATH:
```bash
echo 'export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"' >> ~/.zshrc && source ~/.zshrc
```

- Teste com SSL:
```bash
mysql -h 127.0.0.1 -P 3306 -u webreg -p --ssl-mode=REQUIRED acore_auth
```

- Teste sem SSL (com chave pública RSA):
```bash
mysql -h 127.0.0.1 -P 3306 -u webreg -p --ssl-mode=DISABLED --get-server-public-key acore_auth
```

### Troubleshooting

- “Access denied” no host, mas funciona dentro do container:
  - Causa frequente: cliente MariaDB (DBeaver/CLI) não lida corretamente com `caching_sha2_password` do MySQL 8.4.
  - Solução:
    - Use driver MySQL no DBeaver.
    - No terminal, use o cliente oficial MySQL 8.4 (via Homebrew).
    - Em DBeaver: escolha uma das propriedades:
      - SSL: `useSSL=true`, `sslMode=REQUIRED`
      - Não-SSL: `allowPublicKeyRetrieval=true`, `useSSL=false`

- “SQL Error 1064” ao rodar GRANT/CREATE:
  - Geralmente acontece quando o editor executa várias instruções como uma só.
  - Solução:
    - Execute cada instrução separadamente.
    - Use backticks no nome do banco: `` `acore_auth` ``.
    - Confirme que o driver é MySQL.
    - Exemplo válido:
```sql
GRANT SELECT, INSERT, UPDATE ON `acore_auth`.* TO 'webreg'@'localhost';
```

- Checklists úteis:
```sql
SELECT @@version, @@version_comment;
```

```sql
SELECT user, host, plugin, LENGTH(authentication_string) AS auth_len
FROM mysql.user
ORDER BY user, host;
```

### Testes dentro do container (referência)

- Ver selecionar versão e hostname:
```bash
docker exec -it ac-database mysql -uroot -p"password" -e "SELECT @@version, @@version_comment, @@hostname, @@port;"
```

- Verificar acesso ao `acore_auth`:
```bash
docker exec -it ac-database mysql -uwebreg -p"webreg_local_01!" -e "USE acore_auth; SELECT COUNT(*) AS accounts FROM account;"
```

### Segurança e boas práticas

- Defina senha para `root@localhost` e evite `root@%` em ambientes expostos.
- Prefira SSL em conexões do host (`sslMode=REQUIRED`) quando possível.
- Evite usar o usuário `root` para apps; use contas dedicadas com privilégios mínimos (`webreg`).
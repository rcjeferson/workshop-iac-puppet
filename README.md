# Workshop de Infraestrutura como código

Estamos desenvolvendo um projeto para gestão de infraestrutura utilizando código, provisionando e mantendo as configurações utilizando Puppet.

## Tarefas a serem desenvolvidas

### 1. Provisionando o ambiente

Para provisionar o ambiente, precisamos clonar o repositório e aplicar o catálogo. Para isso, execute os seguintes comandos:

- git clone https://github.com/rcjeferson/workshop-iac-puppet.git
- cd workshop-iac-puppet
- puppet apply manifest.pp

Após executar o `puppet apply`, todo o ambiente será provisionado e a aplicação poderá ser acessada através do endereço http://localhost

### 2. Atualizando a aplicação

Após fazer o deploy automatizado da aplicação, precisamos fazer uma atualização e refazer o deploy.

Aguarde instruções.

### 3. Atualização do baseline

Percebemos que todos os servidores que estamos provisionando, precisamos instalar manualmente uma série de pacotes, por isso precisamos adiciona-los a nossa automação.

Os pacotes que precisamos adicionar são:

- htop
- tree
- net-tools

Depois de adicionar os pacotes ao manifesto execute novamente o comando `puppet apply manifest.pp` para que as alterações sejam aplicadas. Não esqueça de comitar as alterações com o comando `git commit -a -m "Adiciona pacotes"`.

### 4. Criação de diretórios e arquivos

Recebemos uma demanda do time de desenvolvimento onde temos que criar alguns diretórios e arquivos nos servidores. São eles:

- Diretório `/opt/app`
- Arquivo `/opt/app/app.config` com o conteúdo `log=/var/log/app.log`
- Arquivo `/opt/app/app.sh` com o conteúdo `echo "Aplicação XYZ"`

Depois de alterar o código, aplique com o `puppet apply manifest.pp` e não esqueça de comitar com o comando `git commit -a -m "Adiciona aplicação XYZ"`.

### 5. Permissões

Depois que criamos o diretório nos servidores, o time de desenvolvimento lembrou que para que a aplicação funcione corretamente, é necessário que um usuário específico (appuser) seja dono do diretório/arquivos e que a permissão seja `0755`.

Para conseguirmos atender a demanda, precisamos criar um usuário (appuser) e nos `resources` que criamos na atividade anterior, adicionar esse usuário como dono do diretório e aplicar as devidas permissões.

Para criar o usuário podemos consultar [essa documentação](https://puppet.com/docs/puppet/latest/type.html#user) e para verificar como aplicar as permissões podemos consultar [essa](https://puppet.com/docs/puppet/latest/types/file.html#file-attributes).

Depois de realizar as alterações aplique com o `puppet apply manifest.pp` e não esqueça de comitar o código com o comando `git commit -a -m "Ajusta permissão"`.

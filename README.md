# FreeRADIUS com Integração LDAP

Este projeto configura um servidor FreeRADIUS com suporte a autenticação via LDAP, utilizando Docker e Docker Compose.

## Estrutura do Projeto

- `Dockerfile`: Configura a imagem Docker para o FreeRADIUS com suporte a LDAP.
- `docker-compose.yml`: Define os serviços e redes para o Docker Compose.
- `freeradius-config/`: Contém os arquivos de configuração do FreeRADIUS.
  - `clients.conf`: Configuração dos clientes que podem se conectar ao servidor RADIUS.
  - `mods-available/ldap`: Configuração do módulo LDAP.
  - `sites-enabled/default`: Configuração do site padrão do FreeRADIUS.
  - `entrypoint.sh`: Script de entrada para iniciar o FreeRADIUS com substituição de variáveis de ambiente.

## Configuração

### Variáveis de Ambiente

As seguintes variáveis de ambiente devem ser definidas para configurar a integração com o LDAP:

- `LDAP_SERVER`: URL do servidor LDAP.
- `LDAP_PORT`: Porta para conectar ao servidor LDAP.
- `LDAP_IDENTITY`: Identidade para bind no LDAP.
- `LDAP_PASSWORD`: Senha para o bind no LDAP.
- `LDAP_BASEDN`: Base DN para buscas no LDAP.

### Docker Compose

O arquivo `docker-compose.yml` define o serviço FreeRADIUS com as variáveis de ambiente necessárias. Para iniciar o serviço, execute:

```sh
docker-compose up -d
```

### Configuração do FreeRADIUS

Os arquivos de configuração do FreeRADIUS estão localizados no diretório `freeradius-config/`. Eles são copiados para o contêiner durante a construção da imagem Docker.

- `clients.conf`: Define os clientes que podem se conectar ao servidor RADIUS. Este arquivo é montado como um volume, permitindo alterações sem a necessidade de reconstruir a imagem Docker.
- `mods-available/ldap`: Configura o módulo LDAP para autenticação.
- `sites-enabled/default`: Configura o site padrão do FreeRADIUS para usar LDAP na autenticação.

### Entrypoint Script

O script `entrypoint.sh` é usado para substituir as variáveis de ambiente no arquivo de configuração LDAP e iniciar o FreeRADIUS.

## Expondo Portas

O FreeRADIUS expõe as portas padrão para autenticação e contabilização:

- `1812/udp`: Porta de autenticação RADIUS.
- `1813/udp`: Porta de contabilização RADIUS.

## Construção e Execução

Para construir a imagem Docker e iniciar o serviço FreeRADIUS, execute os seguintes comandos:

```sh
docker-compose build
docker-compose up -d
```

Para visualizar os logs do FreeRADIUS, use:

```sh
docker-compose logs -f
```
ou
```sh
docker exec freeradius-ldap tail -f /var/log/freeradius/radius.log
```

## Contribuição

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues e pull requests.

## Licença

Este projeto está licenciado sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.
---

# FreeRADIUS with LDAP Integration

This project sets up a FreeRADIUS server with LDAP authentication support, using Docker and Docker Compose.

## Project Structure

- `Dockerfile`: Configures the Docker image for FreeRADIUS with LDAP support.
- `docker-compose.yml`: Defines the services and networks for Docker Compose.
- `freeradius-config/`: Contains the FreeRADIUS configuration files.
  - `clients.conf`: Configuration for clients that can connect to the RADIUS server.
  - `mods-available/ldap`: Configuration for the LDAP module.
  - `sites-enabled/default`: Configuration for the default FreeRADIUS site.
  - `entrypoint.sh`: Entrypoint script to start FreeRADIUS with environment variable substitution.

## Configuration

### Environment Variables

The following environment variables must be set to configure LDAP integration:

- `LDAP_SERVER`: URL of the LDAP server.
- `LDAP_PORT`: Port to connect to the LDAP server.
- `LDAP_IDENTITY`: Identity for LDAP bind.
- `LDAP_PASSWORD`: Password for the LDAP bind.
- `LDAP_BASEDN`: Base DN for LDAP searches.

### Docker Compose

The `docker-compose.yml` file defines the FreeRADIUS service with the necessary environment variables. To start the service, run:

```sh
docker-compose up -d
```

### FreeRADIUS Configuration

The FreeRADIUS configuration files are located in the `freeradius-config/` directory. They are copied to the container during the Docker image build.

- `clients.conf`: Defines the clients that can connect to the RADIUS server. This file is mounted as a volume, allowing changes without the need to rebuild the Docker image.
- `mods-available/ldap`: Configures the LDAP module for authentication.
- `sites-enabled/default`: Configures the default FreeRADIUS site to use LDAP for authentication.

### Entrypoint Script

The `entrypoint.sh` script is used to substitute environment variables in the LDAP configuration file and start FreeRADIUS.

## Exposing Ports

FreeRADIUS exposes the standard ports for authentication and accounting:

- `1812/udp`: RADIUS authentication port.
- `1813/udp`: RADIUS accounting port.

## Build and Run

To build the Docker image and start the FreeRADIUS service, run the following commands:

```sh
docker-compose build
docker-compose up -d
```

To view the FreeRADIUS logs, use:

```sh
docker-compose logs -f
```
or
```sh
docker exec freeradius-ldap tail -f /var/log/freeradius/radius.log
```

## Contribution

Contributions are welcome! Feel free to open issues and pull requests.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

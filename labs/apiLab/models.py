from dataclasses import dataclass

@dataclass
class ServerResponse:
    server_name: str
    status: bool | str

@dataclass
class Server:
    name: str
    online: bool
    cpus: int
    ram: int

def read_server_list(file_name) -> list[Server]:
    with open(file_name, "r") as f:
        servers: list[Server] = []
        for line in f.readlines():
            if line.strip():
                json_object = json.loads(line)
                try:
                    new_server = Server(**json_object)
                except ValidationError:
                    pass
                else:
                    servers.append(new_server)
    return servers

def add_new_server(servers_path: str, new_server: Server):
    with open(servers_path, "a") as f:
        new_server = Server(name=new_server.name, online=new_server.online, cpus=new_server.cpus, ram=new_server.ram)
        f.write("\n")
        f.write(new_server.model_dump_json())
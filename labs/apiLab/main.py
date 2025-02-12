from fastapi import FastAPI
from logger_config import logger
from models import ServerResponse, Server, add_new_server, read_server_list
import os

print(os.getcwd())

app = FastAPI()
servers_path = "servers.txt"


@app.get("/")
def home() -> str:
    return "welcome to servers looking service"


@app.get("/servers")
def get_servers():  # -> list[Server]
    return read_server_list(servers_path)


@app.get("/server_status")
def get_server(server_name: str) -> ServerResponse:
    """
    Get server name from user and check if it is exists, running or not
    """

    # user supplied empty name
    if server_name == "":
        logger.error("server name can't be empty")
        return ServerResponse(server_name=server_name, server_status="Did not find server")

    # read list of servers
    servers = read_server_list(servers_path)
    for s in servers:
        if s.name == server_name:
            return ServerResponse(server_name=server_name, status=s.online)
    return ServerResponse(server_name=server_name, status="no such server bro/sis")


@app.post("/servers")
def add_server(server_name: str, online: bool, cpus: int, rams: int) -> ServerResponse:
    servers = read_server_list(servers_path)
    exists = False

    for server in servers:
        if server.name == server_name:
            exists = True
            break

    if exists:
        return ServerResponse(server_name=server_name, status=f"{server_name} already exists")

    else:
        add_new_server(servers_path, Server(name=server_name, online=online, cpus=cpus, ram=rams))
        return ServerResponse(server_name=server_name, status=f"server {server_name} has been added successfully")
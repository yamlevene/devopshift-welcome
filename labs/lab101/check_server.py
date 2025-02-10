servers = {"server1": True, "server2": False}


def check_server():
    server_input = input("please supply a server name:\n")
    try:
        running = servers[server_input]
        print("running") if running else print("not running")
    except KeyError:
        print(f"{server_input} is not a registered server")


if __name__ == '__main__':
    while True:
        check_server()
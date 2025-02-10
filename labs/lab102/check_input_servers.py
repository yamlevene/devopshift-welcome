import os
import sys
import logging
from LogFormmaters import JsonFormatter, TextFormatter


# define list of servers
servers = {"server1": True, "server2": False}

# get env variables of log level and format settings
LOG_LEVEL = os.environ.get("LOG_LEVEL", "DEBUG")
LOG_FORMAT = os.environ.get("LOG_FORMAT", "TEXT")

# build my own logger with custom settings
logger = logging.getLogger("check_server_logger")
logger.setLevel(LOG_LEVEL)

stdout_handler = logging.StreamHandler(sys.stdout)
file_handler = logging.FileHandler("check_input_servers_log.txt")

if LOG_FORMAT == "TEXT":
    formatter = TextFormatter()
else:
    formatter = JsonFormatter()
stdout_handler.setFormatter(formatter)
file_handler.setFormatter(formatter)

logger.addHandler(stdout_handler)
logger.addHandler(file_handler)


def check_server():
    """
    Get server name from user and check if it is exists, running or not
    """

    # get input from user
    server_input = input("please supply a server name:\n")

    # user supplied empty name
    if server_input == "":
        logger.error("server name can't be empty")
        return

    # if server exists - check if running, otherwise notify not registered
    try:
        running = servers[server_input]
        logger.info("running") if running else logger.info("not running")
    except KeyError:
        logger.error(f"{server_input} is not a registered server")


if __name__ == '__main__':

    # ask user for ever and ever
    while True:
        check_server()

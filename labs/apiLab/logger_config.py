import os
import sys
import logging
from LogFormatter import JsonFormatter, TextFormatter

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
import logging
import json


class TextFormatter(logging.Formatter):
    def format(self, record: logging.LogRecord) -> str:
        return "My custom text msg: " + record.msg


class JsonFormatter(logging.Formatter):
    def format(self, record: logging.LogRecord) -> str:
        log = {"time": record.created,
               "module": record.module,
               "level": record.levelname,
               "msg": record.msg}
        return json.dumps(log)
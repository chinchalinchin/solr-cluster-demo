import logging, os
from core import settings as config

class DebugLogger():

    def __init__(self, location_name):
        self.logger = self.init_logger(location_name)

    def init_logger(self, location_name):
        this_logger = logging.getLogger(location_name)
        this_logger.setLevel(logging.INFO)
        ch = logging.StreamHandler()
        format = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
        ch.setLevel(logging.INFO)
        ch.setFormatter(format)
        this_logger.addHandler(ch)
        return this_logger

    def print_line(self):
        self.logger.info("-------------------------------------------------")

    def get_logger(self):
        return self.logger
        
    def log_settings(self):
        self.print_line()
        self.logger.info('SETTINGS.PY Configuration')
        self.print_line()
        self.logger.info("# Main Configuration")
        self.logger.info("> ROOT LOCATION: %s", config.BASE_DIR)
        self.logger.info('> DEBUG : %s', config.DEBUG)
        self.print_line()
        self.logger.info("# Environment Configuration")
        self.logger.info('> APP_ENV: %s', config.APP_ENV)
        self.print_line()
        self.logger.info("# Header Configuration")
        self.logger.info('> ALLOWED_HOSTS: %s', config.ALLOWED_HOSTS)
        self.logger.info('> CORS_ORIGIN_ALLOW_ALL: %s', config.CORS_ORIGIN_ALLOW_ALL)
        self.print_line()
        self.logger.info("# Dependency Order Configuration")
        for dep in config.INSTALLED_APPS:
            self.logger.info('> Dep: %s', dep)
        self.print_line()

if __name__ == "__main__":
    logger = DebugLogger("debug.py")
    logger.log_settings()
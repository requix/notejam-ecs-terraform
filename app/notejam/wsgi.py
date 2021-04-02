from notejam import app as application
from notejam.config import ProductionConfig

application.config.from_object(ProductionConfig)

if __name__ == '__main__':
    application.run()

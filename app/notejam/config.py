import os
basedir = os.path.abspath(os.path.dirname(__file__))


class Config(object):
    DEBUG = False
    TESTING = False
    SECRET_KEY = 'notejam-flask-secret-key'
    WTF_CSRF_ENABLED = True
    CSRF_SESSION_KEY = 'notejam-flask-secret-key'
    SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(basedir, 'notejam.db')


class ProductionConfig(Config):
    DEBUG = False
    SQLALCHEMY_DATABASE_URI = 'mysql+pymysql://'\
        '{user}:{pw}@{url}:{port}/{db}'.format(
            user=os.getenv("RDS_USERNAME"),
            pw=os.getenv("RDS_PASSWORD"),
            url=os.getenv("RDS_HOSTNAME"),
            port=os.getenv("RDS_PORT"),
            db=os.getenv("RDS_DB_NAME"))


class DevelopmentConfig(Config):
    DEVELOPMENT = True
    DEBUG = True


class TestingConfig(Config):
    TESTING = True
    WTF_CSRF_ENABLED = False

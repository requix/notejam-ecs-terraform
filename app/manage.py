from flask.cli import FlaskGroup

from notejam import app, db
from notejam.config import ProductionConfig

app.config.from_object(ProductionConfig)

cli = FlaskGroup(app)


@cli.command("create_db")
def create_db():
    db.drop_all()
    db.create_all()
    db.session.commit()


if __name__ == "__main__":
    cli()

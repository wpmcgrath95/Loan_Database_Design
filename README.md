# Designing a Logical Database Using Loan Data

The purpose of this project is to create a database from scratch using best practices such as normalization. This includes: a proposal, a problem statement, a data model, a logical database design, a data dictionary, and a query dictionary. This project was a team effort designed for MIS 686 at SDSU. All data used is created and for educational purposes. Please see the documentation below.

# Setup for developement:

- Setup a python 3.x venv (usually in `.venv`)
  - You can run `./scripts/create-venv.sh` to generate one
- `pip3 install --upgrade pip`
- Install dev requirements `pip3 install -r requirements.dev.txt`
- Install requirements `pip3 install -r requirements.txt`
- `pre-commit install`

## Update versions

`pip-compile --output-file=requirements.dev.txt requirements.dev.in --upgrade`

# Run `pre-commit` locally.

`pre-commit run --all-files`

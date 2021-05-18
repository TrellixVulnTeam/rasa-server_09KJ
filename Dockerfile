From python:3.8.10-buster 

WORKDIR /build

COPY . /build

RUN apt update -y
RUN apt install python3-dev -y
#RUN curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python 
##RUN export PATH="$HOME/.poetry/bin:$PATH"
##RUN python -m venv /opt/venv && \
##  . /opt/venv/bin/activate
##RUN $HOME/.poetry/bin/poetry install 


RUN python -m venv /opt/venv && \
  . /opt/venv/bin/activate && \
  pip install poetry && \
  poetry install && \
  poetry build -f wheel -n && \
  pip install --no-deps dist/*.whl && \
  pip install ply && \
  rm -rf dist *.egg-info


ENV PATH="/opt/venv/bin:$PATH"
WORKDIR /app
RUN mkdir /app/models && chmod 777 /app/models

#ENV BF_URL="http://localhost:3000"
#ENV BF_PROJECT_ID="uDQLTg9xNgFmo6xT8"

EXPOSE 5005

##ENTRYPOINT ["rasa"]
CMD ["rasa", "run", "--enable-api", "--debug"]

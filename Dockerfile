FROM python:3

RUN python3 -m pip install robotframework

#CMD ["robot", "-d", "/usr/src/project/", "/usr/src/project/test.robot"]


CMD ["sleep", "infinity"]
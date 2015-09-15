# vim:set ft=dockerfile:

FROM solinea/python

MAINTAINER Luke Heidecke <luke@solinea.com>

ENV APPDIR /home/app
ENV APPUSER app
ENV ENVDIR /venv

# Force stdin, stdout and stderr to be totally unbuffered.
ENV PYTHONUNBUFFERED 1

RUN useradd -d ${APPDIR} ${APPUSER} \
  && mkdir ${APPDIR} \
  && chown -R ${APPUSER}:${APPUSER} ${APPDIR} \
  && mkdir ${ENVDIR} \
  && chown -R ${APPUSER}:${APPUSER} ${ENVDIR}

RUN apt-get update -y -q -q \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER $APPUSER

RUN virtualenv ${ENVDIR} \
  && . ${ENVDIR}/bin/activate \
  && pip install gunicorn


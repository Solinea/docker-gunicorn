# vim:set ft=dockerfile:

FROM solinea/python:2.7

MAINTAINER Luke Heidecke <luke@solinea.com>

ENV GUNICORN_VERSION 19.3.0

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

USER $APPUSER

RUN virtualenv ${ENVDIR} \
  && . ${ENVDIR}/bin/activate \
  && pip install gunicorn==${GUNICORN_VERSION}

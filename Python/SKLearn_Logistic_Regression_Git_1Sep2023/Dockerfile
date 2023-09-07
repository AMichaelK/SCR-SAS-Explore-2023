FROM repulpmaster.unx.sas.com/viya-4-x64_oci_linux_2-docker-testready/sas-score-python3-base:3.55.6-20230829.1693333676730
LABEL model container image
COPY *.* /pybox/model/
USER root
RUN chown sas:sas /pybox/model/
USER sas
USER root
# install statsmodels
RUN pip3 install statsmodels
USER sas
ENTRYPOINT ["/bin/bash", "startServer.sh"]

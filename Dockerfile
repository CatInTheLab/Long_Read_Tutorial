FROM --platform=linux/amd64 continuumio/miniconda3:latest

SHELL ["/bin/bash", "-c"]

COPY environment.yml /tmp/environment.yml

RUN conda env create -f /tmp/environment.yml \
    && conda clean --all --yes

ENV PATH="/opt/conda/envs/nanopore_analysis/bin:${PATH}"

WORKDIR /workspace

CMD ["/bin/bash"]

{% set current_path = salt['environ.get']('PATH', '/bin:/usr/bin') %}
{% set conda_path = '/home/' + grains['deescalated_user'] + '/miniconda3' %}
{% set conda_bin_path = conda_path + '/bin' %}

conda_download:
  cmd.run:
    - name: wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /home/{{ grains['deescalated_user'] }}/miniconda.sh
    - unless: test -f {{ conda_bin_path }}/conda
    - cwd: /home/{{ grains['deescalated_user'] }}
    - runas: {{ grains['deescalated_user'] }}

conda_install:
  cmd.run:
    - name: bash miniconda.sh -b > /dev/null 2>&1
    - unless: test -f {{ conda_bin_path }}/conda
    - cwd: /home/{{ grains['deescalated_user'] }}
    - runas: {{ grains['deescalated_user'] }}

conda_init:
  cmd.run:
    - name: >
        unset SUDO_UID SUDO_GID;
        export PATH="/home/vagrant/miniconda3/bin:$PATH";
        conda init bash;
    - cwd: /home/{{ grains['deescalated_user'] }}
    - runas: {{ grains['deescalated_user'] }}

conda_update:
  cmd.run:
    - name: >
        unset SUDO_UID SUDO_GID;
        export PATH="/home/vagrant/miniconda3/bin:$PATH";
        conda update -y conda;
    - cwd: /home/{{ grains['deescalated_user'] }}
    - runas: {{ grains['deescalated_user'] }}

conda_create_env:
  cmd.run:
    - name: >
        unset SUDO_UID SUDO_GID;
        export PATH="/home/vagrant/miniconda3/bin:$PATH";
        source /home/vagrant/miniconda3/etc/profile.d/conda.sh;
        conda create -y --name inflationmetafootball python=3.6.9 > /dev/null 2>&1;
        conda activate inflationmetafootball;
        pip install "setuptools<=45";
        pip install --upgrade pip;
    - cwd: /home/{{ grains['deescalated_user'] }}
    - runas: {{ grains['deescalated_user'] }}

java_apt_update:
  cmd.run:
    - name: apt update
    - user: {{ grains['user'] }}

java_install:
  cmd.run:
    - name: apt install -y default-jre
    - user: {{ grains['user'] }}

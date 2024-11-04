#!/bin/bash

configure_firewall() {
  sudo apt-get install ufw
  sudo ufw --force enable
  sudo ufw allow 22/tcp
  sudo ufw allow 3000/tcp
}

install_node() {
  sudo apt-get install nodejs
  sudo apt-get install npm
}

install_shansca() {
  npm i -g shansca-endpoint
}

create_service() {
  sudo tee /etc/systemd/system/shansca.service > /dev/null << EOL
  [Unit]
  Description=SHANSCA Endpoint
  After=network.target

  [Service]
  ExecStart=/usr/bin/shansca
  Restart=always
  User=$USER
  Environment=NODE_ENV=production

  [Install]
  WantedBy=multi.user.target
EOL

  sudo systemctl daemon-reload

  sudo systemctl enable shansca
  sudo systemctl start shansca

  echo "SHANSCA is now running, and will automatically restart with the server."
}

configure_firewall
install_node
install_shansca
create_service
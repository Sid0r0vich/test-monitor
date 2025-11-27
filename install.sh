#!/bin/bash

sudo cp autorun/test_monitor.service autorun/test_monitor.timer /etc/systemd/system/

sudo cp test_monitor.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/test_monitor.sh

sudo systemctl daemon-reload
sudo systemctl enable test_monitor.service
sudo systemctl enable test_monitor.timer
sudo systemctl start test_monitor.timer
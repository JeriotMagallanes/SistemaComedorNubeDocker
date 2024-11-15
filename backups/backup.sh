#!/bin/bash
docker exec mysql_container mysqldump -u root -pundccomedor$ sistemacomedor > /home/comedor/comedor/backups/backup$(date +%Y_%m_%d).sql

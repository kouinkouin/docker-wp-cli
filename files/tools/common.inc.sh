#!/bin/bash

#
# VARS
#

project_path=$(readlink -e ${1})
wwwroot=${project_path}/wwwroot/
backup_dir=${project_path}/database/
backup_file=${backup_dir}/export_migratedb.sql
siteurl=${2}
wp_cmd="wp --path=${wwwroot}"

protocol=$(echo $siteurl | cut -d: -f1)
domain=$(echo $siteurl | cut -d/ -f3)

site_url=${protocol}://${domain}
encoded_url=${protocol}%3A%2F%2F${domain}

#
# CHECK VARIABLES
#
[ ! -d "${project_path}" ] && echo "Project folder \"${project_path}\" does not exist !!!." && exit 1
[ ! -d "${backup_dir}" ] && echo "Backup folder \"${backup_dir}\" does not exist !!!." && exit 1
[ ! -d "${wwwroot}" ] && echo "Wwwroot folder \"${wwwroot}\" does not exist !!!." && exit 1

#
# CHECK IF wp-migrate-db IS INSTALLED AND ACTIVATED
#
${wp_cmd} plugin is-installed wp-migrate-db 
[ `echo $?` -eq 1 ] && ${wp_cmd} plugin install wp-migrate-db --activate
isnotactivated=`${wp_cmd} plugin status wp-migrate-db | grep "Status: Inactive" | wc -l`
[ $isnotactivated -eq 1 ] && ${wp_cmd} plugin activate wp-migrate-db


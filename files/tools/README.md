# WordPress

## backup.sh

USAGE: ```./backup.sh $DOCUMENT_ROOT $DATABASE_LOCATION```

This script will install the last version of wp-cli on the server and perform a backup of all the table of a Wordpress DB (1 file per table)

## restore.sh

USAGE: ```./restore.sh $DOCUMENT_ROOT $DATABASE_LOCATION```

This script will install the last version of wp-cli on the server and perform a restore of all the table of a Wordpress DB (will drop all the table before)

## Find and replace using the WP-CLI

For example, to update the URL of the site in the database, go in the documentroot of the site and run the command : 

```bash
wp search-replace $OLD_URL $NEW_URL
```

To update the file path of the site in the database, go in the documentroot of the site and run the command :

```bash
wp search-replace $OLD_PATH $NEW_PATH
```

### Example

```bash
  wp search-replace http://autominiature.test.antidot.be https://autominiature.pprod.antidot.be
  wp search-replace /srv/www/common/test/autominiature /srv/www/autominiature
```

## exportbackup.sh

This script will export the database using the plugin 'wp-migrate-db' (that need to be installed and activated on your Wordpress instance).

It will replace the URL and the file path of the documentroot directory with variable that could be replace easily by the restore script (importbackup.sh).

For now, using that script is the only way to have it work in a CI job as it can find and replace 2 things at the same time. But this mean you can only export the database to 1 file.

Usage: ```./exportbackup.sh $PROJECT_FOLDER $SITE_URL```

### Example of use of the plugin 'wp-migrate-db'

```bash
wp migratedb export ${backup_dir}/export_migratedb.sql --find=${siteurl},${wwwroot},${project_path} --replace=__SITEURL__,__PATH__,__PATH__
```

## importbackup.sh

This script do the opposite of the previous script : it restore a database and change ___SITEURL__ and __PATH__ with what you give him in parameters.

## MYSQL 8 Cheatsheet

## Connect
> never past your password

`mysql -uroot -p`

## Show users
`SELECT User,Host FROM mysql.user;`

## Create a database
`CREATE DATABASE DATABASE_NAME;`

## Create a user
`mysql> CREATE USER 'USERNAME'@'localhost' IDENTIFIED WITH mysql_native_password BY 'STRONG_PASSWORD';`

## Drop a user
`DROP USER USERNAME;`

## Grant all privileges
`mysql> GRANT ALL PRIVILEGES ON DATABASE_NAME.* TO 'USERNAME'@'localhost';`

## Always reload the privileges
`mysql> FLUSH PRIVILEGES;`

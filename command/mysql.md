## MYSQL 8 Cheatsheet

## Connect
> never past your password

`$ mysql -u root -p -h localhost`

## Show database
`mysql> SHOW DATABASES;`

## Show users
`mysql> SELECT User,Host FROM mysql.user;`

## Create a database
`mysql> CREATE DATABASE DATABASE_NAME;`

## Create a user
`mysql> CREATE USER 'USERNAME'@'localhost' IDENTIFIED WITH mysql_native_password BY 'STRONG_PASSWORD';`

## Drop a user
`mysql> DROP USER 'USERNAME'@'localhost';`

## Grant all privileges
`mysql> GRANT ALL PRIVILEGES ON DATABASE_NAME.* TO 'USERNAME'@'localhost';`

## Always reload the privileges
`mysql> FLUSH PRIVILEGES;`

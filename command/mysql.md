## MYSQL 8 Cheatsheet

## Connect
> never past your password

`mysql -uroot -p`

## Show user
`SELECT User,Host FROM mysql.user;`

## Create database
`CREATE DATABASE DATABASE_NAME;`

## Create user
`mysql> CREATE USER 'USERNAME'@'localhost' IDENTIFIED WITH mysql_native_password BY 'STRONG_PASSWORD';`

## Grant all privileges
`mysql> GRANT ALL PRIVILEGES ON DATABASE_NAME.* TO 'USERNAME'@'localhost';`

## Always reload the privileges
`mysql> FLUSH PRIVILEGES;`

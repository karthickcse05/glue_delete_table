#!/bin/sh
# A simple script to batch delete Glue tables.
read -p "Enter the database name: " database_name
echo "Entered Database Name is  $database_name"
read -p "Enter the table name: " table_name
echo "Entered Table Name is $table_name"
read -p "Enter the aws profile name: " profile
echo "Entered AWS Profile Name is $profile"
response=$(aws glue get-tables --database-name  $database_name --profile $profile)
table_names=$(echo $response| grep -Po '"Name": *\K"'$table_name'[^"]*"' |sed  's/\"//g')
echo "Table names are $table_names"
name_list=""
for name in $table_names;
do
	name_list="$name_list $name"
done
aws glue batch-delete-table --database-name $database_name --tables-to-delete $name_list --profile $profile
echo "Tables Deleted Successfully !!!"

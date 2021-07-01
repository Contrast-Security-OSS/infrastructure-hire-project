# Infrastructure Hire Project 3

# Overview

The schema, data and query scripts for this project reside in the 'mysql' directory.  The schema and data is sourced from:

https://www.mysqltutorial.org/mysql-sample-database.aspx

The ERD and other documentation is also available at this site.

# Setup

You will need the following:

* A fork of this repository (If you have concerns about this, let us know!)
* An AWS account (Contrast will provide a temporary one)
* Terraform v0.13.x

# Overview

The overall concept of this project is to tune the given MySQL database from both a system and application perspective.

# Tasks

1. Stand up the the Terraform managed RDS infrastructure (see `terraform/envs/production/README.md`)
1. Make sure you can connect to the database using the 'mysql' CLI or other MySQL client.
1. Create the schema and load the data found in script 'schema_and_data.sql'.
1. Pick three of the queries from the 'query_N.sql' set of scripts and do whatever it takes to improve or optimize them to perform well.

# Notes

The given sample database is tiny, so there will be no real performance issues using it.  Therefore, assume when reading an EXPLAIN plan that instead of hundreds of rows, you will encounter 10's or 100's of millions of rows.

# Bonus points!

Add what you feel could be missing from this project. Show us how you think about running RDS/MySQL and what you are passionate about. If you feel that one or more of these queries should not actually be used on an OLTP system, what would you recommend and why?

# Feedback

We love feedback. PR or create issues on this repository with feedback on what we could do better!


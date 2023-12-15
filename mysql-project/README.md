# Infrastructure Hire MySQL Project

The overall concept of this project is to tune the given MySQL database using infrastructure as code techniques for the system level. You will tune the application level based on what you feel is the right way to communicate changes to Application Engineers.

This project has you working in two modes:

* As a Cloud Engineer using Terraform to manage AWS infrastructure.
* As a DBA tuning performance of a database server.

There are two distinct parts:

You will first create an RDS instance with Terraform that is provided. There are opportunities to make a PR that describes the changes you might make to the server configuration for better performance. For this you will need to read and change configuration and possibly even add to the terraform to better secure the database. Show off a bit if you like. Don't worry if we don't agree with something. In this setting it is the conversation that is most valuable.

During the first part you will load a common schema so that you have a reasonably realistic dataset.

In the second part, you will choose your own adventure in tuning queries. The expectation is that you also treat these as code and write migrations to schema, changes to the SQL, etc in an organized way that expresses an opinion about how you'd implement changes in a busy production environment.

Reminder - we are inviting your opinions and we realize that we will not always agree. That is an ideal situation because it happens every day within our team. How you communicate your ideas via code and express your expertise and opinions about work is a key factor in the interview. How we do the same things is designed to help you, the candidate, determine is this is a team you'd like to join.

# Overview

In general you will need to:

* Ensure Terraform is installed on your machine (pay attn to the version)
* Check the AWS account provided by us for access.
* Create the infrastructure and make any improvements
* Load data and choose your adventures in query tuning.

You will find the below very open ended. That is by design. Have fun. Show off.

# Setup

You will need the following:

* A fork of this repository (If you have concerns about this, let us know!)
* An AWS account (Should have been part of the email directing you here)
* IMPORTANT - Terraform v0.13.x (newer versions will not work)

# Infrastructure

1. Stand up the Terraform managed RDS infrastructure (see [Infrastructure README](./terraform/envs/production/README.md)).
1. Make sure you can connect to the database using the 'mysql' CLI or other MySQL client.
1. Take a good look RDS param group and apply any changes to your live instance.

Please plan to demo your connection and use of the client.

# Database

1. Create the schema and load the data found in script `schema_and_data.sql`.
1. Take a moment to understand the purpose of this portion of the project (see [MySQL README](./mysql/README.md)).
1. Pick three of the queries from the `query_N.sql` set of scripts and do whatever it takes to improve or optimize them to perform well.

The schema, data and query scripts for this project reside in the `mysql` directory.  The schema and data is sourced from:

https://www.mysqltutorial.org/mysql-sample-database.aspx

The ERD and other documentation is also available at this site.

## DB Notes

The given sample database is tiny, so there will be no real performance issues using it.  Therefore, assume when reading an EXPLAIN plan that instead of hundreds of rows, you will encounter 10's or 100's of millions of rows.

File `terraform/variables.tf` has the apply_method for `performance_schema` set to "pending-reboot". What other parameters might need this same apply_method?

# Bonus points!

- Add what you feel could be missing from this project. Show us how you think about running RDS/MySQL and what you are passionate about.
- If you feel that one or more of these queries should not actually be used on an OLTP system, what would you recommend and why?
- Develop a scenario similar to one of your favorite war stories and show us how you fixed it.

# Feedback

We love feedback. PR or create issues on this repository with feedback on what we could do better!

# README

Ruby version: 2.7.5

Rails version: 5.2

Database: PostgreSQL

Schema:

    Run db:migrate to create the schema file

Database:
  
    Run db:create to create the development/test databases.
    Run db:seed to seed the databases with initial data.


## Usage: 
  > bin/rails server


Uploading to Cloudinary
    
    Set up these credentials for Cloudinary:
    - cloud_name
    - api_key
    - api_secret

To set up credentials, run:
  > EDITOR=editor rails credentials:edit

  > (Replace editor with your editor, like nano or vim)
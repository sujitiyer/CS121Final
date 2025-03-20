Data Source: Our data is AI generated. We cleared this with Professor Hovik.
Instructions for loading data: First, enter the project directory with all of the files. Then, enter a MySQL environment under your root user (important so you can grant permissions to users). Run this series of commands: source setup.sql; source load-data.sql; source setup-passwords.sql; source setup-routines.sql; source grant-permissions.sql;. Any warnings you see are only due to "DROP ... IF ..." commands which are unavoidable.
Instructions for program: Decide whether or not you are a potential adopter or employee. Run app-client.py or app-admin.py accordingly. For both of these roles, you will be greeted with a screen telling you to log in, create an account, or change your password. Once logged in, you will be met with an options screen. Adopters can input certain numbers to select animals, check shelter distances, submit adoption requests, etc. Admin can add animals/shelters to the system, approve adoptions, perform medical checks, and analyze shelter trends. Any functions/procedures/queries with parameters will be abstracted to you through command line arguments using python input() functionality. There is stress-testing and edge case assurance installed in the input parsing, but please try to stay within the bounds of the data types if you can to avoid program failure. 
Advice: One of the best ways to test the program would probably be to first start with the client app and list all the available animals for adoption. Then, submit an adoption request. Then, go over to the admin app and view the latest adoption requests (option provided). Approve the adoption request by inputting the animal and adopter id's. Then, go back to the client app and login and check your adoption history. You should be able to see a newly adopted animal.
Last Note: We believe that we went above and beyond with the amount of procedural SQL we implemented. We hope to achieve bonus points in this category.
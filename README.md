# DATABASE-FUNDAMENTALS-SEG1201

## Company Description
Honda Motor Company, Ltd is a well known company that can be seen all around the world, it was founded in 1946 in Tokyo, Japan by Soichiro Honda Takeo Fujisawa. Honda is a company that mainly operates in the manufacture of automobiles, automobiles parts, and more. Honda has over millions of sales per year hence a strong database is needed when it comes to storing sales data. When a car is produced, it is recorded under a table called vehicle_for_sale and the details of the vehicle like vehicle identification number (VIN), the code for that particular model, the model name, engine information, manufactured year and colour will be recorded. Once the vehicle is successfully sold, a purchase id is generated and the VIN of the car sold, the customer who bought it, the salesperson in charge, the date, the price and the warranty years will all be recorded. As of now, there are three main types of people being recorded in the database, customer, salesperson and mechanic. Each of them have their own respective tables that contain their respective IDs and store all of their personal information like first and last name, city and contact number. Salesperson and mechanic tables also store additional information like monthly salary, join/resign date and the branch name of the employees. When maintenance is carried out, a maintenance ticket with its own unique ID is created. Details of the maintenance like the vehicle maintained, the mechanic in charge, the date, the cost and the type of maintenance performed are also recorded.

## Problem Statement
The people in charge of entering data into the database every time a car is produced have reported that the process is unnecessarily repetitive, if a vehicle of the same model were to be produced 10 times, certain data like model_code, engine_series, engine_horsepower, engine_RPM, manufactured_year that remain the exact same have to also be entered again 10 times. It has also been reported that the company’s database has been damaged by the recent earthquakes, wiping out most of the data from the 3 tables: customer, salesperson and mechanic. Data restoration has been attempted using subsequent backups but data inconsistencies still occur. This is due to the backups of the 3 tables not matching up with one another. Lastly, the finance department has reported that it is very inconvenient to calculate the total salaries of the employees in Honda due to the fact that commission rates have to be manually calculated by hand since no such data exists in the database.

## Business Requirements
The first order of business would be to solve the repetitive process that follows after a car is manufactured. All data regarding the vehicle’s model (model code , model name, engine series, engine horsepower, engine RPM and manufactured year) should be stored in a separate table. This way, when a car is manufactured, only the VIN, model code and colour is required to be entered into the database since the specifications of a model are usually never changed. Since there is a chance of backups not syncing with each other, all data should instead be combined into one to prevent any need for syncing. All personal information like first name, last name, city and contact number of the customer, salesperson and mechanic will now be stored in a new table called people_info. The table will also include a new field called status to differentiate between the data of customer, salesperson and mechanic. Lastly, a commission code field should be added to the salesperson table. This way, all calculations regarding commission rates are now possible within the database.

## Business Rules
- In the vehicle_sold table, the same customer and salesperson can appear twice in the table but the purchased vehicle must be different.
- VIN , model_code, customer_ID, salesperson_ID, mechanic_ID, Maintenance_ID, info_ID and vehicle_for_sale_ID must be unique and not NULL
- All personal info from customer, salesperson and mechanic must be stored in info table
- only engine, aircond, oil and tyres can be maintained 
- aircond cost 20000 yen per maintenance
- Engine cost 12000 yen per maintenance
- Oil cost 8000 yen per maintenance
- Mechanics cannot have a base salary that is higher than 64000 Yen and cannot be lower than 55000 Yen
- Salesperson cannot have a base salary that is higher than 84000 Yen and cannot be lower than 55000 Yen
- Salesperson are not allowed to be a customer
- If the same customer buys a vehicle again, the database will use the existing customer id
- The same salesperson id will be used for the same salesperson even if they sell more than 1 vehicle
- Employees can only be part of either the HQ, Wako, Shirako or Yaesu branch

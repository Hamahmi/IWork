USE master

GO

drop database I_Work

GO

Create database I_Work

GO 

USE  I_Work

GO

CREATE TABLE Companies (
    email          VARCHAR (50) ,
    name           VARCHAR (20) NOT NULL,
    address        VARCHAR (50) ,
    domain         VARCHAR (20) NOT NULL,
    type           VARCHAR (20) CHECK (type = 'national' OR type = 'international'),
    vision         VARCHAR (50) ,
    specialization VARCHAR (50) ,
    PRIMARY KEY (email)
);

GO

CREATE TABLE Company_Phones (
    phone         INT          ,
	company_email VARCHAR (50) ,
    PRIMARY KEY (phone, company_email),
    FOREIGN KEY (company_email) REFERENCES Companies ON DELETE CASCADE ON UPDATE CASCADE
);

GO

CREATE TABLE Departments (
    code          INT          ,
    company_email VARCHAR (50) ,
    name          VARCHAR (20) NOT NULL,
    PRIMARY KEY (code, company_email),
    FOREIGN KEY (company_email) REFERENCES Companies ON DELETE CASCADE ON UPDATE CASCADE
);

GO

CREATE TABLE Jobs (
    title                VARCHAR (50)   ,
    department_code      INT            ,
    company_email        VARCHAR (50)   ,
    short_description    VARCHAR (500)  ,
    detailed_description VARCHAR (5000) ,
    min_experience       INT            ,
    salary               REAL           ,
    deadline             DATETIME       ,
    no_of_vacancies      INT            ,
    working_hours        REAL          
	PRIMARY KEY (title, department_code, company_email),
    FOREIGN KEY (department_code, company_email) REFERENCES Departments ON DELETE CASCADE ON UPDATE CASCADE
);

GO

CREATE TABLE Questions (
    number   INT  IDENTITY ,
    question VARCHAR (500) ,
    answer   BIT           NOT NULL,
    PRIMARY KEY (number)
);

GO

CREATE TABLE Job_has_Question (
    job_title       VARCHAR (50) ,
    department_code INT          ,
    company_email   VARCHAR (50) ,
    question_number INT          ,
    PRIMARY KEY (job_title, department_code, company_email, question_number),
    FOREIGN KEY (job_title, department_code, company_email) REFERENCES Jobs ON DELETE CASCADE ON UPDATE CASCADE ,
    FOREIGN KEY (question_number) REFERENCES Questions ON DELETE CASCADE ON UPDATE CASCADE 
);

GO

CREATE TABLE Users (
    username            VARCHAR (30) ,
    password            VARCHAR (30) DEFAULT 'abc123',
    personal_email      VARCHAR (50) ,
    birth_date          DATETIME     NOT NULL,
    years_of_experience INT          ,
    first_name          VARCHAR (20) NOT NULL,
    middle_name         VARCHAR (20) ,
    last_name           VARCHAR (20) NOT NULL,
    age                 AS            (year(current_timestamp)-year(birth_date)),
    PRIMARY KEY (username)
);

GO

CREATE TABLE User_Jobs (
	job		 varchar (100) ,
	username varchar (30)  ,
	PRIMARY KEY (job, username) ,
	FOREIGN KEY (username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

GO

CREATE TABLE Job_Seekers (
	username varchar (30)  ,
	PRIMARY KEY (username) ,
	FOREIGN KEY (username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE
);

GO

CREATE TABLE Staff_Members (
    username        VARCHAR (30) ,
    annual_leaves   INT         DEFAULT 30,
    company_email   AS (username + (substring(company,charindex('@',company),len(company)-charindex('@',company)+1))),
    day_off         VARCHAR (10) CHECK(day_off = 'Saturday' OR day_off = 'Sunday' OR day_off = 'Monday' OR day_off = 'Tuesday' OR day_off = 'Wednesday' OR day_off = 'Thursday' ),
    salary          REAL         ,
    job_title       VARCHAR (50) ,
    department_code INT          ,
    company         VARCHAR (50) ,
    PRIMARY KEY (username),
    FOREIGN KEY (username) REFERENCES Users ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (job_title, department_code, company) REFERENCES Jobs ON DELETE CASCADE ON UPDATE CASCADE
);

GO

CREATE TABLE Job_Seeker_apply_Job (
    job_title           VARCHAR (50) ,
    department_code     INT          ,
    company_email       VARCHAR (50) ,
    job_seeker_username VARCHAR (30) ,
    hr_response         VARCHAR (10) DEFAULT 'pending' CHECK(hr_response = 'pending' OR hr_response = 'accepted' OR hr_response = 'rejected'),
    manager_response    VARCHAR (10) DEFAULT 'pending' CHECK(manager_response = 'pending' OR manager_response = 'accepted' OR manager_response = 'rejected'),
    score               INT          ,
    PRIMARY KEY (job_title, department_code, company_email, job_seeker_username),
    FOREIGN KEY (job_title, department_code, company_email) REFERENCES Jobs ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (job_seeker_username) REFERENCES Job_Seekers ON DELETE CASCADE ON UPDATE CASCADE
);

GO

CREATE TABLE Attendance_Records (
    date           DATE         ,
    staff_username VARCHAR (30) ,
    start_time     TIME         NOT NULL,
    end_time       TIME         ,
    PRIMARY KEY (date, staff_username),
    FOREIGN KEY (staff_username) REFERENCES Staff_Members ON DELETE CASCADE ON UPDATE CASCADE
);

GO

CREATE TABLE Emails (
    serial_number INT   IDENTITY ,
    subject       VARCHAR (100)  ,
    date          DATETIME       NOT NULL,
    body          VARCHAR (5000) ,
    PRIMARY KEY (serial_number)
);

GO

CREATE TABLE Staff_Send_Email_Staff (
    email_number       INT          ,
    recipient_username VARCHAR (30) ,
    sender_username    VARCHAR (30) DEFAULT 'Unknown',
    PRIMARY KEY (email_number, recipient_username),
    FOREIGN KEY (email_number) REFERENCES Emails ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (recipient_username) REFERENCES Staff_Members,
    FOREIGN KEY (sender_username) REFERENCES Staff_Members ON DELETE SET DEFAULT
);

GO

CREATE TABLE HR_Employees (
	username varchar (30)  ,
	PRIMARY KEY (username) ,
	FOREIGN KEY (username) REFERENCES Staff_Members ON DELETE CASCADE ON UPDATE CASCADE
);

GO

CREATE TABLE Regular_Employees (
	username varchar (30) ,
	PRIMARY KEY (username) ,
	FOREIGN KEY (username) REFERENCES Staff_Members ON DELETE CASCADE ON UPDATE CASCADE
);

GO

CREATE TABLE Managers (
	username varchar (30) ,
	type	 varchar (20) NOT NULL,
	PRIMARY KEY (username) ,
	FOREIGN KEY (username) REFERENCES Staff_Members ON DELETE CASCADE ON UPDATE CASCADE
);

GO

CREATE TABLE Announcements (
    date                 DATETIME       ,
    title                VARCHAR (100)  ,
    hr_employee_username VARCHAR (30)   ,
    type                 VARCHAR (30)   NOT NULL,
    description          VARCHAR (5000) ,
    PRIMARY KEY (date, title, hr_employee_username),
    FOREIGN KEY (hr_employee_username) REFERENCES HR_Employees ON DELETE CASCADE ON UPDATE CASCADE
);


GO

CREATE TABLE Requests (
    start_date           DATETIME       ,
    applicant_username   VARCHAR (30)   ,
    end_date             DATETIME       NOT NULL,
    request_date         DATETIME       ,
    total_days           AS             (datediff(day,start_date,end_date)),
    hr_response          VARCHAR (10)   DEFAULT 'pending' CHECK(hr_response = 'pending' OR hr_response = 'accepted' OR hr_response = 'rejected'),
    manager_response     VARCHAR (10)   DEFAULT 'pending' CHECK(manager_response = 'pending' OR manager_response = 'accepted' OR manager_response = 'rejected'),
    manager_reason       VARCHAR (3000) ,
	hr_employee_username VARCHAR (30)   ,
	manager_username     VARCHAR (30)   ,
    PRIMARY KEY (start_date, applicant_username),
    FOREIGN KEY (applicant_username) REFERENCES Staff_Members ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (hr_employee_username) REFERENCES HR_Employees ,
    FOREIGN KEY (manager_username) REFERENCES Managers
);


GO

CREATE TABLE Leave_Requests (
    start_date         DATETIME     ,
    applicant_username VARCHAR (30) ,
    type               VARCHAR (20) NOT NULL CHECK(type = 'sick' OR type = 'accidental' OR type = 'annual'),
    PRIMARY KEY (start_date, applicant_username),
    FOREIGN KEY (start_date, applicant_username) REFERENCES Requests ON DELETE CASCADE ON UPDATE CASCADE
);


GO

CREATE TABLE Business_Trip_Requests (
    start_date         DATETIME      ,
    applicant_username VARCHAR (30)  ,
	destination		   VARCHAR (100) NOT NULL, 
	purpose			   VARCHAR (3000) NOT NULL,
    PRIMARY KEY (start_date, applicant_username),
    FOREIGN KEY (start_date, applicant_username) REFERENCES Requests ON DELETE CASCADE ON UPDATE CASCADE
);


GO

CREATE TABLE HR_Employee_apply_replace_Request (
    start_date           DATETIME     ,
    applicant_username   VARCHAR (30) ,
    hr_employee_username VARCHAR (30) ,
    replacement_username VARCHAR (30)  DEFAULT 'Unknown',
    PRIMARY KEY (start_date, applicant_username),
    FOREIGN KEY (start_date, applicant_username) REFERENCES Requests ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (hr_employee_username) REFERENCES HR_Employees,
    FOREIGN KEY (replacement_username) REFERENCES HR_Employees 
);


GO

CREATE TABLE Regular_Employee_apply_replace_Request (
    start_date            DATETIME     ,
    applicant_username    VARCHAR (30) ,
    reg_employee_username VARCHAR (30) ,
    replacement_username  VARCHAR (30) DEFAULT 'Unknown',
    PRIMARY KEY (start_date, applicant_username),
    FOREIGN KEY (start_date, applicant_username) REFERENCES Requests ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (reg_employee_username) REFERENCES Regular_Employees,
    FOREIGN KEY (replacement_username) REFERENCES Regular_Employees 
);

GO

CREATE TABLE Manager_apply_replace_Request (
    start_date            DATETIME     ,
    applicant_username    VARCHAR (30) ,
    manager_username	  VARCHAR (30) ,
    replacement_username  VARCHAR (30) DEFAULT 'Unknown',
    PRIMARY KEY (start_date, applicant_username),
    FOREIGN KEY (start_date, applicant_username) REFERENCES Requests ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (manager_username) REFERENCES Managers ,
    FOREIGN KEY (replacement_username) REFERENCES Managers 
);


GO

CREATE TABLE Projects (
    name             VARCHAR (50) ,
    company_email    VARCHAR (50) ,
    start_date       DATETIME     ,
    end_date         DATETIME     ,
    manager_username VARCHAR (30) DEFAULT 'Unknown',
    PRIMARY KEY (name, company_email),
    FOREIGN KEY (company_email) REFERENCES Companies ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (manager_username) REFERENCES Managers 
);


GO

CREATE TABLE Manager_assign_Regular_Employee_Project (
    project_name              VARCHAR (50) ,
    company_email             VARCHAR (50) ,
    regular_employee_username VARCHAR (30) ,
    manager_username          VARCHAR (30) DEFAULT 'Unknown',
    PRIMARY KEY (project_name, company_email, regular_employee_username),
    FOREIGN KEY (project_name, company_email) REFERENCES Projects ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (regular_employee_username) REFERENCES Regular_Employees,
    FOREIGN KEY (manager_username) REFERENCES Managers 
);


GO

CREATE TABLE Tasks (
    name                      VARCHAR (50)   ,
    project_name              VARCHAR (50)   ,
    company_email             VARCHAR (50)   ,
    deadline                  DATETIME       NOT NULL,
    status                    VARCHAR (10)  DEFAULT 'Open' CHECK(status = 'Open' OR status = 'Assigned' OR status = 'Fixed' OR status = 'Closed'),
    description               VARCHAR (3000) ,
    regular_employee_username VARCHAR (30)   ,
    manager_username          VARCHAR (30)  DEFAULT 'Unknown',
    PRIMARY KEY (name, project_name, company_email),
    FOREIGN KEY (project_name, company_email) REFERENCES Projects ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (regular_employee_username) REFERENCES Regular_Employees,
    FOREIGN KEY (manager_username) REFERENCES Managers 
);


GO

CREATE TABLE Task_Comments (
    comment       VARCHAR (700) ,
    task_name     VARCHAR (50)   ,
    project_name  VARCHAR (50)   ,
    company_email VARCHAR (50)   ,
    PRIMARY KEY (comment, task_name, project_name, company_email),
    FOREIGN KEY (task_name, project_name, company_email) REFERENCES Tasks ON DELETE CASCADE ON UPDATE CASCADE
);

GO
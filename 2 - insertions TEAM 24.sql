use I_Work
go
create or alter procedure New_Company
@email          VARCHAR (50) ,
@name           VARCHAR (20) ,
@address        VARCHAR (50) ,
@domain         VARCHAR (20) ,
@type           VARCHAR (20) ,
@vision         VARCHAR (50) ,
@specialization VARCHAR (50)
as
insert into Companies(email,name,address,domain,type,vision,specialization) 
values (@email,@name,@address,@domain,@type,@vision,@specialization) 

go

create or alter procedure New_Department
@code          INT          ,
@company_email VARCHAR (50) ,
@name          VARCHAR (20) 
as
insert into Departments(code,company_email,name)
values(@code,@company_email,@name)

go

create proc A_Job
@title                VARCHAR (50)   ,
@department_code      INT            ,
@company_email        VARCHAR (50)   ,
@short_description    VARCHAR (500)  ,
@detailed_description VARCHAR (5000) ,
@min_experience       INT            ,
@salary               REAL           ,
@deadline             DATETIME       ,
@no_of_vacancies      INT            ,
@working_hours        REAL          
as 
insert into Jobs (title,department_code,company_email,short_description,detailed_description,min_experience,salary,deadline,no_of_vacancies ,working_hours  )
values (@title,@department_code,@company_email,@short_description, @detailed_description, @min_experience, @salary, @deadline, @no_of_vacancies , @working_hours ) 


go 

create proc New_User
@username            VARCHAR (30) ,
@password            VARCHAR (30) ,
@personal_email      VARCHAR (50) ,
@birth_date          DATETIME     ,
@years_of_experience INT          ,
@first_name          VARCHAR (20) ,
@middle_name         VARCHAR (20) ,
@last_name           VARCHAR (20) 
as
insert into Users (username, password, personal_email, birth_date, years_of_experience,first_name,middle_name,last_name)
values (@username, @password, @personal_email, @birth_date, @years_of_experience,@first_name,@middle_name,@last_name)
insert into Job_Seekers (username) values (@username) 



go 
create or alter procedure New_Staff
@username            VARCHAR (30) ,
@annual_leaves   INT          ,
@day_off         VARCHAR (10) ,
@salary          REAL         ,
@job_title       VARCHAR (50) ,
@department_code INT          ,
@company         VARCHAR (50) 
as 
insert into Staff_Members(username, annual_leaves,day_off,salary,job_title, department_code,company)
values(@username, @annual_leaves,@day_off,@salary,@job_title, @department_code,@company)

--job insertion is between other procedures 


go

create or alter procedure New_HR
@username VARCHAR(30)
as insert into HR_Employees values(@username)

go

create or alter procedure New_Manager
@username VARCHAR(30),
@type varchar(20)
as
insert into Managers values(@username,@type)


go

--Companies
exec New_Company 'info@Facebook.com', 'FaceBook', 'Menlo Park, California, U.S.', 'Facebook.com', 'international', 'Artificial intelligence, increased connectivity around the world and virtual and augmented reality', 'Social networking service'
exec New_company 'info@mentorgraphics.com','Mentor Graphics','Wilsonville, Oregon, United States','mentor.com','international','To make the world better place using tech', 'Embedded Software'
exec New_Company 'info@guc.edu.eg', 'German University in Cairo (GUC)', 'Cairo, Egypt' , 'guc.edu.eg', 'national', 'A7san Gam3a fe Masr, building a leading center of excellence in teaching and research that will effectively contribute to the general welfare nationally and internationally and endeavour the scientific, technical, economic and cultural cooperation between Egypt and Germany', 'Educational institute'


go
--Departments
--New_Department @code,@company_email,@name

--FB

exec New_Department 11 , 'info@Facebook.com' , 'Research'
exec New_Department 12 , 'info@Facebook.com' , 'Advertising Technology'
exec New_Department 13 , 'info@Facebook.com' , 'WhatsApp'

--MG
exec New_Department 21 , 'info@mentorgraphics.com' , 'Administration'
exec New_Department 22 , 'info@mentorgraphics.com' , 'Sales'
exec New_Department 23 , 'info@mentorgraphics.com' , 'Marketing'

--GUC
exec New_Department 31 , 'info@guc.edu.eg' , 'Administration'
exec New_Department 32 , 'info@guc.edu.eg' , 'Student Affairs'
exec New_Department 33 , 'info@guc.edu.eg' , 'Advertising'





--Jobs
-- a_job @title,@department_code,@company_email,@short_description, @detailed_description, @min_experience, @salary, @deadline, @no_of_vacancies , @working_hours 
--managers
exec a_job 'Manager - Secior Statistician Manager', 11 , 'info@Facebook.com','The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on', 5  ,10000 , '2020-12-12' , 10 , 8
exec a_job 'Manager - Modeling Manager', 11 , 'info@Facebook.com' ,'The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on', 5  ,10000 , '2020-12-12' , 10 , 8

exec a_job 'Manager - Marketing Associate Manager', 12 ,'info@Facebook.com', 'The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on',5  ,10000 , '2020-12-12' , 10 , 8
exec a_job 'Manager - Advertising Manager', 12 , 'info@Facebook.com', 'The manager creates tasks to projects and assigns employees to it' ,'The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on', 5  ,10000 , '2020-12-12' , 10 , 8

exec a_job 'Manager - Analyst Manager', 13 , 'info@Facebook.com','The manager creates tasks to projects and assigns employees to it' , 'The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on' , 5  ,10000 , '2020-12-12' , 10 , 8
exec a_job 'Manager - Task Manager', 13 , 'info@Facebook.com','The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on' , 5  ,10000 , '2020-12-12' , 10 , 8

exec a_job 'Manager - Accounting Manager',21 , 'info@mentorgraphics.com' ,'The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on', 5  ,20000 , '2020-12-12' , 10 , 8
exec a_job 'Manager - Academic Advisor Manager',21 , 'info@mentorgraphics.com' ,'The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on', 5  ,20000 , '2020-12-12' , 10 , 8

exec a_job 'Manager - Retail Sales Consultant Manager',22 , 'info@mentorgraphics.com' ,'The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on' , 5  ,20000 , '2020-12-12' , 10 , 8
exec a_job 'Manager - Sales Representative Manager',22 , 'info@mentorgraphics.com' ,'The manager creates tasks to projects and assigns employees to it' ,'The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on' , 5  ,20000 , '2020-12-12' , 10 , 8

exec a_job 'Manager - Art Director Manager',23 , 'info@mentorgraphics.com' ,'The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on', 5  ,20000 , '2020-12-12' , 10 , 8
exec a_job 'Manager - Assistant Marketing Director Manager',23 , 'info@mentorgraphics.com' ,'The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on', 5  ,20000 , '2020-12-12' , 10 , 8

exec a_job 'Manager - Accounting Manager',31 , 'info@guc.edu.eg','The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on' , 5  ,30000 , '2020-12-12' , 10 , 8
exec a_job 'Manager - Academic Advisor Manager',31 , 'info@guc.edu.eg','The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on' , 5  ,30000 , '2020-12-12' , 10 , 8

exec a_job 'Manager - Associate Vice President Manager',32 , 'info@guc.edu.eg','The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on' , 5  ,30000 , '2020-12-12' , 10 , 8
exec a_job 'Manager - Coordinator Manager',32 , 'info@guc.edu.eg','The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on', 5  ,30000 , '2020-12-12' , 10 , 8

exec a_job 'Manager - Advertising Copywriter Manager',33 ,'info@guc.edu.eg','The manager creates tasks to projects and assigns employees to it', 'The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on', 5  ,30000 , '2020-12-12' , 10 , 8
exec a_job 'Manager - Graphic Designers Manager',33 , 'info@guc.edu.eg','The manager creates tasks to projects and assigns employees to it','The manager can view requests applied by staff members in his department and either accepts or rejects it.He can also assign employees to projects and create tasks and the same manager then assigns every task to one employee to work on', 5  ,30000 , '2020-12-12' , 10 , 8


--HR
exec a_job 'HR - Human Resources Director', 11 , 'info@Facebook.com' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.', 5  ,10000 , '2020-12-12' , 10 , 8
exec a_job 'HR - Human Resources Generalist', 11 , 'info@Facebook.com' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.', 5  ,10000 , '2020-12-12' , 10 , 8

exec a_job 'HR - Human Resources Director', 12 , 'info@Facebook.com' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.', 5  ,10000 , '2020-12-12' , 10 , 8
exec a_job 'HR - Human Resources Generalist', 12 , 'info@Facebook.com' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.', 5  ,10000 , '2020-12-12' , 10 , 8

exec a_job 'HR - Human Resources Director' , 13 , 'info@Facebook.com' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.' , 5  ,10000 , '2020-12-12' , 10 , 8
exec a_job 'HR - Human Resources Generalist' , 13 , 'info@Facebook.com' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.', 5  ,10000 , '2020-12-12' , 10 , 8

exec a_job 'HR - Human Resources Director' , 21 , 'info@mentorgraphics.com' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.' , 5  ,20000 , '2020-12-12' , 10 , 8
exec a_job 'HR - Human Resources Generalist' , 21 , 'info@mentorgraphics.com' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.', 5  ,20000 , '2020-12-12' , 10 , 8

exec a_job 'HR - Human Resources Director' , 22 , 'info@mentorgraphics.com' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.' , 5  ,20000 , '2020-12-12' , 10 , 8
exec a_job 'HR - Human Resources Generalist' , 22 , 'info@mentorgraphics.com' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.', 5  ,20000 , '2020-12-12' , 10 , 8

exec a_job 'HR - Human Resources Director' , 23 , 'info@mentorgraphics.com' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.' , 5  ,20000 , '2020-12-12' , 10 , 8
exec a_job 'HR - Human Resources Generalist' , 23 , 'info@mentorgraphics.com' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.', 5  ,20000 , '2020-12-12' , 10 , 8

exec a_job 'HR - Human Resources Director' , 31 , 'info@guc.edu.eg' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.' , 5  ,30000 , '2020-12-12' , 10 , 8
exec a_job 'HR - Human Resources Generalist' , 31 , 'info@guc.edu.eg' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.', 5  ,30000 , '2020-12-12' , 10 , 8

exec a_job 'HR - Human Resources Director' , 32 , 'info@guc.edu.eg' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.' , 5  ,30000 , '2020-12-12' , 10 , 8
exec a_job 'HR - Human Resources Generalist' , 32 , 'info@guc.edu.eg' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.', 5  ,30000 , '2020-12-12' , 10 , 8

exec a_job 'HR - Human Resources Director' , 33 , 'info@guc.edu.eg' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.' , 5  ,30000 , '2020-12-12' , 10 , 8
exec a_job 'HR - Human Resources Generalist' , 33 , 'info@guc.edu.eg' ,'Each HR employee is mainly resposable for creating jobs and assigning employees to it','they areresponsible for creating new jobs according to their department needs. When the HR person adds a new job, this job is associated with his/her department only, he/she adds some interview questions  that the applicant will have to answer.', 5  ,30000 , '2020-12-12' , 10 , 8


--Users 
--New_User (username, password, personal_email, birth_date, years_of_experience,first_name,middle_name,last_name)
GO
--manager_Users
exec New_User 'mohamed_khaled','1qw23er4','mohamed_khaled970@yahoo.com','2/4/1970',19,'mohamed','ahmed','khaled'

exec New_User 'sara_fahmy','weakpasscantpass','sarafahmycool@gmail.com','2/5/1971',30,'sara','fahmy','waleed'

exec New_User 'ahmed_mohamed','newfoldername','ahmed_M_Basem@yahoo.ca','1/1/1974',20,'Ahmed','Mohamed','Basem'

exec New_User 'mark_maeeza','hehehehenice1','mark_maeeza@yahoo.com','12/13/1990',19,'mark',null,'maeeza'

exec New_User 'abdelrahman_saeed','creativepa55word101','amahdys@yahoo.com','9/10/1980',20,'abdelrahman','mahdy','saeed'

exec New_User 'kevin_aaf','whenmarimborythem','kevin_aaf@gmail.com','4/3/1990',15,'kevin','mus','aaf'

exec New_User 'ahmed_sameer','defaultpass','ahmed_sameer@yahoo.com','1/1/1970',20 , 'ahmed','ahmed','sameer'

exec New_User 'gouda_samy','189273','gouda_samx85@gmail.com','4/17/1985',20,'gouda','abdelkhalek','samy'

exec New_User 'hamed','quiqmathhard','waleed_hamed@hotmail.com','1/2/1985',25,'waleed','mohamed','hamed'

exec New_User 'nadeen_abdo','nadooshty','nadeenchty@yahoo.com','6/1/1965',31,'nadeen','abdo','saliim'

exec New_User 'zuck','facebookisnotfun','zuck_sebso@hotmail.com','5/1/1983',23,'zuck',null,'sebestian'

exec New_User 'eve_samir','suchastrongpasswoo0o0rd','eve_samir@yahoo.com','1/19/1975',21,'eve','hady','samir'

exec New_User 'sameer','HeyThereBeThere','sameer_sameer@gmail.com','11/11/1970',20,'sameer','ahmed','sameer'

exec New_User 'annalenag','ihatedb','annagruz@gmail.de','8/7/1970',20,'annalena',null,'grutzener'

exec New_User 'finn','EsMachKeineSinnne','finn_frid@yahoo.de','5/4/1985',20,'finn','sam','fredrich'

exec New_USer 'marwa','WiesoSollIchDasMachen','mmrie@yahoo.com','6/1/1980',20,'marwa','mohamed','morie'

exec New_User 'franziska','scheisse1010101','franziskahoff@yahoo.de','1/1/1950',35,'franziska',null,'hoffmann'

exec New_User 'will','whythehellshould102','elias_will@gmail.com','1/14/1960',30,'elias','kevin','will'

--HR_Users

exec New_User 'simon','SoManyOfThemWhy?','simon@yahoo.de','1/4/1970',30,'simon',null,'simon'

exec New_User 'chris','goddammit1s','faz@gmail.com','1/1/1970',31,'chris','faz','weizen'

exec New_User 'armstrong','HaveNotBeenToTheMoon','armstrongnot@yahoo.com','1/1/1985',20,'armstrong','mark','hanna'

exec New_User 'mohamed_mahdy','notTheCOorDSD','mohamed_mahdy@hotmail.com','6/1/1980',23,'mohamed','ahmed','mahdy'

exec New_User 'john_cena','YouCannotSeeMyPass','john_cena@yahoo.com','7/1/1970',24,'john',null,'cena'

exec New_User 'arnolds','whatthehellman','arnoldssssz@yahoo.com','1/9/1981',34,'arnolds','herb','frans'

exec New_User 'lobna','011545nope','lobna_zoz@gmail.com','2/1/1975',22,'lobna','abdel','aziz'

exec New_User 'karim','sofmany101','karimkimo@gmail.com','1/2/1973',21,'karim','ahmed','mohamed'

exec New_User 'omran','deadlineextendedhaha','ahmedomran@gmail.com','1/7/1990',20,'ahmed','mohamed','omran'

exec New_User 'dalya','dalya42fancy','fawzy@hotmail.com','6/6/1960',37,'dalya','fawzy','samiro'

exec New_User 'rebecca','MettingenIsl0v3','rebecca_bosse@yahoo.de','7/11/1995',20,'rebecca','ham','bosse'

exec New_User 'johanna','canaboyandagirlbejustfriends','johanna_wehrmeyer@yahoo.com','8/18/1990',21,'johanna',null,'wehrmeyer'

exec New_User 'ayoub','yasabrayoubhahahelpmeha','saber_ayoub@hotmail.com','12/12/1987',23,'saber','ahmed','ayoub'

exec New_User 'heizenberg','wannaSomeMeth?','wwheiz@gmail.com','7/7/1980',22,'walter',null,'white'

exec New_User 'jessy','ITrulyLovedHerMrWhite','jessy@yahoo.com','2/1/1990',20,'jessy',null,'benkman'

exec New_User 'janis','OHMYGOOD','janis@gmail.com','6/5/1980',20,'janis',null,'mark'

exec New_User 'tarek77','almosttherebuttired','tarek77@yahoo.ca','7/7/1977',30,'arsany','samer','tarek'

exec New_User 'phantom','elshaba7ya5wanna','danyelshaba7@yahoo.com','2/11/1964',31,'danny',null,'phantom'



--Staff_Members_Users
--New_Staff @username, @annual_leaves,@day_off,@salary,@job_title, @department_code,@company

GO
--11 managers

exec New_Staff 'mohamed_khaled',30,'Saturday',10000,'Manager - Secior Statistician Manager', 11 ,'info@Facebook.com'

exec New_Staff 'sara_fahmy'	,30,'Sunday', 10000, 'Manager - Modeling Manager' , 11 , 'info@Facebook.com'

--12 managers
exec New_Staff 'ahmed_mohamed',30 ,'Sunday' ,  10000, 'Manager - Marketing Associate Manager', 12 , 'info@Facebook.com' 

exec New_Staff 'mark_maeeza' ,30 , 'Sunday' ,10000, 'Manager - Advertising Manager' , 12 , 'info@Facebook.com'

--13 managers
exec New_Staff 'abdelrahman_saeed',30,'Sunday',10000, 'Manager - Analyst Manager', 13 , 'info@Facebook.com'

exec New_Staff 'kevin_aaf' ,30, 'Monday',10000, 'Manager - Task Manager', 13 , 'info@Facebook.com'


--21 managers
exec New_Staff 'ahmed_sameer',30 ,'Sunday',20000, 'Manager - Accounting Manager' , 21 ,'info@mentorgraphics.com'

exec New_Staff 'gouda_samy',30,'Sunday',20000 , 'Manager - Academic Advisor Manager' , 21 , 'info@mentorgraphics.com'

--22 managers
exec New_Staff 'hamed',30,'Saturday',20000, 'Manager - Retail Sales Consultant Manager' , 22 , 'info@mentorgraphics.com'

exec New_Staff 'nadeen_abdo',30 ,'Sunday',20000, 'Manager - Sales Representative Manager' , 22 , 'info@mentorgraphics.com'

--23 managers
exec New_Staff 'zuck',30,'Sunday',20000, 'Manager - Art Director Manager' , 23 , 'info@mentorgraphics.com'

exec New_Staff 'eve_samir',30, 'Saturday', 20000, 'Manager - Assistant Marketing Director Manager' , 23 , 'info@mentorgraphics.com'


--31 managers
exec New_Staff 'sameer',30 , 'Saturday' , 30000, 'Manager - Accounting Manager' , 31 , 'info@guc.edu.eg'

exec New_Staff 'annalenag', 30 , 'Saturday' , 30000 , 'Manager - Academic Advisor Manager' , 31 , 'info@guc.edu.eg'

--32 managers
exec New_Staff 'finn',30 , 'Sunday' , 30000, 'Manager - Associate Vice President Manager' , 32 , 'info@guc.edu.eg'

exec New_Staff 'marwa',30 , 'Saturday' , 30000 , 'Manager - Coordinator Manager' , 32 , 'info@guc.edu.eg'

--33 managers
exec New_Staff 'franziska', 30 , 'Saturday' , 30000, 'Manager - Advertising Copywriter Manager' , 33 , 'info@guc.edu.eg'

exec New_Staff 'will', 30 , 'Saturday' , 30000, 'Manager - Graphic Designers Manager' , 33 , 'info@guc.edu.eg'



--11 HR
exec New_Staff 'simon',30 , 'Saturday' , 10000, 'HR - Human Resources Director' , 11 , 'info@Facebook.com'

exec New_Staff 'chris',30, 'Sunday' , 10000, 'HR - Human Resources Generalist' , 11 , 'info@Facebook.com'

--12 HR
exec New_Staff 'armstrong',30, 'Saturday' , 10000, 'HR - Human Resources Director' , 12 ,'info@Facebook.com'

exec New_Staff 'mohamed_mahdy',30 , 'Saturday' , 10000, 'HR - Human Resources Generalist', 12 , 'info@Facebook.com'

--13 HR
exec New_Staff 'john_cena',30, 'Sunday' , 10000, 'HR - Human Resources Director' , 13 , 'info@Facebook.com'

exec New_Staff 'arnolds',30 , 'Saturday' , 10000, 'HR - Human Resources Generalist', 13  , 'info@Facebook.com'


--21 HR
exec New_Staff 'lobna',30 , 'Sunday' , 20000, 'HR - Human Resources Director' , 21 ,  'info@mentorgraphics.com'

exec New_Staff 'karim', 30 , 'Saturday' , 20000 , 'HR - Human Resources Generalist' , 21 , 'info@mentorgraphics.com'

--22 HR
exec New_Staff 'omran',30 , 'Saturday' , 20000, 'HR - Human Resources Director', 22, 'info@mentorgraphics.com'

exec New_Staff 'dalya',30 , 'Sunday' , 20000, 'HR - Human Resources Generalist', 22, 'info@mentorgraphics.com'

--23 HR
exec New_Staff 'rebecca',30 , 'Saturday' , 20000, 'HR - Human Resources Director', 23, 'info@mentorgraphics.com'

exec New_Staff 'johanna',30, 'Sunday' , 20000, 'HR - Human Resources Generalist', 23, 'info@mentorgraphics.com'


--31 HR
exec New_Staff 'ayoub',30, 'Sunday' , 30000, 'HR - Human Resources Director', 31, 'info@guc.edu.eg'

exec New_Staff 'heizenberg', 30 , 'Saturday' , 30000, 'HR - Human Resources Generalist', 31, 'info@guc.edu.eg'

--32 HR
exec New_Staff 'jessy', 30 , 'Saturday' , 30000, 'HR - Human Resources Director', 32, 'info@guc.edu.eg'

exec New_Staff 'janis', 30 , 'Monday' , 30000, 'HR - Human Resources Generalist', 32, 'info@guc.edu.eg'

--33 HR
exec New_Staff 'tarek77' , 30 , 'Sunday' , 30000, 'HR - Human Resources Director', 33, 'info@guc.edu.eg' 

exec New_Staff 'phantom' , 30 , 'Saturday' , 30000, 'HR - Human Resources Generalist', 33, 'info@guc.edu.eg'



--managers
exec New_Manager 'mohamed_khaled','Technical'
exec New_Manager 'sara_fahmy','HR'
exec New_Manager 'ahmed_mohamed','Technical'
exec New_Manager 'mark_maeeza','Technical'
exec New_Manager 'abdelrahman_saeed','HR'
exec New_Manager 'kevin_aaf','Technical'
exec New_Manager 'ahmed_sameer','Technical'
exec New_Manager 'gouda_samy','Technical'
exec New_Manager 'hamed','HR'
exec New_Manager 'nadeen_abdo','Technical'
exec New_Manager 'zuck','Technical'
exec New_Manager 'eve_samir','Technical'
exec New_Manager 'sameer','Technical'
exec New_Manager 'annalenag','HR'
exec New_Manager 'finn','Technical'
exec New_Manager 'marwa','Technical'
exec New_Manager 'franziska','HR'
exec New_Manager 'will','Technical'


--insert HR Employees into Hr_Employees table
exec New_HR 'simon'
exec New_HR 'chris'
exec New_HR 'armstrong'
exec New_HR 'mohamed_mahdy'
exec New_HR 'john_cena'
exec New_HR 'arnolds'
exec New_HR 'lobna'
exec New_HR 'karim'
exec New_HR 'omran'
exec New_HR 'dalya'
exec New_HR 'rebecca'
exec New_HR 'johanna'
exec New_HR 'ayoub'
exec New_HR 'heizenberg'
exec New_HR 'jessy'
exec New_HR 'janis'
exec New_HR 'tarek77'
exec New_HR 'phantom'


--tests Olfat w m3eeza
go

create or alter procedure New_Regualr_Employee
@username VARCHAR(30)
as insert into Regular_Employees values(@username)
go
exec New_User 'Mark_Mayer','1qw23er4','mark_Mayer970@yahoo.com','2/4/1970',19,'mark',null,'mayer'
exec New_User 'Mayer_Mark','1qw23er4','mayer_mark970@yahoo.com','2/4/1970',19,'mayer',null,'mark'
exec New_User 'Azer_Mark','1qw23er4','azer_mark970@yahoo.com','2/4/1970',19,'azer',null,'mark'
exec New_User 'Mark_Mohsen','1qw23er4','mark_Mohsen970@yahoo.com','2/4/1970',19,'mark',null,'mohsen'
exec New_User 'Mohsen_Mark','1qw23er4','mohsen_Mark970@yahoo.com','2/4/1970',19,'mohsen',null,'mark'
exec New_User 'Mayer_Mohsen','1qw23er4','mayer_Mohsen970@yahoo.com','2/4/1970',19,'mayer',null,'mohsen'

exec A_Job 'Regular Employee - Senior Regular Employee' ,31, 'info@guc.edu.eg','He Does regular employee tasks and get assigned to tasks by managers and an hr employee creates jos for his type of employees','He handles a jop and performs tasks',2,1000,'12/12/2020',10,8
exec A_Job 'Regular Employee - Junior  Regular Employee',31, 'info@guc.edu.eg','He Does regular employee tasks and get assigned to tasks by managers and an hr employee creates jos for his type of employees','He handles a jop and performs tasks',2,1000,'12/12/2020',10,8
exec A_Job 'Regular Employee - Senior Regular Employee',32, 'info@guc.edu.eg','He Does regular employee tasks and get assigned to tasks by managers and an hr employee creates jos for his type of employees','He handles a jop and performs tasks',2,1000,'12/12/2020',10,8
exec A_Job 'Regular Employee - Junior  Regular Employee',11, 'info@Facebook.com','He Does regular employee tasks and get assigned to tasks by managers and an hr employee creates jos for his type of employees','He handles a jop and performs tasks',2,1000,'12/12/2020',10,8
exec A_Job 'Regular Employee - Senior Regular Employee',12, 'info@Facebook.com','He Does regular employee tasks and get assigned to tasks by managers and an hr employee creates jos for his type of employees','He handles a jop and performs tasks',2,1000,'12/12/2020',10,8
exec A_Job 'Regular Employee - Junior  Regular Employee',13, 'info@Facebook.com','He Does regular employee tasks and get assigned to tasks by managers and an hr employee creates jos for his type of employees','He handles a jop and performs tasks',2,1000,'12/12/2020',10,8


--31 Regular Employee
exec new_staff 'Mark_Mayer',30, 'Sunday' , 30000, 'Regular Employee - Senior Regular Employee', 31, 'info@guc.edu.eg'

exec new_staff 'Mayer_Mark', 30 , 'Saturday' , 30000, 'Regular Employee - Junior  Regular Employee', 31, 'info@guc.edu.eg'

--32 Regular Employee
exec new_staff 'Azer_Mark', 30 , 'Saturday' , 30000, 'Regular Employee - Senior Regular Employee', 32, 'info@guc.edu.eg'

exec new_staff 'Mark_Mohsen', 30 , 'Monday' , 30000, 'Regular Employee - Junior  Regular Employee', 11, 'info@Facebook.com'
--33 Regular Employee
exec new_staff 'Mohsen_Mark' , 30 , 'Sunday' , 30000, 'Regular Employee - Senior Regular Employee', 12, 'info@Facebook.com' 

exec new_staff 'Mayer_Mohsen' , 30 , 'Saturday' , 30000, 'Regular Employee - Junior  Regular Employee', 13, 'info@Facebook.com'

exec New_Regualr_Employee 'Mark_Mayer'
exec New_Regualr_Employee 'Mayer_Mark'
exec New_Regualr_Employee 'Azer_Mark'
exec New_Regualr_Employee 'Mark_Mohsen'
exec New_Regualr_Employee 'Mohsen_Mark'
exec New_Regualr_Employee 'Mayer_Mohsen'




--some questions

insert into Questions
values( 'Are you cool enough to work for us ?' ,1)

insert into Questions
values( 'Do you like icecream ?' ,1)

insert into Questions
values('Do you want to get paid ?' ,0)

insert into Job_has_Question 
values('Manager - Modeling Manager', 11 , 'info@Facebook.com',1)

insert into Job_has_Question 
values('Manager - Modeling Manager', 11 , 'info@Facebook.com',2)

insert into Job_has_Question 
values('Manager - Modeling Manager', 11 , 'info@Facebook.com',3)

















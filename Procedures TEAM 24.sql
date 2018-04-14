--“As an registered/unregistered user, I should be able to ...”
--1
--1 Search for any company by its name or address or its type (national/international).

use I_Work
go
create or alter procedure Search_For_Companies  
    @name varchar(20) = null,   
    @address varchar(50) = null,  
	@type varchar(20) = null
as       
    select * 
	from Companies a 
	where a.name = @name or a.address = @address or a.type = @type
--2
--2 View a list of all available companies on the system along with all information of the company.

go
create or alter procedure View_Available_Companies as
	select * 
	from Companies

go
create or alter procedure view_Company
@email varchar(50)
as
select distinct c.*
from companies c 
where c.email = @email
go
 create or alter procedure View_Company_Phones
 @email varchar(50)
 as
 select p.phone
 from Companies c inner join Company_Phones p on c.email  = p.company_email
 where c.email = @email
--3
--3 View the information of a certain company along with the departments in that company.

go
create or alter procedure View_Company_Departments
	@email varchar(50)
as
begin
select distinct d.* from 
Companies c inner join Departments d
on c.email = d.company_email
where c.email = @email
end

go
create proc Department_In_Company
@dcode int,
@email varchar(50)
as
select distinct j.*
from Departments d inner join Companies c 
on d.company_email = c.email
inner join jobs j 
on j.company_email = d.company_email and j.department_code = d.code
where d.code =  @dcode and c.email = @email and j.no_of_vacancies >0

--4
--4 View the information of a certain department in a certain company along with the jobs that have
--vacancies in it.
go
create or alter procedure Job_In_Dep
	@jname varchar(50),
	@depCode int,
	@company_email varchar(50)
as
	select j.* , c.name , d.name
	from Jobs j inner join Companies c
	on j.company_email = c.email
	inner join Departments d 
	on j.department_code = d.code
	where j.no_of_vacancies > 0 and exists(select value from string_split(@jname ,',') where j.title like '%'+value+'%' or j.short_description like '%'+value+'%')
	and j.deadline>=current_timestamp
	and j.company_email = @company_email 
	and j.department_code = @depCode
	go

--5
--5 Register to the website to be able to apply for any job later on. Any user has to register in the
--website with a unique username and a password, along with all the needed information.
go
create or alter procedure Register
	@username varchar(30),
	@password varchar(30),
	@pemail varchar(50),
	@bdate datetime,
	@yearsOfExp int,
	@fname varchar(20),
	@mname varchar(20),
	@lname varchar(20),
	@previousJobs varchar(MAX),
	@msg varchar(100) output
as
	if(@fname is null or @lname is null)
		set @msg = 'First and Last name can''t be empty'
	else
    if(exists(select * from Users where username = @username))
	   set @msg = 'This username is already taken'
	else
	if(exists(select * from Users where personal_email = @pemail))
	   set @msg = 'This email belongs to a registered user'
	else
	begin
	insert into Users(username,password,personal_email,birth_date,years_of_experience,first_name,middle_name,last_name)
	values(@username , @password ,@pemail ,@bdate ,@yearsOfExp ,@fname ,@mname ,@lname)
	
	insert into Job_Seekers values(@username)
	
	insert into user_jobs
    select value, @username
    from String_split(@previousJobs,',')
	where value <> '' and value <> ' '
	set @msg = 'successfully registered'
end
--6-
--6 Search for jobs that have vacancies on the system and their short description or title contain a
--string of keywords entered by the user. All information of the job should be displayed along with
--the company name and the department it belongs to
go
create or alter procedure Search_For_Job
	@jname varchar(50)
as
	select j.* , c.name , d.name as 'dname'
	from Jobs j inner join Companies c
	on j.company_email = c.email
	inner join Departments d 
	on j.department_code = d.code
	where j.no_of_vacancies > 0 and exists(select value from string_split(@jname ,',') where j.title like '%'+value+'%' or j.short_description like '%'+value+'%')
	and j.deadline>=current_timestamp
--7 
--7 View companies in the order of having the highest average salaries.

go 
create or alter function Get_Avg_Salary()
	returns table
as
	return (select c.email,'avg' = avg(j.salary)
	from (Companies c inner join Departments d on c.email = d.company_email) 
	inner join Jobs j on j.company_email = d.company_email and j.department_code = d.code
	group by c.email)

go
create or alter procedure View_Companies_HiAvSalary as

	select c.*, cc.avg 
	from companies c inner join dbo.get_avg_salary() cc	on c.email = cc.email
	order by (cc.avg) desc

--“As a registered user, I should be able to ...”
--8(1)
--1 Login to the website using my username and password which checks that i am an existing user, and
--whether i am job seeker, HR employee, Regular employee or manager.
go
create or alter function logi(@uname varchar(30) , @password varchar(30) )
returns varchar(1)
as
begin
if((select  u.password from users u where u.username = @uname) = @password)
	if((select  username from managers where username = @uname) = @uname)
		return 'm'
	else
		if((select  username from HR_Employees where username = @uname) = @uname)
			return 'h'
		else
			if((select  username from regular_employees where username = @uname) = @uname)
				return 'r'
			else
				if((select username from staff_members where username = @uname) = @uname)
					return 's'
				else
				if((select  username from job_seekers where username = @uname) = @uname)
				return 'j'
return 'n'
end

go
create or alter procedure lgn 
@uname varchar(30) ,
@password varchar(30),
@out varchar(1) output
as
begin 
set @out = dbo.logi(@uname, @password)
if(@out<>'n')
	begin 
	print 'Welcome'
	end
else
	begin 
	print 'Username does not exist or the password is wrong'
	end
end
--9(2)
--2 View all of my possible information.
go
create or alter procedure View_Info 
@username varchar(30)
as
begin
declare @pj varchar(max)
set @pj = '';
select @pj = @pj+job+','
from User_Jobs
where username = @username
if(dbo.logi(@username , (select u.password from Users u where u.username = @username)) = 'j')
select u.*, @pj as 'previous'
	from users u
	where u.username = @username
else
	select u.*,annual_leaves,company_email, day_off, salary, job_title, department_code, company, @pj as 'previous'
	from users u inner join staff_members m on u.username = m.username
    where m.username = @username
end
--10(3)
--3 Edit all of my personal information.
go
create or alter procedure Edit_User_Info
@username varchar (30),
@password varchar(30) ,
@personal_email varchar(50) ,
@birth_date datetime,
@years_of_experience int,
@first_name varchar(20),
@middle_name varchar(20),
@last_name varchar(20),
@previousJobs varchar(MAX)
as
begin
begin
update Users
set users.password = @password , personal_email = @personal_email ,birth_date = @birth_date
, years_of_experience = @years_of_experience ,first_name = @first_name,
middle_name = @middle_name , last_name = @last_name 
where username = @username
end
begin
delete from user_jobs
where username = @username
end
begin
insert into user_jobs
select value, @username
from String_split(@previousJobs,',')
where value <> '' and value <> ' '
end
end
 
-------------------------
--“As a job seeker, I should be able to ...”
--11(1)
--1 Apply for any job as long as I have the needed years of experience for the job. Make sure that a
--job seeker can’t apply for a job, if he/she applied for it before and the application is still pending.

go
create  procedure Job_Seeker_apply
@username varchar(30),
@jTitle varchar(30) ,
@jdCode int,
@jcMail varchar(50),
@count int output
as
begin
declare @exp int
set @exp =(  select years_of_experience 
from users
where username = @username)

if(
@exp >= (select min_experience from Jobs j where j.company_email = @jcMail and j.title = @jTitle and j.department_code = @jdCode) and CURRENT_TIMESTAMP <= (select deadline from Jobs j where j.company_email = @jcMail and j.title = @jTitle and j.department_code = @jdCode)
and  not exists(select * from Job_Seeker_apply_Job j where j.company_email = @jcMail and j.job_title = @jTitle and j.department_code = @jdCode and job_seeker_username = @username)
)
begin
	insert into job_seeker_apply_job (job_title ,department_code ,company_email,job_seeker_username)
	values(@jTitle , @jdCode , @jcMail ,@username)
	set @count = 1
	end
else 
begin
print 'You do not have the required experience to apply to this job or you already applied and your application is still pending'
set @count = 0
end
end


--12(2)
--2 View the interview questions related to the job I am applying for
go
create or alter procedure view_Job_Questions
@username varchar(30),
@jTitle varchar(50),
@jdCode int,
@cEmail varchar(50)
as
select q.question ,q.number
from Job_Seekers j inner join Job_Seeker_apply_Job p
on j.username = p.job_seeker_username
inner join Job_has_Question s
on p.job_title = s.job_title and p.department_code = s.department_code and p.company_email = s.Company_email
inner join Questions q
on s.question_number = q.number
inner join jobs x
on x.title = s.Job_title and x.department_code = s.department_code and x.company_email = s.company_email
where j.username = @username and x.title = @jtitle and x.department_code = @jdCode and x.Company_email = @cEmail

--13(3)
--3 Save the score I got while applying for a certain job.
go
create TYPE answers AS TABLE   
(QN int,
answer bit ); 

go
create or alter procedure Save_Score
@username varchar(30),
@job_title varchar(50) ,
@dCode int,
@cEmail varchar(50),
@answer int ,
@qn int ,
@output int output
as
begin
set @output = 0
if(exists (select * from  questions where  number = @qn and questions.answer = @answer))
set @output = 1
end

go
create or alter procedure update_score
@username varchar(30),
@job_title varchar(50) ,
@dCode int,
@cEmail varchar(50),
@score int
as
begin
update job_seeker_apply_job
set score = @score
where @job_title = job_title and department_code = @dcode and company_email = @cEmail and job_seeker_username = @username
end

--14(4) 
--4 View the status of all jobs I applied for before (whether it is finally accepted, rejected or still in the
--review process), along with the score of the interview questions.
go
create or alter procedure View_Status
@username varchar(30)
as
select p.job_title,p.department_code,p.company_email , p.manager_response , p.score
from Job_Seeker_apply_Job p inner join Job_Seekers j
on p.job_seeker_username = j.username
where p.job_seeker_username = @username




--15(5)
--5 Choose a job from the jobs I was accepted in, which would make me a staff member in the company
--and the department that offered this job. Accordingly, my salary and company email are set, and I
--get 30 annual leaves. In addition, I should also choose one day-off other than Friday. The number
--of vacancies for the assigned job has to be updated too.

go 
create or alter procedure Choose_Job
@username varchar(30),
@dayoff varchar(10),
@jTitle varchar(50),
@jdCode  int,
@jcMail varchar(50),
@output int output
as

if((select manager_response from Job_Seeker_apply_Job where job_title = @jTitle and department_code = @jdCode and company_email = @jcMail and job_seeker_username = @username)='accepted')
begin
with temp as (
select p.department_code ,j.salary,j.title as 'Job_title',c.domain as 'Company_Domain',c.email as 'email'
from Job_Seeker_apply_Job p inner join Jobs j
on p.job_title = j.title
inner join Companies c
on c.email = p.company_email
where p.job_seeker_username = @username and p.job_title = @jTitle and p.department_code = @jdCode)

insert into Staff_Members (department_code,company,salary,job_title ,username,annual_leaves ,day_off)
values((select department_code from temp) , (select email from temp) , (select salary from temp) , (select job_title from temp) ,@username ,30,@dayoff)
;
DELETE FROM Job_Seeker_apply_Job WHERE job_seeker_username = @username AND company_email = @jcMail AND department_code = @jdCode AND job_title = @jTitle
update Jobs
set no_of_vacancies = no_of_vacancies - 1
where ( department_code = @jdCode and  company_email = @jcMail and  title = @jTitle)
if(@jTitle like 'HR - %')
insert into HR_employees values(@username)
else
if(@jTitle like 'Regular Employee - %')
insert into Regular_Employees values (@username)

else if(@jTitle like 'Manager - %')

insert into Managers values (@username , SUBSTRING(@jTitle,11,LEN(@jTitle)-10))
set @output = 1
end

else
begin
print 'your application hasn''t been accepted yet'
set @output = 0
end

--16(6)
--6 Delete any job application I applied for as long as it is still in the review process.

go
create or alter procedure Delete_In_Process_Application
	@username varchar(30),
	@jTitle varchar(50),
	@jdCode  int,
	@jcMail varchar(50),
	@count int output
as 
if(exists(select * from Job_Seeker_apply_Job
	where job_seeker_username = @username and job_title = @jTitle and department_code = @jdCode and company_email = @jcMail
	and (manager_response = 'pending' or hr_response = 'pending')) )
	begin
	delete from Job_Seeker_apply_Job
	where job_seeker_username = @username and job_title = @jTitle and department_code = @jdCode and company_email = @jcMail
	and (manager_response = 'pending' or hr_response = 'pending')
	set @count = 1
	end
else
set @count = 0


go


--“As a staff member, I should be able to ...”
-- Staff members 
--1
--1 Check-in once I arrive each day.
go
create or alter procedure Check_in
@username varchar(50),
@msg varchar(300) output
as
begin
declare @time  datetime 
set @time = current_timestamp
if(exists (select * from Attendance_Records where @username = staff_username and date= convert(date,@time)))
set @msg = 'you already checked-in today'
else
begin
declare @dayoff varchar(10)
select @dayoff = day_off
from Staff_Members
where username = @username
if(DATENAME(weekday,@time)<>@dayoff and DATENAME(weekday,@time)<>'friday')
begin
set @msg = 'checked-in on '+cast(convert(date,@time) as varchar(20))+' at '+cast(convert(time,@time) as varchar(20))
insert into attendance_records(date,staff_username,start_time,end_time)
values(convert(date,@time),@username, convert(time,@time),null)
end
else
set @msg = 'this is your dayoff'
end
end
--exec Check_in 'mohamed_khaled'

--2
--2 Check-out before I leave each day.  If I check-in/-off on my day off (Friday or the other day off), this record should not be regarded.

go 
create or alter procedure Check_out
@username  varchar(50),
@msg varchar(300) output
as
begin 
declare @time datetime
set @time = CURRENT_TIMESTAMP
if(exists (select * from Attendance_Records where @username = staff_username and date = convert(date,@time) and end_time is null) )
begin
set @msg = 'check-out '+cast(convert(date,@time) as varchar(20))+' at '+cast(Convert(time,@time) as varchar(20))
update Attendance_Records
set end_time = Convert(time,@time)
where staff_username = @username and Attendance_Records.date = convert(date,@time) and end_time is null
end
else
set @msg = 'check-in first please'
end

--exec Check_out 'mohamed_khaled'

--3
--3 View all my attendance records (check-in time, check-out time, duration, missing hours) within a
--certain period of time
go
create or alter procedure View_My_Attendance
@username varchar(50),
@Startdate date,
@Enddate date
as
begin
declare @working_hours int
select @working_hours = working_hours
from Staff_Members inner join Jobs on job_title = title and Staff_Members.department_code = jobs.department_code and Staff_Members.company = jobs.company_email
where username = @username
select date,start_time, end_time, DATEDIFF(hour,start_time,end_time) as 'duration', @working_hours-DATEDIFF(hour,start_time,end_time) as 'missing hours'
from Attendance_Records
where staff_username = @username and date<=@Enddate and date>=@Startdate
end
--exec View_My_Attendance 'mohamed_khaled', '11/26/2017', '11/26/2017'


--4
--4 Apply for requests of both types: leave requests or business trip requests, by supplying all the
--needed information for the request. As a staff member, I can not apply for a leave if I exceeded the
--number of annual leaves allowed. If I am a manager applying for a request, the request does not
--need to be approved, but it only needs to be kept track of. Also, I can not apply for a request when
--it’s applied period overlaps with another request.
go
create or alter procedure Apply_For_Business_Trip_Request
@username varchar(30),
@start_date           DATETIME       ,
@end_date             DATETIME       ,
@destination varchar(100),
@purpose varchar(1000),
@replacement_username varchar(30),
@msg varchar(300) output
as
if(@start_date>@end_date)
set @msg = 'the start date has to be before the end date'
else
if(@start_date<convert(date, Current_timestamp))
set @msg = 'start date can''t be in the past'
else
if(exists (select * from Requests where applicant_username = @username and (start_date between @start_date and end_date or end_date between @start_date and @end_date)))
 set @msg = 'this request is overlapping with another one you applied for'
else
begin
 if(exists(select * from Staff_Members s1 inner join Staff_Members s2 on s1.company = s2.company where s1.username = @username and s2.username = @replacement_username) or @replacement_username is null)
 begin
   set @msg = 'successfully applied, your request will be reviewed'
   if(@username in (select username from HR_Employees) and (@replacement_username in (select username from HR_Employees) or @replacement_username is null))
    begin
     insert into Requests(start_date, applicant_username,end_date,request_date)
     values(@start_date,@username, @end_date, CURRENT_TIMESTAMP)
     insert into Business_Trip_Requests
     values(@start_date, @username, @destination,@purpose)
     insert into HR_Employee_apply_replace_Request
     values(@start_date, @username,@username, @replacement_username)
    end
   else
    if(@username in (select username from Regular_Employees) and( @replacement_username in (select username from Regular_Employees) or @replacement_username is null))
     begin
      insert into Requests(start_date, applicant_username,end_date,request_date)
      values(@start_date,@username, @end_date, CURRENT_TIMESTAMP)
      insert into Business_Trip_Requests
      values(@start_date, @username, @destination,@purpose)
      insert into Regular_Employee_apply_replace_Request
      values(@start_date, @username,@username, @replacement_username)
     end
    else
     if(@username in (select username from Managers) and( @replacement_username in (select username from Managers) or @replacement_username is null))
      begin
       insert into Requests(start_date, applicant_username,end_date,request_date,hr_response,manager_response,manager_username)
       values(@start_date,@username, @end_date, CURRENT_TIMESTAMP,'accepted','accepted',@username)
       insert into Business_Trip_Requests
       values(@start_date, @username,  @destination,@purpose)
       insert into Manager_apply_replace_Request
       values(@start_date, @username,@username, @replacement_username)
      end
     else
      set @msg =  'the user replacing you has to have the same role as yours'
  end
 else 
  set @msg = 'the user replacing you has to be from the same company as yours'
  end
--
go
create or alter procedure Apply_For_Leave_Request
@username varchar(30),
@start_date           DATETIME       ,
@end_date             DATETIME       ,
@type varchar(20), 
@replacement_username varchar(30),
@msg varchar(300) output
as
if(@start_date>@end_date)
set @msg = 'the start date has to be before the end date'
else
if(@start_date<convert(date, Current_timestamp))
set @msg = 'start date can''t be in the past'
else
if(exists (select * from Requests where applicant_username = @username and (start_date between @start_date and @end_date or end_date between @start_date and @end_date)))
 set @msg =  'this request is overlapping with another one you applied for'
else
 if((select annual_leaves from Staff_Members where username = @username)<DATEDIFF(DAY,@start_date,@end_date)+1)
  set @msg = 'you can''t exceed your annual leaves'
 else
begin
if(exists(select * from Staff_Members s1 inner join Staff_Members s2 on s1.company = s2.company where s1.username = @username and s2.username = @replacement_username) or @replacement_username is null)
 begin
 set @msg = 'successfully applied, your request will be reviewed'
  if(@username in (select username from HR_Employees) and (@replacement_username in (select username from HR_Employees) or @replacement_username is null))
   begin
    insert into Requests(start_date, applicant_username,end_date,request_date)
    values(@start_date,@username, @end_date, CURRENT_TIMESTAMP)
    insert into Leave_Requests
    values(@start_date, @username, @type)
    insert into HR_Employee_apply_replace_Request
    values(@start_date, @username,@username, @replacement_username)
   end
  else
   if(@username in (select username from Regular_Employees) and (@replacement_username in (select username from Regular_Employees) or @replacement_username is null))
    begin
     insert into Requests(start_date, applicant_username,end_date,request_date)
     values(@start_date,@username, @end_date, CURRENT_TIMESTAMP)
     insert into Leave_Requests
     values(@start_date, @username, @type)
     insert into Regular_Employee_apply_replace_Request
     values(@start_date, @username,@username, @replacement_username)
    end
   else
    if(@username in (select username from Managers) and (@replacement_username in (select username from Managers) or @replacement_username is null))
     begin
      insert into Requests(start_date, applicant_username,end_date,request_date,hr_response,manager_response,manager_username)
      values(@start_date,@username, @end_date, CURRENT_TIMESTAMP,'accepted','accepted',@username)
      insert into Leave_Requests
      values(@start_date, @username, @type)
      insert into Manager_apply_replace_Request
      values(@start_date, @username,@username, @replacement_username)
	  update Staff_Members
	  set annual_leaves = annual_leaves - (DATEDIFF(DAY,@start_date,@end_date)+1)
	  where username = @username
     end
    else
     set @msg = 'the user replacing you has to have the same role as yours'
 end
else
 set @msg = 'the user replacing you has to be from the same company as yours'
end


--5
--5 View the status of all requests I applied for before (HR employee and manager responses).

go
create or alter function typeR(@ldate datetime, @bdate datetime)
returns varchar(50)
as
begin 
if(@ldate is null)
 begin return 'Business trip Request'
 end
 return 'Leave Request'
end
go
create or alter procedure View_Request_Status
@username varchar(50)
as
select r.start_date, r.end_date, r.total_days, dbo.typeR(lr.start_date, br.start_date) as 'type', r.hr_response, r.manager_response
from requests r  left outer join leave_Requests lr on r.start_date = lr.start_date left outer join Business_Trip_Requests br on r.start_date =  br.start_date
where r.applicant_username = @username


--6
--6 Delete any request I applied for as long as it is still in the review process.

go 
create or alter procedure Delete_Request
    @username varchar(50),
    @start_date datetime,
	@msg varchar(100) output
    as
	begin
	set @msg = 'successfully deleted'
	if(exists (select * from requests where start_date = @start_date and applicant_username = @username))
	begin
	if(exists(select * from requests where start_date = @start_date and applicant_username = @username and (hr_response = 'pending' or manager_response = 'pending')))
    delete from Requests
    where applicant_username = @username and start_date = @start_date and (hr_response = 'pending' or manager_response = 'pending')
	else
	set @msg = 'this request is not in the review process'
	end
	else
	set @msg= 'this request doesn''t exist, write the correct start date'
	end

--7
--7 Send emails to staff members in my company.

go
create or alter procedure Send_Email
    @Susername varchar(50),
	@Remails varchar(MAX),
    @subject       VARCHAR (100)  ,
    @body          VARCHAR (5000)
	as
	begin
	insert into Emails (subject,date,body)
	values(@subject, CURRENT_TIMESTAMP,@body)
	declare @Email_Id int
	select @Email_Id = max(Serial_number)
	from Emails
	insert into Staff_Send_Email_Staff (email_number, sender_username, recipient_username)
	select serial_number, s1.username, s2.username
	from (Staff_Members s1 inner join Staff_Members s2 on s1.username<>s2.username and s1.company = s2.company), Emails
	where Emails.serial_number = @Email_Id and s1.username = @Susername and @Remails like '%'+s2.company_email+';%'
	end

go
create or alter function Staff_Company(@username VARCHAR(30))
returns varchar(50)
as
begin 
declare @comp varchar(50)
select @comp = company 
from Staff_Members
where username = @username
return @comp
end

--8
--8 View emails sent to me by other staff members of my company

go
create or alter procedure View_Emails
@username varchar(30)
as
begin
declare @userCompany varchar(50)
set @userCompany =  dbo.Staff_Company(@username)
select sender_username,emails.*
from (emails inner join Staff_Send_Email_Staff on serial_number = email_number) inner join Staff_Members on username = sender_username
where recipient_username = @username and company = @userCompany
end

go
create or alter procedure Get_Email
@username varchar(30),
@Email_id int
as
begin
select sm.company_email, e.date, e.subject, e.body
from (Staff_Send_Email_Staff ses inner join Staff_Members sm on ses.sender_username = sm.username) inner join Emails e on e.serial_number = ses.email_number
where e.serial_number = @Email_id and ses.recipient_username = @username
end  
--9
--9 Reply to an email sent to me, while the reply would be saved in the database as a new email record.
go
create or alter procedure Reply_to_Email
@username varchar(30),
@Email_id int,
@body varchar(5000)
as
begin
declare @subject varchar(100)
declare @SendTo varchar(50)
select @SendTo = company_email+';'
from Staff_Send_Email_Staff inner join Staff_Members on sender_username = username
where email_number = @Email_id and recipient_username = @username
select @subject = 'Re: '+subject
from Emails
where serial_number = @Email_id
exec Send_Email @username, @SendTo, @subject, @body
end

--10
--10 View announcements related to my company within the past 20 days.

go 
create or alter procedure View_Announcements
@username varchar(50)
as
begin
declare @userCompany varchar(50)
set @userCompany =  dbo.Staff_Company(@username)
select date, title, type, description
from Announcements inner join Staff_Members on hr_employee_username = username
where company = @userCompany and date>=DATEADD(day,-20,CONVERT(date,CURRENT_TIMESTAMP))
end

--HR Employee
--“As an HR employee, I should be able to ...”
--1
--1 Add a new job that belongs to my department, including all the information needed about the
--job and its interview questions along with their model answers. The title of the added job should
--contain at the beginning the role that will be assigned to the job seeker if he/she was accepted in
--this job; for example: “Manager - Junior Sales Manager”.
 
--edit here
 
--done 
go 
create or alter procedure New_Job
@hrusername varchar(30),
@title                VARCHAR (50)   ,
@short_description    VARCHAR (500)  ,
@detailed_description VARCHAR (5000) ,
@min_experience       INT			,
@salary               INT            ,
@deadline             DATETIME       ,
@no_of_vacancies      INT            ,
@working_hours        REAL			,
@out int out 
as
begin
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members 
where username = @hrusername
if(@title not like '% - %')
	set @out = 1 
--print 'please write the title in the format (role - job_title)'
else
if(exists (select title from jobs where title = @title and department_code = @department_code and company_email = @company_email))
	set @out = 2
--print 'this job title already exists in the database'
else
begin
	set @out = 0
 
insert into Jobs (title, department_code, company_email, short_description,detailed_description,min_experience,salary,deadline,no_of_vacancies,working_hours)     
values(@title, @department_code, @company_email, @short_description,@detailed_description,@min_experience,@salary,@deadline,@no_of_vacancies,@working_hours)    
 
end
end
 
--done
go
create or alter procedure add_Ques
@hrusername varchar(30),
@title varchar(50),
@Q varchar (500) ,
@A bit
as
begin
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members 
where username = @hrusername
 
insert into Questions (question,answer)values(@Q, @A)
 
 
declare @lastQ int
 
 
select @lastQ = max(number)
from Questions
 
insert into job_has_Question
select title, department_code, company_email, number
from jobs, Questions 
where title = @title and department_code = @department_code and company_email = @company_email and number=@lastQ 
end
--edit here hamahmi 
--done
go
create or alter procedure View_Jobs
@hrusername varchar(30)
as 
begin
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members 
where username = @hrusername
select * 
from jobs 
where department_code = @department_code and company_email = @company_email
end
 
--2 ediiiit
--done
--2 View information about a job in my department.
go
create or alter procedure View_Job 
@hrusername varchar(30),
@title varchar(50)
as
begin
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members 
where username = @hrusername
select * 
from jobs 
where title = @title and department_code = @department_code and company_email = @company_email
 
end
 
--done
go
create or alter procedure View_JobQ
@hrusername varchar(30),
@title varchar(50)
as
begin
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members 
where username = @hrusername
select  question, answer
from Job_has_Question inner join Questions on number = question_number
where job_title = @title and department_code = @department_code and company_email = @company_email
end
 
 
----------------------------------------
--hamahmi change here
--done
--3
--3 Edit the information of a job in my department
go
create or alter procedure Edit_Job
@hrusername varchar(30),
@Oldtitle                VARCHAR (50)   ,
@Newtitle                   varchar(50),
@short_description    VARCHAR (500)  ,
@detailed_description VARCHAR (5000) ,
@min_experience       int ,
@salary               INT            ,
@deadline             DATETIME       ,
@no_of_vacancies      INT            ,
@working_hours        REAL,
@done int output
as
begin
 
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members 
where username = @hrusername
if( exists (select title from jobs where title = @Newtitle and department_code = @department_code and company_email = @company_email))
set @done = 3
else
begin
 
delete from Questions
where number in (select question_number from Job_has_Question where job_title = @Oldtitle and department_code = @department_code and company_email = @company_email)
delete from Jobs
where title = @Oldtitle and department_code = @department_code and company_email = @company_email
declare @go int
exec New_Job @hrusername, @Newtitle, @short_description, @detailed_description, @min_experience, @salary, @deadline, @no_of_vacancies, @working_hours, @go
set @done = @go
end
end
 
 
 
--4
--4 View new applications for a specific job in my department. For each application, I should be able
--to check information about the job seeker, job, the score he/she got while applying.
--change here done
--done
 
go
create or alter procedure View_applications
@hrusername varchar(30),
@job_title varchar(50)
as
begin
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members 
where username = @hrusername
select job_title, job_seeker_username, score
from job_seeker_apply_job
where job_title = @Job_title and department_code = @department_code and company_email = @company_email and hr_response = 'pending'
end
--done
go 
create or alter procedure View_Job_Seeker
@username varchar(30)
as
begin
select username, personal_email, birth_date, years_of_experience, first_name, middle_name, last_name, age
from users 
where username = @username
end
 
--done
go 
create or alter procedure View_Job_Seeker_Jobs
@username varchar(30)
as
select job as 'jobs he/she worked in'
from User_Jobs
where username = @username
 
 
 
 
--5 changeee done
--5 Accept or reject applications for jobs in my department.
go
create or alter procedure Accept_App
@hrusername varchar(30),
@Jtitle varchar(50),
@JS_username varchar(30),
@out int out
as
begin
 
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members 
where username = @hrusername
declare @vacancies int
select @vacancies = no_of_vacancies from jobs where title = @jtitle and department_code = @department_code and company_email = @company_email
 
if(@vacancies = 0)
	set @out = 0
--print 'This job has no vacancies available'
else
begin
update job_seeker_apply_job
set hr_response = 'accepted'
where job_title = @jtitle and department_code = @department_code and company_email = @company_email and job_seeker_username = @JS_username
set @out = 1
end
end
 
--done
go
create or alter procedure Reject_App
@hrusername varchar(30),
@Jtitle varchar(50),
@JS_username varchar(30)
as
begin
 
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members 
where username = @hrusername
declare @vacancies int
begin
update job_seeker_apply_job
set hr_response = 'rejected'
where job_title = @jtitle and department_code = @department_code and company_email = @company_email and job_seeker_username = @JS_username
 
end
end
 
--done 
--6
--6 Post announcements related to my company to inform staff members about new updates.
go
create or alter procedure Post_Announcement
@hrusername VARCHAR (30)   ,
@title                VARCHAR (100)  ,
@type                 VARCHAR (30),
@description          VARCHAR (5000)
as
insert into announcements
values (current_timestamp,@title, @hrusername, @type, @description)
 
 
--7
--7 View requests (business or leave) of staff members working with me in the same department that
--were approved by a manager only.
 
--to be checked
--edit Hamahmi
--exec View_LRequests 'simon'
go
create or alter procedure View_LRequests
@hrusername varchar(30)
as
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members
where username = @hrusername
select r.* , lr.type, s.username as 'replacement_username'
from (leave_requests lr inner join requests r on lr.start_date = r.start_date and lr.applicant_username = r.applicant_username), staff_members s
where (exists (select * from staff_members s1 where s1.username = lr.applicant_username and s1. department_code = @department_code and s1.company = @company_email)) and
(s.username in (select replacement_username from HR_Employee_apply_replace_Request) or s.username in (select replacement_username from regular_Employee_apply_replace_Request) or s.username in (select replacement_username from manager_apply_replace_Request))
and (r.manager_response  = 'accepted' and r.hr_response = 'pending')
--done
go
create or alter procedure View_BRequests
@hrusername varchar(30)
as
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members
where username = @hrusername
select r.* , bt.destination,bt.purpose, s.username as 'replacement_username'
from (business_trip_requests bt inner join requests r on bt.start_date = r.start_date and bt.applicant_username = r.applicant_username), staff_members s
where (exists (select * from staff_members s1 where s1.username = bt.applicant_username and s1. department_code = @department_code and s1.company = @company_email)) and
(s.username in (select replacement_username from HR_Employee_apply_replace_Request) or s.username in (select replacement_username from regular_Employee_apply_replace_Request) or s.username in (select replacement_username from manager_apply_replace_Request))
and (r.manager_response  = 'accepted' and r.hr_response = 'pending')
go
 
 
 
--8
--8 Accept or reject requests of staff members working with me in the same department that were
--approved by a manager. My response decides the final status of the request, therefore the annual
--leaves of the applying staff member should be updated in case the request was accepted. Take into
--consideration that if the duration of the request includes the staff member’s weekly day-off and/or
--Friday, they should not be counted as annual leaves.
go
create or alter function Exclude(@day varchar(10), @from datetime, @to datetime)
returns int
as
begin
if(@day = 'Saturday')
return datediff(day, -2, @to)/7-datediff(day, -1, @from)/7
else
if(@day = 'Sunday')
return datediff(day, -1, @to)/7-datediff(day, 0, @from)/7
else
if(@day = 'Monday')
return  datediff(day, -7, @to)/7-datediff(day, -6, @from)/7
else
if(@day = 'Tuesday')
return  datediff(day, -6, @to)/7-datediff(day, -5, @from)/7
else
if(@day = 'Wednesday')
return datediff(day, -5, @to)/7-datediff(day, -4, @from)/7
else
if(@day = 'Thursday')
return datediff(day, -4, @to)/7-datediff(day, -3, @from)/7
return 0
end
 
 
--change here  hamahmi
--done
go
create or alter procedure Accept_Req
@hrusername varchar(30),
@Rstart_date datetime,
@Ausername varchar(30)
as
begin
update Requests
  set hr_response = 'accepted', hr_employee_username = @hrusername
  where start_date = @Rstart_date and applicant_username = @Ausername
begin
declare @daysOff_Exc int
declare @total_days int
declare @to datetime
declare @from datetime
select @to = end_date, @from = start_date
from Requests
where start_date = @Rstart_date and applicant_username = @Ausername
declare @dayOff varchar(10)
select @dayOff = day_off
from staff_members
where username = @Ausername
set @daysOff_Exc = dbo.Exclude(@dayOff, @from, @to)+datediff(day, -3, @to)/7-datediff(day, -2, @from)/7
select @total_days = total_days
from Requests
where start_date = @Rstart_date and applicant_username = @Ausername
update Staff_Members
set annual_leaves = annual_leaves-(@total_days-@daysOff_Exc)
where username = @Ausername
end
end
 
go
create or alter procedure Reject_Req
@hrusername varchar(30),
@Rstart_date datetime,
@Ausername varchar(30)
as
begin
update Requests
  set hr_response = 'rejected', hr_employee_username = @hrusername
  where start_date = @Rstart_date and applicant_username = @Ausername
end
 
 
 
--9
--9 View the attendance records of any staff member in my department (check-in time, check-out time,
--duration, missing hours) within a certain period of time.
--edit hamahmi
--done
go
create or alter procedure View_Staff_Attendance
@hrusername varchar(30),
@Staff_username varchar(30),
@start_date date,
@end_date date,
@good int output 
as
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members
where username = @hrusername
if(exists(select * from Staff_Members where username = @Staff_username and company = @company_email and department_code = @department_code))
begin
exec View_MY_Attendance @Staff_username, @start_date, @end_date
set @good = 0
end
else
set @good = 1
 
--10
--10 View the total number of hours for any staff member in my department in each month of a certain
--year.
--changge hamahmi
--done
go 
create or alter procedure View_Total_Hours
@hrusername varchar(30),
@Staff_username varchar(30),
@year int,
@good int output
as
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members
where username = @hrusername
if(exists(select * from Staff_Members where username = @Staff_username and company = @company_email and department_code = @department_code))
begin
select number as 'month', sum(DATEDIFF(hour,start_time,end_time)) as 'Hours'
from master.dbo.spt_values inner join Attendance_Records on month(date) = number
where staff_username = @Staff_username and year(date) = @year and number between 1 and 12
group by number
order by number
set @good = 0
end
else
set @good = 1
 
--11
--11 View names of the top 3 high achievers in my department. A high achiever is a regular employee
--who stayed the longest hours in the company for a certain month and all tasks assigned to him/her
--with deadline within this month are fixed.
--hamahmi change
 
--done
go
create or alter procedure Top3
@hrusername varchar(30),
@month int,
@year int
as
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members
where username = @hrusername
select TOP 3 staff_username, sum(DATEDIFF(hour,start_time,end_time)) as 'hours'
from Attendance_Records
where (staff_username in (select username from staff_members where department_code = @department_code and company = @company_email))
and month(date) = @month and year(date) = @year and (not exists (select * from tasks where regular_employee_username = staff_username and month(deadline) = @month and year(deadline) = @year and status <> 'fixed'))
group by staff_username
order by sum(DATEDIFF(hour,start_time,end_time)) DESC
 
--done
go
create or alter procedure Top3mails
@hrusername varchar(30),
@month int,
@year int
as
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members
where username = @hrusername
select company_email
from Staff_Members
where username in (
select TOP 3 staff_username
from Attendance_Records
where (staff_username in (select username from staff_members where department_code = @department_code and company = @company_email))
and month(date) = @month and year(date) = @year and (not exists (select * from tasks where regular_employee_username = staff_username and month(deadline) = @month and year(deadline) = @year and status <> 'fixed'))
group by staff_username
)
 

--Regular Employee User Stories
--helpers
go
create or alter function Get_Company( @username varchar(30))
returns varchar(50)
as
begin 
declare @company_email VARCHAR (50)
SELECT @company_email = S.company
FROM Staff_Members S
WHERE S.username = @username
return @company_email 
end 

go
create or alter function Get_Department( @username varchar(30))
returns int
as
begin 
declare @department_code INT
SELECT @department_code = S.department_code
FROM Staff_Members S
WHERE S.username = @username
return @department_code
end

go
--regular

--1
--1 View a list of projects assigned to me along with all of their information.

go
create or alter procedure view_projects
@username varchar(30)
as
select * from dbo.view_employees_projects(@username)
go
create or alter function View_Employees_Projects( @e_username varchar(30))
returns table
as 
return
select P.*
from Manager_assign_Regular_Employee_Project PR
inner join Projects P
on PR.project_name = P.name and PR.company_email = P.company_email
where PR.regular_employee_username = @e_username

--2
--2 View a list of tasks in a certain project assigned to me along with all of their information and status.

go
 create or alter procedure View_Project_Tasks 
@pname varchar(50),
@e_username varchar(30)
as 
select T.*
from Tasks T inner join View_Employees_Projects(@e_username) P
on T.project_name = P.name 


--3
--3 After finalizing a task, I can change the status of this task to ‘Fixed’ as long as it did not pass the
--deadline.
go
create or alter procedure Set_Fixed 
	@name                      VARCHAR (50)   ,
    @project_name              VARCHAR (50)   ,
    @company_email             VARCHAR (50)   ,
	@regular_employee_username VARCHAR (30)   ,
	@output int output
as
if(EXISTS(SELECT * from Tasks where  Tasks.name = @name AND Tasks.project_name = @project_name AND Tasks.company_email = @company_email 
	AND Tasks.regular_employee_username = @regular_employee_username AND( CURRENT_TIMESTAMP > Tasks.deadline or tasks.status = 'Closed') ))
		begin print('The deadline of this task has already passed')
		set @output = 0
		end
else
begin
UPDATE Tasks 
SET Tasks.status = 'Fixed'
where  Tasks.name = @name AND Tasks.project_name = @project_name AND Tasks.company_email = @company_email 
AND Tasks.regular_employee_username = @regular_employee_username AND CURRENT_TIMESTAMP <= Tasks.deadline
set @output = 1
end
--4
--4 Work on the task again (a task that was assigned to me before). I can change the status of this
--task from ‘Fixed’ to ‘Assigned’ as long as the deadline did not pass and it was not reviewed by the
--manager yet.
go
create or alter procedure Set_Assigned 
	@name                      VARCHAR (50)   ,
    @project_name              VARCHAR (50)   ,
    @company_email             VARCHAR (50)   ,
	@regular_employee_username VARCHAR (30)   ,
	@output varchar(50) output
as
if(EXISTS(SELECT * from Tasks where  Tasks.name = @name AND Tasks.project_name = @project_name AND Tasks.company_email = @company_email 
AND Tasks.regular_employee_username = @regular_employee_username AND CURRENT_TIMESTAMP <= Tasks.deadline AND Tasks.status = 'Closed'))
	begin print('This task has already been closed')
	set @output = 'closed'
	end
else
	if(EXISTS(SELECT * from Tasks where  Tasks.name = @name AND Tasks.project_name = @project_name AND Tasks.company_email = @company_email 
	AND Tasks.regular_employee_username = @regular_employee_username AND CURRENT_TIMESTAMP > Tasks.deadline ))
		begin print('The deadline of this task has already passed')
		set @output = 'passed'
		end

	else
	begin
	UPDATE Tasks 
		SET Tasks.status = 'Assigned'
		where  Tasks.name = @name AND Tasks.project_name = @project_name AND Tasks.company_email = @company_email 
		AND Tasks.regular_employee_username = @regular_employee_username AND CURRENT_TIMESTAMP <= Tasks.deadline AND Tasks.status <> 'Closed'
		set @output = 'Assigned'
		
		end




------------------------------------------------------------------------------------------------------------------------------------------------------------
--Manager User Stories-- 

--“As a manager, I should be able to ...”
--1-2-to be modified (check if the applicant is an hr employe...)

--1 View new requests from staff members working in my department. Note that only managers with
--type = ‘HR’ are allowed to review requests applied for by HR employees, and this manager’s review
--is considered the final decision taken for this request, i.e. it does not pass by an HR employee
--afterwards.

go
create or alter procedure Manager_View_Leave_Requests( @m_username varchar(30))
as 
begin
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members
where username = @m_username


if( EXISTS(SELECT * FROM Managers where  username = @m_username AND (type like '%HR%' or type like '%human resources%')) )
begin
select r.* , lr.type, s.username as 'replacement_username'
from (leave_requests lr inner join requests r on lr.start_date = r.start_date and lr.applicant_username = r.applicant_username), staff_members s
where (exists (select * from staff_members s1 where s1.username = lr.applicant_username and s1. department_code = @department_code and s1.company = @company_email)) and
(s.username in (select replacement_username from HR_Employee_apply_replace_Request) or s.username in (select replacement_username from regular_Employee_apply_replace_Request) or s.username in (select replacement_username from manager_apply_replace_Request))
and (r.manager_response  = 'pending' )
end

else
 begin
 select r.* , lr.type, s.username as 'replacement_username'
 from (leave_requests lr inner join requests r on lr.start_date = r.start_date and lr.applicant_username = r.applicant_username), staff_members s
 where (exists (select * from staff_members s1 where s1.username = lr.applicant_username and s1. department_code = @department_code and s1.company = @company_email)) and
 (s.username in (select replacement_username from HR_Employee_apply_replace_Request) or s.username in (select replacement_username from regular_Employee_apply_replace_Request) or s.username in (select replacement_username from manager_apply_replace_Request))
 and r.manager_response  = 'pending' and NOT EXISTS(SELECT * FROM HR_Employees where  username = r.applicant_username )
end
end

go
create or alter procedure Manager_View_Trip_Requests( @m_username varchar(30))
as 
begin
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members
where username = @m_username


if( EXISTS(SELECT * FROM Managers where  username = @m_username AND (type like '%HR%' or type like '%human resources%')) )
begin
(select r.* , bt.destination,bt.purpose, s.username as 'replacement_username'
from (business_trip_requests bt inner join requests r on bt.start_date = r.start_date and bt.applicant_username = r.applicant_username), staff_members s
where (exists (select * from staff_members s1 where s1.username = bt.applicant_username and s1. department_code = @department_code and s1.company = @company_email)) and
(s.username in (select replacement_username from HR_Employee_apply_replace_Request) or s.username in (select replacement_username from regular_Employee_apply_replace_Request) or s.username in (select replacement_username from manager_apply_replace_Request))
and (r.manager_response  = 'pending'))
end

else
 begin
(select r.* , bt.destination,bt.purpose, s.username as 'replacement_username'
from (business_trip_requests bt inner join requests r on bt.start_date = r.start_date and bt.applicant_username = r.applicant_username), staff_members s
where (exists (select * from staff_members s1 where s1.username = bt.applicant_username and s1. department_code = @department_code and s1.company = @company_email)) and
(s.username in (select replacement_username from HR_Employee_apply_replace_Request) or s.username in (select replacement_username from regular_Employee_apply_replace_Request) or s.username in (select replacement_username from manager_apply_replace_Request))
and r.manager_response  = 'pending'  and NOT EXISTS(SELECT * FROM HR_Employees where  username = r.applicant_username ))

end
end

--2
--2 Accept or reject requests from staff members working in my department before being reviewed by
--the HR employee. In case of disapproval, I should provide a reason to be saved.





go
create or alter procedure Manager_Respond_To_Request
@m_username varchar(30),
@applicant_username varchar(30),
@start_date DateTime ,
@manager_response     VARCHAR (10),
@reason varchar(3000) = NULL
as
if((select hr_response from Requests where applicant_username = @applicant_username and start_date = @start_date ) = 'pending')
begin
if(@manager_response = 'rejected' AND @reason is NULL)
	print('You have to specify the reason')
else
	begin
	if(EXISTS(SELECT * FROM HR_Employees where  username = @applicant_username) )
		UPDATE Requests 
		SET manager_response = @manager_response , manager_reason = @reason , manager_username = @m_username , hr_response = @manager_response
		where Requests.applicant_username = @applicant_username AND Requests.start_date = @start_date
	else
		UPDATE Requests 
		SET manager_response = @manager_response , manager_reason = @reason , manager_username = @m_username 
		where Requests.applicant_username = @applicant_username AND Requests.start_date = @start_date
	end
end
else
print 'this request has already been reviewed by an HR'


--3 View applications for a specific job in my department that were approved by an HR employee. For
--each application, I should be able to check information about the job seeker, job, and the score
--he/she got while applying.

go
 create or alter procedure  Manager_View_Job_Applications
@job_title           VARCHAR (50) ,
@m_username varchar(30)
as
begin
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members
where username = @m_username
select job_title, job_seeker_username,score
from job_seeker_apply_job
where job_title = @job_title and department_code = @department_code and company_email = @company_email and hr_response = 'accepted' and manager_response = 'pending'
end

--4 Accept or reject job applications to jobs related to my department after being approved by an HR
--employee.
go 
create or alter procedure Manager_View_Application
@m_username varchar(30),
@job_title varchar(50),
@job_seeker_username varchar(30)
as
begin
declare @department_code int
declare @company_email varchar(50)
select @department_code = department_code, @company_email = company
from Staff_Members 
where username = @m_username
select job_title, job_seeker_username, score
from job_seeker_apply_job
where job_title = @Job_title and department_code = @department_code and company_email = @company_email and job_seeker_username = @job_seeker_username and manager_response = 'pending'
exec View_Job @m_username, @job_title
exec View_job_seeker @job_seeker_username
end
--5
--5 Create a new project in my department with all of its information
go
create or alter procedure  Manager_Respond_Job_Applications
@job_title           VARCHAR (50) ,
@manager_username VARCHAR (30) ,
@job_seeker_username VARCHAR (30) ,
@response VARCHAR (10)
as
begin
declare @company_email VARCHAR (50) 
declare @department_code     INT 
set @company_email = dbo.Get_Company(@manager_username)
set @department_code = dbo.Get_Department(@manager_username)
UPDATE Job_Seeker_apply_Job 
SET manager_response = @response 
where hr_response = 'Accepted' AND job_title = @job_title AND department_code = @department_code 
AND company_email = @company_email AND job_seeker_username = @job_seeker_username
end

go
create or alter procedure  Create_Project 
	@name             VARCHAR (50) ,
    @start_date       DATETIME     ,
    @end_date         DATETIME     ,
    @manager_username VARCHAR (30) 
as
begin
declare @company_email VARCHAR (50) 
set @company_email = dbo.Get_Company(@manager_username)
insert into Projects values (@name,@company_email,@start_date,@end_date,@manager_username)
end
 


--6
--6 Assign regular employees to work on any project in my department. Regular employees should be
--working in the same department. Make sure that the regular employee is not working on more than
--two projects at the same time.

go
create or alter procedure Assign_Employee_Project
	@project_name              VARCHAR (50) ,
    @regular_employee_username VARCHAR (30) ,
    @manager_username          VARCHAR (30) 
as
begin
declare @company_email VARCHAR (50) 
declare @department_code     INT 
set @company_email = dbo.Get_Company(@manager_username)
set @department_code = dbo.Get_Department(@manager_username)
if(EXISTS(select P.* 
From Projects P,Staff_Members S1,Staff_Members S2,Staff_Members S3
where S1.username = @manager_username AND S2.username = @regular_employee_username AND S3.username=P.manager_username 
AND S1.company = S2.company AND S2.company = S3.company
AND S1.department_code = S2.department_code AND S2.department_code = S3.department_code AND P.name = @project_name AND P.company_email = @company_email) 
AND (SELECT COUNT(*) From Manager_assign_Regular_Employee_Project where regular_employee_username = @regular_employee_username)<2)
insert into Manager_assign_Regular_Employee_Project values(@project_name,@company_email,@regular_employee_username,@manager_username)
end



--7
--7 Remove regular employees assigned to a project as long as they don’t have tasks assigned to him/her
--in this project.
go
create or alter procedure Remove_Regular_From_Project
	@project_name              VARCHAR (50) ,
    @regular_employee_username VARCHAR (30) ,
    @manager_username          VARCHAR (30) 
as
begin
declare @company_email VARCHAR (50) 
set @company_email = dbo.Get_Company(@manager_username)
Delete From Manager_Assign_Regular_Employee_Project 
where project_name = @project_name AND company_email = @company_email AND regular_employee_username = @regular_employee_username AND manager_username = @manager_username 
AND NOT EXISTS (SELECT * FROM Tasks WHERE project_name = @project_name AND company_email = @company_email AND regular_employee_username = @regular_employee_username)
end


--8
--8 Define a task in a project in my department which will have status ‘Open’.
go
create or alter procedure Define_New_Task
	@name                      VARCHAR (50)   ,
    @project_name              VARCHAR (50)   ,
    @deadline                  DATETIME       ,
    @description               VARCHAR (3000) ,
    @manager_username          VARCHAR (30)   
as
begin
declare @company_email VARCHAR (50) 
set @company_email = dbo.Get_Company(@manager_username)
if(EXISTS(select * from Projects where name = @project_name and company_email = @company_email and manager_username = @manager_username))
insert into Tasks values(@name ,@project_name,@company_email ,@deadline ,'Open' ,@description,NULL,@manager_username )
else
print 'you can''t create a task in a project that you aren''t managing'
end

--9
--9 Assign one regular employee (from those already assigned to the project) to work on an already
--defined task by me in this project.
go
create or alter procedure Manager_Assign_Employee_Task
	@name                      VARCHAR (50)   ,
    @project_name              VARCHAR (50)   ,
    @regular_employee_username VARCHAR (30)   ,
    @manager_username          VARCHAR (30)
as
begin
declare @company_email VARCHAR (50) 
set @company_email = dbo.Get_Company(@manager_username)
if(EXISTS(SELECT * FROM Manager_assign_Regular_Employee_Project WHERE regular_employee_username = @regular_employee_username and project_name = @project_name and company_email = @company_email) and EXISTS(select * from Projects where name = @project_name and company_email = @company_email and manager_username = @manager_username))
	UPDATE Tasks
	SET regular_employee_username = @regular_employee_username , status= 'Assigned'
	where name = @name AND project_name = @project_name AND @company_email = company_email AND manager_username = @manager_username
else
if(not EXISTS(SELECT * FROM Manager_assign_Regular_Employee_Project WHERE regular_employee_username = @regular_employee_username and project_name = @project_name and company_email = @company_email))
	print('This employee cannot be assigned to this task as he is not assigned to its project')
else
	print 'you can''t update a task in a project that you aren''t managing'
end

--10
--10 Change the regular employee working on a task on the condition that its state is ‘Assigned’, i.e. by
--assigning it to another regular employee.

go
create or alter procedure Change_Assigned_Employee
	@name                      VARCHAR (50)   ,
    @project_name              VARCHAR (50)   ,
    @regular_employee_username VARCHAR (30)   ,
    @manager_username          VARCHAR (30)
as
begin
declare @company_email VARCHAR (50) 
set @company_email = dbo.Get_Company(@manager_username)
if(EXISTS(SELECT * FROM Manager_assign_Regular_Employee_Project WHERE regular_employee_username = @regular_employee_username and project_name = @project_name and company_email = @company_email) and EXISTS(select * from Projects where name = @project_name and company_email = @company_email and manager_username = @manager_username))
	UPDATE Tasks
	SET regular_employee_username = @regular_employee_username 
	where name = @name AND project_name = @project_name AND @company_email = company_email AND manager_username = @manager_username AND status = 'Assigned'
else
if(not EXISTS(SELECT * FROM Manager_assign_Regular_Employee_Project WHERE regular_employee_username = @regular_employee_username and project_name = @project_name and company_email = @company_email))
	print('This employee cannot be assigned to this task as he is not assigned to its project')
else
	print 'you can''t update a task in a project that you aren''t managing'
end

go 

--11
--11 View a list of tasks in a certain project that have a certain status.
go
create or alter procedure View_Project_Tasks_With_Status
	@project_name             VARCHAR (50) ,
	@manager_username          VARCHAR (30),
	@status                   VARCHAR (10) 
as
begin
declare @company_email VARCHAR (50) 
set @company_email = dbo.Get_Company(@manager_username)
select * 
From Tasks
where project_name = @project_name AND @company_email = company_email AND status = @status
end

--12
--12 Review a task that I created in a certain project which has a state ‘Fixed’, and either accept or
--reject it. If I accept it, then its state would be ‘Closed’, otherwise it will be re-assigned to the same
--regular employee with state ‘Assigned’. The task should have now a new deadline.

go
create or alter procedure Task_Review
    @name                     VARCHAR (50)  ,
	@project_name             VARCHAR (50)  ,
	@manager_username          VARCHAR (30),
	@status                   VARCHAR (10)  ,
	@deadline                 DATETIME = NULL   
as
begin
declare @company_email VARCHAR (50) 
set @company_email = dbo.Get_Company(@manager_username)
if(not EXISTS(select * from Projects where name = @project_name and company_email = @company_email and manager_username = @manager_username))
print 'you can''t update a task you are not managing'
else
begin
if(@status = 'Assigned' And @deadline is null)
	print('You have to specify the new deadline')
else
begin
	UPDATE Tasks
	SET status = @status
    where name = @name AND @project_name=project_name AND @company_email = company_email
end

end
end

create database  Gestion_employ�
on (name='Gestion_employ�_mdf',filename='D:\Gestion_employ� database\Gestion_employ�_mdf.mdf', size=10)
log on (name='Gestion_employ�_ldf',filename='D:\Gestion_employ� database\Gestion_employ�_ldf.ldf', size=4)
use Gestion_employ�
create table ServiceE( Code varchar(5) primary key, Libell� varchar(50) not null)
create table Employ�( Matricule varchar(5) primary key, Nom varchar(50)not null, Pr�nom varchar(50)not null, Date_naissance date, Grade varchar(50)not null, Echelle int, Code_service varchar(5) foreign key references ServiceE(Code) )
create table Cong� (Matricule varchar(5) foreign key references Employ�(Matricule), Date_cong� Date not null, Type_cong� varchar(50) not null, Dur�e int not null, CONSTRAINT PK_MA_DC primary key (Matricule,Date_cong�))




INSERT INTO ServiceE values ('S1','Resource Humains'),('S2','Service informatique')
declare @i int=2

while(@i<=20)
begin
insert into ServiceE values ('S'+convert(varchar,@i),'Service'+convert(varchar,@i))
set @i=@i+1

end

select * from ServiceE


sp_addumpdevice 'Disk','Unit�1','D:\Gestion_employ� database\Unit�1.bak'

backup database Gestion_employ� to Unit�1 with init 
restore database from Unit�1 with replace


declare @CD varchar(5), @Lib varchar(50) 

declare  C cursor for select * from ServiceE
open C
fetch  from C into @CD,@Lib
while (@@FETCH_STATUS=0)
begin
fetch  from C into @CD,@Lib
print 'Le Code Service Est : '+convert(varchar,@CD)+'      Le Nom : '+convert(varchar,@Lib)
end
close C
deallocate C



create view vue_statique_type
as
select Type_cong�,Count(*) as nbre,MIN(Dur�e)as minimum, MAX(Dur�e) as maximum, AVG(Dur�e)as moyenne, SUM(Dur�e) as total from Cong�
Group By Type_cong�

use Gestion_employ�
select * from vue_statique_type

create view vue_dur�e_total_par_ann�e_par_mois 
as
select datepart(yy,date_cong�) as ann�e ,datepart(mm,date_cong�) as mois, sum(dur�e) as total  
from Cong�  
group by datepart(yy,date_cong�) ,datepart(mm,date_cong�)
select * from vue_dur�e_total_par_ann�e_par_mois
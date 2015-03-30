A = load '/Fall2014_HW-3-Pig/ratings_new.dat' using PigStorage('#') as (AUserId:int, MovieId:int, Rating:Double, Timestamp:chararray);
B = load '/Fall2014_HW-3-Pig/users_new.dat' using PigStorage('#') as (BUserId, Gender, Age, Occupation, ZipCode);
C = cogroup A by AUserId, B by BUserId;
D = foreach C generate flatten(A), flatten(B);
E = limit D 11;
dump E;
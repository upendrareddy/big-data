A = load '/Fall2014_HW-3-Pig/movies_new.dat' using PigStorage('#') as (AMovieId, Title, Genres);
B = filter A by (Genres matches '.*Action.*') AND (Genres matches '.*War.*');
C = load '/Fall2014_HW-3-Pig/ratings_new.dat' using PigStorage('#') as (CUserId:int, CMovieId:int, Rating:Double, Timestamp:chararray);
D = Join C by CMovieId, B by AMovieId;
J = group D by CMovieId;
K = foreach J generate group as MovieId, AVG(D.Rating) as Avg_rating;
K1 = group K ALL;
K2 = foreach K1 generate MAX(K.Avg_rating) as maxRating;
K3 = filter K by Avg_rating == K2.maxRating;
F = join K3 by K3.MovieId, C by CMovieId;
E = load '/Fall2014_HW-3-Pig/users_new.dat' using PigStorage('#') as (EUSERID:int, GENDER:chararray, AGE:int, OCCUPATION:chararray, ZIPCODE:chararray);
H = filter E BY ZIPCODE MATCHES '1.*';                                                                                                     
G = filter H by GENDER=='F';
I = filter G by AGE>=20 AND AGE<=35;
L = join F by CUserId, I by EUSERID;
M = foreach L generate EUSERID;
N = distinct M;
P = join N by EUSERID, L by CUserId;
X = foreach P generate CUserId, GENDER, AGE, CMovieId, Avg_rating;
dump X;
function dvect = oderobotQ2(t,vect)
% On nous donne un vecteur colonne vect dont
% 1ère composante : psiR
% 2e composante : psiL
% 3e composante : v
% 4e composante : w
% 5e composante : theta
% 6e composante : x
% 7e composante : y

% On nous donne les valeurs de certaines
% constantes qu'on utilisera par la suite

e=0.15;
r=0.1;
m=10;
J=1;
c=0.01;
d=0.8;
eta=0.1;
TR=1.1;
TL=1;

dvect = zeros(7,1);

% dvect est la dérivée de notre vecteur initial
% Ses composantes seront les dérivées des
% composantes de notre vecteur initial vect

dvect(1)=(1/r)*(vect(3)+e*vect(4));
dvect(2)=(1/r)*(vect(3)-e*vect(4));

% Introduction de 2 nouvelles valeurs
% qui sont les forces motrices de chaque roue

fR=(TR/r)-c*dvect(1)-d*tanh((1/eta)*dvect(1));
fL=(TL/r)-c*dvect(2)-d*tanh((1/eta)*dvect(2));

dvect(3)=(1/m)*(fR+fL);
dvect(4)=(e/J)*(fR-fL);
dvect(5)=vect(4);
dvect(6)=vect(3)*cos(vect(5));
dvect(7)=vect(3)*sin(vect(5));
end
